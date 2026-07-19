if (pressed)
{
    if (!initiated)
    {
        initiated = 1;
        image_index = clamp(image_index, 1, 10);
        pressed = approach(pressed, image_number - 1, 0.3 * global.timeScale);
        instance_create_depth(x, y, 0, oShootIntoSpace);
        
        with (oPlayer)
        {
            xsp = -(x - other.x) / 32;
            ysp = -2;
        }
        
        mask_index = mask_nomask;
    }
    
    draw_sprite_ext(sLaunchSwitch_big_switch, pressed, x + cx, y + cy, 0.1, 0.1, image_angle, c_white, image_alpha);
}
else
{
    if (oPlayer.y <= y)
    {
        with (oGameBackground)
            bgArea = -99;
    }
    
    draw_sprite_ext(sLaunchSwitch_big_switch, pressed, x + cx, y + cy, 0.1, 0.1, image_angle, c_white, image_alpha);
}
