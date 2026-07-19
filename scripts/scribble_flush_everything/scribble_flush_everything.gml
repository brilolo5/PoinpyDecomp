function scribble_flush_everything()
{
    var _i = 0;
    
    repeat (ds_list_size(global.__scribble_ecache_list))
    {
        global.__scribble_ecache_list[| _i].flushed = true;
        _i++;
    }
    
    _i = 0;
    
    repeat (array_length(global.__scribble_gc_vbuff_ids))
    {
        vertex_delete_buffer(global.__scribble_gc_vbuff_ids[_i]);
        _i++;
    }
    
    ds_map_clear(global.__scribble_ecache_dict);
    ds_list_clear(global.__scribble_ecache_name_list);
    global.__scribble_ecache_name_index = 0;
    ds_list_clear(global.__scribble_ecache_list);
    global.__scribble_ecache_list_index = 0;
    ds_map_clear(global.__scribble_mcache_dict);
    ds_list_clear(global.__scribble_mcache_name_list);
    global.__scribble_mcache_name_index = 0;
    global.__scribble_gc_vbuff_index = 0;
    global.__scribble_gc_vbuff_refs = [];
    global.__scribble_gc_vbuff_ids = [];
}
