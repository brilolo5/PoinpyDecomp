function locFindAllUniqueGlyphs(arg0, arg1 = "")
{
    var _unique_struct = {};
    variable_struct_set(_unique_struct, "▯", true);
    variable_struct_set(_unique_struct, "?", true);
    var _language_name_tag = "";
    
    switch (arg0)
    {
        case "English":
            _language_name_tag = "language english";
            break;
        
        case "Japanese":
            _language_name_tag = "language japanese";
            break;
        
        case "Korean":
            _language_name_tag = "language korean";
            break;
        
        case "TChinese":
            _language_name_tag = "language tchinese";
            break;
        
        case "French":
            _language_name_tag = "language french";
            break;
        
        case "German":
            _language_name_tag = "language german";
            break;
        
        case "Spanish Spain":
            _language_name_tag = "language spanish spain";
            break;
        
        case "Spanish LatAm":
            _language_name_tag = "language spanish latam";
            break;
        
        case "Portuguese":
            _language_name_tag = "language portuguese";
            break;
        
        case "Italian":
            _language_name_tag = "language italian";
            break;
        
        case "Turkish":
            _language_name_tag = "language turkish";
            break;
        
        case "Arabic":
            _language_name_tag = "language arabic";
            break;
        
        case "Thai":
            _language_name_tag = "language thai";
            break;
        
        case "Swedish":
            _language_name_tag = "language swedish";
            break;
        
        case "Polish":
            _language_name_tag = "language polish";
            break;
    }
    
    var _i = 1;
    
    repeat (string_length(arg1))
    {
        variable_struct_set(_unique_struct, string_char_at(arg1, _i), true);
        _i++;
    }
    
    if (arg0 == "Arabic")
    {
        var _a = 65136;
        var _b = 65279;
        _i = _a;
        
        repeat ((1 + _b) - _a)
        {
            variable_struct_set(_unique_struct, chr(_i), true);
            _i++;
        }
    }
    
    if (arg0 == "Thai")
    {
        var _a = 3584;
        var _b = 3711;
        _i = _a;
        
        repeat ((1 + _b) - _a)
        {
            variable_struct_set(_unique_struct, chr(_i), true);
            _i++;
        }
        
        _a = 63232;
        _b = 63258;
        _i = _a;
        
        repeat ((1 + _b) - _a)
        {
            variable_struct_set(_unique_struct, chr(_i), true);
            _i++;
        }
    }
    
    var _struct = variable_struct_get(global.__locDatabase, arg0);
    
    if (is_struct(_struct))
    {
        var _tags_array = variable_struct_get_names(_struct);
        var _j = 0;
        
        repeat (array_length(_tags_array))
        {
            var _tag = _tags_array[_j];
            
            if (string_copy(_tag, 1, 9) != "language " || _tag == _language_name_tag)
            {
                var _text = variable_struct_get(_struct, _tag);
                var _k = 1;
                
                repeat (string_length(_text))
                {
                    variable_struct_set(_unique_struct, string_char_at(_text, _k), true);
                    _k++;
                }
            }
            
            _j++;
        }
    }
    
    var _array = variable_struct_get_names(_unique_struct);
    array_sort(_array, true);
    var _unique_string = "";
    _i = 0;
    
    repeat (array_length(_array))
    {
        var _char = _array[_i];
        
        if (ord(_char) >= 32)
            _unique_string += _char;
        
        _i++;
    }
    
    return _unique_string;
}
