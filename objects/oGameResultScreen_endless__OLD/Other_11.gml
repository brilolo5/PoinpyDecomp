var vwidth = global.viewWidth;
var vheight = global.viewHeight;
var rectWidth = 140;
var rectHeight = 130;
var rectCenterx = global.windowCenterx;
var rectCentery = vheight / 2;
var rectLeft = rectCenterx - (rectWidth / 2);
var rectRight = rectCenterx + (rectWidth / 2);
var rectTop = rectCentery - (rectHeight / 2);
var rectBottom = rectCentery + (rectHeight / 2);
draw_set_color(make_color_rgb(69, 80, 97));
draw_set_alpha(1);
draw_roundrect(rectLeft, rectTop, rectRight, rectBottom + 4, 0);
draw_set_color(make_color_rgb(176, 183, 195));
draw_set_alpha(1);
draw_roundrect(rectLeft + 2, rectTop + 2, rectRight - 2, rectBottom - 2, 0);
draw_set_alpha(1);
var _gameOverText = loc("result game over");
drawSetAlign(1, 0);
drawTextOutlined(rectCenterx, rectTop + 2, _gameOverText, 16777215, make_color_rgb(46, 50, 59), 0, 1.8);
drawTextOutlined(rectCenterx, rectCentery - 16 - 16, "ENDLESS: " + string(getMaxJump()) + " JUMPS", make_color_rgb(255, 255, 255), make_color_rgb(46, 50, 59), 0, 1);
drawTextOutlined(rectCenterx, rectCentery, "SCORE: " + string(gameScore), make_color_rgb(255, 255, 255), make_color_rgb(46, 50, 59), 0, 1);

if (newHighScore)
    drawTextOutlined(rectCenterx, rectCentery + 16, "[cycle,32,42][wheel]NEW HIGH SCORE!", make_color_rgb(255, 255, 255), make_color_rgb(46, 50, 59), 0, 1);

drawTextOutlined(rectCenterx, rectCentery + 16 + 16, "HIGH SCORE: " + string(global.endlessHighScore[endlessMode]), make_color_rgb(255, 255, 255), make_color_rgb(46, 50, 59), 0, 1);
allowTapToReturnTimer -= 1;

if (mouse_check_button_pressed(mb_left) && !allowTapToReturnTimer)
{
    var _lobbySpawnPoint = "lobby normal";
    roomTransitionTo(rmPlayableMainMenu, _lobbySpawnPoint);
}
