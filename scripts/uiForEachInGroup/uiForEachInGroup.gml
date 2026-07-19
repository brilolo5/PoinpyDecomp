function uiForEachInGroup()
{
    var _tag = argument[0];
    var _group_name = argument[1];
    var _function = argument[2];
    var _data = (argument_count > 3) ? argument[3] : undefined;
    var _element = __uiElementFind(_tag);
    
    if (_element == global.__uiNullElement)
        __uiError("Tag \"", _tag, "\" not found");
    
    _element.__forEachInGroup(_group_name, _function, _data);
}
