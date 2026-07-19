function drawThreeSlice(arg0, arg1, arg2, arg3)
{
    var _spriteWidth = sprite_get_width(arg0);
    var _width = max(2 * _spriteWidth, (1 + arg2) - arg1);
    draw_sprite(arg0, 0, arg1, arg3);
    draw_sprite_stretched(arg0, 1, arg1 + _spriteWidth, arg3, _width - (2 * _spriteWidth), sprite_get_height(arg0));
    draw_sprite(arg0, 2, arg2 - _spriteWidth, arg3);
}
