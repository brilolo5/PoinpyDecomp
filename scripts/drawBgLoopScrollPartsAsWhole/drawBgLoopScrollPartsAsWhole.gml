function drawBgLoopScrollPartsAsWhole(arg0, arg1)
{
    var _manualOffsety = 0;
    
    if (argument_count > 2)
        _manualOffsety = argument[2];
    
    var _bgSprite = arg0;
    var _scrollDepth = arg1;
    var _partsNum = sprite_get_number(arg0);
    var viewy = getViewy(global.cam);
    var viewx = getViewx(global.cam);
    var _bgSpriteShrinkScale = global.viewWidth / sprite_get_width(_bgSprite);
    var _bgSpriteHeight = sprite_get_height(_bgSprite) * _bgSpriteShrinkScale * _partsNum;
    var _bgPartHeight = sprite_get_height(_bgSprite) * _bgSpriteShrinkScale;
    var _scrollAmount = -(((viewy * _scrollDepth) + _manualOffsety) % _bgSpriteHeight);
    var _bgTileNum = ceil(global.viewHeight / _bgSpriteHeight);
    
    for (var i = -2; i < _bgTileNum; i += 1)
    {
        for (var _t = 0; _t < _partsNum; _t += 1)
            draw_sprite_ext(_bgSprite, _t, viewx, viewy + _scrollAmount + (_bgSpriteHeight * i) + (_bgPartHeight * _t), _bgSpriteShrinkScale, _bgSpriteShrinkScale, 0, c_white, 1);
    }
}

function drawBgPartsAsWhole(arg0, arg1, arg2, arg3, arg4)
{
    var _partsNum = sprite_get_number(arg0);
    var _spriteHeight = sprite_get_height(arg0) * arg4;
    
    for (var _t = 0; _t < _partsNum; _t += 1)
        draw_sprite_ext(arg0, _t, arg1, arg2 + (_spriteHeight * _t), arg3, arg4, 0, c_white, 1);
}

function drawDreamObjectBg()
{
    var _bgSprite = sTestDreamBgObject;
    var _scrollDepth = 0.04;
    var viewy = getViewy(global.cam);
    var viewx = getViewx(global.cam);
    var _sunx = viewx + (global.viewWidth / 2);
    var _suny = (viewy + (global.viewHeight / 2)) - 36;
    var _dreamWindowScale = 0.2;
    var _dreamWindowAlpha = 0.5 + (sin(global.time / 100) * 0.5);
    var _dreamObjScale = 0.25;
    var _dreamObjIndex = global.time / 1000;
    var _dreamObjAlpha = 0.6 + (sin(global.time / 1) * 0.025);
    var _objScrollArea = 400;
    var _objScrollAreaTop = (viewy + (global.viewHeight / 2)) - (_objScrollArea / 2);
    var _objCount = 6;
    
    for (var i = 0; i < _objCount; i += 1)
    {
        _dreamObjIndex += i;
        var _dreamObjPosyOffset = ((_objScrollArea / _objCount) * i) / _scrollDepth;
        var _dreamObjPosy = viewy + _dreamObjPosyOffset;
        var _objScrollAreaBottom = _objScrollAreaTop + _objScrollArea;
        var _scrollAmount = -((_dreamObjPosy * _scrollDepth) % _objScrollArea);
        var _dreamObjx = viewx + (global.viewWidth / 2) + (42 * (((i % 2) == 0) ? 1 : -1));
        var _dreamObjy = _objScrollAreaTop + _scrollAmount;
        draw_sprite_ext(sTestDreamBgObject, _dreamObjIndex + 6, _dreamObjx, _dreamObjy, _dreamObjScale, _dreamObjScale, 0, c_white, _dreamObjAlpha);
    }
}
