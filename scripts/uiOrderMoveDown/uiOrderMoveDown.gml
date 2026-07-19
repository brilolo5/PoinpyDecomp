function uiOrderMoveDown(arg0)
{
    var _index = uiIndexOnParent(arg0);
    
    if (_index == undefined)
        exit;
    
    if (_index > 0)
    {
        array_delete(_array, _index, 1);
        array_insert(_array, _index - 1, arg0);
    }
}
