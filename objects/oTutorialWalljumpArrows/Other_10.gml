var _drawx = xstart;
var _drawy = ystart;
var _imageIndex = 0;

switch (currentState)
{
    case "inactive":
        if (oPlayer.y < (y + 32))
            stateChange("appear");
        
        break;
    
    case "pause before appear":
        if (stateInit())
            stateTimer = 0;
        
        stateTimer += 0.022222222222222223;
        
        if (stateTimer >= 1)
            stateChange("appear");
        
        break;
    
    case "appear":
        if (stateInit())
        {
            offsetRate_y = -1;
            imageAlpha = 0;
        }
        
        offsetRate_y = deltaLerp(offsetRate_y, 0, 0.05);
        imageAlpha = (1 + offsetRate_y) * 0.75;
        _drawy += (offsetRate_y * 3);
        
        if (offsetRate_y == 0)
            stateChange("pause");
        
        break;
    
    case "pause":
        if (stateInit())
            stateTimer = 0;
        
        stateTimer += 1;
        
        if (stateTimer >= 1)
            stateChange("animate");
        
        break;
    
    case "animate":
        if (stateInit())
            imageAlpha = 0.75;
        
        imageAlpha = 0.75;
        imageIndex += doDelta(0.25);
        _imageIndex = 0;
        break;
}

draw_sprite_ext(sTutorialJumpArrow1, _imageIndex, _drawx, _drawy, image_xscale, image_yscale, image_angle, c_white, imageAlpha);
