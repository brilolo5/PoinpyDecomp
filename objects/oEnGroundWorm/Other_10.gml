xscale = xDirection * xShrink * xscaleBase;
yscale = yDirection * yShrink * yscaleBase;
dcx = cx;
dcy = cy;
imageSpeed = 0.125;
image_index += (imageSpeed * global.timeScale);
draw_sprite_ext(sprite_index, image_index, x + dcx, y + dcy, xscale, yscale, imageAngle * xDirection, c_white, 1);
