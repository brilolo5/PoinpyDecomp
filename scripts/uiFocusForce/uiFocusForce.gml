function uiFocusForce(arg0)
{
    var _element = __uiElementFind(arg0);
    
    if (_element == global.__uiNullElement)
        __uiError("Tag \"", arg0, "\" not found");
    
    if (_element.getActive() != true)
        __uiTrace("Warning! Forcing focus on element \"", _element.tagPath, "\". but element is inactive");
    
    with (__uiElementFind(_element.rootTag))
    {
        global.__uiTempOver = _element;
        __uiFocusCommonStart();
        __uiFocusCommonEnd(false, false, false);
        __callOnOffEvents(true);
        global.__uiTempOver = global.__uiNullElement;
    }
}
