function TexanFetch()
{
    var _i = 0;
    
    repeat (argument_count)
    {
        var _texture_group = argument[_i];
        var _index = ds_list_find_index(global.__texanFlush, _texture_group);
        
        if (_index >= 0)
            ds_list_delete(global.__texanFlush, _index);
        
        if (ds_list_find_index(global.__texanFetch, _texture_group) < 0)
            ds_list_add(global.__texanFetch, _texture_group);
        
        _i++;
    }
}
