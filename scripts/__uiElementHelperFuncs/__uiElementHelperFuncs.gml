function __uiElementRegister(arg0, arg1)
{
    if (ds_map_exists(global.__uiDictionary, arg1))
        __uiError("Tag \"", arg1, "\" has already been registered");
    
    global.__uiDictionary[? arg1] = arg0;
}

function __uiElementUnregister(arg0)
{
    ds_map_delete(global.__uiDictionary, arg0);
}

function __uiElementFind(arg0)
{
    if (!ds_map_exists(global.__uiDictionary, arg0))
        return global.__uiNullElement;
    
    return global.__uiDictionary[? arg0];
}
