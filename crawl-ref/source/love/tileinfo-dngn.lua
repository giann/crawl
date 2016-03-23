local tileinfo = {}

local floor = require "tileinfo-floor"
local wall = require "tileinfo-wall"
local feat = require "tileinfo-feat"

tileinfo.tile_info = table.join(table.join(floor.tile_info, wall.tile_info), feat.tile_info)
tileinfo._tile_count = table.join(table.join(floor._tile_count, wall._tile_count), feat._tile_count)
tileinfo._basetiles = table.join(table.join(floor._basetiles, wall._basetiles), feat._basetiles)


DNGN_MAX = TILE_DNGN_MAX = FEAT_MAX;

tileinfo.get_tile_info = function (idx)
    if (idx < floor.FLOOR_MAX) then
        return (floor.get_tile_info(idx))
    elseif (idx < wall.WALL_MAX) then
        return (wall.get_tile_info(idx))
    else
        return (feat.get_tile_info(idx))
    end
end

tileinfo.tile_count = function (idx)
    if (idx < floor.FLOOR_MAX) then
        return (floor.tile_count(idx))
    elseif (idx < wall.WALL_MAX) then
        return (wall.tile_count(idx))
    else
        return (feat.tile_count(idx))
    end
end

tileinfo.basetile = function (idx)
    if (idx < floor.FLOOR_MAX) then
        return (floor.basetile(idx))
    elseif (idx < wall.WALL_MAX) then
        return (wall.basetile(idx))
    else
        return (feat.basetile(idx))
    end
end

tileinfo.get_img = function (idx)
    if (idx < floor.FLOOR_MAX) then
        return "floor"
    elseif (idx < wall.WALL_MAX) then
        return "wall"
    else
        return "feat"
    end
end

return tileinfo
