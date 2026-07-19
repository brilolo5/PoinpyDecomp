function initializeInput()
{
    if (os_type == os_switch)
        input_default_gamepad_swap_ab(true);
    
    if (os_type != os_switch && os_type != os_ps4)
    {
        input_default_mouse_button(1, "select", 0);
        input_default_mouse_button(1, "jump");
        input_default_mouse_button(1, "slam");
        input_default_key(13, "pause", 0);
        input_default_key(27, "pause", 1);
    }
    
    input_default_gamepad_button(32769, "select");
    input_default_gamepad_button(32770, "cancel");
    
    if (os_type == os_switch)
    {
        input_default_gamepad_button(32770, "jump");
        input_default_gamepad_button(32769, "slam");
    }
    else
    {
        input_default_gamepad_button(32769, "jump");
        input_default_gamepad_button(32770, "slam");
    }
    
    input_default_gamepad_button(32772, "ability equip");
    input_default_gamepad_button(32778, "pause");
    input_default_gamepad_axis_pair(32785, 32786, "x", "y");
    input_default_mouse_button(1, "menu select");
    input_default_key(27, "menu back");
    input_default_gamepad_button(32769, "menu select");
    input_default_gamepad_button(32770, "menu back");
    input_default_gamepad_axis(32785, true, "menu left", 0);
    input_default_gamepad_axis(32785, false, "menu right", 0);
    input_default_gamepad_axis(32786, true, "menu up", 0);
    input_default_gamepad_axis(32786, false, "menu down", 0);
    input_default_gamepad_button(32783, "menu left", 1);
    input_default_gamepad_button(32784, "menu right", 1);
    input_default_gamepad_button(32781, "menu up", 1);
    input_default_gamepad_button(32782, "menu down", 1);
}
