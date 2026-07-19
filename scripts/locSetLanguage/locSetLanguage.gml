function locSetLanguage(arg0)
{
    if (arg0 == "japanese")
        arg0 = "Japanese";
    
    if (arg0 == "english")
        arg0 = "English";
    
    if (!variable_struct_exists(global.__locDatabase, arg0))
        traceError("Language \"", arg0, "\" not recognised");
    
    global.__locLanguage = arg0;
    global.__locLanguageStruct = variable_struct_get(global.__locDatabase, arg0);
    __locTrace("Set language to \"", arg0, "\"");
    
    switch (arg0)
    {
        case "Japanese":
            scribble_msdf_thickness_offset(0);
            break;
        
        case "Arabic":
            scribble_msdf_thickness_offset(0.02);
            break;
        
        default:
            scribble_msdf_thickness_offset(0);
            break;
    }
}
