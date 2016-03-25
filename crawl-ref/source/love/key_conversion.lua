local val
-- Key codes - from cio.h
val = -255
local CK_DELETE = val
val = val + 1

local CK_UP = val
val = val + 1
local CK_DOWN = val
val = val + 1
local CK_LEFT = val
val = val + 1
local CK_RIGHT = val
val = val + 1

local CK_INSERT = val
val = val + 1

local CK_HOME = val
val = val + 1
local CK_END = val
val = val + 1
local CK_CLEAR = val
val = val + 1

local CK_PGUP = val
val = val + 1
local CK_PGDN = val
val = val + 1
local CK_TAB_TILE = val
val = val + 1 -- unused

local CK_SHIFT_UP = val
val = val + 1
local CK_SHIFT_DOWN = val
val = val + 1
local CK_SHIFT_LEFT = val
val = val + 1
local CK_SHIFT_RIGHT = val
val = val + 1

local CK_SHIFT_INSERT = val
val = val + 1

local CK_SHIFT_HOME = val
val = val + 1
local CK_SHIFT_END = val
val = val + 1
local CK_SHIFT_CLEAR = val
val = val + 1

local CK_SHIFT_PGUP = val
val = val + 1
local CK_SHIFT_PGDN = val
val = val + 1
local CK_SHIFT_TAB = val
val = val + 1

local CK_CTRL_UP = val
val = val + 1
local CK_CTRL_DOWN = val
val = val + 1
local CK_CTRL_LEFT = val
val = val + 1
local CK_CTRL_RIGHT = val
val = val + 1

local CK_CTRL_INSERT = val
val = val + 1

local CK_CTRL_HOME = val
val = val + 1
local CK_CTRL_END = val
val = val + 1
local CK_CTRL_CLEAR = val
val = val + 1

local CK_CTRL_PGUP = val
val = val + 1
local CK_CTRL_PGDN = val
val = val + 1
local CK_CTRL_TAB = val
val = val + 1

-- Mouse codes.
val = -10009
local CK_MOUSE_MOVE  = val
val = val + 1
local CK_MOUSE_CMD = val
val = val + 1
local CK_MOUSE_B1 = val
val = val + 1
local CK_MOUSE_B2 = val
val = val + 1
local CK_MOUSE_B3 = val
val = val + 1
local CK_MOUSE_B4 = val
val = val + 1
local CK_MOUSE_B5 = val
val = val + 1
local CK_MOUSE_CLICK = val
val = val + 1

local key_conversion = {}
-- Escape
key_conversion['escape'] = 27,
-- Backspace
key_conversion['backspace'] = 8,
-- Tab
key_conversion['tab'] = 9,

-- Numpad / Arrow keys
key_conversion['insert']   = -250
key_conversion['end']      = -1001
key_conversion['down']     = -253-- -1002
key_conversion['pagedown'] = -1003
key_conversion['left']     = -252-- -1004
key_conversion['clear']    = -247
key_conversion['right']    = -251-- -1006
key_conversion['home']     = -1007
key_conversion['up']       = -254-- -1008
key_conversion['pageup']   = -1009

-- Function keys
key_conversion['f1'] = -1011 -- F1
key_conversion['f2'] = -1012
key_conversion['f3'] = -1013
key_conversion['f4'] = -1014
key_conversion['f5'] = -1015
key_conversion['f6'] = -1016
key_conversion['f7'] = -1017
key_conversion['f8'] = -1018
key_conversion['f9'] = -1019
key_conversion['f10'] = -1020
--    122 = -1021, -- Don't occupy F11, it's used for fullscreen
--    123 = -1022, -- used for chat

-- Will have to use love.keyboard.isDown to build those codes
local shift_key_conversion = {}
    -- Numpad / Arrow keys
shift_key_conversion['insert']   = CK_SHIFT_INSERT
shift_key_conversion['end']      = CK_SHIFT_END
shift_key_conversion['pagedown'] = CK_SHIFT_PGDN
shift_key_conversion['left']     = CK_SHIFT_LEFT
shift_key_conversion['clear']    = CK_SHIFT_CLEAR
shift_key_conversion['right']    = CK_SHIFT_RIGHT
shift_key_conversion['home']     = CK_SHIFT_HOME
shift_key_conversion['up']       = CK_SHIFT_UP
shift_key_conversion['pageup']   = CK_SHIFT_PGUP

-- TODO Numpad with numlock
-- shift_key_conversion[97] = CK_SHIFT_END
-- shift_key_conversion[98] = CK_SHIFT_DOWN
-- shift_key_conversion[99] = CK_SHIFT_PGDN
-- shift_key_conversion[100] = CK_SHIFT_LEFT
-- shift_key_conversion[102] = CK_SHIFT_RIGHT
-- shift_key_conversion[103] = CK_SHIFT_HOME
-- shift_key_conversion[104] = CK_SHIFT_UP
-- shift_key_conversion[105] = CK_SHIFT_PGUP

local ctrl_key_conversion = {}
-- Numpad / Arrow keys
ctrl_key_conversion['insert']   = CK_CTRL_INSERT
ctrl_key_conversion['end']      = CK_CTRL_END
ctrl_key_conversion['down']     = CK_CTRL_DOWN
ctrl_key_conversion['pagedown'] = CK_CTRL_PGDN
ctrl_key_conversion['left']     = CK_CTRL_LEFT
ctrl_key_conversion['clear']    = CK_CTRL_CLEAR
ctrl_key_conversion['right']    = CK_CTRL_RIGHT
ctrl_key_conversion['home']     = CK_CTRL_HOME
ctrl_key_conversion['up']       = CK_CTRL_UP
ctrl_key_conversion['pageup']   = CK_CTRL_PGUP

-- TODO Numpad with numlock
-- ctrl_key_conversion[97] = CK_CTRL_END
-- ctrl_key_conversion[98] = CK_CTRL_DOWN
-- ctrl_key_conversion[99] = CK_CTRL_PGDN
-- ctrl_key_conversion[100] = CK_CTRL_LEFT
-- ctrl_key_conversion[102] = CK_CTRL_RIGHT
-- ctrl_key_conversion[103] = CK_CTRL_HOME
-- ctrl_key_conversion[104] = CK_CTRL_UP
-- ctrl_key_conversion[105] = CK_CTRL_PGUP

local captured_control_keys = {
    "O", "Q", "F", "P", "W", "A", "T", "X", "S", "G", "I", "D", "E",
    "H", "J", "K", "L", "Y", "U", "B", "N", "C"
}

return {
    simple = key_conversion,
    shift = shift_key_conversion,
    ctrl = ctrl_key_conversion,
    captured_control_keys = captured_control_keys
}
