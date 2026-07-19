myAlarm0.tick();
myAlarm1.tick();
myAlarmPlayLeadIn.tick();
var _viewy = getViewy(global.cam);
var _viewx = getViewx(global.cam);
var _depth = -(y - _viewy) / 16;
var _bgx = x;
var _bgy = y;

if (logoVisible)
{
    if (logoBoingTime < 1)
        logoBoingTime = approach(logoBoingTime, 1, doDelta(0.022222222222222223));
    
    sparkle = approach(sparkle, 0, doDelta(1));
    
    if (sparkle && (round(global.timeScaledTime) % 16) == 0)
    {
        repeat (choose(1, 1, 2))
        {
            var _sparkleRandx = random_range(bbox_left, bbox_right);
            var _sparkleRandy = random_range(bbox_top, bbox_bottom);
            generateEffect(_sparkleRandx, _sparkleRandy, "logo sparkle", 0);
        }
    }
    
    if (allMedalUnlocked)
    {
        if ((round(global.timeScaledTime) % 24) == 0)
        {
            repeat (choose(0, 1, 1, 2))
            {
                var _sparkleRandx = random_range(bbox_left, bbox_right);
                var _sparkleRandy = random_range(bbox_top, bbox_bottom);
                generateEffect(_sparkleRandx, _sparkleRandy, "logo sparkle", 0);
            }
        }
    }
    
    var _scaleOffset = 1 + (0.3 - (0.3 * animcurveGetValueAtPos(curveElasticInv, "curve1", logoBoingTime)));
    var _scale = defaultScale * _scaleOffset * logoScale;
    drawLogoFromParts(sprite_index, _bgx, _bgy, _scale);
}
