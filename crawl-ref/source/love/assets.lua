Assets = {
    loading = love.timer.getTime()
}

Assets.shaders = {
    alphaDiscard = love.graphics.newShader [[
       vec4 effect ( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords ) {
          // a discarded fragment will fail the stencil test.
          if (Texel(texture, texture_coords).a <= 0.0)
             discard;
          return vec4(1.0);
       }
    ]]
}

local tileinfo_main = require "tileinfo-main"
local tileinfo_player = require "tileinfo-player"
local tileinfo_floor = require "tileinfo-floor"
local tileinfo_wall = require "tileinfo-wall"
local tileinfo_feat = require "tileinfo-feat"
local tileinfo_icons = require "tileinfo-icons"
local tileinfo_gui = require "tileinfo-gui"

Assets.tile_info = {
    main = {
        tileinfo = tileinfo_main,
        spritesheet = SpriteSheet(true, {
            image = love.graphics.newImage('dat/tiles/main.png'),
            tileinfo = tileinfo_main
        }),
        spritesheet_normal = SpriteSheet(true, {
            image = love.graphics.newImage('dat/tiles/main_NORMALS.png'),
            tileinfo = tileinfo_main
        })
    },
    player = {
        tileinfo = tileinfo_player,
        spritesheet = SpriteSheet(false, {
            image = love.graphics.newImage('dat/tiles/player.png'),
            tileinfo = tileinfo_player
        }),
        spritesheet_normal = SpriteSheet(false, {
            image = love.graphics.newImage('dat/tiles/player_NORMALS.png'),
            tileinfo = tileinfo_player
        })
    },
    floor = {
        tileinfo = tileinfo_floor,
        spritesheet = SpriteSheet(true, {
            image = love.graphics.newImage('dat/tiles/floor_light.png'),
            tileinfo = tileinfo_floor
        }),
        spritesheet_normal = SpriteSheet(true, {
            image = love.graphics.newImage('dat/tiles/floor_NORMALS.png'),
            tileinfo = tileinfo_floor
        })
    },
    wall = {
        tileinfo = tileinfo_wall,
        spritesheet = SpriteSheet(true, {
            image = love.graphics.newImage('dat/tiles/wall.png'),
            tileinfo = tileinfo_wall
        }),
        spritesheet_normal = SpriteSheet(true, {
            image = love.graphics.newImage('dat/tiles/wall_NORMALS.png'),
            tileinfo = tileinfo_wall
        })
    },
    dngn = {
        tileinfo = tileinfo_dngn,
        spritesheet = SpriteSheet(true, {
            image = nil, -- used only for it's functions
            tileinfo = tileinfo_dngn
        })
    },
    feat = {
        tileinfo = tileinfo_feat,
        spritesheet = SpriteSheet(true, {
            image = love.graphics.newImage('dat/tiles/feat.png'),
            tileinfo = tileinfo_feat
        }),
        spritesheet_normal = SpriteSheet(true, {
            image = love.graphics.newImage('dat/tiles/feat_NORMALS.png'),
            tileinfo = tileinfo_feat
        })
    },
    icons = {
        tileinfo = tileinfo_icons,
        spritesheet = SpriteSheet(true, {
            image = love.graphics.newImage('dat/tiles/icons.png'),
            tileinfo = tileinfo_icons
        })
    },
    gui = {
        tileinfo = tileinfo_gui,
        spritesheet = SpriteSheet(true, {
                image = love.graphics.newImage('dat/tiles/gui.png'),
                tileinfo = tileinfo_gui
        })
    }
}


Assets.loading = love.timer.getTime() - Assets.loading

print('Assets loaded in ' .. Assets.loading .. 's')
