function TexanCommitStep()
{
    __TexanTrace("Performing a flush/fetch step");
    
    if (!ds_list_empty(global.__texanFlush))
    {
        var _i = 0;
        
        repeat (ds_list_size(global.__texanFlush))
        {
            var _texture_group = global.__texanFlush[| _i];
            texture_flush(_texture_group);
            __TexanTrace("Flushed \"", _texture_group, "\"");
            _i++;
        }
        
        ds_list_clear(global.__texanFlush);
    }
    
    var _t_outer = get_timer();
    
    while (!ds_list_empty(global.__texanFetch) && (get_timer() - _t_outer) < 1000)
    {
        var _texture_group = global.__texanFetch[| 0];
        ds_list_delete(global.__texanFetch, 0);
        var _t = get_timer();
        texture_prefetch(_texture_group);
        
        if (true && (get_timer() - _t) > 1000)
        {
            __TexanTrace("Fetched \"", _texture_group, "\"");
        }
        else
        {
        }
    }
    
    if (ds_list_empty(global.__texanFlush) && ds_list_empty(global.__texanFetch))
    {
        ds_list_copy(global.__texanFetch, global.__texanAlwaysFetch);
        return true;
    }
    else
    {
        return false;
    }
}
