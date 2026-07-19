function uiForEachChild()
{
    var _tag = argument[0];
    var _function = argument[1];
    var _data = (argument_count > 2) ? argument[2] : undefined;
    var _element = __uiElementFind(_tag);
    
    if (_element == global.__uiNullElement)
        __uiError("Tag \"", _tag, "\" not found");
    
    _element.__forEachChild(_function, _data);
}
