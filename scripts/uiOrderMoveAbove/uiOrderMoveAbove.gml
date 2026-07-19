function uiOrderMoveAbove(arg0, arg1)
{
    var _index_a = uiIndexOnParent(arg0);
    
    if (_index_a == undefined)
        exit;
    
    var _index_b = uiIndexOnParent(arg1);
    
    if (_index_b == undefined)
        exit;
    
    var _element_a = __uiElementFind(arg0);
    var _element_b = __uiElementFind(arg1);
    
    if (_element_a.parentTag != _element_b.parentTag)
        __uiError("Cannot move \"", arg0, "\" relative to \"", arg1, "\", they have different parents (\"", _element_a.parentTag, "\" vs. \"", _element_b.parentTag, "\")");
    
    if (_index_a > _index_b)
    {
        var _array = __uiElementFind(_element_a.parentTag).children;
        array_delete(_array, _index_a, 1);
        array_insert(_array, _index_b + 1, arg0);
    }
}
