dcx = cx;
dcy = cy;
var xx = xstart + (sin(enAngle + pi) * enRadius);
var yy = ystart + (cos(enAngle + pi) * enRadius);
draw_set_color(make_color_rgb(255, 255, 255));
draw_sprite_ext(sprite_index, image_index, x + dcx, y + dcy, xscale, yscale, imageAngle * xDirection, c_white, 1);

if (instance_exists(myDamageTwin))
{
    with (myDamageTwin)
    {
        x = xx;
        y = yy;
    }
}

draw_set_color(make_color_rgb(46, 50, 59));
