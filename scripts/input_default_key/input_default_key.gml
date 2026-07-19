function input_default_key()
{
    var _key = argument[0];
    var _verb = argument[1];
    var _alternate = (argument_count > 2 && argument[2] != undefined) ? argument[2] : 0;
    
    if (is_string(_key))
        _key = ord(string_upper(_key));
    
    global.__input_keyboard_valid = true;
    global.__input_default_player.set_binding(UnknownEnum.Value_1, _verb, _alternate, new __input_class_binding("key", _key));
    var _p = 0;
    
    repeat (4)
    {
        global.__input_players[_p].set_binding(UnknownEnum.Value_1, _verb, _alternate, new __input_class_binding("key", _key));
        _p++;
    }
}
