function debugVarTrackDraw()
{
    if (global.debugDrawVariableTracker)
    {
        if (is_array(global.debugDrawVariableTrackerArray))
        {
            var _objArraySize = array_length(global.debugDrawVariableTrackerArray);
            var _drawy = 8;
            
            for (var _o = 0; _o < _objArraySize; _o += 1)
            {
                var _obj = global.debugDrawVariableTrackerArray[_o][0];
                var _varTrackDataString, i;
                
                if (_obj != "global")
                {
                    var _objname = object_get_name(_obj);
                    _varTrackDataString = "[ER_GREEN2]" + _objname;
                    var _arraySize = array_length(global.debugDrawVariableTrackerArray[_o]);
                    
                    for (i = 1; i < _arraySize; i += 1)
                    {
                        if (variable_instance_exists(_obj, global.debugDrawVariableTrackerArray[_o][i]))
                        {
                            var _getvar = variable_instance_get(_obj, global.debugDrawVariableTrackerArray[_o][i]);
                            _varTrackDataString += ("[ER_WHITE]\n    " + string(global.debugDrawVariableTrackerArray[_o][i]) + " :[ER_YELLOW] " + string(_getvar));
                        }
                        else
                        {
                            var _getvar = variable_instance_get(_obj, global.debugDrawVariableTrackerArray[_o][i]);
                            _varTrackDataString += ("[ER_WHITE]\n    " + string(global.debugDrawVariableTrackerArray[_o][i]) + " :[ER_RED] " + "??");
                        }
                    }
                }
                else
                {
                    var _globalTextColor = "[ER_WHITE]";
                    _varTrackDataString = "[ER_RED2]global variables";
                    var _arraySize = array_length(global.debugDrawVariableTrackerArray[_o]);
                    
                    for (i = 1; i < _arraySize; i += 1)
                    {
                        if (variable_global_exists(global.debugDrawVariableTrackerArray[_o][i]))
                        {
                            var _getvar = variable_global_get(global.debugDrawVariableTrackerArray[_o][i]);
                            _varTrackDataString += (_globalTextColor + "\n    " + string(global.debugDrawVariableTrackerArray[_o][i]) + " :[ER_YELLOW] " + string(_getvar));
                        }
                        else
                        {
                            _varTrackDataString += (_globalTextColor + "\n    " + string(global.debugDrawVariableTrackerArray[_o][i]) + " :[ER_RED] " + "??");
                        }
                    }
                }
                
                drawSetAlign(0, 0);
                drawTextOutlined(16, _drawy, _varTrackDataString, make_color_rgb(255, 255, 255), make_color_rgb(46, 50, 59), 0, 0.5);
                _drawy += (i * 12);
            }
        }
    }
}
