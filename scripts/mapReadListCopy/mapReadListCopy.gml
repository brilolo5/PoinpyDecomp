function mapReadListCopy(arg0, arg1)
{
    var _list_copy = ds_list_create();
    var _list = arg0[? arg1];
    
    if (_list != undefined)
        ds_list_copy(_list_copy, _list);
    
    return _list_copy;
}
