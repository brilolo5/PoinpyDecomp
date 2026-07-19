function __scribble_gc_collect()
{
    if ((current_time - global.__scribble_cache_check_time) < ((0.95 * game_get_speed(gamespeed_microseconds)) / 1000))
        exit;
    
    global.__scribble_cache_check_time = current_time;
    var _list = global.__scribble_ecache_list;
    var _size = ds_list_size(_list);
    var _index = min(global.__scribble_ecache_list_index, _size);
    
    repeat (max(3, ceil(sqrt(_size))))
    {
        _index--;
        
        if (_index < 0)
        {
            _index += ds_list_size(_list);
            
            if (_index < 0)
            {
                _index = 0;
                break;
            }
        }
        
        var _element = _list[| _index];
        
        if ((_element.last_drawn + 120) < current_time)
            ds_list_delete(_list, _index);
    }
    
    global.__scribble_ecache_list_index = _index;
    _index = global.__scribble_ecache_name_index;
    _list = global.__scribble_ecache_name_list;
    var _dict = global.__scribble_ecache_dict;
    
    repeat (max(3, ceil(sqrt(ds_list_size(_list)))))
    {
        _index--;
        
        if (_index < 0)
        {
            _index += ds_list_size(_list);
            
            if (_index < 0)
            {
                _index = 0;
                break;
            }
        }
        
        var _name = _list[| _index];
        var _weak = _dict[? _name];
        
        if (_weak == undefined || !weak_ref_alive(_weak))
        {
            ds_map_delete(_dict, _name);
            ds_list_delete(_list, _index);
        }
    }
    
    global.__scribble_ecache_name_index = _index;
    _index = global.__scribble_mcache_name_index;
    _list = global.__scribble_mcache_name_list;
    _dict = global.__scribble_mcache_dict;
    
    repeat (max(3, ceil(sqrt(ds_list_size(_list)))))
    {
        _index--;
        
        if (_index < 0)
        {
            _index += ds_list_size(_list);
            
            if (_index < 0)
            {
                _index = 0;
                break;
            }
        }
        
        var _name = _list[| _index];
        var _weak = _dict[? _name];
        
        if (_weak == undefined || !weak_ref_alive(_weak))
        {
            ds_map_delete(_dict, _name);
            ds_list_delete(_list, _index);
        }
    }
    
    global.__scribble_mcache_name_index = _index;
    _index = global.__scribble_gc_vbuff_index;
    var _ref_array = global.__scribble_gc_vbuff_refs;
    var _id_array = global.__scribble_gc_vbuff_ids;
    
    repeat (max(3, ceil(sqrt(array_length(_ref_array)))))
    {
        _index--;
        
        if (_index < 0)
        {
            _index += array_length(_ref_array);
            
            if (_index < 0)
            {
                _index = 0;
                break;
            }
        }
        
        var _weak = _ref_array[_index];
        
        if (!weak_ref_alive(_weak))
        {
            vertex_delete_buffer(_id_array[_index]);
            array_delete(_ref_array, _index, 1);
            array_delete(_id_array, _index, 1);
        }
    }
    
    global.__scribble_gc_vbuff_index = _index;
}

function __scribble_gc_add_vbuff(arg0, arg1)
{
    array_push(global.__scribble_gc_vbuff_refs, weak_ref_create(arg0));
    array_push(global.__scribble_gc_vbuff_ids, arg1);
}

function __scribble_gc_remove_vbuff(arg0)
{
    var _index = __scribble_array_find_index(global.__scribble_gc_vbuff_ids, arg0);
    
    if (_index >= 0)
    {
        array_delete(global.__scribble_gc_vbuff_refs, _index, 1);
        array_delete(global.__scribble_gc_vbuff_ids, _index, 1);
    }
}
