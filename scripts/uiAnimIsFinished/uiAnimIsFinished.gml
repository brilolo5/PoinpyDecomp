function uiAnimIsFinished()
{
    var _tag = argument[0];
    var _include_children = (argument_count > 1 && argument[1] != undefined) ? argument[1] : true;
    var _element = __uiElementFind(_tag);
    
    if (_element == global.__uiNullElement)
        __uiError("Tag \"", _tag, "\" not found");
    
    return _element.animIsFinished(_include_children);
}
