if (live_call())
    return global.live_result;

imageIndex += (global.timeScale * 0.016666666666666666);
draw_sprite_ext(spriteIndex, imageIndex, x, y, 0.1 * image_xscale, 0.1 * image_yscale, 0, c_white, 1);
