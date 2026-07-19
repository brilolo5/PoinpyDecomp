if (stomped)
{
    repeat (2)
    {
        var _randPosx = random_range(x, bbox_right);
        var _randPosy = random_range(bbox_top, bbox_bottom + 32);
        var _randDir = 45 + (random(30) * choose(-1, 1));
        generateEffect(_randPosx, _randPosy, "glass shard", _randDir);
    }
    
    repeat (2)
    {
        var _randPosx = random_range(bbox_left, x);
        var _randPosy = random_range(bbox_top, bbox_bottom + 32);
        var _randDir = 135 + (random(30) * choose(-1, 1));
        generateEffect(_randPosx, _randPosy, "glass shard", _randDir);
    }
    
    stomped = 0;
    whiteFlash = 6;
    durability = approach(durability, 0, 1);
    
    if (durability == 0)
    {
        timeScaleChange(0.4, 120, 1);
        playerControlLockTimer(60);
        
        repeat (4)
        {
            repeat (2)
            {
                var _randPosx = random_range(x, bbox_right);
                var _randPosy = random_range(bbox_top, bbox_bottom + 16);
                var _randDir = 55 + (random(30) * choose(-1, 1));
                generateEffect(_randPosx, _randPosy, "glass shard dramatic", _randDir);
            }
            
            repeat (2)
            {
                var _randPosx = random_range(bbox_left, x);
                var _randPosy = random_range(bbox_top, bbox_bottom + 16);
                var _randDir = 125 + (random(30) * choose(-1, 1));
                generateEffect(_randPosx, _randPosy, "glass shard dramatic", _randDir);
            }
            
            repeat (2)
            {
                var _randPosx = random_range(x - 16, x + 16);
                var _randPosy = random_range(bbox_top, bbox_bottom);
                var _randDir = 90 + (random(20) * choose(-1, 1));
                generateEffect(_randPosx, _randPosy, "glass shard dramatic", _randDir);
            }
        }
        
        playSoundMagmaSwitchBreak();
        beastFaceStateChange("magma switch case shattered");
        instance_create_depth(x, y, 0, oSlamSwitch_FinalArea);
        instance_destroy();
    }
    else
    {
        beastFaceStateChange("magma switch case stomped");
        playSoundMagmaSwitchBounce();
    }
}

if (whiteFlash > 0)
{
    whiteFlash -= 1;
    shader_set_track(shaderWhiteFlash);
    draw_sprite_ext(sLaunchSwitch_light, 1, x, y, 0.1, 0.1, 0, c_white, 1);
}

image_index = ((durabilityMax - durability) / durabilityMax) * (image_number - 1);
image_index = ceil(image_index);
draw_self();
shader_reset_track();
