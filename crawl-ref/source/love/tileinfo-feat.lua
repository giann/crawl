local tileinfo = {}

local val = TILE_WALL_MAX;
DNGN_TREE = val + 1
val = val + 1
DNGN_TREE_1 = val + 1
val = val + 1
DNGN_TREE_2 = val + 1
val = val + 1
DNGN_TREE_3 = val + 1
val = val + 1
DNGN_TREE_4 = val + 1
val = val + 1
DNGN_TREE_5 = val + 1
val = val + 1
DNGN_TREE_6 = val + 1
val = val + 1
DNGN_TREE_7 = val + 1
val = val + 1
DNGN_TREE_8 = val + 1
val = val + 1
DNGN_TREE_9 = val + 1
val = val + 1
DNGN_TREE_10 = val + 1
val = val + 1
DNGN_TREE_11 = val + 1
val = val + 1
DNGN_TREE_12 = val + 1
val = val + 1
DNGN_TREE_13 = val + 1
val = val + 1
DNGN_TREE_14 = val + 1
val = val + 1
DNGN_TREE_15 = val + 1
val = val + 1
DNGN_TREE_16 = val + 1
val = val + 1
DNGN_TREE_17 = val + 1
val = val + 1
DNGN_TREE_18 = val + 1
val = val + 1
DNGN_TREE_19 = val + 1
val = val + 1
DNGN_TREE_20 = val + 1
val = val + 1
DNGN_TREE_YELLOW = val + 1
val = val + 1
DNGN_TREE_YELLOW_1 = val + 1
val = val + 1
DNGN_TREE_YELLOW_2 = val + 1
val = val + 1
DNGN_TREE_LIGHTRED = val + 1
val = val + 1
DNGN_TREE_LIGHTRED_1 = val + 1
val = val + 1
DNGN_TREE_RED = val + 1
val = val + 1
DNGN_TREE_RED_1 = val + 1
val = val + 1
DNGN_TREE_RED_2 = val + 1
val = val + 1
DNGN_TREE_RED_3 = val + 1
val = val + 1
DNGN_TREE_DEAD = val + 1
val = val + 1
DNGN_TREE_DEAD_1 = val + 1
val = val + 1
DNGN_MANGROVE = val + 1
val = val + 1
DNGN_MANGROVE_1 = val + 1
val = val + 1
DNGN_MANGROVE_2 = val + 1
val = val + 1
DNGN_CLOSED_DOOR = val + 1
val = val + 1
DNGN_GATE_CLOSED_LEFT = val + 1
val = val + 1
DNGN_GATE_CLOSED_MIDDLE = val + 1
val = val + 1
DNGN_GATE_CLOSED_RIGHT = val + 1
val = val + 1
DNGN_VGATE_CLOSED_UP = val + 1
val = val + 1
DNGN_VGATE_CLOSED_MIDDLE = val + 1
val = val + 1
DNGN_VGATE_CLOSED_DOWN = val + 1
val = val + 1
DNGN_OPEN_DOOR = val + 1
val = val + 1
DNGN_GATE_OPEN_LEFT = val + 1
val = val + 1
DNGN_GATE_OPEN_MIDDLE = val + 1
val = val + 1
DNGN_GATE_OPEN_RIGHT = val + 1
val = val + 1
DNGN_VGATE_OPEN_UP = val + 1
val = val + 1
DNGN_VGATE_OPEN_MIDDLE = val + 1
val = val + 1
DNGN_VGATE_OPEN_DOWN = val + 1
val = val + 1
DNGN_RUNED_DOOR = val + 1
val = val + 1
DNGN_GATE_RUNED_LEFT = val + 1
val = val + 1
DNGN_GATE_RUNED_MIDDLE = val + 1
val = val + 1
DNGN_GATE_RUNED_RIGHT = val + 1
val = val + 1
DNGN_VGATE_RUNED_UP = val + 1
val = val + 1
DNGN_VGATE_RUNED_MIDDLE = val + 1
val = val + 1
DNGN_VGATE_RUNED_DOWN = val + 1
val = val + 1
DNGN_SEALED_DOOR = val + 1
val = val + 1
DNGN_GATE_SEALED_LEFT = val + 1
val = val + 1
DNGN_GATE_SEALED_MIDDLE = val + 1
val = val + 1
DNGN_GATE_SEALED_RIGHT = val + 1
val = val + 1
DNGN_VGATE_SEALED_UP = val + 1
val = val + 1
DNGN_VGATE_SEALED_MIDDLE = val + 1
val = val + 1
DNGN_VGATE_SEALED_DOWN = val + 1
val = val + 1
DNGN_CLOSED_DOOR_CRYPT = val + 1
val = val + 1
DNGN_GATE_CLOSED_LEFT_CRYPT = val + 1
val = val + 1
DNGN_GATE_CLOSED_MIDDLE_CRYPT = val + 1
val = val + 1
DNGN_GATE_CLOSED_RIGHT_CRYPT = val + 1
val = val + 1
DNGN_VGATE_CLOSED_UP_CRYPT = val + 1
val = val + 1
DNGN_VGATE_CLOSED_MIDDLE_CRYPT = val + 1
val = val + 1
DNGN_VGATE_CLOSED_DOWN_CRYPT = val + 1
val = val + 1
DNGN_OPEN_DOOR_CRYPT = val + 1
val = val + 1
DNGN_GATE_OPEN_LEFT_CRYPT = val + 1
val = val + 1
DNGN_GATE_OPEN_MIDDLE_CRYPT = val + 1
val = val + 1
DNGN_GATE_OPEN_RIGHT_CRYPT = val + 1
val = val + 1
DNGN_VGATE_OPEN_UP_CRYPT = val + 1
val = val + 1
DNGN_VGATE_OPEN_MIDDLE_CRYPT = val + 1
val = val + 1
DNGN_VGATE_OPEN_DOWN_CRYPT = val + 1
val = val + 1
DNGN_FLESHY_ORIFICE = val + 1
val = val + 1
DNGN_FLESHY_ORIFICE_1 = val + 1
val = val + 1
DNGN_STONE_ARCH = val + 1
val = val + 1
DNGN_ORCISH_IDOL = val + 1
val = val + 1
DNGN_GRANITE_STATUE = val + 1
val = val + 1
DNGN_GRANITE_STATUE_1 = val + 1
val = val + 1
DNGN_GRANITE_STATUE_2 = val + 1
val = val + 1
DNGN_STATUE_CENTAUR = val + 1
val = val + 1
DNGN_STATUE_SNAIL = val + 1
val = val + 1
DNGN_STATUE_CAT = val + 1
val = val + 1
DNGN_STATUE_CAT_1 = val + 1
val = val + 1
DNGN_STATUE_MERMAID = val + 1
val = val + 1
DNGN_STATUE_NAGA = val + 1
val = val + 1
DNGN_STATUE_DRAGON = val + 1
val = val + 1
DNGN_STATUE_DRAGON_1 = val + 1
val = val + 1
DNGN_STATUE_ANGEL = val + 1
val = val + 1
DNGN_STATUE_ELEPHANT = val + 1
val = val + 1
DNGN_STATUE_WRAITH = val + 1
val = val + 1
DNGN_STATUE_IMP = val + 1
val = val + 1
DNGN_STATUE_IMP_1 = val + 1
val = val + 1
DNGN_STATUE_IMP_2 = val + 1
val = val + 1
DNGN_STATUE_DEMONIC_BUST = val + 1
val = val + 1
DNGN_STATUE_DEMONIC_BUST_1 = val + 1
val = val + 1
DNGN_STATUE_DEMONIC_BUST_2 = val + 1
val = val + 1
DNGN_STATUE_DEMONIC_BUST_3 = val + 1
val = val + 1
DNGN_STATUE_DEMONIC_BUST_4 = val + 1
val = val + 1
DNGN_STATUE_ANCIENT_HERO = val + 1
val = val + 1
DNGN_STATUE_ANCIENT_EVIL = val + 1
val = val + 1
DNGN_STATUE_ANCIENT_EVIL_1 = val + 1
val = val + 1
DNGN_CRUMBLED_COLUMN = val + 1
val = val + 1
DNGN_CRUMBLED_COLUMN_1 = val + 1
val = val + 1
DNGN_CRUMBLED_COLUMN_2 = val + 1
val = val + 1
DNGN_CRUMBLED_COLUMN_3 = val + 1
val = val + 1
DNGN_CRUMBLED_COLUMN_4 = val + 1
val = val + 1
DNGN_CRUMBLED_COLUMN_5 = val + 1
val = val + 1
DNGN_STATUE_IRON = val + 1
val = val + 1
DNGN_GRAVESTONE = val + 1
val = val + 1
DNGN_GRAVESTONE_1 = val + 1
val = val + 1
DNGN_GRAVESTONE_2 = val + 1
val = val + 1
DNGN_GRAVESTONE_ORNATE = val + 1
val = val + 1
DNGN_TELEPORTER_ICE_CAVE = val + 1
val = val + 1
DNGN_GOLDEN_STATUE = val + 1
val = val + 1
DNGN_GOLDEN_STATUE_1 = val + 1
val = val + 1
DNGN_SARCOPHAGUS_SEALED = val + 1
val = val + 1
DNGN_SARCOPHAGUS_PEDESTAL_LEFT = val + 1
val = val + 1
DNGN_SARCOPHAGUS_PEDESTAL_RIGHT = val + 1
val = val + 1
DNGN_STATUE_ELEPHANT_JADE = val + 1
val = val + 1
DNGN_STATUE_IRON_GOLEM = val + 1
val = val + 1
DNGN_DIMENSION_EDGE = val + 1
val = val + 1
DNGN_DISCO_BALL = val + 1
val = val + 1
PLACEHOLDER1 = val + 1
val = val + 1
PLACEHOLDER2 = val + 1
val = val + 1
PLACEHOLDER3 = val + 1
val = val + 1
DNGN_TRAP_DART = val + 1
val = val + 1
DNGN_TRAP_ARROW = val + 1
val = val + 1
DNGN_TRAP_NEEDLE = val + 1
val = val + 1
DNGN_TRAP_BOLT = val + 1
val = val + 1
DNGN_TRAP_SPEAR = val + 1
val = val + 1
DNGN_TRAP_BLADE = val + 1
val = val + 1
DNGN_TRAP_NET = val + 1
val = val + 1
DNGN_TRAP_ALARM = val + 1
val = val + 1
DNGN_TRAP_SHAFT = val + 1
val = val + 1
DNGN_TRAP_TELEPORT = val + 1
val = val + 1
DNGN_TRAP_TELEPORT_PERMANENT = val + 1
val = val + 1
DNGN_TRAP_ZOT = val + 1
val = val + 1
DNGN_TRAP_GOLUBRIA = val + 1
val = val + 1
DNGN_TRAP_PLATE = val + 1
val = val + 1
DNGN_TRAP_WEB = val + 1
val = val + 1
DNGN_TRAP_WEB_1 = val + 1
val = val + 1
DNGN_TRAP_WEB_2 = val + 1
val = val + 1
DNGN_TRAP_WEB_3 = val + 1
val = val + 1
DNGN_TRAP_WEB_4 = val + 1
val = val + 1
DNGN_TRAP_WEB_N = val + 1
val = val + 1
DNGN_TRAP_WEB_E = val + 1
val = val + 1
DNGN_TRAP_WEB_NE = val + 1
val = val + 1
DNGN_TRAP_WEB_S = val + 1
val = val + 1
DNGN_TRAP_WEB_NS = val + 1
val = val + 1
DNGN_TRAP_WEB_ES = val + 1
val = val + 1
DNGN_TRAP_WEB_NES = val + 1
val = val + 1
DNGN_TRAP_WEB_W = val + 1
val = val + 1
DNGN_TRAP_WEB_NW = val + 1
val = val + 1
DNGN_TRAP_WEB_EW = val + 1
val = val + 1
DNGN_TRAP_WEB_NEW = val + 1
val = val + 1
DNGN_TRAP_WEB_SW = val + 1
val = val + 1
DNGN_TRAP_WEB_NSW = val + 1
val = val + 1
DNGN_TRAP_WEB_ESW = val + 1
val = val + 1
DNGN_TRAP_WEB_NESW = val + 1
val = val + 1
DNGN_EXIT_DUNGEON = val + 1
val = val + 1
DNGN_STONE_STAIRS_DOWN = val + 1
val = val + 1
DNGN_STONE_STAIRS_UP = val + 1
val = val + 1
DNGN_ESCAPE_HATCH_DOWN = val + 1
val = val + 1
DNGN_ESCAPE_HATCH_UP = val + 1
val = val + 1
DNGN_SHOALS_STAIRS_DOWN = val + 1
val = val + 1
DNGN_SHOALS_STAIRS_UP = val + 1
val = val + 1
DNGN_ENTER = val + 1
val = val + 1
DNGN_RETURN = val + 1
val = val + 1
DNGN_SEALED_STAIRS_UP = val + 1
val = val + 1
DNGN_SEALED_STAIRS_DOWN = val + 1
val = val + 1
SHOP_GENERAL = val + 1
val = val + 1
SHOP_WEAPONS = val + 1
val = val + 1
SHOP_ARMOUR = val + 1
val = val + 1
SHOP_FOOD = val + 1
val = val + 1
SHOP_BOOKS = val + 1
val = val + 1
SHOP_SCROLLS = val + 1
val = val + 1
SHOP_WANDS = val + 1
val = val + 1
SHOP_JEWELLERY = val + 1
val = val + 1
SHOP_POTIONS = val + 1
val = val + 1
SHOP_GADGETS = val + 1
val = val + 1
DNGN_ABANDONED_SHOP = val + 1
val = val + 1
DNGN_ENTER_ZOT_CLOSED = val + 1
val = val + 1
DNGN_ENTER_ZOT_OPEN = val + 1
val = val + 1
DNGN_RETURN_ZOT = val + 1
val = val + 1
DNGN_ENTER_TEMPLE = val + 1
val = val + 1
DNGN_EXIT_TEMPLE = val + 1
val = val + 1
DNGN_ENTER_ORC = val + 1
val = val + 1
DNGN_EXIT_ORC = val + 1
val = val + 1
DNGN_ENTER_ELF = val + 1
val = val + 1
DNGN_EXIT_ELF = val + 1
val = val + 1
DNGN_ENTER_LAIR = val + 1
val = val + 1
DNGN_EXIT_LAIR = val + 1
val = val + 1
DNGN_ENTER_SNAKE = val + 1
val = val + 1
DNGN_EXIT_SNAKE = val + 1
val = val + 1
DNGN_ENTER_SWAMP = val + 1
val = val + 1
DNGN_EXIT_SWAMP = val + 1
val = val + 1
DNGN_ENTER_SPIDER = val + 1
val = val + 1
DNGN_EXIT_SPIDER = val + 1
val = val + 1
DNGN_ENTER_SHOALS = val + 1
val = val + 1
DNGN_EXIT_SHOALS = val + 1
val = val + 1
DNGN_ENTER_SLIME = val + 1
val = val + 1
DNGN_EXIT_SLIME = val + 1
val = val + 1
DNGN_ENTER_VAULTS_CLOSED = val + 1
val = val + 1
DNGN_ENTER_VAULTS_OPEN = val + 1
val = val + 1
DNGN_EXIT_VAULTS = val + 1
val = val + 1
DNGN_ENTER_DEPTHS = val + 1
val = val + 1
DNGN_RETURN_DEPTHS = val + 1
val = val + 1
DNGN_ENTER_CRYPT = val + 1
val = val + 1
DNGN_EXIT_CRYPT = val + 1
val = val + 1
DNGN_ENTER_TOMB = val + 1
val = val + 1
DNGN_EXIT_TOMB = val + 1
val = val + 1
DNGN_ENTER_HELL = val + 1
val = val + 1
DNGN_ENTER_HELL_1 = val + 1
val = val + 1
DNGN_ENTER_HELL_2 = val + 1
val = val + 1
DNGN_RETURN_VESTIBULE = val + 1
val = val + 1
DNGN_STONE_ARCH_HELL = val + 1
val = val + 1
DNGN_ENTER_DIS = val + 1
val = val + 1
DNGN_ENTER_DIS_1 = val + 1
val = val + 1
DNGN_ENTER_DIS_2 = val + 1
val = val + 1
DNGN_ENTER_GEHENNA = val + 1
val = val + 1
DNGN_ENTER_GEHENNA_1 = val + 1
val = val + 1
DNGN_ENTER_GEHENNA_2 = val + 1
val = val + 1
DNGN_ENTER_COCYTUS = val + 1
val = val + 1
DNGN_ENTER_COCYTUS_1 = val + 1
val = val + 1
DNGN_ENTER_COCYTUS_2 = val + 1
val = val + 1
DNGN_ENTER_TARTARUS = val + 1
val = val + 1
DNGN_ENTER_TARTARUS_1 = val + 1
val = val + 1
DNGN_ENTER_TARTARUS_2 = val + 1
val = val + 1
DNGN_RETURN_HELL = val + 1
val = val + 1
DNGN_ENTER_ABYSS = val + 1
val = val + 1
DNGN_ENTER_ABYSS_1 = val + 1
val = val + 1
DNGN_ENTER_ABYSS_2 = val + 1
val = val + 1
DNGN_EXIT_ABYSS = val + 1
val = val + 1
DNGN_EXIT_ABYSS_1 = val + 1
val = val + 1
DNGN_ABYSSAL_STAIR = val + 1
val = val + 1
DNGN_ENTER_PANDEMONIUM = val + 1
val = val + 1
DNGN_PORTAL = val + 1
val = val + 1
DNGN_PORTAL_1 = val + 1
val = val + 1
DNGN_PORTAL_EXPIRED = val + 1
val = val + 1
DNGN_STARRY_PORTAL = val + 1
val = val + 1
DNGN_TRANSIT_PANDEMONIUM = val + 1
val = val + 1
DNGN_EXIT_PANDEMONIUM = val + 1
val = val + 1
DNGN_EXIT_PANDEMONIUM_1 = val + 1
val = val + 1
DNGN_PORTAL_VOLCANO = val + 1
val = val + 1
DNGN_PORTAL_VOLCANO_GONE = val + 1
val = val + 1
DNGN_EXIT_VOLCANO = val + 1
val = val + 1
DNGN_PORTAL_SEWER = val + 1
val = val + 1
DNGN_PORTAL_SEWER_RUSTED = val + 1
val = val + 1
DNGN_PORTAL_ICE_CAVE = val + 1
val = val + 1
DNGN_PORTAL_ICE_CAVE_GONE = val + 1
val = val + 1
DNGN_PORTAL_WIZARD_LAB = val + 1
val = val + 1
DNGN_PORTAL_WIZARD_LAB_1 = val + 1
val = val + 1
DNGN_PORTAL_WIZARD_LAB_2 = val + 1
val = val + 1
DNGN_PORTAL_WIZARD_LAB_3 = val + 1
val = val + 1
DNGN_PORTAL_WIZARD_LAB_4 = val + 1
val = val + 1
DNGN_PORTAL_WIZARD_LAB_5 = val + 1
val = val + 1
DNGN_PORTAL_WIZARD_LAB_6 = val + 1
val = val + 1
DNGN_PORTAL_WIZARD_LAB_7 = val + 1
val = val + 1
DNGN_PORTAL_WIZLAB_GONE = val + 1
val = val + 1
DNGN_PORTAL_OSSUARY = val + 1
val = val + 1
DNGN_PORTAL_OSSUARY_GONE = val + 1
val = val + 1
DNGN_PORTAL_BAILEY = val + 1
val = val + 1
DNGN_PORTAL_BAILEY_GONE = val + 1
val = val + 1
DNGN_PORTAL_LABYRINTH = val + 1
val = val + 1
DNGN_PORTAL_LABYRINTH_GONE = val + 1
val = val + 1
DNGN_PORTAL_TROVE = val + 1
val = val + 1
DNGN_PORTAL_TROVE_GONE = val + 1
val = val + 1
DNGN_PORTAL_BAZAAR = val + 1
val = val + 1
DNGN_PORTAL_BAZAAR_GONE = val + 1
val = val + 1
DNGN_PORTAL_ZIGGURAT = val + 1
val = val + 1
DNGN_PORTAL_ZIGGURAT_GONE = val + 1
val = val + 1
DNGN_UNKNOWN_PORTAL = val + 1
val = val + 1
DNGN_UNSEEN_ALTAR = val + 1
val = val + 1
DNGN_ALTAR_ZIN = val + 1
val = val + 1
DNGN_ALTAR_SHINING_ONE = val + 1
val = val + 1
DNGN_ALTAR_KIKUBAAQUDGHA = val + 1
val = val + 1
DNGN_ALTAR_YREDELEMNUL = val + 1
val = val + 1
DNGN_ALTAR_XOM = val + 1
val = val + 1
DNGN_ALTAR_XOM_1 = val + 1
val = val + 1
DNGN_ALTAR_XOM_2 = val + 1
val = val + 1
DNGN_ALTAR_XOM_3 = val + 1
val = val + 1
DNGN_ALTAR_XOM_4 = val + 1
val = val + 1
DNGN_ALTAR_XOM_5 = val + 1
val = val + 1
DNGN_ALTAR_XOM_6 = val + 1
val = val + 1
DNGN_ALTAR_XOM_7 = val + 1
val = val + 1
DNGN_ALTAR_VEHUMET = val + 1
val = val + 1
DNGN_ALTAR_VEHUMET_1 = val + 1
val = val + 1
DNGN_ALTAR_OKAWARU = val + 1
val = val + 1
DNGN_ALTAR_MAKHLEB = val + 1
val = val + 1
DNGN_ALTAR_MAKHLEB_1 = val + 1
val = val + 1
DNGN_ALTAR_MAKHLEB_2 = val + 1
val = val + 1
DNGN_ALTAR_MAKHLEB_3 = val + 1
val = val + 1
DNGN_ALTAR_MAKHLEB_4 = val + 1
val = val + 1
DNGN_ALTAR_MAKHLEB_5 = val + 1
val = val + 1
DNGN_ALTAR_MAKHLEB_6 = val + 1
val = val + 1
DNGN_ALTAR_MAKHLEB_7 = val + 1
val = val + 1
DNGN_ALTAR_SIF_MUNA = val + 1
val = val + 1
DNGN_ALTAR_TROG = val + 1
val = val + 1
DNGN_ALTAR_NEMELEX_XOBEH = val + 1
val = val + 1
DNGN_ALTAR_NEMELEX_XOBEH_1 = val + 1
val = val + 1
DNGN_ALTAR_NEMELEX_XOBEH_2 = val + 1
val = val + 1
DNGN_ALTAR_NEMELEX_XOBEH_3 = val + 1
val = val + 1
DNGN_ALTAR_NEMELEX_XOBEH_4 = val + 1
val = val + 1
DNGN_ALTAR_ELYVILON = val + 1
val = val + 1
DNGN_ALTAR_LUGONU = val + 1
val = val + 1
DNGN_ALTAR_BEOGH = val + 1
val = val + 1
DNGN_ALTAR_JIYVA = val + 1
val = val + 1
DNGN_ALTAR_JIYVA_1 = val + 1
val = val + 1
DNGN_ALTAR_JIYVA_2 = val + 1
val = val + 1
DNGN_ALTAR_JIYVA_3 = val + 1
val = val + 1
DNGN_ALTAR_JIYVA_4 = val + 1
val = val + 1
DNGN_ALTAR_JIYVA_5 = val + 1
val = val + 1
DNGN_ALTAR_JIYVA_6 = val + 1
val = val + 1
DNGN_ALTAR_JIYVA_7 = val + 1
val = val + 1
DNGN_ALTAR_JIYVA_8 = val + 1
val = val + 1
DNGN_ALTAR_JIYVA_9 = val + 1
val = val + 1
DNGN_ALTAR_JIYVA_10 = val + 1
val = val + 1
DNGN_ALTAR_FEDHAS = val + 1
val = val + 1
DNGN_ALTAR_CHEIBRIADOS = val + 1
val = val + 1
DNGN_ALTAR_ASHENZARI = val + 1
val = val + 1
DNGN_ALTAR_DITHMENOS = val + 1
val = val + 1
DNGN_ALTAR_DITHMENOS_1 = val + 1
val = val + 1
DNGN_ALTAR_DITHMENOS_2 = val + 1
val = val + 1
DNGN_ALTAR_GOZAG = val + 1
val = val + 1
DNGN_ALTAR_GOZAG_1 = val + 1
val = val + 1
DNGN_ALTAR_GOZAG_2 = val + 1
val = val + 1
DNGN_ALTAR_QAZLAL = val + 1
val = val + 1
DNGN_ALTAR_QAZLAL_1 = val + 1
val = val + 1
DNGN_ALTAR_QAZLAL_2 = val + 1
val = val + 1
DNGN_ALTAR_RU = val + 1
val = val + 1
DNGN_ALTAR_PAKELLAS = val + 1
val = val + 1
DNGN_ALTAR_PAKELLAS_1 = val + 1
val = val + 1
DNGN_ALTAR_PAKELLAS_2 = val + 1
val = val + 1
DNGN_ALTAR_PAKELLAS_3 = val + 1
val = val + 1
DNGN_UNKNOWN_ALTAR = val + 1
val = val + 1
DNGN_FOUNTAIN = val + 1
val = val + 1
DNGN_BLUE_FOUNTAIN = val
DNGN_FOUNTAIN_1 = val + 1
val = val + 1
DNGN_SPARKLING_FOUNTAIN = val + 1
val = val + 1
DNGN_SPARKLING_FOUNTAIN_1 = val + 1
val = val + 1
DNGN_BLOOD_FOUNTAIN = val + 1
val = val + 1
DNGN_BLOOD_FOUNTAIN_1 = val + 1
val = val + 1
DNGN_DRY_FOUNTAIN = val + 1
val = val + 1
DNGN_DRY_FOUNTAIN_WHITE = val + 1
val = val + 1
DNGN_TELEPORTER = val + 1
val = val + 1
BLOOD = val + 1
val = val + 1
BLOOD_1 = val + 1
val = val + 1
BLOOD_2 = val + 1
val = val + 1
BLOOD_3 = val + 1
val = val + 1
BLOOD_4 = val + 1
val = val + 1
BLOOD_5 = val + 1
val = val + 1
BLOOD_6 = val + 1
val = val + 1
BLOOD_7 = val + 1
val = val + 1
BLOOD_8 = val + 1
val = val + 1
BLOOD_9 = val + 1
val = val + 1
BLOOD_10 = val + 1
val = val + 1
BLOOD_11 = val + 1
val = val + 1
BLOOD_12 = val + 1
val = val + 1
BLOOD_13 = val + 1
val = val + 1
BLOOD_14 = val + 1
val = val + 1
BLOOD_15 = val + 1
val = val + 1
BLOOD_16 = val + 1
val = val + 1
BLOOD_17 = val + 1
val = val + 1
BLOOD_18 = val + 1
val = val + 1
BLOOD_19 = val + 1
val = val + 1
BLOOD_20 = val + 1
val = val + 1
BLOOD_21 = val + 1
val = val + 1
BLOOD_22 = val + 1
val = val + 1
BLOOD_23 = val + 1
val = val + 1
BLOOD_24 = val + 1
val = val + 1
BLOOD_25 = val + 1
val = val + 1
BLOOD_26 = val + 1
val = val + 1
BLOOD_27 = val + 1
val = val + 1
BLOOD_28 = val + 1
val = val + 1
BLOOD_29 = val + 1
val = val + 1
WALL_BLOOD_S = val + 1
val = val + 1
WALL_BLOOD_S_1 = val + 1
val = val + 1
WALL_BLOOD_S_2 = val + 1
val = val + 1
WALL_BLOOD_S_3 = val + 1
val = val + 1
WALL_BLOOD_S_4 = val + 1
val = val + 1
WALL_BLOOD_S_5 = val + 1
val = val + 1
WALL_BLOOD_S_6 = val + 1
val = val + 1
WALL_BLOOD_S_7 = val + 1
val = val + 1
WALL_BLOOD_S_8 = val + 1
val = val + 1
WALL_BLOOD_S_9 = val + 1
val = val + 1
WALL_BLOOD_S_10 = val + 1
val = val + 1
WALL_BLOOD_S_11 = val + 1
val = val + 1
WALL_BLOOD_S_12 = val + 1
val = val + 1
WALL_BLOOD_S_13 = val + 1
val = val + 1
WALL_BLOOD_S_14 = val + 1
val = val + 1
WALL_BLOOD_S_15 = val + 1
val = val + 1
WALL_BLOOD_S_16 = val + 1
val = val + 1
WALL_BLOOD_S_17 = val + 1
val = val + 1
WALL_BLOOD_W = val + 1
val = val + 1
WALL_BLOOD_W_1 = val + 1
val = val + 1
WALL_BLOOD_W_2 = val + 1
val = val + 1
WALL_BLOOD_W_3 = val + 1
val = val + 1
WALL_BLOOD_W_4 = val + 1
val = val + 1
WALL_BLOOD_W_5 = val + 1
val = val + 1
WALL_BLOOD_W_6 = val + 1
val = val + 1
WALL_BLOOD_W_7 = val + 1
val = val + 1
WALL_BLOOD_W_8 = val + 1
val = val + 1
WALL_BLOOD_W_9 = val + 1
val = val + 1
WALL_BLOOD_W_10 = val + 1
val = val + 1
WALL_BLOOD_W_11 = val + 1
val = val + 1
WALL_BLOOD_W_12 = val + 1
val = val + 1
WALL_BLOOD_W_13 = val + 1
val = val + 1
WALL_BLOOD_W_14 = val + 1
val = val + 1
WALL_BLOOD_W_15 = val + 1
val = val + 1
WALL_BLOOD_W_16 = val + 1
val = val + 1
WALL_BLOOD_W_17 = val + 1
val = val + 1
WALL_BLOOD_N = val + 1
val = val + 1
WALL_BLOOD_N_1 = val + 1
val = val + 1
WALL_BLOOD_N_2 = val + 1
val = val + 1
WALL_BLOOD_N_3 = val + 1
val = val + 1
WALL_BLOOD_N_4 = val + 1
val = val + 1
WALL_BLOOD_N_5 = val + 1
val = val + 1
WALL_BLOOD_N_6 = val + 1
val = val + 1
WALL_BLOOD_N_7 = val + 1
val = val + 1
WALL_BLOOD_N_8 = val + 1
val = val + 1
WALL_BLOOD_N_9 = val + 1
val = val + 1
WALL_BLOOD_N_10 = val + 1
val = val + 1
WALL_BLOOD_N_11 = val + 1
val = val + 1
WALL_BLOOD_N_12 = val + 1
val = val + 1
WALL_BLOOD_N_13 = val + 1
val = val + 1
WALL_BLOOD_N_14 = val + 1
val = val + 1
WALL_BLOOD_N_15 = val + 1
val = val + 1
WALL_BLOOD_N_16 = val + 1
val = val + 1
WALL_BLOOD_N_17 = val + 1
val = val + 1
WALL_BLOOD_E = val + 1
val = val + 1
WALL_BLOOD_E_1 = val + 1
val = val + 1
WALL_BLOOD_E_2 = val + 1
val = val + 1
WALL_BLOOD_E_3 = val + 1
val = val + 1
WALL_BLOOD_E_4 = val + 1
val = val + 1
WALL_BLOOD_E_5 = val + 1
val = val + 1
WALL_BLOOD_E_6 = val + 1
val = val + 1
WALL_BLOOD_E_7 = val + 1
val = val + 1
WALL_BLOOD_E_8 = val + 1
val = val + 1
WALL_BLOOD_E_9 = val + 1
val = val + 1
WALL_BLOOD_E_10 = val + 1
val = val + 1
WALL_BLOOD_E_11 = val + 1
val = val + 1
WALL_BLOOD_E_12 = val + 1
val = val + 1
WALL_BLOOD_E_13 = val + 1
val = val + 1
WALL_BLOOD_E_14 = val + 1
val = val + 1
WALL_BLOOD_E_15 = val + 1
val = val + 1
WALL_BLOOD_E_16 = val + 1
val = val + 1
WALL_BLOOD_E_17 = val + 1
val = val + 1
WALL_OLD_BLOOD = val + 1
val = val + 1
WALL_OLD_BLOOD_1 = val + 1
val = val + 1
WALL_OLD_BLOOD_2 = val + 1
val = val + 1
WALL_OLD_BLOOD_3 = val + 1
val = val + 1
WALL_OLD_BLOOD_4 = val + 1
val = val + 1
WALL_OLD_BLOOD_5 = val + 1
val = val + 1
WALL_OLD_BLOOD_6 = val + 1
val = val + 1
WALL_OLD_BLOOD_7 = val + 1
val = val + 1
WALL_OLD_BLOOD_8 = val + 1
val = val + 1
WALL_OLD_BLOOD_9 = val + 1
val = val + 1
HALO = val + 1
val = val + 1
HALO_RANGE = val + 1
val = val + 1
UMBRA = val + 1
val = val + 1
UMBRA_1 = val + 1
val = val + 1
UMBRA_2 = val + 1
val = val + 1
UMBRA_3 = val + 1
val = val + 1
ORB_GLOW = val + 1
val = val + 1
ORB_GLOW_1 = val + 1
val = val + 1
QUAD_GLOW = val + 1
val = val + 1
DISJUNCT = val + 1
val = val + 1
DISJUNCT_1 = val + 1
val = val + 1
DISJUNCT_2 = val + 1
val = val + 1
DISJUNCT_3 = val + 1
val = val + 1
LANDING = val + 1
val = val + 1
HEAT_AURA = val + 1
val = val + 1
HEAT_AURA_1 = val + 1
val = val + 1
HEAT_AURA_2 = val + 1
val = val + 1
RAY = val + 1
val = val + 1
RAY_MULTI = val + 1
val = val + 1
RAY_OUT_OF_RANGE = val + 1
val = val + 1
TRAVEL_EXCLUSION_BG = val + 1
val = val + 1
TRAVEL_EXCLUSION_CENTRE_BG = val + 1
val = val + 1
SANCTUARY = val + 1
val = val + 1
MOLD = val + 1
val = val + 1
MOLD_1 = val + 1
val = val + 1
MOLD_2 = val + 1
val = val + 1
MOLD_3 = val + 1
val = val + 1
GLOWING_MOLD = val + 1
val = val + 1
GLOWING_MOLD_1 = val + 1
val = val + 1
GLOWING_MOLD_2 = val + 1
val = val + 1
GLOWING_MOLD_3 = val + 1
val = val + 1
SILENCED = val + 1
val = val + 1
KRAKEN_OVERLAY_NW = val + 1
val = val + 1
KRAKEN_OVERLAY_NE = val + 1
val = val + 1
KRAKEN_OVERLAY_SE = val + 1
val = val + 1
KRAKEN_OVERLAY_SW = val + 1
val = val + 1
ELDRITCH_OVERLAY_NW = val + 1
val = val + 1
ELDRITCH_OVERLAY_NE = val + 1
val = val + 1
ELDRITCH_OVERLAY_SE = val + 1
val = val + 1
ELDRITCH_OVERLAY_SW = val + 1
val = val + 1
STARSPAWN_OVERLAY_NW = val + 1
val = val + 1
STARSPAWN_OVERLAY_NE = val + 1
val = val + 1
STARSPAWN_OVERLAY_SE = val + 1
val = val + 1
STARSPAWN_OVERLAY_SW = val + 1
val = val + 1
VINE_OVERLAY_NW = val + 1
val = val + 1
VINE_OVERLAY_NE = val + 1
val = val + 1
VINE_OVERLAY_SE = val + 1
val = val + 1
VINE_OVERLAY_SW = val + 1
val = val + 1
TILE_FEAT_MAX = val + 1
FEAT_MAX = TILE_FEAT_MAX
val = val + 1

tileinfo.tile_info = {
  {w = 32, h = 32, ox = 3, oy = 0, sx = 0, sy = 0, ex = 29, ey = 32},
  {w = 32, h = 32, ox = 3, oy = 0, sx = 29, sy = 0, ex = 58, ey = 32},
  {w = 32, h = 32, ox = 2, oy = 0, sx = 58, sy = 0, ex = 88, ey = 32},
  {w = 32, h = 32, ox = 2, oy = 0, sx = 88, sy = 0, ex = 118, ey = 32},
  {w = 32, h = 32, ox = 2, oy = 0, sx = 118, sy = 0, ex = 148, ey = 32},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 148, sy = 0, ex = 180, ey = 32},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 180, sy = 0, ex = 212, ey = 32},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 212, sy = 0, ex = 244, ey = 32},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 244, sy = 0, ex = 276, ey = 32},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 276, sy = 0, ex = 308, ey = 32},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 308, sy = 0, ex = 340, ey = 32},
  {w = 32, h = 32, ox = 5, oy = 0, sx = 340, sy = 0, ex = 362, ey = 32},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 362, sy = 0, ex = 394, ey = 32},
  {w = 32, h = 32, ox = 4, oy = 0, sx = 394, sy = 0, ex = 422, ey = 32},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 422, sy = 0, ex = 454, ey = 32},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 454, sy = 0, ex = 486, ey = 32},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 486, sy = 0, ex = 518, ey = 32},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 518, sy = 0, ex = 550, ey = 32},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 550, sy = 0, ex = 582, ey = 32},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 582, sy = 0, ex = 614, ey = 32},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 614, sy = 0, ex = 646, ey = 32},
  {w = 32, h = 32, ox = 3, oy = 0, sx = 646, sy = 0, ex = 675, ey = 32},
  {w = 32, h = 32, ox = 3, oy = 0, sx = 675, sy = 0, ex = 704, ey = 32},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 704, sy = 0, ex = 736, ey = 32},
  {w = 32, h = 32, ox = 3, oy = 0, sx = 736, sy = 0, ex = 765, ey = 32},
  {w = 32, h = 32, ox = 3, oy = 0, sx = 765, sy = 0, ex = 794, ey = 32},
  {w = 32, h = 32, ox = 3, oy = 0, sx = 794, sy = 0, ex = 823, ey = 32},
  {w = 32, h = 32, ox = 3, oy = 0, sx = 823, sy = 0, ex = 852, ey = 32},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 852, sy = 0, ex = 884, ey = 32},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 884, sy = 0, ex = 916, ey = 32},
  {w = 32, h = 32, ox = 4, oy = 3, sx = 916, sy = 0, ex = 942, ey = 29},
  {w = 32, h = 32, ox = 2, oy = 0, sx = 942, sy = 0, ex = 972, ey = 32},
  {w = 32, h = 32, ox = 1, oy = 0, sx = 972, sy = 0, ex = 1002, ey = 32},
  {w = 32, h = 32, ox = 1, oy = 1, sx = 0, sy = 32, ex = 30, ey = 63},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 30, sy = 32, ex = 62, ey = 64},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 62, sy = 32, ex = 94, ey = 64},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 94, sy = 32, ex = 126, ey = 64},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 126, sy = 32, ex = 158, ey = 64},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 158, sy = 32, ex = 190, ey = 64},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 190, sy = 32, ex = 222, ey = 64},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 222, sy = 32, ex = 254, ey = 64},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 254, sy = 32, ex = 286, ey = 64},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 286, sy = 32, ex = 318, ey = 64},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 318, sy = 32, ex = 350, ey = 64},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 350, sy = 32, ex = 382, ey = 40},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 382, sy = 32, ex = 414, ey = 64},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 414, sy = 32, ex = 446, ey = 64},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 446, sy = 32, ex = 478, ey = 64},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 478, sy = 32, ex = 510, ey = 64},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 510, sy = 32, ex = 542, ey = 64},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 542, sy = 32, ex = 574, ey = 64},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 574, sy = 32, ex = 606, ey = 64},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 606, sy = 32, ex = 638, ey = 64},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 638, sy = 32, ex = 670, ey = 64},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 670, sy = 32, ex = 702, ey = 64},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 702, sy = 32, ex = 734, ey = 64},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 734, sy = 32, ex = 766, ey = 64},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 766, sy = 32, ex = 798, ey = 64},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 798, sy = 32, ex = 830, ey = 64},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 830, sy = 32, ex = 862, ey = 64},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 862, sy = 32, ex = 894, ey = 64},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 894, sy = 32, ex = 926, ey = 64},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 926, sy = 32, ex = 958, ey = 64},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 958, sy = 32, ex = 990, ey = 64},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 990, sy = 32, ex = 1022, ey = 64},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 0, sy = 64, ex = 32, ey = 96},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 32, sy = 64, ex = 64, ey = 96},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 64, sy = 64, ex = 96, ey = 96},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 96, sy = 64, ex = 128, ey = 96},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 128, sy = 64, ex = 160, ey = 96},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 160, sy = 64, ex = 192, ey = 96},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 192, sy = 64, ex = 224, ey = 96},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 224, sy = 64, ex = 256, ey = 72},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 256, sy = 64, ex = 288, ey = 96},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 288, sy = 64, ex = 320, ey = 96},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 320, sy = 64, ex = 352, ey = 96},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 352, sy = 64, ex = 384, ey = 96},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 384, sy = 64, ex = 416, ey = 96},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 416, sy = 64, ex = 448, ey = 96},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 448, sy = 64, ex = 480, ey = 96},
  {w = 32, h = 32, ox = 3, oy = 0, sx = 480, sy = 64, ex = 507, ey = 96},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 507, sy = 64, ex = 539, ey = 95},
  {w = 32, h = 32, ox = 1, oy = 0, sx = 539, sy = 64, ex = 570, ey = 95},
  {w = 32, h = 32, ox = 0, oy = 1, sx = 570, sy = 64, ex = 602, ey = 94},
  {w = 32, h = 32, ox = 1, oy = 0, sx = 602, sy = 64, ex = 633, ey = 95},
  {w = 32, h = 32, ox = 0, oy = 2, sx = 633, sy = 64, ex = 665, ey = 93},
  {w = 32, h = 32, ox = 1, oy = 1, sx = 665, sy = 64, ex = 696, ey = 94},
  {w = 32, h = 32, ox = 1, oy = 0, sx = 696, sy = 64, ex = 727, ey = 95},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 727, sy = 64, ex = 759, ey = 96},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 759, sy = 64, ex = 791, ey = 95},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 791, sy = 64, ex = 823, ey = 95},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 823, sy = 64, ex = 855, ey = 96},
  {w = 32, h = 32, ox = 1, oy = 0, sx = 855, sy = 64, ex = 886, ey = 95},
  {w = 32, h = 32, ox = 1, oy = 0, sx = 886, sy = 64, ex = 917, ey = 96},
  {w = 32, h = 32, ox = 1, oy = 1, sx = 917, sy = 64, ex = 948, ey = 94},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 948, sy = 64, ex = 980, ey = 95},
  {w = 32, h = 32, ox = 1, oy = 2, sx = 980, sy = 64, ex = 1011, ey = 93},
  {w = 32, h = 32, ox = 1, oy = 0, sx = 0, sy = 96, ex = 31, ey = 127},
  {w = 32, h = 32, ox = 1, oy = 0, sx = 31, sy = 96, ex = 62, ey = 127},
  {w = 32, h = 32, ox = 1, oy = 0, sx = 62, sy = 96, ex = 93, ey = 127},
  {w = 32, h = 32, ox = 1, oy = 0, sx = 93, sy = 96, ex = 124, ey = 127},
  {w = 32, h = 32, ox = 2, oy = 0, sx = 124, sy = 96, ex = 153, ey = 127},
  {w = 32, h = 32, ox = 1, oy = 0, sx = 153, sy = 96, ex = 184, ey = 128},
  {w = 32, h = 32, ox = 1, oy = 0, sx = 184, sy = 96, ex = 215, ey = 127},
  {w = 32, h = 32, ox = 1, oy = 0, sx = 215, sy = 96, ex = 246, ey = 127},
  {w = 32, h = 32, ox = 2, oy = 1, sx = 246, sy = 96, ex = 276, ey = 126},
  {w = 32, h = 32, ox = 5, oy = 1, sx = 276, sy = 96, ex = 298, ey = 126},
  {w = 32, h = 32, ox = 5, oy = 5, sx = 298, sy = 96, ex = 320, ey = 122},
  {w = 32, h = 32, ox = 5, oy = 1, sx = 320, sy = 96, ex = 342, ey = 126},
  {w = 32, h = 32, ox = 5, oy = 11, sx = 342, sy = 96, ex = 368, ey = 116},
  {w = 32, h = 32, ox = 5, oy = 1, sx = 368, sy = 96, ex = 390, ey = 126},
  {w = 32, h = 32, ox = 0, oy = 8, sx = 390, sy = 96, ex = 417, ey = 120},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 417, sy = 96, ex = 449, ey = 127},
  {w = 32, h = 32, ox = 0, oy = 3, sx = 449, sy = 96, ex = 481, ey = 125},
  {w = 32, h = 32, ox = 0, oy = 3, sx = 481, sy = 96, ex = 513, ey = 125},
  {w = 32, h = 32, ox = 0, oy = 3, sx = 513, sy = 96, ex = 545, ey = 125},
  {w = 32, h = 32, ox = 0, oy = 1, sx = 545, sy = 96, ex = 577, ey = 127},
  {w = 32, h = 32, ox = 0, oy = 7, sx = 577, sy = 96, ex = 609, ey = 114},
  {w = 32, h = 32, ox = 1, oy = 2, sx = 609, sy = 96, ex = 640, ey = 126},
  {w = 32, h = 32, ox = 1, oy = 2, sx = 640, sy = 96, ex = 671, ey = 126},
  {w = 32, h = 32, ox = 8, oy = 0, sx = 671, sy = 96, ex = 687, ey = 128},
  {w = 32, h = 32, ox = 0, oy = 3, sx = 687, sy = 96, ex = 719, ey = 125},
  {w = 32, h = 32, ox = 0, oy = 3, sx = 719, sy = 96, ex = 751, ey = 125},
  {w = 32, h = 32, ox = 1, oy = 0, sx = 751, sy = 96, ex = 782, ey = 128},
  {w = 32, h = 32, ox = 1, oy = 0, sx = 782, sy = 96, ex = 813, ey = 127},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 813, sy = 96, ex = 845, ey = 128},
  {w = 32, h = 32, ox = 1, oy = 4, sx = 845, sy = 96, ex = 875, ey = 120},
  {w = 32, h = 32, ox = 6, oy = 6, sx = 875, sy = 96, ex = 896, ey = 119},
  {w = 32, h = 32, ox = 6, oy = 6, sx = 896, sy = 96, ex = 917, ey = 119},
  {w = 32, h = 32, ox = 6, oy = 6, sx = 917, sy = 96, ex = 938, ey = 119},
  {w = 32, h = 32, ox = 1, oy = 9, sx = 938, sy = 96, ex = 968, ey = 117},
  {w = 32, h = 32, ox = 1, oy = 8, sx = 968, sy = 96, ex = 998, ey = 118},
  {w = 32, h = 32, ox = 1, oy = 9, sx = 0, sy = 128, ex = 30, ey = 149},
  {w = 32, h = 32, ox = 1, oy = 9, sx = 30, sy = 128, ex = 60, ey = 149},
  {w = 32, h = 32, ox = 1, oy = 7, sx = 60, sy = 128, ex = 90, ey = 151},
  {w = 32, h = 32, ox = 1, oy = 6, sx = 90, sy = 128, ex = 120, ey = 152},
  {w = 32, h = 32, ox = 1, oy = 9, sx = 120, sy = 128, ex = 150, ey = 149},
  {w = 32, h = 32, ox = 0, oy = 5, sx = 150, sy = 128, ex = 182, ey = 150},
  {w = 32, h = 32, ox = 1, oy = 5, sx = 182, sy = 128, ex = 212, ey = 150},
  {w = 32, h = 32, ox = 0, oy = 5, sx = 212, sy = 128, ex = 244, ey = 150},
  {w = 32, h = 32, ox = 0, oy = 5, sx = 244, sy = 128, ex = 276, ey = 150},
  {w = 32, h = 32, ox = 0, oy = 5, sx = 276, sy = 128, ex = 308, ey = 150},
  {w = 32, h = 32, ox = 7, oy = 2, sx = 308, sy = 128, ex = 326, ey = 156},
  {w = 32, h = 32, ox = 1, oy = 6, sx = 326, sy = 128, ex = 356, ey = 149},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 356, sy = 128, ex = 388, ey = 160},
  {w = 32, h = 32, ox = 0, oy = 1, sx = 388, sy = 128, ex = 416, ey = 159},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 416, sy = 128, ex = 447, ey = 160},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 447, sy = 128, ex = 479, ey = 160},
  {w = 32, h = 32, ox = 2, oy = 3, sx = 479, sy = 128, ex = 508, ey = 155},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 508, sy = 128, ex = 540, ey = 160},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 540, sy = 128, ex = 572, ey = 160},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 572, sy = 128, ex = 604, ey = 160},
  {w = 32, h = 32, ox = 0, oy = 2, sx = 604, sy = 128, ex = 636, ey = 158},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 636, sy = 128, ex = 668, ey = 160},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 668, sy = 128, ex = 700, ey = 160},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 700, sy = 128, ex = 732, ey = 160},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 732, sy = 128, ex = 764, ey = 160},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 764, sy = 128, ex = 796, ey = 160},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 796, sy = 128, ex = 828, ey = 160},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 828, sy = 128, ex = 860, ey = 160},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 860, sy = 128, ex = 892, ey = 160},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 892, sy = 128, ex = 924, ey = 160},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 924, sy = 128, ex = 956, ey = 160},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 956, sy = 128, ex = 988, ey = 160},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 988, sy = 128, ex = 1020, ey = 160},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 0, sy = 160, ex = 32, ey = 192},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 32, sy = 160, ex = 64, ey = 192},
  {w = 32, h = 32, ox = 1, oy = 3, sx = 64, sy = 160, ex = 94, ey = 185},
  {w = 32, h = 32, ox = 3, oy = 1, sx = 94, sy = 160, ex = 120, ey = 191},
  {w = 32, h = 32, ox = 0, oy = 2, sx = 120, sy = 160, ex = 151, ey = 189},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 151, sy = 160, ex = 183, ey = 192},
  {w = 32, h = 32, ox = 0, oy = 2, sx = 183, sy = 160, ex = 215, ey = 189},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 215, sy = 160, ex = 247, ey = 192},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 247, sy = 160, ex = 279, ey = 192},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 279, sy = 160, ex = 311, ey = 192},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 311, sy = 160, ex = 343, ey = 192},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 343, sy = 160, ex = 375, ey = 192},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 375, sy = 160, ex = 407, ey = 192},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 407, sy = 160, ex = 439, ey = 192},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 439, sy = 160, ex = 471, ey = 192},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 471, sy = 160, ex = 503, ey = 192},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 503, sy = 160, ex = 535, ey = 192},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 535, sy = 160, ex = 567, ey = 192},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 567, sy = 160, ex = 599, ey = 192},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 599, sy = 160, ex = 631, ey = 192},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 631, sy = 160, ex = 663, ey = 192},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 663, sy = 160, ex = 695, ey = 192},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 695, sy = 160, ex = 727, ey = 192},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 727, sy = 160, ex = 759, ey = 192},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 759, sy = 160, ex = 791, ey = 192},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 791, sy = 160, ex = 823, ey = 192},
  {w = 32, h = 32, ox = 0, oy = 1, sx = 823, sy = 160, ex = 855, ey = 190},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 855, sy = 160, ex = 887, ey = 192},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 887, sy = 160, ex = 919, ey = 192},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 919, sy = 160, ex = 951, ey = 192},
  {w = 32, h = 32, ox = 0, oy = 1, sx = 951, sy = 160, ex = 983, ey = 191},
  {w = 32, h = 32, ox = 0, oy = 3, sx = 983, sy = 160, ex = 1015, ey = 189},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 0, sy = 192, ex = 32, ey = 224},
  {w = 32, h = 32, ox = 0, oy = 2, sx = 32, sy = 192, ex = 64, ey = 222},
  {w = 32, h = 32, ox = 0, oy = 4, sx = 64, sy = 192, ex = 96, ey = 219},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 96, sy = 192, ex = 128, ey = 224},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 128, sy = 192, ex = 160, ey = 224},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 160, sy = 192, ex = 192, ey = 224},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 192, sy = 192, ex = 224, ey = 224},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 224, sy = 192, ex = 256, ey = 224},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 256, sy = 192, ex = 288, ey = 224},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 288, sy = 192, ex = 320, ey = 224},
  {w = 32, h = 32, ox = 1, oy = 1, sx = 320, sy = 192, ex = 350, ey = 222},
  {w = 32, h = 32, ox = 1, oy = 1, sx = 350, sy = 192, ex = 380, ey = 222},
  {w = 32, h = 32, ox = 1, oy = 1, sx = 380, sy = 192, ex = 410, ey = 222},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 410, sy = 192, ex = 442, ey = 224},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 442, sy = 192, ex = 474, ey = 224},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 474, sy = 192, ex = 506, ey = 224},
  {w = 32, h = 32, ox = 3, oy = 0, sx = 506, sy = 192, ex = 532, ey = 224},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 532, sy = 192, ex = 564, ey = 224},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 564, sy = 192, ex = 596, ey = 222},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 596, sy = 192, ex = 627, ey = 224},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 627, sy = 192, ex = 658, ey = 224},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 658, sy = 192, ex = 690, ey = 224},
  {w = 32, h = 32, ox = 1, oy = 0, sx = 690, sy = 192, ex = 719, ey = 224},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 719, sy = 192, ex = 750, ey = 224},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 750, sy = 192, ex = 781, ey = 224},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 781, sy = 192, ex = 812, ey = 224},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 812, sy = 192, ex = 844, ey = 224},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 844, sy = 192, ex = 875, ey = 224},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 875, sy = 192, ex = 906, ey = 224},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 906, sy = 192, ex = 938, ey = 224},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 938, sy = 192, ex = 969, ey = 224},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 969, sy = 192, ex = 1000, ey = 224},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 0, sy = 224, ex = 32, ey = 256},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 32, sy = 224, ex = 63, ey = 256},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 63, sy = 224, ex = 94, ey = 256},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 94, sy = 224, ex = 126, ey = 256},
  {w = 32, h = 32, ox = 1, oy = 0, sx = 126, sy = 224, ex = 155, ey = 256},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 155, sy = 224, ex = 187, ey = 256},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 187, sy = 224, ex = 219, ey = 256},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 219, sy = 224, ex = 251, ey = 256},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 251, sy = 224, ex = 283, ey = 256},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 283, sy = 224, ex = 315, ey = 256},
  {w = 32, h = 32, ox = 5, oy = 0, sx = 315, sy = 224, ex = 336, ey = 256},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 336, sy = 224, ex = 368, ey = 256},
  {w = 32, h = 32, ox = 3, oy = 2, sx = 368, sy = 224, ex = 394, ey = 253},
  {w = 32, h = 32, ox = 3, oy = 2, sx = 394, sy = 224, ex = 420, ey = 253},
  {w = 32, h = 32, ox = 3, oy = 2, sx = 420, sy = 224, ex = 446, ey = 253},
  {w = 32, h = 32, ox = 3, oy = 2, sx = 446, sy = 224, ex = 472, ey = 253},
  {w = 32, h = 32, ox = 2, oy = 0, sx = 472, sy = 224, ex = 500, ey = 256},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 500, sy = 224, ex = 532, ey = 256},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 532, sy = 224, ex = 564, ey = 256},
  {w = 32, h = 32, ox = 1, oy = 1, sx = 564, sy = 224, ex = 595, ey = 255},
  {w = 32, h = 32, ox = 0, oy = 1, sx = 595, sy = 224, ex = 627, ey = 255},
  {w = 32, h = 32, ox = 0, oy = 1, sx = 627, sy = 224, ex = 658, ey = 255},
  {w = 32, h = 32, ox = 2, oy = 2, sx = 658, sy = 224, ex = 686, ey = 254},
  {w = 32, h = 32, ox = 2, oy = 2, sx = 686, sy = 224, ex = 714, ey = 252},
  {w = 32, h = 32, ox = 1, oy = 0, sx = 714, sy = 224, ex = 743, ey = 256},
  {w = 32, h = 32, ox = 1, oy = 0, sx = 743, sy = 224, ex = 772, ey = 256},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 772, sy = 224, ex = 804, ey = 256},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 804, sy = 224, ex = 836, ey = 256},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 836, sy = 224, ex = 868, ey = 256},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 868, sy = 224, ex = 900, ey = 256},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 900, sy = 224, ex = 932, ey = 256},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 932, sy = 224, ex = 964, ey = 256},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 964, sy = 224, ex = 996, ey = 256},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 0, sy = 256, ex = 32, ey = 288},
  {w = 32, h = 32, ox = 0, oy = 7, sx = 32, sy = 256, ex = 64, ey = 281},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 64, sy = 256, ex = 96, ey = 288},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 96, sy = 256, ex = 128, ey = 288},
  {w = 32, h = 32, ox = 2, oy = 0, sx = 128, sy = 256, ex = 158, ey = 288},
  {w = 32, h = 32, ox = 2, oy = 4, sx = 158, sy = 256, ex = 184, ey = 284},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 184, sy = 256, ex = 216, ey = 288},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 216, sy = 256, ex = 248, ey = 288},
  {w = 32, h = 32, ox = 4, oy = 0, sx = 248, sy = 256, ex = 273, ey = 288},
  {w = 32, h = 32, ox = 4, oy = 0, sx = 273, sy = 256, ex = 297, ey = 288},
  {w = 32, h = 32, ox = 3, oy = 1, sx = 297, sy = 256, ex = 323, ey = 287},
  {w = 32, h = 32, ox = 3, oy = 1, sx = 323, sy = 256, ex = 349, ey = 287},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 349, sy = 256, ex = 381, ey = 288},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 381, sy = 256, ex = 413, ey = 288},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 413, sy = 256, ex = 445, ey = 288},
  {w = 32, h = 32, ox = 1, oy = 2, sx = 445, sy = 256, ex = 475, ey = 286},
  {w = 32, h = 32, ox = 1, oy = 0, sx = 475, sy = 256, ex = 505, ey = 288},
  {w = 32, h = 32, ox = 2, oy = 0, sx = 505, sy = 256, ex = 533, ey = 288},
  {w = 32, h = 32, ox = 2, oy = 3, sx = 533, sy = 256, ex = 561, ey = 285},
  {w = 32, h = 32, ox = 2, oy = 1, sx = 561, sy = 256, ex = 589, ey = 287},
  {w = 32, h = 32, ox = 2, oy = 2, sx = 589, sy = 256, ex = 617, ey = 286},
  {w = 32, h = 32, ox = 2, oy = 2, sx = 617, sy = 256, ex = 645, ey = 286},
  {w = 32, h = 32, ox = 2, oy = 2, sx = 645, sy = 256, ex = 673, ey = 286},
  {w = 32, h = 32, ox = 2, oy = 2, sx = 673, sy = 256, ex = 701, ey = 286},
  {w = 32, h = 32, ox = 2, oy = 2, sx = 701, sy = 256, ex = 729, ey = 286},
  {w = 32, h = 32, ox = 2, oy = 2, sx = 729, sy = 256, ex = 757, ey = 286},
  {w = 32, h = 32, ox = 2, oy = 2, sx = 757, sy = 256, ex = 785, ey = 286},
  {w = 32, h = 32, ox = 2, oy = 2, sx = 785, sy = 256, ex = 813, ey = 286},
  {w = 32, h = 32, ox = 1, oy = 0, sx = 813, sy = 256, ex = 843, ey = 288},
  {w = 32, h = 32, ox = 1, oy = 0, sx = 843, sy = 256, ex = 873, ey = 288},
  {w = 32, h = 32, ox = 2, oy = 0, sx = 873, sy = 256, ex = 901, ey = 288},
  {w = 32, h = 32, ox = 2, oy = 0, sx = 901, sy = 256, ex = 929, ey = 288},
  {w = 32, h = 32, ox = 2, oy = 0, sx = 929, sy = 256, ex = 957, ey = 288},
  {w = 32, h = 32, ox = 2, oy = 0, sx = 957, sy = 256, ex = 985, ey = 288},
  {w = 32, h = 32, ox = 2, oy = 0, sx = 985, sy = 256, ex = 1013, ey = 288},
  {w = 32, h = 32, ox = 2, oy = 0, sx = 0, sy = 288, ex = 28, ey = 320},
  {w = 32, h = 32, ox = 2, oy = 0, sx = 28, sy = 288, ex = 56, ey = 320},
  {w = 32, h = 32, ox = 2, oy = 0, sx = 56, sy = 288, ex = 84, ey = 320},
  {w = 32, h = 32, ox = 2, oy = 0, sx = 84, sy = 288, ex = 112, ey = 320},
  {w = 32, h = 32, ox = 2, oy = 3, sx = 112, sy = 288, ex = 140, ey = 317},
  {w = 32, h = 32, ox = 2, oy = 7, sx = 140, sy = 288, ex = 168, ey = 313},
  {w = 32, h = 32, ox = 1, oy = 1, sx = 168, sy = 288, ex = 197, ey = 319},
  {w = 32, h = 32, ox = 1, oy = 1, sx = 197, sy = 288, ex = 226, ey = 319},
  {w = 32, h = 32, ox = 1, oy = 1, sx = 226, sy = 288, ex = 255, ey = 319},
  {w = 32, h = 32, ox = 1, oy = 1, sx = 255, sy = 288, ex = 284, ey = 319},
  {w = 32, h = 32, ox = 1, oy = 1, sx = 284, sy = 288, ex = 313, ey = 319},
  {w = 32, h = 32, ox = 2, oy = 4, sx = 313, sy = 288, ex = 341, ey = 316},
  {w = 32, h = 32, ox = 2, oy = 0, sx = 341, sy = 288, ex = 369, ey = 320},
  {w = 32, h = 32, ox = 2, oy = 1, sx = 369, sy = 288, ex = 397, ey = 319},
  {w = 32, h = 32, ox = 2, oy = 11, sx = 397, sy = 288, ex = 425, ey = 309},
  {w = 32, h = 32, ox = 2, oy = 11, sx = 425, sy = 288, ex = 453, ey = 309},
  {w = 32, h = 32, ox = 2, oy = 11, sx = 453, sy = 288, ex = 481, ey = 309},
  {w = 32, h = 32, ox = 2, oy = 12, sx = 481, sy = 288, ex = 509, ey = 308},
  {w = 32, h = 32, ox = 2, oy = 10, sx = 509, sy = 288, ex = 537, ey = 310},
  {w = 32, h = 32, ox = 2, oy = 11, sx = 537, sy = 288, ex = 565, ey = 309},
  {w = 32, h = 32, ox = 2, oy = 11, sx = 565, sy = 288, ex = 593, ey = 309},
  {w = 32, h = 32, ox = 2, oy = 10, sx = 593, sy = 288, ex = 621, ey = 310},
  {w = 32, h = 32, ox = 2, oy = 10, sx = 621, sy = 288, ex = 649, ey = 310},
  {w = 32, h = 32, ox = 2, oy = 12, sx = 649, sy = 288, ex = 677, ey = 308},
  {w = 32, h = 32, ox = 2, oy = 12, sx = 677, sy = 288, ex = 705, ey = 308},
  {w = 32, h = 32, ox = 1, oy = 0, sx = 705, sy = 288, ex = 735, ey = 320},
  {w = 32, h = 32, ox = 2, oy = 1, sx = 735, sy = 288, ex = 763, ey = 319},
  {w = 30, h = 31, ox = 0, oy = 0, sx = 763, sy = 288, ex = 793, ey = 319},
  {w = 32, h = 32, ox = 2, oy = 2, sx = 793, sy = 288, ex = 821, ey = 318},
  {w = 32, h = 32, ox = 2, oy = 1, sx = 821, sy = 288, ex = 849, ey = 319},
  {w = 32, h = 32, ox = 2, oy = 3, sx = 849, sy = 288, ex = 877, ey = 317},
  {w = 32, h = 32, ox = 2, oy = 0, sx = 877, sy = 288, ex = 907, ey = 320},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 907, sy = 288, ex = 939, ey = 320},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 939, sy = 288, ex = 971, ey = 320},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 971, sy = 288, ex = 1003, ey = 320},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 0, sy = 320, ex = 32, ey = 352},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 32, sy = 320, ex = 64, ey = 352},
  {w = 32, h = 32, ox = 1, oy = 1, sx = 64, sy = 320, ex = 94, ey = 351},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 94, sy = 320, ex = 126, ey = 352},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 126, sy = 320, ex = 158, ey = 352},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 158, sy = 320, ex = 190, ey = 352},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 190, sy = 320, ex = 222, ey = 352},
  {w = 32, h = 32, ox = 2, oy = 5, sx = 222, sy = 320, ex = 250, ey = 347},
  {w = 32, h = 32, ox = 1, oy = 0, sx = 250, sy = 320, ex = 281, ey = 352},
  {w = 32, h = 32, ox = 1, oy = 0, sx = 281, sy = 320, ex = 312, ey = 352},
  {w = 32, h = 32, ox = 1, oy = 0, sx = 312, sy = 320, ex = 343, ey = 352},
  {w = 32, h = 32, ox = 1, oy = 0, sx = 343, sy = 320, ex = 374, ey = 352},
  {w = 32, h = 32, ox = 1, oy = 0, sx = 374, sy = 320, ex = 405, ey = 352},
  {w = 32, h = 32, ox = 1, oy = 0, sx = 405, sy = 320, ex = 436, ey = 352},
  {w = 32, h = 32, ox = 1, oy = 0, sx = 436, sy = 320, ex = 467, ey = 352},
  {w = 32, h = 32, ox = 1, oy = 0, sx = 467, sy = 320, ex = 498, ey = 352},
  {w = 32, h = 32, ox = 0, oy = 7, sx = 498, sy = 320, ex = 530, ey = 338},
  {w = 32, h = 32, ox = 4, oy = 3, sx = 530, sy = 320, ex = 557, ey = 348},
  {w = 32, h = 32, ox = 3, oy = 0, sx = 557, sy = 320, ex = 584, ey = 351},
  {w = 32, h = 32, ox = 1, oy = 1, sx = 584, sy = 320, ex = 613, ey = 349},
  {w = 32, h = 32, ox = 3, oy = 2, sx = 613, sy = 320, ex = 639, ey = 349},
  {w = 32, h = 32, ox = 2, oy = 1, sx = 639, sy = 320, ex = 664, ey = 347},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 664, sy = 320, ex = 696, ey = 347},
  {w = 32, h = 32, ox = 3, oy = 2, sx = 696, sy = 320, ex = 716, ey = 347},
  {w = 32, h = 32, ox = 4, oy = 0, sx = 716, sy = 320, ex = 741, ey = 350},
  {w = 32, h = 32, ox = 1, oy = 2, sx = 741, sy = 320, ex = 771, ey = 350},
  {w = 32, h = 32, ox = 4, oy = 3, sx = 771, sy = 320, ex = 794, ey = 348},
  {w = 32, h = 32, ox = 2, oy = 2, sx = 794, sy = 320, ex = 822, ey = 350},
  {w = 32, h = 32, ox = 2, oy = 4, sx = 822, sy = 320, ex = 848, ey = 347},
  {w = 32, h = 32, ox = 5, oy = 4, sx = 848, sy = 320, ex = 873, ey = 347},
  {w = 32, h = 32, ox = 0, oy = 2, sx = 873, sy = 320, ex = 902, ey = 348},
  {w = 32, h = 32, ox = 3, oy = 1, sx = 902, sy = 320, ex = 931, ey = 350},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 931, sy = 320, ex = 962, ey = 350},
  {w = 32, h = 32, ox = 4, oy = 4, sx = 962, sy = 320, ex = 990, ey = 347},
  {w = 32, h = 32, ox = 1, oy = 2, sx = 990, sy = 320, ex = 1019, ey = 350},
  {w = 32, h = 32, ox = 1, oy = 3, sx = 0, sy = 352, ex = 28, ey = 381},
  {w = 32, h = 32, ox = 3, oy = 0, sx = 28, sy = 352, ex = 53, ey = 382},
  {w = 32, h = 32, ox = 2, oy = 1, sx = 53, sy = 352, ex = 80, ey = 381},
  {w = 32, h = 32, ox = 2, oy = 7, sx = 80, sy = 352, ex = 102, ey = 376},
  {w = 32, h = 32, ox = 2, oy = 2, sx = 102, sy = 352, ex = 127, ey = 381},
  {w = 32, h = 32, ox = 2, oy = 2, sx = 127, sy = 352, ex = 156, ey = 380},
  {w = 32, h = 32, ox = 1, oy = 1, sx = 156, sy = 352, ex = 184, ey = 381},
  {w = 32, h = 32, ox = 1, oy = 1, sx = 184, sy = 352, ex = 209, ey = 383},
  {w = 32, h = 32, ox = 1, oy = 2, sx = 209, sy = 352, ex = 238, ey = 381},
  {w = 32, h = 32, ox = 0, oy = 2, sx = 238, sy = 352, ex = 268, ey = 378},
  {w = 32, h = 32, ox = 1, oy = 2, sx = 268, sy = 352, ex = 297, ey = 380},
  {w = 32, h = 32, ox = 3, oy = 1, sx = 297, sy = 352, ex = 323, ey = 382},
  {w = 32, h = 32, ox = 3, oy = 0, sx = 323, sy = 352, ex = 349, ey = 384},
  {w = 32, h = 32, ox = 3, oy = 4, sx = 349, sy = 352, ex = 375, ey = 380},
  {w = 32, h = 32, ox = 1, oy = 1, sx = 375, sy = 352, ex = 404, ey = 383},
  {w = 32, h = 32, ox = 2, oy = 3, sx = 404, sy = 352, ex = 433, ey = 381},
  {w = 32, h = 32, ox = 12, oy = 5, sx = 433, sy = 352, ex = 448, ey = 379},
  {w = 32, h = 32, ox = 1, oy = 4, sx = 448, sy = 352, ex = 477, ey = 380},
  {w = 32, h = 32, ox = 1, oy = 5, sx = 477, sy = 352, ex = 506, ey = 379},
  {w = 32, h = 32, ox = 2, oy = 3, sx = 506, sy = 352, ex = 535, ey = 381},
  {w = 32, h = 32, ox = 4, oy = 4, sx = 535, sy = 352, ex = 561, ey = 380},
  {w = 32, h = 32, ox = 11, oy = 11, sx = 561, sy = 352, ex = 569, ey = 373},
  {w = 32, h = 32, ox = 0, oy = 3, sx = 569, sy = 352, ex = 601, ey = 381},
  {w = 32, h = 32, ox = 0, oy = 5, sx = 601, sy = 352, ex = 631, ey = 379},
  {w = 32, h = 32, ox = 1, oy = 6, sx = 631, sy = 352, ex = 659, ey = 375},
  {w = 32, h = 32, ox = 1, oy = 0, sx = 659, sy = 352, ex = 689, ey = 384},
  {w = 32, h = 32, ox = 1, oy = 1, sx = 689, sy = 352, ex = 717, ey = 383},
  {w = 32, h = 32, ox = 1, oy = 0, sx = 717, sy = 352, ex = 746, ey = 384},
  {w = 32, h = 32, ox = 3, oy = 7, sx = 746, sy = 352, ex = 772, ey = 377},
  {w = 32, h = 32, ox = 2, oy = 0, sx = 772, sy = 352, ex = 802, ey = 384},
  {w = 32, h = 32, ox = 0, oy = 3, sx = 802, sy = 352, ex = 834, ey = 379},
  {w = 32, h = 32, ox = 0, oy = 1, sx = 834, sy = 352, ex = 862, ey = 381},
  {w = 32, h = 32, ox = 0, oy = 1, sx = 862, sy = 352, ex = 893, ey = 381},
  {w = 32, h = 32, ox = 0, oy = 2, sx = 893, sy = 352, ex = 922, ey = 381},
  {w = 32, h = 32, ox = 0, oy = 5, sx = 922, sy = 352, ex = 949, ey = 374},
  {w = 32, h = 32, ox = 0, oy = 1, sx = 949, sy = 352, ex = 977, ey = 380},
  {w = 32, h = 32, ox = 0, oy = 1, sx = 977, sy = 352, ex = 1004, ey = 381},
  {w = 32, h = 32, ox = 0, oy = 2, sx = 0, sy = 384, ex = 29, ey = 413},
  {w = 32, h = 32, ox = 0, oy = 4, sx = 29, sy = 384, ex = 57, ey = 410},
  {w = 32, h = 32, ox = 0, oy = 9, sx = 57, sy = 384, ex = 78, ey = 394},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 78, sy = 384, ex = 107, ey = 416},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 107, sy = 384, ex = 134, ey = 414},
  {w = 32, h = 32, ox = 3, oy = 1, sx = 134, sy = 384, ex = 157, ey = 412},
  {w = 32, h = 32, ox = 0, oy = 1, sx = 157, sy = 384, ex = 189, ey = 414},
  {w = 32, h = 32, ox = 0, oy = 1, sx = 189, sy = 384, ex = 220, ey = 412},
  {w = 32, h = 32, ox = 0, oy = 1, sx = 220, sy = 384, ex = 252, ey = 413},
  {w = 32, h = 32, ox = 0, oy = 3, sx = 252, sy = 384, ex = 277, ey = 410},
  {w = 32, h = 32, ox = 0, oy = 2, sx = 277, sy = 384, ex = 309, ey = 414},
  {w = 32, h = 32, ox = 2, oy = 0, sx = 309, sy = 384, ex = 336, ey = 416},
  {w = 32, h = 32, ox = 2, oy = 0, sx = 336, sy = 384, ex = 365, ey = 412},
  {w = 32, h = 32, ox = 2, oy = 0, sx = 365, sy = 384, ex = 394, ey = 415},
  {w = 32, h = 32, ox = 1, oy = 0, sx = 394, sy = 384, ex = 423, ey = 413},
  {w = 32, h = 32, ox = 5, oy = 0, sx = 423, sy = 384, ex = 445, ey = 411},
  {w = 32, h = 32, ox = 2, oy = 0, sx = 445, sy = 384, ex = 474, ey = 412},
  {w = 32, h = 32, ox = 2, oy = 0, sx = 474, sy = 384, ex = 503, ey = 411},
  {w = 32, h = 32, ox = 1, oy = 0, sx = 503, sy = 384, ex = 532, ey = 413},
  {w = 32, h = 32, ox = 2, oy = 0, sx = 532, sy = 384, ex = 558, ey = 412},
  {w = 32, h = 32, ox = 13, oy = 0, sx = 558, sy = 384, ex = 568, ey = 405},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 568, sy = 384, ex = 600, ey = 413},
  {w = 32, h = 32, ox = 2, oy = 0, sx = 600, sy = 384, ex = 630, ey = 411},
  {w = 32, h = 32, ox = 3, oy = 3, sx = 630, sy = 384, ex = 658, ey = 407},
  {w = 32, h = 32, ox = 1, oy = 0, sx = 658, sy = 384, ex = 688, ey = 416},
  {w = 32, h = 32, ox = 3, oy = 0, sx = 688, sy = 384, ex = 716, ey = 415},
  {w = 32, h = 32, ox = 2, oy = 0, sx = 716, sy = 384, ex = 745, ey = 416},
  {w = 32, h = 32, ox = 3, oy = 0, sx = 745, sy = 384, ex = 771, ey = 409},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 771, sy = 384, ex = 801, ey = 416},
  {w = 32, h = 32, ox = 0, oy = 3, sx = 801, sy = 384, ex = 833, ey = 410},
  {w = 32, h = 32, ox = 4, oy = 3, sx = 833, sy = 384, ex = 861, ey = 410},
  {w = 32, h = 32, ox = 1, oy = 2, sx = 861, sy = 384, ex = 892, ey = 413},
  {w = 32, h = 32, ox = 3, oy = 1, sx = 892, sy = 384, ex = 921, ey = 413},
  {w = 32, h = 32, ox = 5, oy = 5, sx = 921, sy = 384, ex = 948, ey = 399},
  {w = 32, h = 32, ox = 4, oy = 2, sx = 948, sy = 384, ex = 976, ey = 413},
  {w = 32, h = 32, ox = 5, oy = 2, sx = 976, sy = 384, ex = 1003, ey = 413},
  {w = 32, h = 32, ox = 3, oy = 1, sx = 0, sy = 416, ex = 29, ey = 445},
  {w = 32, h = 32, ox = 4, oy = 2, sx = 29, sy = 416, ex = 57, ey = 442},
  {w = 32, h = 32, ox = 11, oy = 13, sx = 57, sy = 416, ex = 78, ey = 424},
  {w = 32, h = 32, ox = 3, oy = 0, sx = 78, sy = 416, ex = 107, ey = 448},
  {w = 32, h = 32, ox = 5, oy = 2, sx = 107, sy = 416, ex = 134, ey = 446},
  {w = 32, h = 32, ox = 6, oy = 3, sx = 134, sy = 416, ex = 157, ey = 444},
  {w = 32, h = 32, ox = 0, oy = 1, sx = 157, sy = 416, ex = 189, ey = 446},
  {w = 32, h = 32, ox = 1, oy = 3, sx = 189, sy = 416, ex = 220, ey = 444},
  {w = 32, h = 32, ox = 0, oy = 2, sx = 220, sy = 416, ex = 252, ey = 445},
  {w = 32, h = 32, ox = 7, oy = 3, sx = 252, sy = 416, ex = 277, ey = 442},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 277, sy = 416, ex = 309, ey = 446},
  {w = 32, h = 32, ox = 2, oy = 2, sx = 309, sy = 416, ex = 338, ey = 446},
  {w = 32, h = 32, ox = 2, oy = 2, sx = 338, sy = 416, ex = 367, ey = 446},
  {w = 32, h = 32, ox = 1, oy = 1, sx = 367, sy = 416, ex = 397, ey = 447},
  {w = 32, h = 32, ox = 1, oy = 2, sx = 397, sy = 416, ex = 427, ey = 445},
  {w = 32, h = 32, ox = 1, oy = 2, sx = 427, sy = 416, ex = 456, ey = 446},
  {w = 32, h = 32, ox = 1, oy = 1, sx = 456, sy = 416, ex = 486, ey = 447},
  {w = 32, h = 32, ox = 1, oy = 0, sx = 486, sy = 416, ex = 516, ey = 447},
  {w = 32, h = 32, ox = 1, oy = 1, sx = 516, sy = 416, ex = 545, ey = 447},
  {w = 32, h = 32, ox = 1, oy = 1, sx = 545, sy = 416, ex = 575, ey = 446},
  {w = 32, h = 32, ox = 1, oy = 1, sx = 575, sy = 416, ex = 600, ey = 447},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 600, sy = 416, ex = 632, ey = 448},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 632, sy = 416, ex = 664, ey = 448},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 664, sy = 416, ex = 696, ey = 448},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 696, sy = 416, ex = 728, ey = 448},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 728, sy = 416, ex = 760, ey = 448},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 760, sy = 416, ex = 792, ey = 448},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 792, sy = 416, ex = 824, ey = 448},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 824, sy = 416, ex = 856, ey = 448},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 856, sy = 416, ex = 888, ey = 448},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 888, sy = 416, ex = 920, ey = 448},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 920, sy = 416, ex = 952, ey = 448},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 952, sy = 416, ex = 984, ey = 448},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 984, sy = 416, ex = 1016, ey = 448},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 0, sy = 448, ex = 32, ey = 480},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 32, sy = 448, ex = 64, ey = 480},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 64, sy = 448, ex = 96, ey = 480},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 96, sy = 448, ex = 128, ey = 480},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 128, sy = 448, ex = 160, ey = 480},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 160, sy = 448, ex = 192, ey = 480},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 192, sy = 448, ex = 224, ey = 480},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 224, sy = 448, ex = 256, ey = 480},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 256, sy = 448, ex = 288, ey = 480},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 288, sy = 448, ex = 320, ey = 480},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 320, sy = 448, ex = 352, ey = 480},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 352, sy = 448, ex = 384, ey = 480},
  {w = 32, h = 32, ox = 1, oy = 1, sx = 384, sy = 448, ex = 415, ey = 479},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 415, sy = 448, ex = 447, ey = 480},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 447, sy = 448, ex = 479, ey = 480},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 479, sy = 448, ex = 511, ey = 480},
  {w = 32, h = 32, ox = 1, oy = 1, sx = 511, sy = 448, ex = 542, ey = 479},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 542, sy = 448, ex = 574, ey = 480},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 574, sy = 448, ex = 606, ey = 480},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 606, sy = 448, ex = 638, ey = 480},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 638, sy = 448, ex = 670, ey = 480},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 670, sy = 448, ex = 702, ey = 480},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 702, sy = 448, ex = 734, ey = 480},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 734, sy = 448, ex = 766, ey = 480},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 766, sy = 448, ex = 798, ey = 480},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 798, sy = 448, ex = 830, ey = 480},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 830, sy = 448, ex = 862, ey = 480},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 862, sy = 448, ex = 894, ey = 480},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 894, sy = 448, ex = 926, ey = 480},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 926, sy = 448, ex = 958, ey = 480},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 958, sy = 448, ex = 990, ey = 480},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 990, sy = 448, ex = 1022, ey = 480},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 0, sy = 480, ex = 32, ey = 512},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 32, sy = 480, ex = 64, ey = 512},
  {w = 32, h = 32, ox = 0, oy = 0, sx = 64, sy = 480, ex = 96, ey = 512},
}

tileinfo.get_tile_info = function (idx)
    return tileinfo.tile_info[idx - TILE_WALL_MAX]
end

tileinfo._tile_count =
{
    21,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    3,
    1,
    1,
    2,
    1,
    4,
    1,
    1,
    1,
    2,
    1,
    3,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    2,
    1,
    1,
    1,
    25,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    6,
    1,
    1,
    1,
    1,
    1,
    1,
    3,
    1,
    1,
    1,
    1,
    2,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    5,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    3,
    1,
    1,
    1,
    1,
    3,
    1,
    1,
    3,
    1,
    1,
    3,
    1,
    1,
    3,
    1,
    1,
    1,
    3,
    1,
    1,
    2,
    1,
    1,
    1,
    2,
    1,
    1,
    1,
    1,
    2,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    8,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    8,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    2,
    1,
    1,
    8,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    5,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    11,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    3,
    1,
    1,
    3,
    1,
    1,
    3,
    1,
    1,
    1,
    4,
    1,
    1,
    1,
    1,
    2,
    1,
    2,
    1,
    2,
    1,
    1,
    1,
    1,
    30,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    18,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    18,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    18,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    18,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    10,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    4,
    1,
    1,
    1,
    2,
    1,
    1,
    4,
    1,
    1,
    1,
    1,
    3,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    4,
    1,
    1,
    1,
    4,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
}

tileinfo.tile_count = function (idx)
    return tileinfo._tile_count[idx - TILE_WALL_MAX]
end

tileinfo._basetiles =
{
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    21,
    21,
    21,
    24,
    24,
    26,
    26,
    26,
    26,
    30,
    30,
    32,
    32,
    32,
    35,
    36,
    37,
    38,
    39,
    40,
    41,
    42,
    43,
    44,
    45,
    46,
    47,
    48,
    49,
    50,
    51,
    52,
    53,
    54,
    55,
    56,
    57,
    58,
    59,
    60,
    61,
    62,
    63,
    64,
    65,
    66,
    67,
    68,
    69,
    70,
    71,
    72,
    73,
    74,
    75,
    76,
    77,
    77,
    79,
    80,
    81,
    81,
    81,
    81,
    81,
    81,
    81,
    81,
    81,
    81,
    81,
    81,
    81,
    81,
    81,
    81,
    81,
    81,
    81,
    81,
    81,
    81,
    81,
    81,
    81,
    106,
    106,
    106,
    106,
    106,
    106,
    112,
    113,
    113,
    113,
    116,
    117,
    118,
    118,
    120,
    121,
    122,
    123,
    124,
    125,
    126,
    127,
    128,
    129,
    130,
    131,
    132,
    133,
    134,
    135,
    136,
    137,
    138,
    139,
    140,
    141,
    142,
    143,
    144,
    144,
    144,
    144,
    144,
    149,
    150,
    151,
    152,
    153,
    154,
    155,
    156,
    157,
    158,
    159,
    160,
    161,
    162,
    163,
    164,
    165,
    166,
    167,
    168,
    169,
    170,
    171,
    172,
    173,
    174,
    175,
    176,
    177,
    178,
    179,
    180,
    181,
    182,
    183,
    184,
    185,
    186,
    187,
    188,
    189,
    190,
    191,
    192,
    193,
    194,
    195,
    196,
    197,
    198,
    199,
    200,
    201,
    202,
    203,
    204,
    205,
    206,
    207,
    208,
    209,
    210,
    211,
    212,
    213,
    214,
    215,
    216,
    216,
    216,
    219,
    220,
    221,
    221,
    221,
    224,
    224,
    224,
    227,
    227,
    227,
    230,
    230,
    230,
    233,
    234,
    234,
    234,
    237,
    237,
    239,
    240,
    241,
    241,
    243,
    244,
    245,
    246,
    246,
    248,
    249,
    250,
    251,
    252,
    253,
    254,
    255,
    255,
    255,
    255,
    255,
    255,
    255,
    255,
    263,
    264,
    265,
    266,
    267,
    268,
    269,
    270,
    271,
    272,
    273,
    274,
    275,
    276,
    277,
    278,
    279,
    280,
    281,
    282,
    282,
    282,
    282,
    282,
    282,
    282,
    282,
    290,
    290,
    292,
    293,
    293,
    293,
    293,
    293,
    293,
    293,
    293,
    301,
    302,
    303,
    303,
    303,
    303,
    303,
    308,
    309,
    310,
    311,
    311,
    311,
    311,
    311,
    311,
    311,
    311,
    311,
    311,
    311,
    322,
    323,
    324,
    325,
    325,
    325,
    328,
    328,
    328,
    331,
    331,
    331,
    334,
    335,
    335,
    335,
    335,
    339,
    340,
    340,
    342,
    342,
    344,
    344,
    346,
    347,
    348,
    349,
    349,
    349,
    349,
    349,
    349,
    349,
    349,
    349,
    349,
    349,
    349,
    349,
    349,
    349,
    349,
    349,
    349,
    349,
    349,
    349,
    349,
    349,
    349,
    349,
    349,
    349,
    349,
    349,
    349,
    379,
    379,
    379,
    379,
    379,
    379,
    379,
    379,
    379,
    379,
    379,
    379,
    379,
    379,
    379,
    379,
    379,
    379,
    397,
    397,
    397,
    397,
    397,
    397,
    397,
    397,
    397,
    397,
    397,
    397,
    397,
    397,
    397,
    397,
    397,
    397,
    415,
    415,
    415,
    415,
    415,
    415,
    415,
    415,
    415,
    415,
    415,
    415,
    415,
    415,
    415,
    415,
    415,
    415,
    433,
    433,
    433,
    433,
    433,
    433,
    433,
    433,
    433,
    433,
    433,
    433,
    433,
    433,
    433,
    433,
    433,
    433,
    451,
    451,
    451,
    451,
    451,
    451,
    451,
    451,
    451,
    451,
    461,
    462,
    463,
    463,
    463,
    463,
    467,
    467,
    469,
    470,
    470,
    470,
    470,
    474,
    475,
    475,
    475,
    478,
    479,
    480,
    481,
    482,
    483,
    484,
    484,
    484,
    484,
    488,
    488,
    488,
    488,
    492,
    493,
    494,
    495,
    496,
    497,
    498,
    499,
    500,
    501,
    502,
    503,
    504,
    505,
    506,
    507,
    508,
}

tileinfo.basetile = function (idx)
    return tileinfo_basetiles[idx - TILE_WALL_MAX] + TILE_WALL_MAX
end

tileinfo.get_img = function (idx)
    return "feat"
end

return tileinfo
