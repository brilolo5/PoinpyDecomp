xx = lerp(xx, endx, 0.2);
yy = lerp(yy, endy, 0.2);
draw_sprite_ext(sprite_index, image_index, xx, yy, 0.1, 0.1, 0, c_white, 1);

if (abs((xx - endx) + (yy - endy)) < 1)
{
    draw_set_color(make_color_rgb(255, 255, 255));
    draw_circle(xx, yy, 16, 0);
    instance_destroy();
}
