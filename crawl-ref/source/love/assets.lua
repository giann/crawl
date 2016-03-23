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


Assets.tile_info = {
    main = {
        tileinfo = require "tileinfo-main",
        spritesheet = SpriteSheet({
                image = love.graphics.newImage('dat/tiles/main.png'),
                tileinfo = tileinfo_main
        })
    }
}


Assets.loading = love.timer.getTime() - Assets.loading

print('Assets loaded in ' .. Assets.loading .. 's')
