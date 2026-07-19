function input_bindings_read()
{
    var _string = argument[0];
    var _player_index = (argument_count > 1 && argument[1] != undefined) ? argument[1] : -3;
    
    if (_player_index < 0 && _player_index != -3)
    {
        __input_error("Invalid player index provided (", _player_index, ")");
        return undefined;
    }
    
    if (_player_index >= 4)
    {
        __input_error("Player index too large (", _player_index, " vs. ", 4, ")\nIncrease INPUT_MAX_PLAYERS to support more players");
        return undefined;
    }
    
    var _config = json_parse(_string);
    
    if (_player_index == -3)
    {
        var _i = 0;
        
        repeat (4)
        {
            var _config_struct = _config[_i];
            __input_fix_config_struct(_config_struct);
            global.__input_players[_i].config = _config_struct;
            _i++;
        }
    }
    else
    {
        __input_fix_config_struct(_config);
        global.__input_players[_player_index].config = _config;
    }
}
