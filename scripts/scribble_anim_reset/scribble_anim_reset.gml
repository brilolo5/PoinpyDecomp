function scribble_anim_reset()
{
    if (!global.__scribble_anim_shader_default || !global.__scribble_anim_shader_msdf_default)
    {
        array_set(global.__scribble_anim_properties, UnknownEnum.Value_0, 4);
        array_set(global.__scribble_anim_properties, UnknownEnum.Value_1, 50);
        array_set(global.__scribble_anim_properties, UnknownEnum.Value_2, 0.2);
        array_set(global.__scribble_anim_properties, UnknownEnum.Value_3, 2);
        array_set(global.__scribble_anim_properties, UnknownEnum.Value_4, 0.4);
        array_set(global.__scribble_anim_properties, UnknownEnum.Value_5, 0.5);
        array_set(global.__scribble_anim_properties, UnknownEnum.Value_6, 0.01);
        array_set(global.__scribble_anim_properties, UnknownEnum.Value_7, 15);
        array_set(global.__scribble_anim_properties, UnknownEnum.Value_8, 0.075);
        array_set(global.__scribble_anim_properties, UnknownEnum.Value_9, 0.4);
        array_set(global.__scribble_anim_properties, UnknownEnum.Value_10, 0.1);
        array_set(global.__scribble_anim_properties, UnknownEnum.Value_11, 1);
        array_set(global.__scribble_anim_properties, UnknownEnum.Value_12, 0.5);
        array_set(global.__scribble_anim_properties, UnknownEnum.Value_13, 0.2);
        array_set(global.__scribble_anim_properties, UnknownEnum.Value_14, 0.5);
        array_set(global.__scribble_anim_properties, UnknownEnum.Value_15, 180);
        array_set(global.__scribble_anim_properties, UnknownEnum.Value_16, 255);
        array_set(global.__scribble_anim_properties, UnknownEnum.Value_17, 0.7);
        array_set(global.__scribble_anim_properties, UnknownEnum.Value_18, 1.2);
        array_set(global.__scribble_anim_properties, UnknownEnum.Value_19, 0.4);
        global.__scribble_anim_blink_on_duration = 50;
        global.__scribble_anim_blink_off_duration = 50;
        global.__scribble_anim_blink_time_offset = 0;
    }
    
    if (!global.__scribble_anim_shader_default)
    {
        global.__scribble_anim_shader_desync = true;
        global.__scribble_anim_shader_desync_to_default = true;
    }
    
    if (!global.__scribble_anim_shader_msdf_default)
    {
        global.__scribble_anim_shader_msdf_desync = true;
        global.__scribble_anim_shader_msdf_desync_to_default = true;
    }
}
