function uiFocusGamepad()
{
    var _tag = argument[0];
    var _dx = argument[1];
    var _dy = argument[2];
    var _select_state = argument[3];
    var _back_state = argument[4];
    var _threshold = (argument_count > 5 && argument[5] != undefined) ? argument[5] : 0.3;
    var _element = __uiElementFind(_tag);
    
    if (_element == global.__uiNullElement)
        __uiError("Tag \"", _tag, "\" not found");
    
    with (_element)
    {
        __uiFocusCommonStart();
        
        if (__rootPrevTopElement == global.__uiNullElement)
        {
            global.__uiTempOver = __nearestFocusableDecendent(outShapeXCenter, outShapeYCenter);
            __rootGamepadLastFocus = current_time;
            __uiTrace("Root \"", _tag, "\" had no gamepad focus, found nearest focusable decendent \"", global.__uiTempOver.tagPath, "\"");
        }
        else if (!__rootPrevTopElement.__isFocusable())
        {
            global.__uiTempOver = __nearestFocusableDecendent(outShapeXCenter, outShapeYCenter);
            __rootGamepadLastFocus = current_time;
            __uiTrace("Root \"", _tag, "\"'s last focused element is no invalid, found nearest focusable decendent \"", global.__uiTempOver.tagPath, "\"");
        }
        else
        {
            global.__uiTempOver = __rootPrevTopElement;
            
            if (((_dx * _dx) + (_dy * _dy)) > 0.09 && (__rootGamepadLastFocus < 0 || (current_time - __rootGamepadLastFocus) > 170))
            {
                var _origin_x = __rootPrevTopElement.outShapeXCenter;
                var _origin_y = __rootPrevTopElement.outShapeYCenter;
                var _d = 1 / sqrt((_dx * _dx) + (_dy * _dy));
                var _axis_dx = _d * _dx;
                var _axis_dy = _d * _dy;
                var _origin_dist = (_origin_x * _axis_dx) + (_origin_y * _axis_dy);
                global.__uiTempElementArray = [];
                global.__uiTempElementDict = {};
                __focusGamepadBuildTree(_origin_x, _origin_y, _origin_dist, _axis_dx, _axis_dy, dcos(30));
                array_sort(global.__uiTempElementArray, function(arg0, arg1)
                {
                    return sign(arg0.distance - arg1.distance);
                });
                
                if (array_length(global.__uiTempElementArray) > 0)
                {
                    if (global.__uiTempElementArray[0].distance > 0)
                    {
                        var _nearest;
                        
                        do
                        {
                            _nearest = __uiElementFind(global.__uiTempElementArray[0].tag).__nearestFocusableDecendent(_origin_x, _origin_y);
                            
                            if (_nearest == global.__uiNullElement)
                                array_delete(global.__uiTempElementArray, 0, 1);
                            
                            if (_nearest == __rootPrevTopElement.globalTag)
                            {
                                array_delete(global.__uiTempElementArray, 0, 1);
                                _nearest = global.__uiNullElement;
                            }
                        }
                        until (_nearest != global.__uiNullElement || array_length(global.__uiTempElementArray) <= 0);
                        
                        if (_nearest != global.__uiNullElement)
                            global.__uiTempOver = _nearest;
                        
                        __rootGamepadLastFocus = current_time;
                    }
                }
                
                global.__uiTempElementArray = undefined;
                global.__uiTempElementDict = undefined;
            }
            else
            {
                __focusGamepadBuildTreeNeutral();
                
                if (((_dx * _dx) + (_dy * _dy)) <= 0.09)
                    __rootGamepadLastFocus = -1;
            }
        }
        
        if (global.__uiTempOver != global.__uiNullElement)
            global.__uiTempOver.scrollTo();
        
        __uiFocusCommonEnd(_select_state, _back_state, false);
        __callOnOffEvents(true);
    }
}
