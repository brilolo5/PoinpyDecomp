function clearLocalHighscores()
{
    for (var _mode = 0; _mode < UnknownEnum.Value_3; _mode++)
    {
        var _current_list = global.arcadeAverageList_current[_mode];
        var _highest_list = global.arcadeAverageList_highest[_mode];
        ds_list_clear(_current_list);
        ds_list_clear(_highest_list);
        ds_list_add(_current_list, -1, -1, -1);
        ds_list_add(_highest_list, -1, -1, -1);
        array_set(global.highscore, _mode, 0);
        array_set(global.arcadeAreaLock, _mode, UnknownEnum.Value_5);
        array_set(global.arcadeAreaLock_highest, _mode, UnknownEnum.Value_5);
    }
}
