if (!set)
{
    dir = 45;
    spd = 0.2;
    set = 1;
}

if (set)
{
    spd *= 1.1;
    
    if (spd > 16)
        spd = 16;
    
    dir = point_direction(drawx, drawy, goalx, goaly);
    xsp = abs(spd * dcos(dir)) * global.timeScale;
    ysp = abs(spd * dsin(-dir)) * global.timeScale;
    drawx = approach(drawx, goalx, xsp);
    drawy = approach(drawy, goaly, ysp);
    
    if (drawx == goalx)
    {
        if (drawy == goaly)
            instance_destroy();
    }
}

xscale = imageSize / sprite_width;
image_angle = lerp(image_angle, 0, 0.05);
draw_sprite_ext(sprite_index, image_index, drawx, drawy, xscale, xscale, image_angle, c_white, 1);
