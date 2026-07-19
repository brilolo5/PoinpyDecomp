function input_source_get_name(arg0)
{
    switch (arg0)
    {
        case UnknownEnum.Value_0:
            return "none";
            break;
        
        case UnknownEnum.Value_1:
            return "keyboard and mouse";
            break;
        
        case UnknownEnum.Value_2:
            return "gamepad";
            break;
    }
    
    return "unknown";
}
