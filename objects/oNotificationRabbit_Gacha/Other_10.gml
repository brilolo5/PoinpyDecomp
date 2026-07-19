if (live_call())
    return global.live_result;

var gts = global.timeScale;
imageSpeed = sprite_get_speed(spriteIndex);
imageIndex += (imageSpeed * gts);
var _imageCount = sprite_get_number(spriteIndex);
var _animationLooped = imageIndex >= _imageCount;

switch (state)
{
    case "notification - jumping":
        var _reducedImageCount = _imageCount - 4;
        _animationLooped = imageIndex >= _reducedImageCount;
        
        if (_animationLooped)
        {
            if (stateBuffer != -1)
                rabbitStateChange(stateBuffer);
            else
                imageIndex -= _reducedImageCount;
        }
        
        break;
    
    case "notification - checking in":
        if (spriteIndex == 595)
        {
            if (_animationLooped)
            {
                spriteIndex = sNotifRabbit_Blink;
                imageSpeed = sprite_get_speed(spriteIndex);
                imageIndex = 0;
            }
        }
        else if (spriteIndex == 630)
        {
            if (_animationLooped)
            {
                if (stateBuffer != -1)
                    rabbitStateChange(stateBuffer);
                else
                    imageIndex -= _imageCount;
            }
        }
        else if (spriteIndex == 278)
        {
            if (_animationLooped)
            {
                spriteIndex = sNotifRabbit_Blink;
                imageSpeed = sprite_get_speed(spriteIndex);
                imageIndex = 0;
            }
        }
        
        break;
    
    case "notification - checking back out":
        if (spriteIndex == 595)
        {
            if (_animationLooped)
                rabbitStateChange("notification - jumping");
        }
        
        break;
    
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
                rabbitStateChange("notification cleared - asleep");
        }
    
    case "notification cleared - asleep":
        break;
    
    default:
        break;
}

draw_sprite_ext(spriteIndex, imageIndex, x, y + 0.5, 0.1 * xDirection, 0.1, 0, c_white, 1);
draw_sprite_ext(getEyesSprite(), imageIndex, x, y + 0.5, 0.1 * xDirection, 0.1, 0, eyeColor, 1);
