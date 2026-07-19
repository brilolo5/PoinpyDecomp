function uiAnimSetCallback(arg0, arg1)
{
    var _element = __uiElementFind(arg0);
    
    if (_element == global.__uiNullElement)
        __uiError("Tag \"", arg0, "\" not found");
    
    return _element.animSetCallback(arg1);
}
