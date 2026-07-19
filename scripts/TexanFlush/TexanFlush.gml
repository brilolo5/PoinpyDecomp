function TexanFlush()
{
    var _i = 0;
    
    repeat (argument_count)
    {
        var _texture_group = argument[_i];
        
        if (ds_list_find_index(global.__texanFetch, _texture_group) < 0 && ds_list_find_index(global.__texanFlush, _texture_group) < 0)
            ds_list_add(global.__texanFlush, argument[_i]);
        
        _i++;
    }
}
