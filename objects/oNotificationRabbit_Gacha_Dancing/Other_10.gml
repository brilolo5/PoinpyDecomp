if (live_call())
    return global.live_result;

var gts = global.timeScale;
var _drawx = x;
var _drawy = y;
imageSpeed = sprite_get_speed(spriteIndex);
imageIndex += (imageSpeed * gts);
var _imageCount = sprite_get_number(spriteIndex);
var _animationLooped = imageIndex >= _imageCount;

switch (state)
{
    case "jump awake":
        _drawx -= (startXdir * 4);
        
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
            backToSleepTimer += doDelta(0.012077294685990338);
            
            if (backToSleepTimer >= 1)
            {
                holdPositionTimer = 0;
                rabbitStateChange("dancing");
                imageIndex = 3;
                xDirection = 1;
            }
        }
        
        _drawy += 1;
        break;
    
    case "dancing - hold":
        imageIndex = 0;
        
        if (holdPositionTimer >= 1)
            rabbitStateChange("dancing", xDirection);
        
        break;
    
    case "dancing":
        if (imageIndex > _imageCount)
        {
            holdPositionTimer = 0;
            rabbitStateChange("dancing - hold", -xDirection);
        }
        
        break;
    
    default:
        break;
}

if (instance_exists(oTE_thoughtBubbleOpen))
    holdPositionTimer = 0.1;

holdPositionTimer += doDelta(0.024154589371980676);
draw_sprite_ext(spriteIndex, imageIndex, _drawx, _drawy, 0.1 * xDirection, 0.1, 0, c_white, 1);
draw_sprite_ext(getEyesSprite(), imageIndex, _drawx, _drawy, 0.1 * xDirection, 0.1, 0, eyeColor, 1);
