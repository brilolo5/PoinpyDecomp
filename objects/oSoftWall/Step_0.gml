var _cullHeight = -16;
var _bottomCheck = bbox_bottom - _cullHeight - getViewy(global.cam);
var _topCheck = (getViewy(global.cam) + global.viewHeight) - (bbox_top + _cullHeight);
var _inScreen = sign(min(_bottomCheck, _topCheck));
onScreen = clamp(_inScreen, 0, 1);
