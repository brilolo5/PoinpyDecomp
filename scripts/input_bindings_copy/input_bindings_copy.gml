function input_bindings_copy(arg0, arg1)
{
    var _player_s;
    
    if (is_struct(arg0))
    {
        _player_s = arg0;
    }
    else
    {
        _player_s = global.__input_players[arg0];
        
        if (arg0 < 0)
        {
            __input_error("Invalid source player index provided (", arg0, ")");
            return undefined;
        }
        
        if (arg0 >= 4)
        {
            __input_error("Source player index too large (", arg0, " vs. ", 4, ")\nIncrease INPUT_MAX_PLAYERS to support more players");
            return undefined;
        }
    }
    
    var _player_d;
    
    if (is_struct(arg1))
    {
        _player_d = arg1;
    }
    else
    {
        _player_d = global.__input_players[arg1];
        
        if (arg1 < 0)
        {
            __input_error("Invalid destination player index provided (", arg1, ")");
            return undefined;
        }
        
        if (arg1 >= 4)
        {
            __input_error("Destination player index too large (", arg1, " vs. ", 4, ")\nIncrease INPUT_MAX_PLAYERS to support more players");
            return undefined;
        }
    }
    
    with (_player_d)
    {
        sources = array_create(UnknownEnum.Value_3, undefined);
        var _source = 0;
        
        repeat (UnknownEnum.Value_3)
        {
            var _source_verb_struct = variable_struct_get(_player_s.config, global.__input_source_names[_source]);
            
            if (is_struct(_source_verb_struct))
            {
                var _verb_names = variable_struct_get_names(_source_verb_struct);
                var _v = 0;
                
                repeat (array_length(_verb_names))
                {
                    var _verb = _verb_names[_v];
                    var _alternate_array = variable_struct_get(_source_verb_struct, _verb);
                    
                    if (is_array(_alternate_array))
                    {
                        var _alternate = 0;
                        
                        repeat (array_length(_alternate_array))
                        {
                            var _binding = _alternate_array[_alternate];
                            
                            if (is_struct(_binding))
                                set_binding(_source, _verb, _alternate, __input_binding_duplicate(_binding));
                            
                            _alternate++;
                        }
                    }
                    
                    _v++;
                }
            }
            
            _source++;
        }
    }
}
