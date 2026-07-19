function __uiFocusCommonStart()
{
}

function __uiFocusCommonEnd(arg0, arg1, arg2)
{
    var _element_top = global.__uiTempOver;
    var _element_drag = _element_top.__findAncestorWithEventGroup(UnknownEnum.Value_5);
    
    if (_element_drag == global.__uiNullElement)
        _element_drag = __rootPrevElement;
    
    var _element_back = _element_top.__findAncestorWithEventGroup(UnknownEnum.Value_4);
    var _gesture = __rootCursorGesture;
    var _event = undefined;
    var _drag_dx = 0;
    var _drag_dy = 0;
    
    if (arg0)
    {
        if (__rootDragTime < 0)
        {
            __rootDragTime = 0;
            __rootDragLastX = global.__uiTempX;
            __rootDragLastY = global.__uiTempY;
        }
        else
        {
            __rootDragTime++;
        }
        
        var _limit = (arg2 && (os_type == os_ios || os_type == os_android)) ? 2 : 0;
        
        if (__rootDragTime >= _limit)
        {
            if (arg2 && _element_drag != global.__uiNullElement)
            {
                _drag_dx = global.__uiTempX - __rootDragLastX;
                _drag_dy = global.__uiTempY - __rootDragLastY;
                
                if (__rootCursorGesture == "drag")
                {
                    __rootDragLastX = global.__uiTempX;
                    __rootDragLastY = global.__uiTempY;
                    _event = "on";
                }
                else if ((abs(_drag_dx) + abs(_drag_dy)) > global.__uiScrollThreshold)
                {
                    _gesture = "drag";
                    _event = "pressed";
                }
            }
            
            if (_gesture != "drag")
            {
                if (__rootCursorClickState)
                {
                    _event = "on";
                }
                else
                {
                    _gesture = "click";
                    _event = "pressed";
                    __rootCursorClickState = true;
                }
            }
        }
    }
    else
    {
        if (__rootCursorButtonState)
        {
            _event = "released";
            
            if (__rootDragTime >= 0 && _gesture == "none")
            {
                _gesture = "click";
                _event = "short release";
            }
        }
        else if ((os_type == os_windows || os_type == os_macosx || os_type == os_linux) && mouse_wheel_up() && _element_drag != global.__uiNullElement)
        {
            _gesture = "drag";
            _event = "mouse wheel up";
        }
        else if ((os_type == os_windows || os_type == os_macosx || os_type == os_linux) && mouse_wheel_down() && _element_drag != global.__uiNullElement)
        {
            _gesture = "drag";
            _event = "mouse wheel down";
        }
        else
        {
            _event = "off";
        }
        
        __rootDragTime = -1;
        __rootCursorClickState = false;
    }
    
    if (_element_back != global.__uiNullElement)
    {
        if (arg1)
        {
            _gesture = "back";
            
            if (__rootCursorBackState)
            {
                _event = "on";
            }
            else
            {
                _event = "pressed";
                __rootCursorBackState = true;
            }
        }
        else
        {
            if (__rootCursorBackState)
            {
                _gesture = "back";
                _event = "released";
            }
            
            __rootCursorBackState = false;
        }
    }
    
    if (__rootCursorGesture != _gesture)
    {
        if (__rootPrevElement != global.__uiNullElement)
        {
            switch (__rootCursorGesture)
            {
                case "click":
                    with (__rootPrevElement)
                        outCursorClick = false;
                    
                    break;
                
                case "back":
                    with (__rootPrevElement)
                        outCursorBack = false;
                    
                    break;
                
                case "drag":
                    with (__rootPrevElement)
                    {
                        outCursorDrag = false;
                        __callEvent(UnknownEnum.Value_18, 0, 0);
                    }
                    
                    break;
            }
        }
        
        __rootCursorGesture = _gesture;
    }
    
    if (__rootCursorGesture == "drag" || (arg2 && (os_type == os_ios || os_type == os_android) && !arg0))
    {
        if (__rootPrevTopElement != global.__uiNullElement)
        {
            with (__rootPrevTopElement)
            {
                outCursorTop = false;
                
                if (!arg2)
                    outCursorInside = false;
                
                __callEvent(UnknownEnum.Value_6);
            }
        }
        
        __rootPrevTopElement = global.__uiNullElement;
    }
    else if (!(arg2 && (os_type == os_ios || os_type == os_android) && __rootDragTime < 6))
    {
        if (__rootPrevTopElement != _element_top)
        {
            if (__rootPrevTopElement != global.__uiNullElement)
            {
                with (__rootPrevTopElement)
                {
                    outCursorTop = false;
                    
                    if (!arg2)
                        outCursorInside = false;
                    
                    __callEvent(UnknownEnum.Value_6);
                }
            }
            
            if (_element_top != global.__uiNullElement)
            {
                with (_element_top)
                {
                    outCursorTop = true;
                    
                    if (!arg2)
                        outCursorInside = true;
                    
                    __callEvent(UnknownEnum.Value_4);
                }
            }
            
            __rootPrevTopElement = _element_top;
        }
    }
    
    var _element = global.__uiNullElement;
    
    switch (__rootCursorGesture)
    {
        case "inside":
            _element = _element_top.__findAncestorWithEventGroup(UnknownEnum.Value_2);
            break;
        
        case "click":
            _element = _element_top.__findAncestorWithEventGroup(UnknownEnum.Value_3);
            break;
        
        case "back":
            _element = _element_back;
            break;
        
        case "drag":
            _element = _element_drag;
            break;
    }
    
    if (_element != global.__uiNullElement)
    {
        switch (__rootCursorGesture)
        {
            case "click":
                with (_element)
                {
                    switch (_event)
                    {
                        case "pressed":
                            if (!outCursorClick)
                            {
                                outCursorClick = true;
                                __callEvent(UnknownEnum.Value_8);
                            }
                            
                            break;
                        
                        case "released":
                            if (outCursorClick)
                            {
                                outCursorClick = false;
                                __callEvent(UnknownEnum.Value_10);
                            }
                            
                            break;
                        
                        case "short release":
                            __callEvent(UnknownEnum.Value_10);
                            break;
                    }
                }
                
                break;
            
            case "back":
                with (_element)
                {
                    switch (_event)
                    {
                        case "pressed":
                            if (!outCursorBack)
                            {
                                outCursorBack = true;
                                __callEvent(UnknownEnum.Value_12);
                            }
                            
                            break;
                        
                        case "released":
                            if (outCursorBack)
                            {
                                outCursorBack = false;
                                __callEvent(UnknownEnum.Value_14);
                            }
                            
                            break;
                    }
                }
                
                break;
            
            case "drag":
                with (_element)
                {
                    switch (_event)
                    {
                        case "pressed":
                            if (!outCursorDrag)
                            {
                                outCursorDrag = true;
                                __callEvent(UnknownEnum.Value_16, _drag_dx, _drag_dy);
                            }
                            
                            break;
                        
                        case "on":
                            if (outCursorDrag)
                                __callEvent(UnknownEnum.Value_17, _drag_dx, _drag_dy);
                            
                            break;
                        
                        case "released":
                            if (outCursorDrag)
                            {
                                outCursorDrag = false;
                                __callEvent(UnknownEnum.Value_18, _drag_dx, _drag_dy);
                            }
                            
                            break;
                        
                        case "mouse wheel up":
                            __callEvent(UnknownEnum.Value_20, _drag_dx, _drag_dy);
                            break;
                        
                        case "mouse wheel down":
                            __callEvent(UnknownEnum.Value_21, _drag_dx, _drag_dy);
                            break;
                    }
                }
                
                break;
        }
    }
    
    if (_event == "off")
    {
        __rootCursorGesture = "none";
        __rootCursorEvent = "off";
        __rootPrevElement = global.__uiNullElement;
    }
    else
    {
        __rootCursorGesture = _gesture;
        __rootCursorEvent = _event;
        __rootPrevElement = _element;
    }
    
    __rootCursorButtonState = arg0;
}
