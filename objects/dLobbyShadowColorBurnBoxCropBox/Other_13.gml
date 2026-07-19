gpu_set_blendmode_ext(bm_src_alpha, bm_dest_alpha);
var _blink = 1;
spriteIndex = sprite_index;

if (_blink)
    draw_sprite_ext(spriteIndex, 0, x, y, image_xscale, image_yscale, image_angle, c_white, 0.3);

gpu_set_blendmode(bm_normal);
