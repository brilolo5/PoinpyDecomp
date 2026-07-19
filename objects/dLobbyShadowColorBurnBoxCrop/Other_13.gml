gpu_set_blendmode_ext(bm_src_alpha, bm_dest_alpha);
var _blink = (global.timeScaledTime / 2) % 60;
spriteIndex = sprite_index;

if (_blink)
    draw_sprite_ext(spriteIndex, 0, x, y, image_xscale * 2, image_yscale * 2, image_angle, c_white, 0.3);

gpu_set_blendmode(bm_normal);
