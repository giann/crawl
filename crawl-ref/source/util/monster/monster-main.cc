/**
 * @file
 * @brief Contains code for the `monster` utility.
**/

#include "AppHdr.h"
#include "externs.h"
#include "directn.h"
#include "unwind.h"
#include "env.h"
#include "colour.h"
#include "coordit.h"
#include "dungeon.h"
#include "los.h"
#include "message.h"
#include "mon-abil.h"
#include "mon-book.h"
#include "mon-cast.h"
#include "mon-util.h"
#include "version.h"
#include "view.h"
#include "los.h"
#include "maps.h"
#include "initfile.h"
#include "libutil.h"
#include "item-name.h"
#include "item-prop.h"
#include "act-iter.h"
#include "mon-death.h"
#include "random.h"
#include "spl-util.h"
#include "state.h"
#include "stepdown.h"
#include "stringutil.h"
#include "syscalls.h"
#include "artefact.h"
#include "json.h"
#include "json-wrapper.h"
#include <sstream>
#include <set>
#include <unistd.h>

const coord_def MONSTER_PLACE(20, 20);

const string CANG = "cang";

const int PLAYER_MAXHP = 500;
const int PLAYER_MAXMP = 50;

// Clockwise, around the compass from north (same order as enum RUN_DIR)
const struct coord_def Compass[9] = {
    coord_def(0, -1), coord_def(1, -1),  coord_def(1, 0),
    coord_def(1, 1),  coord_def(0, 1),   coord_def(-1, 1),
    coord_def(-1, 0), coord_def(-1, -1), coord_def(0, 0),
};

static bool _is_element_colour(int col)
{
    col = col & 0x007f;
    ASSERT(col < NUM_COLOURS);
    return col >= ETC_FIRE;
}

static string colour_codes[] = {"",   "02", "03", "10", "05", "06",
                                     "07", "15", "14", "12", "09", "11",
                                     "04", "13", "08", "00"};

static int bgr[8] = {0, 4, 2, 6, 1, 5, 3, 7};

#ifdef CONTROL
#undef CONTROL
#endif
#define CONTROL(x) char(x - 'A' + 1)

static string colour(int colour, string text, bool bg = false)
{
    if (_is_element_colour(colour))
        colour = element_colour(colour, true);

    if (isatty(1))
    {
        if (!colour)
            return text;
        return make_stringf("\033[0;%d%d%sm%s\033[0m", bg ? 4 : 3,
                            bgr[colour & 7],
                            (!bg && (colour & 8)) ? ";1" : "", text.c_str());
    }

    const string code(colour_codes[colour]);

    if (code.empty())
        return text;

    return string() + CONTROL('C') + code + (bg ? ",01" : "") + text
           + CONTROL('O');
}

static void record_resvul(unsigned color, const char* name, const char* caption,
                          string& str, JsonNode *node, int rval)
{
    JsonNode *resvul(json_mkobject());
    json_append_member(resvul, "name", json_mkstring(name));
    if (rval > 1 && rval <= 3)
        json_append_member(resvul, "value", json_mknumber(rval));
    json_append_member(resvul, "color", json_mknumber(color));
    json_append_element(node, resvul);

    if (str.empty())
        str = " | " + string(caption) + ": ";
    else
        str += ", ";

    if (color && (rval == 3 || rval == 1 && color == BROWN
                  || string(caption) == "Vul")
        && (int)color <= 7)
    {
        color += 8;
    }

    string token(name);
    if (rval > 1 && rval <= 3)
    {
        while (rval-- > 0)
            token += "+";
    }

    str += colour(color, token);
}

static void record_resist(unsigned colour, string name, string& res, JsonNode *jres,
                          string& vul, JsonNode *jvul, int rval)
{
    if (rval > 0)
        record_resvul(colour, name.c_str(), "Res", res, jres, rval);
    else if (rval < 0)
        record_resvul(colour, name.c_str(), "Vul", vul, jvul, -rval);
}

static void monster_action_cost(string& qual, int cost, const char* desc)
{
    if (cost != 10)
    {
        if (!qual.empty())
            qual += "; ";
        qual += desc;
        qual += ": " + to_string(cost * 10) + "%";
    }
}

static void json_monster_action_cost(JsonNode *qualifiers, int cost, const char* desc)
{
    if (cost != 10)
    {
        JsonNode *action_cost(json_mkobject());

        json_append_member(action_cost, "name", json_mkstring(desc));
        json_append_member(action_cost, "cost", json_mknumber(cost * 10));

        json_append_element(qualifiers, action_cost);
    }
}

static string monster_int(const monster& mon)
{
    string intel = "???";
    switch (mons_intel(mon))
    {
    case I_BRAINLESS:
        intel = "brainless";
        break;
    case I_ANIMAL:
        intel = "animal";
        break;
    case I_HUMAN:
        intel = "human";
        break;
        // Let the compiler issue warnings for missing entries.
    }

    return intel;
}

static string monster_size(const monster& mon)
{
    switch (mon.body_size())
    {
    case SIZE_TINY:
        return "tiny";
    case SIZE_LITTLE:
        return "little";
    case SIZE_SMALL:
        return "small";
    case SIZE_MEDIUM:
        return "Medium";
    case SIZE_LARGE:
        return "Large";
    case SIZE_BIG:
        return "Big";
    case SIZE_GIANT:
        return "Giant";
    default:
        return "???";
    }
}

static string monster_speed(const monster& mon, const monsterentry* me,
                                 int speed_min, int speed_max)
{
    string speed;

    if (speed_max != speed_min)
        speed += to_string(speed_min) + "-" + to_string(speed_max);
    else if (speed_max == 0)
        speed += colour(BROWN, "0");
    else
        speed += to_string(speed_max);

    const mon_energy_usage& cost = mons_energy(mon);
    string qualifiers;

    bool skip_action = false;
    if (cost.attack != 10 && cost.attack == cost.missile
        && cost.attack == cost.spell && cost.attack == cost.special
        && cost.attack == cost.item)
    {
        monster_action_cost(qualifiers, cost.attack, "act");
        skip_action = true;
    }

    monster_action_cost(qualifiers, cost.move, "move");
    if (cost.swim != cost.move)
        monster_action_cost(qualifiers, cost.swim, "swim");
    if (!skip_action)
    {
        monster_action_cost(qualifiers, cost.attack, "atk");
        monster_action_cost(qualifiers, cost.missile, "msl");
        monster_action_cost(qualifiers, cost.spell, "spell");
        monster_action_cost(qualifiers, cost.special, "special");
        monster_action_cost(qualifiers, cost.item, "item");
    }
    if (speed_max > 0 && mons_class_flag(mon.type, M_STATIONARY))
    {
        if (!qualifiers.empty())
            qualifiers += "; ";
        qualifiers += colour(BROWN, "stationary");
    }

    if (!qualifiers.empty())
        speed += " (" + qualifiers + ")";

    return speed;
}

static JsonNode *json_monster_speed(const monster& mon, const monsterentry* me,
                                    int speed_min, int speed_max)
{
    JsonNode *speed(json_mkobject());
    json_append_member(speed, "min", json_mknumber(speed_min));
    json_append_member(speed, "max", json_mknumber(speed_max));

    const mon_energy_usage& cost = mons_energy(mon);
    JsonNode *qualifiers(json_mkarray());

    bool skip_action = false;
    if (cost.attack != 10 && cost.attack == cost.missile
        && cost.attack == cost.spell && cost.attack == cost.special
        && cost.attack == cost.item)
    {
        json_monster_action_cost(qualifiers, cost.attack, "act");
        skip_action = true;
    }

    json_monster_action_cost(qualifiers, cost.move, "move");

    if (cost.swim != cost.move)
        json_monster_action_cost(qualifiers, cost.swim, "swim");

    if (!skip_action)
    {
        json_monster_action_cost(qualifiers, cost.attack, "atk");
        json_monster_action_cost(qualifiers, cost.missile, "msl");
        json_monster_action_cost(qualifiers, cost.spell, "spell");
        json_monster_action_cost(qualifiers, cost.special, "special");
        json_monster_action_cost(qualifiers, cost.item, "item");
    }

    if (speed_max > 0 && mons_class_flag(mon.type, M_STATIONARY))
        json_monster_action_cost(qualifiers, -1, "stationary");

    return speed;
}

static void mons_flag(string& flag, JsonNode *jflag, const string& newflag, const unsigned color = BLACK)
{
    if (flag.empty())
        flag = " | ";
    else
        flag += ", ";
    flag += colour(color, newflag);

    JsonNode *json_flag(json_mkobject());
    json_append_member(json_flag, "name", json_mkstring(newflag.c_str()));
    json_append_member(json_flag, "color", json_mknumber(color));
    json_append_element(jflag, json_flag);
}

static void mons_check_flag(bool set, string& flag, JsonNode *jflag,
                            const string& newflag, const unsigned color = BLACK)
{
    if (set)
        mons_flag(flag, jflag, newflag, color);
}

static void initialize_crawl()
{
    init_monsters();
    init_properties();
    init_item_name_cache();

    init_zap_index();
    init_spell_descs();
    init_monster_symbols();
    init_mon_name_cache();
    init_spell_name_cache();
    init_mons_spells();
    init_element_colours();
    init_show_table(); // Initializes indices for get_feature_def.

    dgn_reset_level();
    for (rectangle_iterator ri(0); ri; ++ri)
        grd(*ri) = DNGN_FLOOR;

    los_changed();
    you.hp = you.hp_max = PLAYER_MAXHP;
    you.magic_points = you.max_magic_points = PLAYER_MAXMP;
    you.species = SP_HUMAN;
}

static string dice_def_string(dice_def dice)
{
    return dice.num == 1 ? make_stringf("d%d", dice.size) :
                           make_stringf("%dd%d", dice.num, dice.size);
}

static dice_def mi_calc_iood_damage(monster* mons)
{
    const int power =
        stepdown_value(6 * mons->get_experience_level(), 30, 30, 200, -1);
    return dice_def(9, power / 4);
}

static string mi_calc_smiting_damage(monster* mons) { return "7-17"; }

static string mi_calc_airstrike_damage(monster* mons)
{
    return make_stringf("0-%d", 10 + 2 * mons->get_experience_level());
}

static string mi_calc_glaciate_damage(monster* mons)
{
    int pow = 12 * mons->get_experience_level();
    // Minimum of the number of dice, or the max damage at max range
    int minimum = min(10, (54 + 3 * pow / 2) / 6);
    // Maximum damage at minimum range.
    int max = (54 + 3 * pow / 2) / 3;

    return make_stringf("%d-%d", minimum, max);
}

static string mi_calc_chain_lightning_damage(monster* mons)
{
    int pow = 4 * mons->get_experience_level();

    // Damage is 5d(9.2 + pow / 30), but if lots of targets are around
    // it can hit the player precisely once at very low (e.g. 1) power
    // and deal 5 damage.
    int min = 5;

    // Max damage per bounce is 46 + pow / 6; in the worst case every other
    // bounce hits the player, losing 8 pow on the bounce away and 8 on the
    // bounce back for a total of 16; thus, for n bounces, it's:
    // (46 + pow/6) * n less 16/6 times the (n - 1)th triangular number.
    int n = (pow + 15) / 16;
    int max = (46 + (pow / 6)) * n - 4 * n * (n - 1) / 3;

    return make_stringf("%d-%d", min, max);
}

static string mi_calc_vampiric_drain_damage(monster* mons)
{
    int pow = 12 * mons->get_experience_level();

    // The current formula is 3 + random2avg(9, 2) + 1 + random2(pow) / 7.
    // Min is 3 + 0 + 1 + (0 / 7) = 4.
    // Max is 3 + 8 + 1 + (pow - 1) / 7 = 12 + (pow - 1) / 7.
    int min = 4;
    int max = 12 + (pow - 1) / 7;
    return make_stringf("%d-%d", min, max);
}

static string mi_calc_major_healing(monster* mons)
{
    const int min = 50;
    const int max = min + mons->spell_hd(SPELL_MAJOR_HEALING) * 10;
    return make_stringf("%d-%d", min, max);
}

/**
 * @return e.g.: "2d6", "5-12".
 */
static string mons_human_readable_spell_damage_string(monster* monster,
                                                      spell_type sp)
{
    bolt spell_beam = mons_spell_beam(
        monster, sp, mons_power_for_hd(sp, monster->spell_hd(sp), false), true);
    switch (sp)
    {
        case SPELL_PORTAL_PROJECTILE:
        case SPELL_LRD:
            return ""; // Fake damage beam
        case SPELL_SMITING:
            return mi_calc_smiting_damage(monster);
        case SPELL_AIRSTRIKE:
            return mi_calc_airstrike_damage(monster);
        case SPELL_GLACIATE:
            return mi_calc_glaciate_damage(monster);
        case SPELL_CHAIN_LIGHTNING:
            return mi_calc_chain_lightning_damage(monster);
        case SPELL_WATERSTRIKE:
            spell_beam.damage = waterstrike_damage(*monster);
            break;
        case SPELL_RESONANCE_STRIKE:
            return dice_def_string(resonance_strike_base_damage(*monster))
                   + "+"; // could clarify further?
        case SPELL_IOOD:
            spell_beam.damage = mi_calc_iood_damage(monster);
            break;
        case SPELL_VAMPIRIC_DRAINING:
            return mi_calc_vampiric_drain_damage(monster);
        case SPELL_MAJOR_HEALING:
            return mi_calc_major_healing(monster);
        case SPELL_MINOR_HEALING:
        case SPELL_HEAL_OTHER:
            return dice_def_string(spell_beam.damage) + "+3";
        default:
            break;
    }

    if (spell_beam.origin_spell == SPELL_IOOD)
        spell_beam.damage = mi_calc_iood_damage(monster);

    if (spell_beam.damage.size && spell_beam.damage.num)
        return dice_def_string(spell_beam.damage);
    return "";
}

static string shorten_spell_name(string name)
{
    lowercase(name);
    string::size_type pos = name.find('\'');
    if (pos != string::npos)
    {
        pos = name.find(' ', pos);
        if (pos != string::npos)
        {
            // strip wizard names
            if (starts_with(name, "iskenderun's")
                || starts_with(name, "olgreb's") || starts_with(name, "lee's")
                || starts_with(name, "leda's") || starts_with(name, "lehudib's")
                || starts_with(name, "borgnjor's")
                || starts_with(name, "ozocubu's")
                || starts_with(name, "tukima's")
                || starts_with(name, "alistair's"))
            {
                name = name.substr(pos + 1);
            }
        }
    }
    if ((pos = name.find(" of ")) != string::npos)
    {
        istringstream words { name.substr(0, pos) };
        string abbrev, word;
        while (words >> word)
        {
            abbrev += word[0];
            abbrev += '.';
        }
        name = abbrev + name.substr(pos + 4);
    }
    if (starts_with(name, "summon "))
        name = "sum." + name.substr(7);
    if (ends_with(name, " bolt"))
        name = "b." + name.substr(0, name.length() - 5);
    return name;
}

static string _spell_flag_string(const mon_spell_slot& slot)
{
    string flags;

    if (!(slot.flags & MON_SPELL_ANTIMAGIC_MASK))
        flags += colour(LIGHTCYAN, "!AM");
    if (!(slot.flags & MON_SPELL_SILENCE_MASK))
    {
        if (!flags.empty())
            flags += ", ";
        flags += colour(MAGENTA, "!sil");
    }
    if (slot.flags & MON_SPELL_BREATH)
    {
        if (!flags.empty())
            flags += ", ";
        flags += colour(YELLOW, "breath");
    }
    if (slot.flags & MON_SPELL_EMERGENCY)
    {
        if (!flags.empty())
            flags += ", ";
        flags += colour(LIGHTRED, "emergency");
    }

    if (!flags.empty())
        flags = " [" + flags + "]";
    return flags;
}

static JsonNode *_spell_flag_json(const mon_spell_slot& slot)
{
    JsonNode *json_spell_flags(json_mkarray());

    if (!(slot.flags & MON_SPELL_ANTIMAGIC_MASK))
    {
        JsonNode *json_flag(json_mkobject());
        json_append_member(json_flag, "name", json_mkstring("!AM"));
        json_append_member(json_flag, "color", json_mknumber(LIGHTCYAN));
        json_append_element(json_spell_flags, json_flag);
    }
    if (!(slot.flags & MON_SPELL_SILENCE_MASK))
    {
        JsonNode *json_flag(json_mkobject());
        json_append_member(json_flag, "name", json_mkstring("!sil"));
        json_append_member(json_flag, "color", json_mknumber(MAGENTA));
        json_append_element(json_spell_flags, json_flag);
    }
    if (slot.flags & MON_SPELL_BREATH)
    {
        JsonNode *json_flag(json_mkobject());
        json_append_member(json_flag, "name", json_mkstring("breath"));
        json_append_member(json_flag, "color", json_mknumber(YELLOW));
        json_append_element(json_spell_flags, json_flag);
    }
    if (slot.flags & MON_SPELL_EMERGENCY)
    {
        JsonNode *json_flag(json_mkobject());
        json_append_member(json_flag, "name", json_mkstring("emergency"));
        json_append_member(json_flag, "color", json_mknumber(LIGHTRED));
        json_append_element(json_spell_flags, json_flag);
    }

    return json_spell_flags;
}

// ::first is spell name, ::second is possible damages
typedef multimap<string, string> spell_damage_map;
static void record_spell_set(monster* mp, set<string>& spell_lists,
                             JsonNode *json_spell_lists,
                             spell_damage_map& damages,
                             bool record_json)
{
    string ret;
    for (const auto& slot : mp->spells)
    {
        spell_type sp = slot.spell;
        if (!ret.empty())
            ret += ", ";
        if (spell_is_soh_breath(sp))
        {
            const vector<spell_type> *breaths = soh_breath_spells(sp);
            ASSERT(breaths);

            ret += "{";
            for (unsigned int k = 0; k < mp->number; ++k)
            {
                const spell_type breath = (*breaths)[k];
                const string rawname = spell_title(breath);
                ret += k == 0 ? "" : ", ";
                ret += make_stringf("head %d: ", k + 1)
                       + shorten_spell_name(rawname) + " (";
                ret +=
                    mons_human_readable_spell_damage_string(mp, breath) + ")";

                if (record_json)
                {
                    JsonNode *json_spell(json_mkobject());
                    json_append_member(json_spell, "head", json_mknumber(k + 1));
                    json_append_member(json_spell, "name",
                                       json_mkstring(shorten_spell_name(rawname).c_str()));
                    JsonNode *json_damages(json_mkarray());
                    json_append_element(json_damages,
                                        json_mkstring(mons_human_readable_spell_damage_string(mp, breath).c_str()));
                    json_append_member(json_spell, "damage", json_damages);
                    json_append_member(json_spell, "flags", _spell_flag_json(slot));
                    json_append_element(json_spell_lists, json_spell);
                }
            }
            ret += "}";

            ret += _spell_flag_string(slot);
            continue;
        }

        string spell_name = spell_title(sp);
        spell_name = shorten_spell_name(spell_name);

        JsonNode *json_spell;
        if (record_json)
        {
            json_spell = json_mkobject();
            json_append_member(json_spell, "name", json_mkstring(spell_name.c_str()));
            json_append_member(json_spell, "flags", _spell_flag_json(slot));
        }

        ret += spell_name;
        ret += _spell_flag_string(slot);

        for (int j = 0; j < 100; j++)
        {
            string damage =
            mons_human_readable_spell_damage_string(mp, sp);
            const auto range = damages.equal_range(spell_name);
            if (!damage.empty()
                && none_of(range.first, range.second, [&](const pair<string,string>& entry){ return entry.first == spell_name && entry.second == damage; }))
            {
                // TODO: use emplace once we drop g++ 4.7 support
                damages.insert(make_pair(spell_name, damage));
            }
        }

        if (record_json)
            json_append_element(json_spell_lists, json_spell);
    }

    spell_lists.insert(ret);
}

static string construct_spells(const set<string>& spell_lists,
                               const spell_damage_map& damages)
{
    string ret;
    for (const string& spell_list : spell_lists)
    {
        if (!ret.empty())
            ret += " / ";
        ret += spell_list;
    }
    map<string, string> merged_damages;
    for (const auto& entry : damages)
    {
        string &dam = merged_damages[entry.first];
        if (!dam.empty())
            dam += " / ";
        dam += entry.second;
    }

    for (const auto& entry : merged_damages)
    {
        ret = replace_all(ret, entry.first,
                          make_stringf("%s (%s)", entry.first.c_str(),
                                                  entry.second.c_str()));
    }

    return ret;
}

static JsonNode *construct_json_spell_damages(const spell_damage_map& damages)
{
    JsonNode *json_spell_damages(json_mkarray());

    map<string, set<string>> merged_damages;
    for (const auto& entry : damages)
        merged_damages[entry.first].insert(entry.second);

    for (const auto& entry : merged_damages)
    {
        JsonNode *json_spell_damage(json_mkobject());
        json_append_member(json_spell_damage, "spell", json_mkstring(entry.first.c_str()));

        JsonNode *json_damages(json_mkarray());
        for (const auto& dam : entry.second)
            json_append_element(json_damages, json_mkstring(dam.c_str()));

        json_append_member(json_spell_damage, "damage", json_damages);

        json_append_element(json_spell_damages, json_spell_damage);
    }

    return json_spell_damages;
}

static inline void set_min_max(int num, int& min, int& max)
{
    if (!min || num < min)
        min = num;
    if (!max || num > max)
        max = num;
}

static string monster_symbol(const monster& mon)
{
    string symbol;
    const monsterentry* me = mon.find_monsterentry();
    if (me)
    {
        monster_info mi(&mon, MILEV_NAME);
        symbol += me->basechar;
        symbol = colour(mi.colour(), symbol);
    }
    return symbol;
}

static string monster_raw_symbol(const monster& mon)
{
    string symbol;
    const monsterentry* me = mon.find_monsterentry();
    if (me)
    {
        monster_info mi(&mon, MILEV_NAME);
        symbol += me->basechar;
    }
    return symbol;
}

static unsigned monster_color(const monster& mon)
{
    unsigned color = 0;
    const monsterentry* me = mon.find_monsterentry();
    if (me)
    {
        monster_info mi(&mon, MILEV_NAME);
        color = mi.colour();
    }
    return color;
}

static int _mi_create_monster(mons_spec spec)
{
    monster* monster =
        dgn_place_monster(spec, MONSTER_PLACE, true, false, false);
    if (monster)
    {
        monster->behaviour = BEH_SEEK;
        monster->foe = MHITYOU;
        no_messages mx;
        monster->del_ench(ENCH_SUBMERGED);
        return monster->mindex();
    }
    return NON_MONSTER;
}

static string damage_flavour(const string& name,
                                  const string& damage)
{
    return "(" + name + ":" + damage + ")";
}

static JsonNode *json_damage_flavour(const string& name, const unsigned color = BLACK, const string& damage = "")
{
    JsonNode *json_damage(json_mkobject());
    json_append_member(json_damage, "name", json_mkstring(name.c_str()));
    if (!damage.empty())
        json_append_member(json_damage, "value", json_mkstring(damage.c_str()));
    json_append_member(json_damage, "color", json_mknumber(color));
    return json_damage;
}

static string damage_flavour(const string& name, int low, int high)
{
    return make_stringf("(%s:%d-%d)", name.c_str(), low, high);
}

static JsonNode *json_damage_flavour(const string& name, const int low, const int high, const unsigned color = BLACK)
{
    JsonNode *json_damage(json_mkobject());
    json_append_member(json_damage, "name", json_mkstring(name.c_str()));
    json_append_member(json_damage, "min", json_mknumber(low));
    json_append_member(json_damage, "max", json_mknumber(high));
    json_append_member(json_damage, "color", json_mknumber(color));
    return json_damage;
}

static void rebind_mspec(string* requested_name,
                         const string& actual_name, mons_spec* mspec)
{
    if (*requested_name != actual_name
        && (requested_name->find("draconian") == 0
            || requested_name->find("blood saint") == 0
            || requested_name->find("corrupter") == 0
            || requested_name->find("warmonger") == 0
            || requested_name->find("black sun") == 0))
    {
        // If the user requested a drac, the game might generate a
        // coloured drac in response. Try to reuse that colour for further
        // tests.
        mons_list mons;
        const string err = mons.add_mons(actual_name, false);
        if (err.empty())
        {
            *mspec = mons.get_monster(0);
            *requested_name = actual_name;
        }
    }
}

const vector<string> monsters = {
#include "vault_monster_data.h"
};

/**
 * Return a vault-defined monster spec.
 *
 * This function parses the contents of (the generated) vault_monster_data.h
 * and attempts to return a specification. If there is an invalid specification,
 * no error will be recorded.
 *
 * @param monster_name Monster being searched for.
 * @param[out] vault_spec the spec found for the monster, if any
 * @return A mons_spec instance that either contains the relevant data, or
 *         nothing if not found.
 *
**/
static mons_spec _get_vault_monster(string monster_name, string* vault_spec)
{
    lowercase(monster_name);
    trim_string(monster_name);

    monster_name = replace_all_of(monster_name, "'", "");

    mons_list mons;
    mons_spec no_monster;

    for (const string& spec : monsters)
    {
        mons.clear();

        const string err = mons.add_mons(spec, false);
        if (err.empty())
        {
            mons_spec this_mons = mons.get_monster(0);
            int index = _mi_create_monster(this_mons);

            if (index < 0 || index >= MAX_MONSTERS)
                continue;

            bool this_spec = false;

            monster* mp = &menv[index];

            if (mp)
            {
                string name =
                    replace_all_of(mp->name(DESC_PLAIN, true), "'", "");
                lowercase(name);
                if (name == monster_name)
                    this_spec = true;
            }

            mons_remove_from_grid(*mp);

            if (this_spec)
            {
                if (vault_spec)
                    *vault_spec = spec;
                return this_mons;
            }
        }
    }

    if (vault_spec)
        *vault_spec = "";

    return no_monster;
}
static string canned_reports[][2] = {
    {"cang", ("cang (" + colour(LIGHTRED, "Ω")
              + (") | Spd: c | HD: i | HP: 666 | AC/EV: e/π | Dam: 999"
                 " | Res: sanity | XP: ∞ | Int: god | Sz: !!!"))},
};

int main(int argc, char* argv[])
{
    alarm(5);
    crawl_state.test = true;
    JsonNode *json_mons = NULL;
    int argi = 0;
    if (argc < 2)
    {
        printf("Usage: @? <monster name>\n");
        return 0;
    }

    if (!strcmp(argv[1], "-version") || !strcmp(argv[1], "--version"))
    {
        printf("Monster stats Crawl version: %s\n", Version::Long);
        return 0;
    }
    else if (!strcmp(argv[1], "-name") || !strcmp(argv[1], "--name"))
    {
        seed_rng();
        printf("%s\n", make_name().c_str());
        return 0;
    }
    else if (!strcmp(argv[1], "-json") || !strcmp(argv[1], "--json"))
    {
        json_mons = json_mkobject();
        argi++;
    }

    initialize_crawl();

    mons_list mons;
    string target = argv[1 + argi];

    if (argc > (2 + argi))
        for (int x = (2 + argi); x < argc; x++)
        {
            target.append(" ");
            target.append(argv[x]);
        }

    trim_string(target);

    const bool want_vault_spec = target.find("spec:") == 0;
    if (want_vault_spec)
    {
        target.erase(0, 5);
        trim_string(target);
    }

    // [ds] Nobody mess with cang.
    for (const auto& row : canned_reports)
    {
        if (row[0] == target)
        {
            if (json_mons == NULL)
                printf("%s\n", row[1].c_str());
            else
            {
                json_append_member(json_mons, "name", json_mkstring("cang"));
                json_append_member(json_mons, "symbol", json_mkstring("Ω"));
                json_append_member(json_mons, "color", json_mknumber(LIGHTRED));
                json_append_member(json_mons, "speed", json_mknumber(999));
                json_append_member(json_mons, "hitDice", json_mknumber(666));
                json_append_member(json_mons, "healthPoints", json_mknumber(666));
                json_append_member(json_mons, "armourClass", json_mknumber(3.14));
                json_append_member(json_mons, "evasion", json_mknumber(2.71));
                json_append_member(json_mons, "damage", json_mknumber(999));

                JsonNode *resistances(json_mkarray());
                json_append_element(resistances, json_mkstring("sanity"));
                json_append_member(json_mons, "resistances", resistances);
                json_append_member(json_mons, "experience", json_mknumber(999));
                json_append_member(json_mons, "intelligence", json_mknumber(999));
                json_append_member(json_mons, "size", json_mkstring("!!!"));

                JsonWrapper json(json_mons);
                printf("%s\n", json.to_string().c_str());
            }
            return 0;
        }
    }

    string orig_target = string(target);

    string err = mons.add_mons(target, false);
    if (!err.empty())
    {
        target = "the " + target;
        const string test = mons.add_mons(target, false);
        if (test.empty())
            err = test;
    }

    mons_spec spec = mons.get_monster(0);
    monster_type spec_type = static_cast<monster_type>(spec.type);
    bool vault_monster = false;
    string vault_spec;

    if ((spec_type < 0 || spec_type >= NUM_MONSTERS
         || spec_type == MONS_PLAYER_GHOST)
        || !err.empty())
    {
        spec = _get_vault_monster(orig_target, &vault_spec);
        spec_type = static_cast<monster_type>(spec.type);
        if (spec_type < 0 || spec_type >= NUM_MONSTERS
            || spec_type == MONS_PLAYER_GHOST)
        {
            if (err.empty())
                printf("unknown monster: \"%s\"\n", target.c_str());
            else
                printf("%s\n", err.c_str());
            return 1;
        }

        // _get_vault_monster created the monster; make uniques ungenerated again
        if (mons_is_unique(spec_type))
            you.unique_creatures.set(spec_type, false);

        vault_monster = true;
    }

    if (want_vault_spec)
    {
        if (!vault_monster)
        {
            printf("Not a vault monster: %s\n", orig_target.c_str());
            return 1;
        }
        else
        {
            printf("%s: %s\n", orig_target.c_str(), vault_spec.c_str());
            return 0;
        }
    }

    int index = _mi_create_monster(spec);
    if (index < 0 || index >= MAX_MONSTERS)
    {
        printf("Failed to create test monster for %s\n", target.c_str());
        return 1;
    }

    const int ntrials = 100;

    long exper = 0L;
    int hp_min = 0;
    int hp_max = 0;
    int mac = 0;
    int mev = 0;
    int speed_min = 0, speed_max = 0;
    // Calculate averages.
    set<string> spell_lists;
    JsonNode *json_spell_lists(json_mkarray());
    spell_damage_map damages;
    for (int i = 0; i < ntrials; ++i)
    {
        monster* mp = &menv[index];
        const string mname = mp->name(DESC_PLAIN, true);
        exper += exper_value(*mp);
        mac += mp->armour_class();
        mev += mp->evasion();
        set_min_max(mp->speed, speed_min, speed_max);
        set_min_max(mp->hit_points, hp_min, hp_max);

        record_spell_set(mp, spell_lists, json_spell_lists, damages, i == ntrials - 1);

        // If it was a unique or had unrands, let it/them generate in future
        // iterations as well.
        for (int obj : mp->inv)
            if (obj != NON_ITEM)
                set_unique_item_status(mitm[obj], UNIQ_NOT_EXISTS);
        // Destroy the monster.
        mp->reset();
        you.unique_creatures.set(spec_type, false);

        rebind_mspec(&target, mname, &spec);

        index = _mi_create_monster(spec);
        if (index == -1)
        {
            printf("Unexpected failure generating monster for %s\n",
                   target.c_str());
            return 1;
        }
    }
    exper /= ntrials;
    mac /= ntrials;
    mev /= ntrials;

    monster& mon(menv[index]);

    const string symbol(monster_symbol(mon));
    const string raw_symbol(monster_raw_symbol(mon));
    const unsigned color = monster_color(mon);

    const bool shapeshifter = mon.is_shapeshifter()
                              || spec_type == MONS_SHAPESHIFTER
                              || spec_type == MONS_GLOWING_SHAPESHIFTER;

    const bool nonbase =
        mons_species(mon.type) == MONS_DRACONIAN && mon.type != MONS_DRACONIAN
        || mons_species(mon.type) == MONS_DEMONSPAWN
               && mon.type != MONS_DEMONSPAWN;

    const monsterentry* me =
        shapeshifter ? get_monster_data(spec_type) : mon.find_monsterentry();

    const monsterentry* mbase =
        nonbase ? get_monster_data(draco_or_demonspawn_subspecies(mon)) :
                  (monsterentry*)0;

    if (me)
    {
        string monsterflags;
        string monsterresistances;
        string monstervulnerabilities;
        string monsterattacks;

        JsonNode *json_monsterflags(json_mkarray());
        JsonNode *json_monsterresistances(json_mkarray());
        JsonNode *json_monstervulnerabilities(json_mkarray());
        JsonNode *json_monsterattacks(json_mkarray());

        lowercase(target);

        const bool changing_name =
            mon.has_hydra_multi_attack() || mon.type == MONS_PANDEMONIUM_LORD
            || shapeshifter || mon.type == MONS_DANCING_WEAPON;

        if (json_mons == NULL)
        {
            printf("%s (%s)",
                   changing_name ? me->name : mon.name(DESC_PLAIN, true).c_str(),
                   symbol.c_str());
        }
        else
        {
            json_append_member(json_mons, "name",
                               json_mkstring(changing_name ? me->name : mon.name(DESC_PLAIN, true).c_str()));
            json_append_member(json_mons, "symbol", json_mkstring(raw_symbol.c_str()));
            json_append_member(json_mons, "color", json_mknumber(color));
        }

        if (mons_class_flag(mon.type, M_UNFINISHED))
        {
            if (json_mons == NULL)
                printf(" | %s", colour(LIGHTRED, "UNFINISHED").c_str());
            else
                json_append_member(json_mons, "unfinished", json_mkbool(true));
        }

        if (json_mons == NULL)
        {
            printf(" | Spd: %s",
                   monster_speed(mon, me, speed_min, speed_max).c_str());
        }
        else
            json_append_member(json_mons, "speed", json_monster_speed(mon, me, speed_min, speed_max));

        const int hd = mon.get_experience_level();
        if (json_mons == NULL)
            printf(" | HD: %d", hd);
        else
            json_append_member(json_mons, "hitDice", json_mknumber(hd));

        if (json_mons == NULL)
        {
            printf(" | HP: ");
            const int hplow = hp_min;
            const int hphigh = hp_max;
            if (hplow < hphigh)
                printf("%i-%i", hplow, hphigh);
            else
                printf("%i", hplow);
        }
        else
        {
            JsonNode *hp(json_mkobject());
            json_append_member(hp, "min", json_mknumber(hp_min));
            json_append_member(hp, "max", json_mknumber(hp_max));

            json_append_member(json_mons, "healthPoints", hp);
        }

        if (json_mons == NULL)
            printf(" | AC/EV: %i/%i", mac, mev);
        else
        {
            json_append_member(json_mons, "armourClass", json_mknumber(mac));
            json_append_member(json_mons, "evasion", json_mknumber(mev));
        }

        if (json_mons == NULL)
        {
            string defenses;
            if (mon.is_spiny() > 0)
                defenses += colour(YELLOW, "(spiny 5d4)");
            if (mons_species(mons_base_type(mon)) == MONS_MINOTAUR)
                defenses += colour(LIGHTRED, "(headbutt: d20-1)");
            if (!defenses.empty())
                printf(" %s", defenses.c_str());
        }
        else
        {
            JsonNode *defenses(json_mkarray());
            if (mon.is_spiny() > 0)
                json_append_element(defenses, json_mkstring("spiny 5d4"));
            if (mons_species(mons_base_type(mon)) == MONS_MINOTAUR)
                json_append_element(defenses, json_mkstring("headbutt: d20-1"));

            json_append_member(json_mons, "defenses", defenses);
        }

        mon.wield_melee_weapon();
        for (int x = 0; x < 4; x++)
        {
            mon_attack_def orig_attk(me->attack[x]);
            int attack_num = x;
            if (mon.has_hydra_multi_attack())
                attack_num = x == 0 ? x : x + mon.number - 1;
            mon_attack_def attk = mons_attack_spec(mon, attack_num);
            if (attk.type)
            {
                if (monsterattacks.empty())
                    monsterattacks = " | Dam: ";
                else
                    monsterattacks += ", ";

                JsonNode *json_attack(json_mkobject());

                short int dam = attk.damage;
                if (mon.has_ench(ENCH_BERSERK) || mon.has_ench(ENCH_MIGHT))
                    dam = dam * 3 / 2;

                if (mon.has_ench(ENCH_WEAK))
                    dam = dam * 2 / 3;

                monsterattacks += to_string(dam);
                json_append_member(json_attack, "damage", json_mknumber(dam));

                if (attk.type == AT_CONSTRICT){
                    monsterattacks += colour(GREEN, "(constrict)");
                    json_append_member(json_attack, "type", json_mkstring("constrict"));
                }

                if (attk.type == AT_CLAW && mon.has_claws() >= 3){
                    monsterattacks += colour(LIGHTGREEN, "(claw)");
                    json_append_member(json_attack, "type", json_mkstring("claw"));
                }

                JsonNode *json_flavours(json_mkarray());

                const attack_flavour flavour(orig_attk.flavour == AF_KLOWN
                                                     || orig_attk.flavour
                                                            == AF_DRAIN_STAT ?
                                                 orig_attk.flavour :
                                                 attk.flavour);

                switch (flavour)
                {
                case AF_REACH:
                case AF_REACH_STING:
                    monsterattacks += "(reach)";
                    json_append_element(json_flavours, json_damage_flavour("reach"));
                    break;
                case AF_KITE:
                    monsterattacks += "(kite)";
                    json_append_element(json_flavours, json_damage_flavour("kite"));
                    break;
                case AF_SWOOP:
                    monsterattacks += "(swoop)";
                    json_append_element(json_flavours, json_damage_flavour("swoop"));
                    break;
                case AF_ACID:
                    monsterattacks +=
                        colour(YELLOW, damage_flavour("acid", "7d3"));
                    json_append_element(json_flavours, json_damage_flavour("acid", YELLOW, "7d3"));
                    break;
                case AF_BLINK:
                    monsterattacks += colour(MAGENTA, "(blink self)");
                    json_append_element(json_flavours, json_damage_flavour("blink self", MAGENTA));
                    break;
                case AF_COLD:
                    monsterattacks += colour(
                        LIGHTBLUE, damage_flavour("cold", hd, 3 * hd - 1));
                    json_append_element(json_flavours, json_damage_flavour("acid", hd, 3 * hd - 1, LIGHTBLUE));
                    break;
                case AF_CONFUSE:
                    monsterattacks += colour(LIGHTMAGENTA, "(confuse)");
                    json_append_element(json_flavours, json_damage_flavour("confuse", LIGHTMAGENTA));
                    break;
                case AF_DRAIN_DEX:
                    monsterattacks += colour(RED, "(drain dexterity)");
                    json_append_element(json_flavours, json_damage_flavour("drain dexterity", RED));
                    break;
                case AF_DRAIN_STR:
                    monsterattacks += colour(RED, "(drain strength)");
                    json_append_element(json_flavours, json_damage_flavour("drain strength", RED));
                    break;
                case AF_DRAIN_XP:
                    monsterattacks += colour(LIGHTMAGENTA, "(drain)");
                    json_append_element(json_flavours, json_damage_flavour("drain", LIGHTMAGENTA));
                    break;
                case AF_CHAOTIC:
                    monsterattacks += colour(LIGHTGREEN, "(chaos)");
                    json_append_element(json_flavours, json_damage_flavour("chaos", LIGHTGREEN));
                    break;
                case AF_ELEC:
                    monsterattacks +=
                        colour(LIGHTCYAN,
                               damage_flavour("elec", hd,
                                              hd + max(hd / 2 - 1, 0)));
                        json_append_element(json_flavours, json_damage_flavour("elec", hd,
                                                                               hd + max(hd / 2 - 1, 0),
                                                                               LIGHTCYAN));
                    break;
                case AF_FIRE:
                    monsterattacks += colour(
                        LIGHTRED, damage_flavour("fire", hd, hd * 2 - 1));
                    json_append_element(json_flavours, json_damage_flavour("acid", hd, hd * 2 - 1, LIGHTRED));
                    break;
                case AF_PURE_FIRE:
                    monsterattacks +=
                        colour(LIGHTRED, damage_flavour("pure fire", hd * 3 / 2,
                                                        hd * 5 / 2 - 1));
                        json_append_element(json_flavours, json_damage_flavour("pure fire",
                                                                               hd * 3 / 2,
                                                                               hd * 5 / 2 - 1,
                                                                               LIGHTRED));
                    break;
                case AF_STICKY_FLAME:
                    monsterattacks += colour(LIGHTRED, "(napalm)");
                    json_append_element(json_flavours, json_damage_flavour("napalm", LIGHTRED));
                    break;
                case AF_HUNGER:
                    monsterattacks += colour(BLUE, "(hunger)");
                    json_append_element(json_flavours, json_damage_flavour("hunger", BLUE));
                    break;
                case AF_MUTATE:
                    monsterattacks += colour(LIGHTGREEN, "(mutation)");
                    json_append_element(json_flavours, json_damage_flavour("mutation", LIGHTGREEN));
                    break;
                case AF_POISON_PARALYSE:
                    monsterattacks += colour(LIGHTRED, "(paralyse)");
                    json_append_element(json_flavours, json_damage_flavour("paralyse", LIGHTRED));
                    break;
                case AF_POISON:
                    monsterattacks += colour(
                        YELLOW, damage_flavour("poison", hd * 2, hd * 4));
                    json_append_element(json_flavours, json_damage_flavour("poison", hd * 2, hd * 4, YELLOW));
                    break;
                case AF_POISON_STRONG:
                    monsterattacks += colour(
                        LIGHTRED, damage_flavour("strong poison", hd * 11 / 3,
                                                 hd * 13 / 2));
                    json_append_element(json_flavours, json_damage_flavour("strong poison",
                                                                           hd * 11 / 3, hd * 13 / 2,
                                                                           LIGHTRED));
                    break;
                case AF_ROT:
                    monsterattacks += colour(LIGHTRED, "(rot)");
                    json_append_element(json_flavours, json_damage_flavour("rot", LIGHTRED));
                    break;
                case AF_VAMPIRIC:
                    monsterattacks += colour(RED, "(vampiric)");
                    json_append_element(json_flavours, json_damage_flavour("vampiric", RED));
                    break;
                case AF_KLOWN:
                    monsterattacks += colour(LIGHTBLUE, "(klown)");
                    json_append_element(json_flavours, json_damage_flavour("klown", LIGHTBLUE));
                    break;
                case AF_SCARAB:
                    monsterattacks += colour(LIGHTMAGENTA, "(scarab)");
                    json_append_element(json_flavours, json_damage_flavour("scarab", LIGHTMAGENTA));
                    break;
                case AF_DISTORT:
                    monsterattacks += colour(LIGHTBLUE, "(distort)");
                    json_append_element(json_flavours, json_damage_flavour("distort", LIGHTBLUE));
                    break;
                case AF_RAGE:
                    monsterattacks += colour(RED, "(rage)");
                    json_append_element(json_flavours, json_damage_flavour("rage", RED));
                    break;
                case AF_HOLY:
                    monsterattacks += colour(YELLOW, "(holy)");
                    json_append_element(json_flavours, json_damage_flavour("holy", YELLOW));
                    break;
                case AF_PAIN:
                    monsterattacks += colour(RED, "(pain)");
                    json_append_element(json_flavours, json_damage_flavour("pain", RED));
                    break;
                case AF_ANTIMAGIC:
                    monsterattacks += colour(LIGHTBLUE, "(antimagic)");
                    json_append_element(json_flavours, json_damage_flavour("antimagic", LIGHTBLUE));
                    break;
                case AF_DRAIN_INT:
                    monsterattacks += colour(BLUE, "(drain int)");
                    json_append_element(json_flavours, json_damage_flavour("drain int", BLUE));
                    break;
                case AF_DRAIN_STAT:
                    monsterattacks += colour(BLUE, "(drain stat)");
                    json_append_element(json_flavours, json_damage_flavour("drain stat", BLUE));
                    break;
                case AF_STEAL:
                    monsterattacks += colour(CYAN, "(steal)");
                    json_append_element(json_flavours, json_damage_flavour("steal", CYAN));
                    break;
                case AF_ENSNARE:
                    monsterattacks += colour(WHITE, "(ensnare)");
                    json_append_element(json_flavours, json_damage_flavour("ensnare", WHITE));
                    break;
                case AF_DROWN:
                    monsterattacks += colour(LIGHTBLUE, "(drown)");
                    json_append_element(json_flavours, json_damage_flavour("drown", LIGHTBLUE));
                    break;
                case AF_ENGULF:
                    monsterattacks += colour(LIGHTBLUE, "(engulf)");
                    json_append_element(json_flavours, json_damage_flavour("engulf", LIGHTBLUE));
                    break;
                case AF_DRAIN_SPEED:
                    monsterattacks += colour(LIGHTMAGENTA, "(drain speed)");
                    json_append_element(json_flavours, json_damage_flavour("drain speed", LIGHTMAGENTA));
                    break;
                case AF_VULN:
                    monsterattacks += colour(LIGHTBLUE, "(vuln)");
                    json_append_element(json_flavours, json_damage_flavour("vuln", LIGHTBLUE));
                    break;
                case AF_SHADOWSTAB:
                    monsterattacks += colour(MAGENTA, "(shadow stab)");
                    json_append_element(json_flavours, json_damage_flavour("shadow stab", MAGENTA));
                    break;
                case AF_CORRODE:
                    monsterattacks += colour(BROWN, "(corrosion)");
                    json_append_element(json_flavours, json_damage_flavour("corrosion", BROWN));
                    break;
                case AF_TRAMPLE:
                    monsterattacks += colour(BROWN, "(trample)");
                    json_append_element(json_flavours, json_damage_flavour("trample", BROWN));
                    break;
                case AF_WEAKNESS:
                    monsterattacks += colour(LIGHTRED, "(weakness)");
                    json_append_element(json_flavours, json_damage_flavour("weakness", LIGHTRED));
                    break;
                case AF_CRUSH:
                case AF_PLAIN:
                    break;
#if TAG_MAJOR_VERSION == 34
                case AF_DISEASE:
                case AF_PLAGUE:
                case AF_STEAL_FOOD:
                case AF_POISON_MEDIUM:
                case AF_POISON_NASTY:
                case AF_POISON_STR:
                case AF_POISON_DEX:
                case AF_POISON_INT:
                case AF_POISON_STAT:
                case AF_FIREBRAND:
                case AF_MIASMATA:
                    monsterattacks += colour(LIGHTRED, "(?\?\?)");
                    break;
#endif
                    // let the compiler issue warnings for us
                    //      default:
                    //        monsterattacks += "(???)";
                    //        break;
                }

                json_append_member(json_attack, "flavours", json_flavours);

                if (x == 0 && mon.has_hydra_multi_attack())
                    monsterattacks += " per head";

                json_append_element(json_monsterattacks, json_attack);
            }
        }

        if (json_mons == NULL)
            printf("%s", monsterattacks.c_str());
        else
            json_append_member(json_mons, "attacks", json_monsterattacks);

        mons_check_flag((bool)(me->holiness & MH_NATURAL)
                        && (bool)(me->holiness & ~MH_NATURAL),
                        monsterflags, json_monsterflags, "natural");
        mons_check_flag(mon.is_holy(), monsterflags, json_monsterflags, "holy", YELLOW);
        mons_check_flag((bool)(me->holiness & MH_UNDEAD),
                        monsterflags, json_monsterflags, "undead", BROWN);
        mons_check_flag((bool)(me->holiness & MH_DEMONIC),
                        monsterflags, json_monsterflags, "demonic", RED);
        mons_check_flag((bool)(me->holiness & MH_NONLIVING),
                        monsterflags, json_monsterflags, "non-living", LIGHTCYAN);
        mons_check_flag(mons_is_plant(mon), monsterflags, json_monsterflags,
                        "plant", GREEN);

        switch (me->gmon_use)
        {
        case MONUSE_WEAPONS_ARMOUR:
            mons_flag(monsterflags, json_monsterflags, "weapons", CYAN);
        // intentional fall-through
        case MONUSE_STARTING_EQUIPMENT:
            mons_flag(monsterflags, json_monsterflags, "items", CYAN);
        // intentional fall-through
        case MONUSE_OPEN_DOORS:
            mons_flag(monsterflags, json_monsterflags, "doors", CYAN);
        // intentional fall-through
        case MONUSE_NOTHING:
            break;

        case NUM_MONUSE: // Can't happen
            mons_flag(monsterflags, json_monsterflags, "uses bugs", CYAN);
            break;
        }

        mons_check_flag(bool(me->bitfields & M_EAT_DOORS), monsterflags, json_monsterflags,
                        "eats doors", LIGHTRED);
        mons_check_flag(bool(me->bitfields & M_CRASH_DOORS), monsterflags, json_monsterflags,
                        "breaks doors", LIGHTRED);

        mons_check_flag(mons_wields_two_weapons(mon), monsterflags, json_monsterflags,
                        "two-weapon");
        mons_check_flag(mon.is_fighter(), monsterflags, json_monsterflags, "fighter");
        if (mon.is_archer())
        {
            if (me->bitfields & M_DONT_MELEE)
                mons_flag(monsterflags, json_monsterflags, "master archer");
            else
                mons_flag(monsterflags, json_monsterflags, "archer");
        }
        mons_check_flag(mon.is_priest(), monsterflags, json_monsterflags, "priest");

        mons_check_flag(me->habitat == HT_AMPHIBIOUS, monsterflags, json_monsterflags,
                        "amphibious");

        mons_check_flag(mon.evil(), monsterflags, json_monsterflags, "evil");
        mons_check_flag(mon.is_actual_spellcaster(), monsterflags, json_monsterflags,
                        "spellcaster");
        mons_check_flag(bool(me->bitfields & M_COLD_BLOOD), monsterflags, json_monsterflags,
                        "cold-blooded");
        mons_check_flag(bool(me->bitfields & M_SEE_INVIS), monsterflags, json_monsterflags,
                        "see invisible");
        mons_check_flag(bool(me->bitfields & M_FLIES), monsterflags, json_monsterflags, "fly");
        mons_check_flag(bool(me->bitfields & M_FAST_REGEN), monsterflags, json_monsterflags,
                        "regen");
        mons_check_flag(mon.can_cling_to_walls(), monsterflags, json_monsterflags, "cling");
        mons_check_flag(bool(me->bitfields & M_WEB_SENSE), monsterflags, json_monsterflags,
                        "web sense");
        mons_check_flag(mon.is_unbreathing(), monsterflags, json_monsterflags, "unbreathing");

        string spell_string = construct_spells(spell_lists, damages);
        if (shapeshifter || mon.type == MONS_PANDEMONIUM_LORD
            || mon.type == MONS_CHIMERA
                   && (mon.base_monster == MONS_PANDEMONIUM_LORD))
        {
            spell_string = "(random)";

            JsonNode *random_spell(json_mkobject());
            json_append_member(random_spell, "name", json_mkstring("random"));
            json_append_element(json_spell_lists, random_spell);
        }

        mons_check_flag(vault_monster, monsterflags, json_monsterflags, "vault", BROWN);

        if (json_mons == NULL)
            printf("%s", monsterflags.c_str());
        else
            json_append_member(json_mons, "flags", json_monsterflags);

        if (me->resist_magic == 5000)
        {
            if (monsterresistances.empty())
                monsterresistances = " | Res: ";
            else
                monsterresistances += ", ";
            monsterresistances += colour(LIGHTMAGENTA, "magic(immune)");
        }
        else if (me->resist_magic < 0)
        {
            const int res = (mbase) ? mbase->resist_magic : me->resist_magic;
            if (monsterresistances.empty())
                monsterresistances = " | Res: ";
            else
                monsterresistances += ", ";
            monsterresistances +=
                colour(MAGENTA,
                       "magic(" + to_string(hd * res * 4 / 3 * -1) + ")");
        }
        else if (me->resist_magic > 0)
        {
            if (monsterresistances.empty())
                monsterresistances = " | Res: ";
            else
                monsterresistances += ", ";
            monsterresistances += colour(
                MAGENTA, "magic(" + to_string(me->resist_magic) + ")");
        }

        const resists_t res(shapeshifter ? me->resists :
                                           get_mons_resists(mon));
#define res(c, x)                                                              \
    do                                                                         \
    {                                                                          \
        record_resist(c, lowercase_string(#x), monsterresistances,             \
                      json_monsterresistances,                                 \
                      monstervulnerabilities,                                  \
                      json_monstervulnerabilities,                             \
                      get_resist(res, MR_RES_##x));                            \
    } while (false)

#define res2(c, x, y)                                                          \
    do                                                                         \
    {                                                                          \
        record_resist(c, #x, monsterresistances,                               \
                      json_monsterresistances,                                 \
                      monstervulnerabilities, json_monstervulnerabilities, y); \
    } while (false)

        // Don't record regular rF as damnation vulnerability.
        res(RED, FIRE);
        res(RED, DAMNATION);
        res(BLUE, COLD);
        res(CYAN, ELEC);
        res(GREEN, POISON);
        res(BROWN, ACID);
        res(0, STEAM);

        if (me->bitfields & M_UNBLINDABLE)
            res2(YELLOW, blind, 1);

        res2(LIGHTBLUE, drown, mon.res_water_drowning());
        res2(LIGHTRED, rot, mon.res_rotting());
        res2(LIGHTMAGENTA, neg, mon.res_negative_energy(true));
        res2(YELLOW, holy, mon.res_holy_energy());
        res2(LIGHTMAGENTA, torm, mon.res_torment());
        res2(LIGHTBLUE, tornado, mon.res_tornado());
        res2(LIGHTRED, napalm, mon.res_sticky_flame());
        res2(LIGHTCYAN, silver, mon.how_chaotic() ? -1 : 0);

        if (json_mons == NULL)
        {
            printf("%s", monsterresistances.c_str());
            printf("%s", monstervulnerabilities.c_str());
        }
        else
        {
            json_append_member(json_mons, "resistances", json_monsterresistances);
            json_append_member(json_mons, "vulnerabilities", json_monstervulnerabilities);
        }

        if (me->corpse_thingy != CE_NOCORPSE && me->corpse_thingy != CE_CLEAN)
        {
            if (json_mons == NULL)
            {
                printf(" | Chunks: ");
                switch (me->corpse_thingy)
                {
                case CE_NOXIOUS:
                    printf("%s", colour(DARKGREY, "noxious").c_str());
                    break;
                // We should't get here; including these values so we can get
                // compiler
                // warnings for unhandled enum values.
                case CE_NOCORPSE:
                case CE_CLEAN:
                    printf("???");
                }
            }
            else
            {
                if (me->corpse_thingy == CE_NOXIOUS)
                    json_append_member(json_mons, "chunks", json_mkstring("noxious"));
            }
        }

        if (json_mons == NULL) {
            printf(" | XP: %ld", exper);

            if (!spell_string.empty())
                printf(" | Sp: %s", spell_string.c_str());

            printf(" | Sz: %s", monster_size(mon).c_str());

            printf(" | Int: %s", monster_int(mon).c_str());

            printf(".\n");
        }
        else
        {
            json_append_member(json_mons, "experience", json_mknumber(exper));

            json_append_member(json_mons, "spells", json_spell_lists);

            json_append_member(json_mons, "spellDamages", construct_json_spell_damages(damages));

            json_append_member(json_mons, "size", json_mkstring(monster_size(mon).c_str()));

            json_append_member(json_mons, "intelligence", json_mkstring(monster_int(mon).c_str()));

            JsonWrapper json(json_mons);
            printf("%s\n", json.to_string().c_str());
        }

        return 0;
    }
    return 1;
}

//////////////////////////////////////////////////////////////////////////
// main.cc stuff

CLua clua(true);
CLua dlua(false);      // Lua interpreter for the dungeon builder.
crawl_environment env; // Requires dlua.
player you;
game_state crawl_state;

void process_command(command_type);
void process_command(command_type) {}

void world_reacts();
void world_reacts() {}
