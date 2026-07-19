draw_set_circle_precision(256);
endTimer += 0.0016666666666666668;
var _wCenter = global.windowCenterx;
var _wLeft = global.windowLeft;
var _wRight = global.windowRight;
var _wMiddle = global.windowMiddley;
var _wTop = global.windowTop;
var _wBottom = global.windowBottom;
var _wWidth = _wRight - _wLeft;
var _wHeight = global.viewHeight;
var cr = global.surfaceCompressionRate;
var surfaceWidth = _wWidth;
var surfaceHeight = _wHeight;
surfaceWidth *= cr;
surfaceHeight *= cr;
var _surfaceCenter = surfaceWidth / 2;
var _surfaceMiddle = surfaceHeight / 2;
var _surfacePlayerx = (oPlayer.x - getViewx(global.cam)) * cr;
var _surfacePlayery = (oPlayer.y - getViewy(global.cam)) * cr;
var _closeRatio = clamp(1 - (endTimer / 0.2), 0, 1);
var _openRatio = clamp(-5 + (endTimer / 0.15), 0, 1);
var _circleRatio;

if (endTimer <= 0.5)
    _circleRatio = _closeRatio;
else
    _circleRatio = _openRatio;

var _circleSize = 256 * cr * _circleRatio;

if (!surface_exists(baseSurface))
    baseSurface = surface_create_track(surfaceWidth, surfaceHeight);

if (!surface_exists(cropSurface))
    cropSurface = surface_create_track(surfaceWidth, surfaceHeight);

surface_set_target(cropSurface);
draw_clear_alpha(c_black, 0);
draw_set_color(c_black);
draw_circle(_surfacePlayerx, _surfacePlayery, _circleSize, 0);
surface_reset_target();
surface_set_target(baseSurface);
draw_clear_alpha(c_white, 0);
draw_clear(make_color_rgb(46, 50, 59));
gpu_set_blendmode(bm_subtract);
draw_surface_stretched(cropSurface, 0, 0, surfaceWidth, surfaceHeight);
gpu_set_blendmode(bm_normal);
surface_reset_target();
draw_surface_stretched(baseSurface, _wLeft, _wTop, surfaceWidth / cr, surfaceHeight / cr);

if (endTimer >= 0.3 && endTimer <= 0.7)
{
    drawSetAlign(1, 1);
    drawTextOutlined(_wCenter, _wMiddle, "(OPENING SEQUENCE)", make_color_rgb(255, 255, 255), make_color_rgb(46, 50, 59), 0, 1);
}
