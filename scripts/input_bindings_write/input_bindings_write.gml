function input_bindings_write()
{
    var _player_index = (argument_count > 0 && argument[0] != undefined) ? argument[0] : -3;
    
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
    
    var _config = undefined;
    
    if (_player_index == -3)
    {
        _config = array_create(4, undefined);
        var _i = 0;
        
        repeat (4)
        {
            array_set(_config, _i, global.__input_players[_i].config);
            _i++;
        }
    }
    else
    {
        _config = global.__input_players[_player_index].config;
    }
    
    return json_stringify(_config);
}
