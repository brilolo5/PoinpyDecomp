function shader_set_track(arg0)
{
    if (keyboard_check_pressed(ord("J")))
        show_debug_message(concat("shader_set(", shader_get_name(arg0), ")          ", debug_get_callstack()));
    
    shader_set(arg0);
}

function shader_reset_track()
{
    if (keyboard_check_pressed(ord("J")))
        show_debug_message(concat("shader_reset()          ", debug_get_callstack()));
    
    shader_reset();
}
