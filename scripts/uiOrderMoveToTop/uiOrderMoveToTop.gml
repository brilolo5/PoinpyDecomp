function uiOrderMoveToTop(arg0)
{
    var _index = uiIndexOnParent(arg0);
    
    if (_index == undefined)
        exit;
    
    if (_index < (array_length(_array) - 1))
    {
        array_delete(_array, _index, 1);
        array_insert(_array, array_length(_array) - 1, arg0);
    }
}
