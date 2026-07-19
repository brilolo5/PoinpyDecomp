function uiFocusCursor(arg0, arg1, arg2, arg3, arg4)
{
    var _element = __uiElementFind(arg0);
    
    if (_element == global.__uiNullElement)
        __uiError("Tag \"", arg0, "\" not found");
    
    with (_element)
    {
        global.__uiTempOver = global.__uiNullElement;
        global.__uiTempX = arg1;
        global.__uiTempY = arg2;
        __uiFocusCommonStart();
        __focusCursor(false);
        __uiFocusCommonEnd(arg3, arg4, true);
        __callOnOffEvents(true);
    }
}
