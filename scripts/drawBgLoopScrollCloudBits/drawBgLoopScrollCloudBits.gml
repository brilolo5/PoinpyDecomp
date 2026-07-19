function drawBgLoopScrollCloudBits(arg0)
{
    var viewy = getViewy(global.cam);
    var viewx = getViewx(global.cam);
    var _bgSpriteShrinkScale = global.viewWidth / 1600;
    var _bgSpriteHeight = 3340 * _bgSpriteShrinkScale;
    var _scrollAmount = -((viewy * arg0) % _bgSpriteHeight);
    var _bgTileNum = ceil(global.viewHeight / _bgSpriteHeight);
    var _offsets = [1366, 193, 255, 664, 790, 1275, 1232, 1715, 383, 1930, 1345, 2470, 710, 2900];
    
    for (var i = -2; i < _bgTileNum; i++)
    {
        var _j = 0;
        
        repeat (sprite_get_number(sBgLayer_CannonCloudsAfarBits))
        {
            var _x = _bgSpriteShrinkScale * _offsets[2 * _j];
            var _y = _bgSpriteShrinkScale * _offsets[(2 * _j) + 1];
            _x += viewx;
            _y += (viewy + _scrollAmount + (i * _bgSpriteHeight));
            draw_sprite_ext(sBgLayer_CannonCloudsAfarBits, _j, _x, _y, _bgSpriteShrinkScale, _bgSpriteShrinkScale, 0, c_white, 1);
            _j++;
        }
    }
}
