if (live_call())
    return global.live_result;

var centerx = global.windowCenterx;
var _drawOrderIndex = 0;
drawReadyBonusSign();
var _levelTextTop = ((global.windowTop + global.notchOffset + 16) - 2 - 2) + 12;
var _levelTextRight = global.windowRight - 4;
var _levelNum = ((global.puzzleCurrentTheme - 1) * global.puzzleLevelCount) + (global.puzzleCurrentIndex + 1);
var _levelString = locGetNumFont(true) + "" + string(_levelNum);
drawSetAlign(2, 0);
var _jumpCountTop = _levelTextTop + 8 + 2 + 2 + 2 + 2;
var _jumpCountx = global.windowLeft + 16 + 2;
var _jumpCountString = locGetNumFont(true) + string(global.jumpTimesMax);
drawSpriteSetSize(sJumpCounts00, 0, _jumpCountx - 8 - 1 - 1, _jumpCountTop + 4 + 1 + 1.5, 12, 12);
drawSetAlign(0, 0);
drawTextOutlined((_jumpCountx - 8 - 1 - 1 - 2) + 6, _jumpCountTop, _jumpCountString, make_color_rgb(255, 255, 255), make_color_rgb(46, 50, 59), 0, 0.9);
