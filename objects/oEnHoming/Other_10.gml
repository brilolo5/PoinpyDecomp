dcx = cx;
dcy = cy;
var _tailx = tailArray[tailArrayDelay][0];
var _taily = tailArray[tailArrayDelay][1];
draw_sprite_ext(sEnemyHomer_Body, 2, _tailx, _taily, xscale, yscale, imageAngle * xDirection, c_white, 1);
_tailx = tailArray[tailArrayDelay / 2][0];
_taily = tailArray[tailArrayDelay / 2][1];
draw_sprite_ext(sEnemyHomer_Body, 1, _tailx, _taily, xscale, yscale, imageAngle * xDirection, c_white, 1);

if (enemyState != "idle")
    flutterSpeed = approach(flutterSpeed, 0.25, doDelta(0.01));
else
    flutterSpeed = 0.15;

flutterIndex += (flutterSpeed * global.timeScale);
draw_sprite_ext(sEnemyHomer_Head, flutterIndex, x + dcx, y + dcy, xscale, yscale, imageAngle * xDirection, c_white, 1);
var _len = 1.5;
var _eyex = lengthdir_x(_len, eyeAngle);
var _eyey = lengthdir_y(_len, eyeAngle);
var _eyePointx = x + (xDirection * 1.5);
eyeIndex = 3;
draw_sprite_ext(sEnemyHomer_Eye, 0, _eyePointx + dcx + _eyex, y + dcy + _eyey, xscale, yscale, imageAngle * xDirection, c_white, 1);

if (enemyState == "idle")
    eyelidIndex = 2;

if (blinking)
{
    var _eyelidNumber = sprite_get_number(sEnemyHomer_Eyelid) - 1;
    eyelidIndex = approach(eyelidIndex, _eyelidNumber, 0.75 * global.timeScale);
    
    if (eyelidIndex == _eyelidNumber)
    {
        blinking -= 1;
        eyelidIndex = 0;
        blinkAlarm.setTimer(blinkTime());
    }
}

draw_sprite_ext(sEnemyHomer_Eyelid, eyelidIndex, x + dcx, y + dcy, xscale, yscale, imageAngle * xDirection, c_white, 1);
