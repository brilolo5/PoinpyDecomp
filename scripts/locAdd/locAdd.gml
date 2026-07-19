function locAdd(arg0, arg1, arg2)
{
    var _struct = variable_struct_get(global.__locDatabase, arg0);
    
    if (!is_struct(_struct))
        traceError("New language found (", arg0, ") but new languages not permitted. Check for typos!");
    
    if (variable_struct_exists(_struct, arg1))
    {
        traceLoud("Warning! Tag \"", arg1, "\" already exists (=\"", variable_struct_get(_struct, arg1), "\", ", arg0, ")");
    }
    else
    {
        arg2 = string_replace_all(arg2, "\\n", "\n");
        variable_struct_set(_struct, arg1, arg2);
    }
}
