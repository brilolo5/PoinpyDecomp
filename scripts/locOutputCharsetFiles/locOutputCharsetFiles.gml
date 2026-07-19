function locOutputCharsetFiles(arg0 = "")
{
    __locTrace("Outputting charset files...");
    var _t = get_timer();
    var _i = 0;
    
    repeat (array_length(global.__locLanguageArray))
    {
        var _language = global.__locLanguageArray[_i];
        var _filename = "charset_" + string_replace_all(_language, " ", "_") + ".txt";
        var _string = locFindAllUniqueGlyphs(_language, arg0);
        __locTrace("", _filename, " = \"", _string, "\"");
        _string = string_replace_all(_string, "\\", "\\\\");
        _string = string_replace_all(_string, "\"", "\\\"");
        _string = "\"" + _string + "\"";
        var _buffer = buffer_create(string_byte_length(_string), buffer_fixed, 1);
        buffer_write(_buffer, buffer_text, _string);
        buffer_save(_buffer, _filename);
        buffer_delete(_buffer);
        _i++;
    }
    
    __locTrace("...took ", (get_timer() - _t) / 1000, "ms");
}
