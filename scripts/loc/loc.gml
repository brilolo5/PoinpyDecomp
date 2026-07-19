function loc(arg0)
{
    var _text = variable_struct_get(global.__locLanguageStruct, arg0);
    
    if (_text == undefined || _text == "")
        return "!" + arg0 + "!";
    
    var _i = 1;
    
    repeat (argument_count - 1)
    {
        _text = string_replace_all(_text, "%" + string(_i) + "%", string(argument[_i]));
        _i++;
    }
    
    return _text;
}
