var _gachaCost = getGachaCost();
drawSetAlign(1, 1);
var _textColor = make_color_rgb(255, 255, 255);

if (global.moneyJar < _gachaCost)
{
    _textColor = make_color_rgb(248, 45, 97);
}
else
{
    var _notifx = 14;
    var _notify = 40;
    var _notifText = blink("!", "<", 1);
    draw_set_color(make_color_rgb(248, 45, 97));
    draw_circle(_notifx, _notify, 12, 0);
    drawTextOutlined(_notifx, _notify, _notifText, make_color_rgb(255, 255, 255), make_color_rgb(248, 45, 97), 0, 1.5);
}

_gachaCost = "$" + string(_gachaCost);
drawTextOutlined(x, y - 32, _gachaCost, _textColor, make_color_rgb(46, 50, 59), 0, 1);
draw_self();
