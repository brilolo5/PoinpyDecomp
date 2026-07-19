dcx = cx;
dcy = cy;
image_speed = 0;
image_index += (imageSpeed * global.timeScale);

if (angleIsDirecion)
    imageAngle = point_direction(0, 0, xsp, ysp);

draw_sprite_ext(sprite_index, image_index, x + dcx, y + dcy, xscale, yscale, imageAngle * xDirection, c_white, 1);
