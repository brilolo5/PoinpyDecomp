function scribble_typewriter_add_character_delay(arg0, arg1)
{
    if (is_string(arg0))
        arg0 = ord(arg0);
    
    global.__scribble_character_delay = true;
    global.__scribble_character_delay_map[? arg0] = arg1;
}
