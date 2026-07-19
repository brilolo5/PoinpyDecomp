var _scale = 0.06;
xscale = _scale;
yscale = _scale;
curveSpeed = 0.02;
curvePos += curveSpeed;
curvePos %= 2;
var _alphaAnimCurve = animcurve_get(acNoJumpsLeftAlpha);
var _alphaAnimChannel = animcurve_get_channel(_alphaAnimCurve, "alpha");
var _alphaValue = animcurve_channel_evaluate(_alphaAnimChannel, curvePos);
_alphaValue = _alphaValue / 255;
var _shakeRate = 0.2;
var _xposAnimCurve = animcurve_get(acNoJumpsPos);
var _xposAnimChannel = animcurve_get_channel(_xposAnimCurve, "x");
var _xposValue = animcurve_channel_evaluate(_xposAnimChannel, curvePos) * _shakeRate;
var _yposAnimCurve = animcurve_get(acNoJumpsPos);
var _yposAnimChannel = animcurve_get_channel(_yposAnimCurve, "y");
var _yposValue = animcurve_channel_evaluate(_yposAnimChannel, curvePos) * _shakeRate;
var _xpos = oPlayer.x + oPlayer.cx + _xposValue;
var _ypos = ((oPlayer.y + oPlayer.cy) - 24) + _yposValue;
draw_sprite_ext(sJumpCounts_noneLeft, 1, _xpos, _ypos, xscale, yscale, imageAngle, c_white, _alphaValue);

if (curvePos >= 1 || global.jumpTimes >= 1)
    instance_destroy();
