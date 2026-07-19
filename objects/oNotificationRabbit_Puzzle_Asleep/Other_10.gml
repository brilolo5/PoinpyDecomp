if (live_call())
    return global.live_result;

var gts = global.timeScale;
var _drawx = x + 4;
var _drawy = y + 1;
eyeColor = make_color_rgb(36, 145, 249);
imageSpeed = sprite_get_speed(spriteIndex);
imageIndex += (imageSpeed * gts);
var _imageCount = sprite_get_number(spriteIndex);
var _animationLooped = imageIndex >= _imageCount;

switch (state)
{
    case "jump awake":
        if (spriteIndex == 278)
        {
            if (_animationLooped)
            {
                spriteIndex = sNotifRabbit_Blink;
                playerSlammed = 0;
                backToSleepTimer = 0;
            }
        }
        else
        {
            backToSleepTimer += doDelta(0.002380952380952381);
            
            if (backToSleepTimer >= 1)
                rabbitStateChange("notification cleared - asleep", xDirection);
        }
        
        break;
    
    case "notification cleared - asleep":
        break;
    
    default:
        break;
}

xDirection = -1;
draw_sprite_ext(spriteIndex, imageIndex, _drawx, _drawy, 0.1 * xDirection, 0.1, 0, c_white, 1);
draw_sprite_ext(getEyesSprite(), imageIndex, _drawx, _drawy, 0.1 * xDirection, 0.1, 0, eyeColor, 1);
