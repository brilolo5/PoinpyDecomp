function drawBgLoopScroll(arg0, arg1)
{
    if (!sprite_exists(arg0))
        return -1;
    
    var _bgSprite = arg0;
    var _scrollDepth = arg1;
    var viewy = getViewy(global.cam);
    var viewx = getViewx(global.cam);
    var _bgSpriteShrinkScale = global.viewWidth / sprite_get_width(_bgSprite);
    var _bgSpriteHeight = sprite_get_height(_bgSprite) * _bgSpriteShrinkScale;
    var _scrollAmount = -((viewy * _scrollDepth) % _bgSpriteHeight);
    var _bgTileNum = ceil(global.viewHeight / _bgSpriteHeight);
    
    for (var i = -2; i < _bgTileNum; i += 1)
        draw_sprite_ext(_bgSprite, 0, viewx, viewy + _scrollAmount + (_bgSpriteHeight * i), _bgSpriteShrinkScale, _bgSpriteShrinkScale, 0, c_white, 1);
}
