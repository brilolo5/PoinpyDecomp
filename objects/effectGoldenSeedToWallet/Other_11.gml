var _relativeGuistartx = global.windowCenterx + (xstart - (room_width / 2));
var _viewCenter = getViewy(global.cam) + (global.viewHeight / 2);
var _relativeGuistarty = global.windowMiddley + (ystart - 16 - _viewCenter);
var _relativeGuix = global.windowCenterx + (x - (room_width / 2));
_viewCenter = getViewy(global.cam) + (global.viewHeight / 2);
var _relativeGuiy = global.windowMiddley + (y - _viewCenter);

if (guiy > goaly && ysp > 0)
{
    global.moneyJar += 1;
    
    with (oControl)
    {
        walletUIappearTime = 240;
        walletWobble = 1;
        walletChangeTextAmount += 1;
        walletChangeTextDrawTimer = 120;
        walletChangeTextOffsety = 4;
        moneyAmountCountUpDelay = 0;
    }
    
    shownMoneyAmountUpdate();
    playSoundCoinStash();
    instance_destroy();
}
else if (initialFlashTimer < 3)
{
    var _circleSize = 7;
    draw_set_color(make_color_rgb(255, 255, 255));
    draw_circle(_relativeGuistartx, _relativeGuistarty, _circleSize + 1, 0);
    initialFlashTimer += doDelta(1);
    spinSpeed = -30;
}
else
{
    spinSpeed = approach(spinSpeed, -10, doDelta(0.75));
    spin += doDelta(spinSpeed);
    draw_sprite_ext(sGoldenSeedUI, 1, guix, guiy, 0.1, 0.1, spin, c_white, 1);
}
