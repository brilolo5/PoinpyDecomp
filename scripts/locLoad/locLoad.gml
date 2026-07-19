function locLoad()
{
    var _filename = argument[0];
    var _allow_new_languages = (argument_count > 1) ? argument[1] : undefined;
    __locTrace("Loading database from \"", _filename, "\"");
    
    if (!file_exists(_filename))
        traceError("Could not find localisation database (", _filename, ")");
    
    _allow_new_languages ??= array_length(global.__locLanguageArray) == 0;
    
    if (_allow_new_languages)
        __locTrace("Allowing new languages to be defined");
    
    var _tag_count = 0;
    var _csv_string = string_from_file(_filename);
    var _row_array = snap_from_csv(_csv_string);
    var _column_titles = _row_array[0];
    var _tag_x = array_find_index_custom(_column_titles, "Text ID");
    
    if (_tag_x < 0)
        traceError("Tag column not found (was searching for \"name / language\")");
    
    function languageExists(arg0)
    {
        switch (arg0)
        {
            case "English":
            case "Japanese":
            case "Korean":
            case "TChinese":
            case "French":
            case "German":
            case "Spanish Spain":
            case "Spanish LatAm":
            case "Portuguese":
            case "Italian":
            case "Turkish":
            case "Arabic":
            case "Thai":
            case "Swedish":
            case "Polish":
                return true;
            
            default:
                return false;
        }
    }
    
    var _x = 0;
    
    repeat (array_length(_column_titles))
    {
        var _language = _column_titles[_x];
        
        if (_x != _tag_x && languageExists(_language))
        {
            var _struct = variable_struct_get(global.__locDatabase, _language);
            
            if (!is_struct(_struct))
            {
                if (_allow_new_languages)
                {
                    array_push(global.__locLanguageArray, _language);
                    __locTrace("Found new language \"", _language, "\"");
                    _struct = {};
                    variable_struct_set(global.__locDatabase, _language, _struct);
                }
                else
                {
                    traceError("New language found (", _language, ") but new languages not permitted. Check for typos!");
                }
            }
            
            var _y = 1;
            
            repeat (array_length(_row_array) - 1)
            {
                var _column_array = _row_array[_y];
                var _tag = _column_array[_tag_x];
                
                if (_tag != "")
                {
                    if (array_length(_column_array) <= _x)
                        var _text = "";
                    else
                        _text = _column_array[_x];
                    
                    if (variable_struct_exists(_struct, _tag))
                    {
                        traceLoud("Warning! Tag \"", _tag, "\" already exists (=\"", variable_struct_get(_struct, _tag), "\", ", _language, ")");
                    }
                    else
                    {
                        _text = string_replace_all(_text, "\\n", "\n");
                        variable_struct_set(_struct, _tag, _text);
                    }
                    
                    array_push(global.locTagArray, _tag);
                    _tag_count++;
                }
                
                _y++;
            }
        }
        
        _x++;
    }
    
    var _language_count = array_length(global.__locLanguageArray);
    __locTrace("Unpacked ", _language_count, " languages and ", _tag_count / _language_count, " tags");
}
