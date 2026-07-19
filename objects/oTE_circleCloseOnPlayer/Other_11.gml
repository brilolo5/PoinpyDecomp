if (!soundPlayed)
{
    soundPlayed = 1;
    
    if (!seqReverse)
        playSoundCircleTransitionClose();
    else
        playSoundCircleTransitionOpen();
}

seqTimer += doDelta(1 / seqTimerLength);
hiResRatio = 2;
surfWidth = global.viewWidth * hiResRatio;
surfHeight = global.viewHeight * hiResRatio;

if (instance_exists(oPlayer))
{
    focusPosx = oPlayer.x - getViewx(global.cam);
    focusPosy = oPlayer.y - getViewy(global.cam);
}

focusPosy = clamp(focusPosy, 0, global.viewHeight);
surfFocusPosx = (focusPosx / global.viewWidth) * surfWidth;
surfFocusPosy = (focusPosy / global.viewHeight) * surfHeight;

if (surface_exists(surf) && surface_get_width(surf) != surfWidth && surface_get_height(surf) != surfHeight)
    surface_free(surf);

if (!surface_exists(surf))
    surf = surface_create_track(surfWidth, surfHeight);

surface_set_target(surf);
draw_clear(make_color_rgb(46, 50, 59));
draw_set_circle_precision(64);
gpu_set_blendmode(bm_subtract);
draw_set_color(c_black);
var _seqReverse = seqReverse;
var _seqScaler = seqTimer;

if (_seqReverse)
    _seqScaler = 1 - seqTimer;

var _animScaler = animcurveGetValueAtPos(curveLinear, "curve1", 1 - _seqScaler);
var _holeScale = _animScaler * 3;
draw_circle(surfFocusPosx, surfFocusPosy, _animScaler * (surfHeight * 1.1), 0);
gpu_set_blendmode(bm_normal);
surface_reset_target();
draw_surface_stretched(surf, global.windowLeft, global.windowTop, global.applicationSurfaceDrawWidth, global.applicationSurfaceDrawHeight);

if (seqTimer >= 5)
    instance_destroy();
