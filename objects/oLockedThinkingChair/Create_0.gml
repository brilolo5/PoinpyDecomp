hanging = 1;
ysp = 0;
cx = 0;
cy = 0;
grav = 0.1;
maxFallSpeed = 10;
imageAngle = 0;

if (global.puzzleModeUnlocked)
    instance_destroy();

drawChairHangingRope = function()
{
    if (hanging)
        draw_sprite_ext(sPuzzleChairRope, image_index, x + 6, y - 38, image_xscale, image_yscale, imageAngle, c_white, 1);
    
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, imageAngle, c_white, 1);
};
