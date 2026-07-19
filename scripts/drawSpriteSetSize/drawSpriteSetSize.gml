function drawSpriteSetSize(arg0, arg1, arg2, arg3, arg4, arg5)
{
    if (!sprite_exists(arg0))
        return -1;
    
    var _sprite = arg0;
    var _imageIndex = arg1;
    var _drawx = arg2;
    var _drawy = arg3;
    var _rectWidth = arg4;
    var _rectHeight = arg5;
    var _spriteWidth = sprite_get_width(_sprite);
    var _spriteHeight = sprite_get_height(_sprite);
    var _xscale = _rectWidth / _spriteWidth;
    var _yscale = _rectHeight / _spriteHeight;
    draw_sprite_ext(_sprite, _imageIndex, _drawx, _drawy, _xscale, _yscale, 0, c_white, 1);
}

function drawSpriteSetSizeExt(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
{
    if (!sprite_exists(arg0))
        return -1;
    
    var _sprite = arg0;
    var _imageIndex = arg1;
    var _drawx = arg2;
    var _drawy = arg3;
    var _rectWidth = arg4;
    var _rectHeight = arg5;
    var _spriteWidth = sprite_get_width(_sprite);
    var _spriteHeight = sprite_get_height(_sprite);
    var _xscale = _rectWidth / _spriteWidth;
    var _yscale = _rectHeight / _spriteHeight;
    draw_sprite_ext(_sprite, _imageIndex, _drawx, _drawy, _xscale, _yscale, arg6, arg7, arg8);
}
