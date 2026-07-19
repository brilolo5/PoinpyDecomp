pauseDrawSurface();
draw_set_color(make_color_rgb(46, 50, 59));
draw_set_alpha(0.3);
draw_rectangle(0, 0, 1000, 1000, false);
draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_colour(c_white);
uiDraw("service root");
