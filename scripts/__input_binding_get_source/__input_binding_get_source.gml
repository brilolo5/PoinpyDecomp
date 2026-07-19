function __input_binding_get_source(arg0)
{
    if (arg0.type == "key" || arg0.type == "mouse button" || arg0.type == "mouse wheel up" || arg0.type == "mouse wheel down")
        return UnknownEnum.Value_1;
    else if (arg0.type == "gamepad button" || arg0.type == "gamepad axis")
        return UnknownEnum.Value_2;
    
    __input_error("Binding type \"", arg0.type, "\" unrecognised");
    return undefined;
}
