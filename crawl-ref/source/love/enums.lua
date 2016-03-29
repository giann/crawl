local exports = {}
-- Various constants
exports.gxm = 80
exports.gym = 70
exports.stat_width = 42

-- UI States (tileweb.h)
exports.ui = {}
exports.ui.NORMAL   = 0
exports.ui.CRT      = 1
exports.ui.VIEW_MAP = 2

-- Mouse modes
local val = 0
exports.mouse_mode = {}
exports.mouse_mode.NORMAL = val + 1
val = val + 1
exports.mouse_mode.COMMAND = val + 1
val = val + 1
exports.mouse_mode.TARGET = val + 1
val = val + 1
exports.mouse_mode.TARGET_DIR = val + 1
val = val + 1
exports.mouse_mode.TARGET_PATH = val + 1
val = val + 1
exports.mouse_mode.MORE = val + 1
val = val + 1
exports.mouse_mode.MACRO = val + 1
val = val + 1
exports.mouse_mode.PROMPT = val + 1
val = val + 1
exports.mouse_mode.YESNO = val + 1
val = val + 1
exports.mouse_mode.MAX = val + 1
val = val + 1

-- Cursors
exports.CURSOR_MOUSE = 0
exports.CURSOR_TUTORIAL = 1
exports.CURSOR_MAP = 2
exports.CURSOR_MAX = 3

-- Halo flags
exports.HALO_NONE = 0
exports.HALO_RANGE = 1
exports.HALO_MONSTER = 2
exports.HALO_UMBRA = 3

-- equipment_type
exports.equip = {}
val = 0
exports.equip.WEAPON = val + 1
val = val + 1
exports.equip.CLOAK = val + 1
val = val + 1
exports.equip.HELMET = val + 1
val = val + 1
exports.equip.GLOVES = val + 1
val = val + 1
exports.equip.BOOTS = val + 1
val = val + 1
exports.equip.SHIELD = val + 1
val = val + 1
exports.equip.BODY_ARMOUR = val + 1
val = val + 1
exports.equip.LEFT_RING = val + 1
val = val + 1
exports.equip.RIGHT_RING = val + 1
val = val + 1
exports.equip.AMULET = val + 1
val = val + 1
exports.equip.RING_ONE = val + 1
val = val + 1
exports.equip.RING_TWO = val + 1
val = val + 1
exports.equip.RING_THREE = val + 1
val = val + 1
exports.equip.RING_FOUR = val + 1
val = val + 1
exports.equip.RING_FIVE = val + 1
val = val + 1
exports.equip.RING_SIX = val + 1
val = val + 1
exports.equip.RING_SEVEN = val + 1
val = val + 1
exports.equip.RING_EIGHT = val + 1
val = val + 1
exports.equip.NUM_EQUIP = val + 1
val = val + 1

-- Tile flags.
-- Mostly this complicated because they need more than 32 bits.

function array_and(arr1, arr2)
    local result = {}
    for i = 1, math.min(#arr1, #arr2) do
        result[#result] = bit.band(arr1[i], arr2[i])
    end
    return result
end

function array_equal(arr1, arr2)
    -- return (arr1 <= arr2) && (arr1 >= arr2)
    for i = 1, math.max(#arr1, #arr2) do
        if (arr1[i] or 0) ~= (arr2[i] or 0) then
            return false
        end
    end
    return true
end

function array_nonzero(arr)
    for i = 1, #arr do
        if arr[i] ~= 0 then
            return true
        end
    end
    return false
end

function prepare_flags(tileidx, flagdata, cache)
    if not isNaN(tileidx) then
        tileidx = {tileidx}
    elseif tileidx.value then
        return tileidx
    end

    while true do
        table.insert(tileidx, 0)

        if #tileidx > 2 then
            break
        end
    end

    -- if cache[[tileidx[1],tileidx[1]]] then
    --     return cache[[tileidx[1],tileidx[1]]]
    -- end

    for flagname, flagmask in pairs(flagdata.flags) do
        if (isNaN(flagmask)) then
            tileidx[flagname] = array_nonzero(array_and(tileidx, flagmask))
        else
            tileidx[flagname] = bit.band(tileidx[1], flagmask) ~= 0
        end
    end

    for i = 1, #flagdata.exclusive_flags do
        local excl = flagdata.exclusive_flags[i]
        local val
        if (isNaN(excl.mask)) then
            val = array_and(tileidx, excl.mask)
        else
            val = {bit.band(tileidx[1], excl.mask)}
        end

        for flagname, value in pairs(excl) do
            if flagname ~= "mask" then
                if isNaN(excl[flagname]) then
                    tileidx[flagname] = array_equal(val, excl[flagname])
                else
                    tileidx[flagname] = (val[1] == excl[flagname])
                end
            end
        end
    end

    tileidx.value = bit.band(tileidx[1], flagdata.mask)
    -- cache[[tileidx[1],tileidx[1]]] = tileidx
    -- cache.size++
    return tileidx
end

-- Hex literals are signed, so values with the highest bit set
-- would have to be written in 2-complement this way is easier to
-- read
-- 1 << 31
local highbit = -2147483648

-- Foreground flags

-- 3 mutually exclusive flags for attitude.
local fg_flags = { flags = {}, exclusive_flags = {} }
table.insert(fg_flags.exclusive_flags, {
    mask       = 0x00030000,
    PET        = 0x00010000,
    GD_NEUTRAL = 0x00020000,
    NEUTRAL    = 0x00030000,
})

fg_flags.flags.S_UNDER = 0x00040000
fg_flags.flags.FLYING  = 0x00080000

-- 3 mutually exclusive flags for behaviour.
table.insert(fg_flags.exclusive_flags, {
    mask       = 0x00300000,
    STAB       = 0x00100000,
    MAY_STAB   = 0x00200000,
    FLEEING    = 0x00300000,
})

fg_flags.flags.NET          = 0x00400000
fg_flags.flags.POISON       = 0x00800000
fg_flags.flags.WEB          = 0x01000000
fg_flags.flags.GLOWING      = 0x02000000
fg_flags.flags.STICKY_FLAME = 0x04000000
fg_flags.flags.BERSERK      = 0x08000000
fg_flags.flags.INNER_FLAME  = 0x10000000
fg_flags.flags.CONSTRICTED  = 0x20000000
fg_flags.flags.SLOWED       = {0, 0x080}
fg_flags.flags.PAIN_MIRROR  = {0, 0x100}
fg_flags.flags.HASTED       = {0, 0x200}
fg_flags.flags.MIGHT        = {0, 0x400}
fg_flags.flags.PETRIFYING   = {0, 0x800}
fg_flags.flags.PETRIFIED    = {0, 0x1000}
fg_flags.flags.BLIND        = {0, 0x2000}
fg_flags.flags.ANIM_WEP     = {0, 0x4000}
fg_flags.flags.SUMMONED     = {0, 0x8000}
fg_flags.flags.PERM_SUMMON  = {0, 0x10000}
fg_flags.flags.DEATHS_DOOR  = {0, 0x20000}
fg_flags.flags.RECALL       = {0, 0x40000}
fg_flags.flags.DRAIN        = {0, 0x80000}

-- MDAM has 5 possibilities, so uses 3 bits.
table.insert(fg_flags.exclusive_flags, {
    mask       = {bit.bor(0x40000000, highbit), 0x01},
    MDAM_LIGHT = {0x40000000, 0x00},
    MDAM_MOD   = {highbit, 0x00},
    MDAM_HEAVY = {bit.bor(0x40000000, highbit), 0x00},
    MDAM_SEV   = {0x00000000, 0x01},
    MDAM_ADEAD = {bit.bor(0x40000000, highbit), 0x01},
})

-- Demon difficulty has 5 possibilities, so uses 3 bits.
table.insert(fg_flags.exclusive_flags, {
    mask       = {0, 0x0E},
    DEMON_5    = {0, 0x02},
    DEMON_4    = {0, 0x04},
    DEMON_3    = {0, 0x06},
    DEMON_2    = {0, 0x08},
    DEMON_1    = {0, 0x0E},
})

-- Mimics, 2 bits.
table.insert(fg_flags.exclusive_flags, {
    mask        = {0, 0x60},
    MIMIC_INEPT = {0, 0x20},
    MIMIC       = {0, 0x40},
    MIMIC_RAVEN = {0, 0x60},
})

fg_flags.mask             = 0x0000FFFF

-- Background flags
local bg_flags = { flags = {}, exclusive_flags = {} }
bg_flags.flags.RAY        = 0x00010000
bg_flags.flags.MM_UNSEEN  = 0x00020000
bg_flags.flags.UNSEEN     = 0x00040000
table.insert(bg_flags.exclusive_flags, {
    mask       = 0x00180000,
    CURSOR1    = 0x00180000,
    CURSOR2    = 0x00080000,
    CURSOR3    = 0x00100000,
})
bg_flags.flags.TUT_CURSOR = 0x00200000
bg_flags.flags.TRAV_EXCL  = 0x00400000
bg_flags.flags.EXCL_CTR   = 0x00800000
bg_flags.flags.RAY_OOR    = 0x01000000
bg_flags.flags.OOR        = 0x02000000
bg_flags.flags.WATER      = 0x04000000
bg_flags.flags.NEW_STAIR  = 0x08000000

-- Kraken tentacle overlays.
bg_flags.flags.KRAKEN_NW  = 0x20000000
bg_flags.flags.KRAKEN_NE  = 0x40000000
bg_flags.flags.KRAKEN_SE  = highbit
bg_flags.flags.KRAKEN_SW  = {0, 0x01}

-- Eldritch tentacle overlays.
bg_flags.flags.ELDRITCH_NW = {0, 0x02}
bg_flags.flags.ELDRITCH_NE = {0, 0x04}
bg_flags.flags.ELDRITCH_SE = {0, 0x08}
bg_flags.flags.ELDRITCH_SW = {0, 0x10}
bg_flags.flags.LANDING     = {0, 0x200}
bg_flags.flags.RAY_MULTI   = {0, 0x400}
bg_flags.mask              = 0x0000FFFF

-- Since the current flag implementation is really slow we use a trivial
-- cache system for now.
local fg_cache = { size = 0 }
exports.prepare_fg_flags = function (tileidx)
    if fg_cache.size >= 100 then
        fg_cache = { size = 0 }
    end

    return prepare_flags(tileidx, fg_flags, fg_cache)
end

local bg_cache = { size = 0 }
exports.prepare_bg_flags = function (tileidx)
    if (bg_cache.size >= 250) then
        bg_cache = { size = 0 }
    end

    return prepare_flags(tileidx, bg_flags, bg_cache)
end

-- Menu flags -- see menu.h
local mf = {}
mf.NOSELECT         = 0x0001
mf.SINGLESELECT     = 0x0002
mf.MULTISELECT      = 0x0004
mf.NO_SELECT_QTY    = 0x0008
mf.ANYPRINTABLE     = 0x0010
mf.SELECT_BY_PAGE   = 0x0020
mf.ALWAYS_SHOW_MORE = 0x0040
mf.NOWRAP           = 0x0080
mf.ALLOW_FILTER     = 0x0100
mf.ALLOW_FORMATTING = 0x0200
mf.SHOW_PAGENUMBERS = 0x0400
mf.EASY_EXIT        = 0x1000
mf.START_AT_END     = 0x2000
mf.PRESELECTED      = 0x4000
exports.menu_flag = mf

val = 0
exports.CHATTR = {}
exports.CHATTR.NORMAL = val + 1
val = val + 1
exports.CHATTR.STANDOUT = val + 1
val = val + 1
exports.CHATTR.BOLD = val + 1
val = val + 1
exports.CHATTR.BLINK = val + 1
val = val + 1
exports.CHATTR.UNDERLINE = val + 1
val = val + 1
exports.CHATTR.REVERSE = val + 1
val = val + 1
exports.CHATTR.DIM = val + 1
val = val + 1
exports.CHATTR.HILITE = val + 1
val = val + 1
exports.CHATTR.ATTRMASK = 0xF

-- Minimap features
val = 0
exports.MF_UNSEEN = val + 1
val = val + 1
exports.MF_FLOOR = val + 1
val = val + 1
exports.MF_WALL = val + 1
val = val + 1
exports.MF_MAP_FLOOR = val + 1
val = val + 1
exports.MF_MAP_WALL = val + 1
val = val + 1
exports.MF_DOOR = val + 1
val = val + 1
exports.MF_ITEM = val + 1
val = val + 1
exports.MF_MONS_FRIENDLY = val + 1
val = val + 1
exports.MF_MONS_PEACEFUL = val + 1
val = val + 1
exports.MF_MONS_NEUTRAL = val + 1
val = val + 1
exports.MF_MONS_HOSTILE = val + 1
val = val + 1
exports.MF_MONS_NO_EXP = val + 1
val = val + 1
exports.MF_STAIR_UP = val + 1
val = val + 1
exports.MF_STAIR_DOWN = val + 1
val = val + 1
exports.MF_STAIR_BRANCH = val + 1
val = val + 1
exports.MF_FEATURE = val + 1
val = val + 1
exports.MF_WATER = val + 1
val = val + 1
exports.MF_LAVA = val + 1
val = val + 1
exports.MF_TRAP = val + 1
val = val + 1
exports.MF_EXCL_ROOT = val + 1
val = val + 1
exports.MF_EXCL = val + 1
val = val + 1
exports.MF_PLAYER = val + 1
val = val + 1
exports.MF_DEEP_WATER = val + 1
val = val + 1
exports.MF_PORTAL = val + 1
val = val + 1
exports.MF_MAX = val + 1
val = val + 1

exports.MF_SKIP = val + 1
val = val + 1

exports.reverse_lookup = function (e, value)
    for prop, v in pairs(e) do
        if e[prop] == value then
            return prop
        end
    end
end

return exports
