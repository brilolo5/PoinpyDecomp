playSoundCoinPickup();
endTimer = 0;
goalx = 12;
goalx = 14;
goaly = global.windowMiddley + (global.viewHeight / 3);
xsp = (goalx - x) / 69;
ysp = -4;
grav = 0.15;
var _relativeGuistartx = global.windowCenterx + (xstart - (room_width / 2));
var _viewCenter = getViewy(global.cam) + (global.viewHeight / 2);
var _relativeGuistarty = global.windowMiddley + (ystart - 16 - _viewCenter);
guix = _relativeGuistartx;
guiy = _relativeGuistarty;
initialBoostFrames = 3;
initialFlashTimer = 0;
spin = 0;
spinSpeed = 10;

with (oControl)
    walletUIappearTime = 120;
