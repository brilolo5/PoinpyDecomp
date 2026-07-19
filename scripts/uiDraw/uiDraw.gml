function uiDraw(arg0)
{
    var _element = __uiElementFind(arg0);
    
    if (_element == global.__uiNullElement)
        __uiError("Tag \"", arg0, "\" not found");
    
    if (keyboard_check_pressed(ord("J")))
        __uiTrace("-------------------------------------------\nStart\n-------------------------------------------");
    
    uiShaderReset();
    _element.__draw();
    shader_reset_track();
    
    if (keyboard_check_pressed(ord("J")))
        __uiTrace("-------------------------------------------\nEnd\n-------------------------------------------");
}
