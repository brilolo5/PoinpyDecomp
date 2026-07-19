var rectHeightMax = global.applicationSurfaceDrawHeight;
var rectLeft = global.windowLeft;
var rectRight = global.windowRight;
var fadeInProgress = fadeInTimer / fadeInTimerMax;
var rectTop = global.windowTop;
var rectBottom = rectTop + rectHeightMax;
fadeColorShift += 3;
fadeColor = make_color_rgb(36, 145, 249);

if (fadeInTimer < fadeInTimerMax)
{
    fadeInTimer += doDelta(1);
    fadeInProgress = fadeInTimer / fadeInTimerMax;
    rectTop += (rectHeightMax - (rectHeightMax * fadeInProgress));
    rectBottom = global.windowTop + rectHeightMax;
    draw_set_color(fadeColor);
    draw_rectangle(rectLeft, rectTop, rectRight, rectBottom, 0);
}
else if (remainTimer < remainTimerMax)
{
    remainTimer += doDelta(1);
    rectBottom = rectTop + rectHeightMax;
    draw_set_color(fadeColor);
    draw_rectangle(rectLeft, rectTop, rectRight, rectBottom, 0);
    
    if (remainTimer >= remainTimerMax)
    {
        if (!inPuzzleLevel())
            audio_stop_all();
        
        if (room == destination)
        {
            TextureManagerGoto(room);
            room_restart();
        }
        else
        {
            TextureManagerGoto(destination);
            room_goto(destination);
        }
    }
}
else if (fadeOutTimer < fadeOutTimerMax)
{
    if (fadeOutDelayFrame > 0)
        fadeOutDelayFrame -= 1;
    else
        fadeOutTimer += doDelta(1);
    
    var fadeOutProgress = fadeOutTimer / fadeOutTimerMax;
    rectBottom = (global.windowTop + rectHeightMax) - (rectHeightMax * fadeOutProgress);
    draw_set_color(fadeColor);
    draw_rectangle(rectLeft, rectTop, rectRight, rectBottom, 0);
}
else
{
    instance_destroy();
}
