function uiFocusNearestDecendent(arg0, arg1, arg2)
{
    var _element = __uiElementFind(arg0);
    
    if (_element == global.__uiNullElement)
        __uiError("Tag \"", arg0, "\" not found");
    
    with (_element)
    {
        __uiFocusCommonStart();
        __nearestFocusableDecendent(arg1, arg2);
        
        if (global.__uiTempOver != global.__uiNullElement)
        {
            __rootGamepadLastFocus = current_time;
            global.__uiTempOver.scrollTo();
        }
        
        __uiFocusCommonEnd(false, false, false);
        __callOnOffEvents(true);
    }
}
