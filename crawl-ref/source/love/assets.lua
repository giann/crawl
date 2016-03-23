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

Assets.tile_info = {
    main = {
        tileinfo = tileinfo_main,
        spritesheet = SpriteSheet({
                image = love.graphics.newImage('dat/tiles/main.png'),
                tileinfo = tileinfo_main
        })
    },
    player = {
        tileinfo = tileinfo_player,
        spritesheet = SpriteSheet({
                image = love.graphics.newImage('dat/tiles/player.png'),
                tileinfo = tileinfo_player
        })
    }
}


Assets.loading = love.timer.getTime() - Assets.loading

print('Assets loaded in ' .. Assets.loading .. 's')
