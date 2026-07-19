function uiTemplateSpriteScaled()
{
    var _sprite = argument[0];
    var _index = argument[1];
    var _scale = (argument_count > 2 && argument[2] != undefined) ? argument[2] : 1;
    spriteIndex = _sprite;
    imageIndex = _index;
    spriteXScale = 1;
    spriteYScale = 1;
    setWidth(_scale * sprite_get_width(_sprite));
    setHeight(_scale * sprite_get_height(_sprite));
    eventAddFunction(UnknownEnum.Value_2, function()
    {
        var _spriteWidth = sprite_get_width(spriteIndex);
        var _spriteHeight = sprite_get_height(spriteIndex);
        var _xscale = getDrawWidth() / _spriteWidth;
        var _yscale = getDrawHeight() / _spriteHeight;
        var _x = getDrawLeft() + (_xscale * sprite_get_xoffset(spriteIndex));
        var _y = getDrawTop() + (_yscale * sprite_get_yoffset(spriteIndex));
        draw_sprite_ext(spriteIndex, imageIndex, _x, _y, spriteXScale * _xscale, spriteYScale * _yscale, 0, visBlend, visAlpha);
    });
}
