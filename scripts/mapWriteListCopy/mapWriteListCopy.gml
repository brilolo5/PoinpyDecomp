function mapWriteListCopy(arg0, arg1, arg2)
{
    var _list_copy = ds_list_create();
    ds_list_copy(_list_copy, arg2);
    ds_map_add_list(arg0, arg1, _list_copy);
}
