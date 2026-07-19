function sceneSkipInputCheck(arg0 = 0, arg1 = 0, arg2 = 120)
{
    if (global.endingReached > UnknownEnum.Value_1 || arg1 || global.debugControl)
    {
        if (mouse_check_button_pressed(mb_left))
            endSkipHold = 0;
        
        if (mouse_check_button(mb_left) && endSkipHold >= 0)
        {
            var _mx = device_mouse_x_to_gui(0);
            var _my = device_mouse_y_to_gui(0) - 16 - 8;
            endSkipHold = approach(endSkipHold, 1, doDelta(1 / arg2));
            
            if (endSkipHold >= arg0)
            {
                var _pieMax = 1 - arg0;
                var _pieValue = endSkipHold - arg0;
                var _pieAngle = (_pieValue / _pieMax) * -360;
                var _pieRadius = 12;
                draw_set_color(make_color_rgb(46, 50, 59));
                draw_circle(_mx - (1 * (os_type == os_windows)), _my - (1 * (os_type == os_windows)), _pieRadius + 1, 0);
                drawPie(_mx, _my, _pieValue, _pieMax, make_color_rgb(255, 255, 255), _pieRadius, 1, _pieAngle + 90);
                draw_set_color(make_color_rgb(46, 50, 59));
                draw_circle(_mx - (1 * (os_type == os_windows)), _my - (1 * (os_type == os_windows)), _pieRadius / 2, 0);
                drawSetAlign(1, 2);
                drawTextOutlined(_mx, _my - _pieRadius, loc("ending skip UI"), make_color_rgb(255, 255, 255), make_color_rgb(46, 50, 59), 0, 0.6);
            }
        }
        else
        {
            endSkipHold = -1;
        }
        
        if (endSkipHold >= 1)
            return true;
        else
            return false;
    }
    else
    {
        return false;
    }
}
