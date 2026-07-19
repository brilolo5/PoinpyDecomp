function uiIndexOnParent(arg0)
{
    var _element = __uiElementFind(arg0);
    
    if (_element == global.__uiNullElement)
    {
        __uiTrace("Element \"", arg0, "\" doesn't exist");
        return undefined;
    }
    
    var _parent = __uiElementFind(_element.parentTag);
    
    if (_parent == global.__uiNullElement)
    {
        __uiTrace("Element \"", arg0, "\" has no parent, or the parent element has been destroyed (parentTag = \"", _element.parentTag, "\")");
        return undefined;
    }
    
    var _index = undefined;
    var _array = _parent.children;
    var _i = 0;
    
    repeat (array_length(_array))
    {
        if (_array[_i] == arg0)
        {
            _index = _i;
            break;
        }
        
        _i++;
    }
    
    if (_index == undefined)
    {
        __uiError("Element \"", arg0, "\" could not be found in parent's children array (parentTag = \"", _element.parentTag, "\")");
        return undefined;
    }
    
    return _index;
}
