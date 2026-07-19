function input_cursor_follow_camera()
{
    var _camera = argument[0];
    var _player_index = (argument_count > 1 && argument[1] != undefined) ? argument[1] : 0;
    
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
    
    if (_player_index == -3)
    {
        var _i = 0;
        
        repeat (4)
        {
            input_cursor_follow_camera(_camera, _i);
            _i++;
        }
    }
    else
    {
        global.__input_players[_player_index].cursor.camera = _camera;
    }
}
