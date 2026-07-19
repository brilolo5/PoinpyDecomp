if (surface_exists(printScreen))
    draw_surface_stretched(printScreen, global.windowLeft, global.gameSurfaceTop, global.viewWidth, global.viewHeight);

draw_set_color(make_color_rgb(46, 50, 59));
draw_set_alpha(0.3);
draw_rectangle(0, 0, 1000, 1000, false);
draw_set_alpha(1);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_colour(c_white);
drawTextOutlined(global.windowCenterx, global.windowMiddley - 64, "TROPHY", make_color_rgb(255, 255, 255), make_color_rgb(46, 50, 59), 0);
drawSpriteSetSize(sItem_pajama1, 0, global.windowCenterx + 16 + 8, (global.windowMiddley + 32) - 8, 32, 32);
drawSpriteSetSize(sTrophyRoomTrophy, 1, global.windowCenterx, global.windowMiddley, 64, 64);
var _trophyDescString = loc("trophy clear by 10");
drawTextOutlined(global.windowCenterx, global.windowMiddley + 64, _trophyDescString, make_color_rgb(255, 255, 255), make_color_rgb(46, 50, 59), 0, 0.8, 150);

if (mouse_check_button_released(mb_left))
    instance_destroy();
