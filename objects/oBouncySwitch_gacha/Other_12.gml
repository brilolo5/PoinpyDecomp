var _shakex = 0;
var _shakey = 0;
var _alphaValue = 1;

if (noMoneyAlarmShake)
{
    with (oCosmos)
    {
        curvePos = 0;
        noMoneyAlarmShake = 1;
    }
    
    noMoneyAlarmShake = 0;
}

if (areThereItemsLeftToGetFromGacha())
{
    var _gachaCost = getGachaCost();
    drawSetAlign(1, 1);
    var _textColor = make_color_rgb(255, 255, 255);
    
    if (global.moneyJar < _gachaCost)
        _textColor = make_color_rgb(248, 45, 97);
    
    _gachaCost = locGetNumFont(true) + "$" + string(_gachaCost);
}
else
{
    var _gachaCost = "sold out";
    var _textColor = make_color_rgb(255, 255, 255);
}

var _textSize = 1;
_textSize *= 0.5;
var _textx = -128 + _shakex;
var _texty = -23 + _shakey;
