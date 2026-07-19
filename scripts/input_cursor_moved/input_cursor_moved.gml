function input_cursor_moved()
{
    var _player_index = (argument_count > 0 && argument[0] != undefined) ? argument[0] : 0;
    var _buffer_duration = (argument_count > 1) ? argument[1] : undefined;
    
    if (_player_index < 0)
    {
        __input_error("Invalid player index provided (", _player_index, ")");
        return undefined;
    }
    
    if (_player_index >= 4)
    {
        __input_error("Player index too large (", _player_index, " vs. ", 4, ")\nIncrease INPUT_MAX_PLAYERS to support more players");
        return undefined;
    }
    
    if (_buffer_duration == undefined)
        _buffer_duration = 0;
    
    with (global.__input_players[_player_index].cursor)
        return (__input_get_time() - moved_time) <= _buffer_duration;
}
