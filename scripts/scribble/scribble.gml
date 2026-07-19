function scribble()
{
    var _string = (argument_count > 0) ? argument[0] : undefined;
    var _unique_id = (argument_count > 1) ? string(argument[1]) : "default";
    
    if (argument_count == 0)
    {
        do
            _unique_id = "anonymous " + string(floor(999999 * __scribble_random()));
        until (!ds_map_exists(global.__scribble_ecache_dict, ":" + _unique_id));
        
        return new __scribble_class_element("", _unique_id);
    }
    else
    {
        if (is_struct(_string) && instanceof(_string) == "__scribble_class_element")
            __scribble_error("scribble() should not be used to access/draw text elements\nPlease instead call the .draw() method on a text element e.g. scribble(\"text\").draw(x, y);");
        else
            _string = string(_string);
        
        var _weak = global.__scribble_ecache_dict[? _string + ":" + _unique_id];
        
        if (_weak == undefined || !weak_ref_alive(_weak) || _weak.ref.flushed)
            return new __scribble_class_element(_string, _unique_id);
        else
            return _weak.ref;
    }
}
