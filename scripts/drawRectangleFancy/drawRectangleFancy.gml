function drawRectangleFancy()
{
    var _x1 = argument[0];
    var _y1 = argument[1];
    var _x2 = argument[2];
    var _y2 = argument[3];
    var _colour = argument[4];
    var _outline_colour = (argument_count > 5) ? argument[5] : undefined;
    var _outline_thickness = (argument_count > 6) ? argument[6] : undefined;
    var _shadow_colour = (argument_count > 6) ? argument[6] : undefined;
    var _shadow_alpha = (argument_count > 7) ? argument[7] : undefined;
    var _shadow_radius = (argument_count > 8) ? argument[8] : undefined;
    var _shadow_dx = (argument_count > 9) ? argument[9] : undefined;
    var _shadow_dy = (argument_count > 10) ? argument[10] : undefined;
    
    if (_shadow_alpha != undefined && _shadow_alpha >= 0)
        drawSquircle(_x1 + _shadow_dx, _y1 + _shadow_dy, _x2 + _shadow_dx, _y2 + _shadow_dy, _shadow_radius, _shadow_colour, _shadow_alpha);
    
    drawRectangleFast(_x1, _y1, _x2, _y2, _colour, 1);
    
    if (_outline_colour != undefined && _outline_thickness != undefined && _outline_thickness > 0)
        drawRectangleOutlineFast(_x1, _y1, _x2, _y2, _outline_colour, 1, _outline_thickness);
}
