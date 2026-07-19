function uiAnimStart()
{
    var _tag = argument[0];
    var _anim_name = argument[1];
    var _include_children = (argument_count > 2 && argument[2] != undefined) ? argument[2] : true;
    var _element = __uiElementFind(_tag);
    
    if (_element == global.__uiNullElement)
        __uiError("Tag \"", _tag, "\" not found");
    
    return _element.animStart(_anim_name, _include_children);
}
