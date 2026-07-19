draw_sprite_ext(sGachaBody, 0, x, y, 0.1, 0.1, 0, c_white, 1);
draw_sprite_ext(sGachaBody, 1, x, y, 0.1, 0.1, 0, c_white, 1);
draw_sprite_ext(sGachaBody, 2, x, y, 0.1, 0.1, 0, c_white, 1);
draw_sprite_ext(sGachaBody, 3, x, y, 0.1, 0.1, 0, c_white, 1);
var _shakex = 0;
var _shakey = 0;
var _alphaValue = 1;

if (noMoneyAlarmShake)
{
    curveSpeed = 0.021666666666666667;
    curvePos += curveSpeed;
    curvePos %= 2;
    var _alphaAnimCurve = animcurve_get(acNoJumpsLeftAlpha);
    var _alphaAnimChannel = animcurve_get_channel(_alphaAnimCurve, "alpha");
    _alphaValue = animcurve_channel_evaluate(_alphaAnimChannel, curvePos);
    _alphaValue = 1;
    var _shakeRate = 1;
    var _xposAnimCurve = animcurve_get(acNoJumpsPos);
    var _xposAnimChannel = animcurve_get_channel(_xposAnimCurve, "x");
    var _xposValue = animcurve_channel_evaluate(_xposAnimChannel, curvePos) * _shakeRate;
    var _yposAnimCurve = animcurve_get(acNoJumpsPos);
    var _yposAnimChannel = animcurve_get_channel(_yposAnimCurve, "y");
    var _yposValue = animcurve_channel_evaluate(_yposAnimChannel, curvePos) * _shakeRate;
    _shakex = _xposValue / 2;
    _shakey = _yposValue;
    
    if (curvePos >= 1)
    {
        curvePos = 0;
        noMoneyAlarmShake = 0;
    }
}

var _gachaCost = getGachaCost();
var _gachaNumSprite = sGachaNumberYellow;
var _blink = (global.timeScaledTime / 5) % 10;

if (global.moneyJar < _gachaCost)
{
    _blink = (global.timeScaledTime / 10) % 4;
    _gachaNumSprite = sGachaNumberRed;
}

if (areThereItemsLeftToGetFromGacha())
{
    if (_blink)
        draw_sprite_ext(_gachaNumSprite, _gachaCost / 10, x + _shakex, y + _shakey, 0.1, 0.1, 0, c_white, 1);
}

with (oBouncySwitch_gacha)
    event_user(3);

draw_sprite_ext(sGachaBody, 4, x, y, 0.1, 0.1, 0, c_white, 1);
