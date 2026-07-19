function TexanFetchSprite()
{
    var _i = 0;
    
    repeat (argument_count)
    {
        var _sprite = argument[_i];
        var _texture_group = global.__texanSpriteToTextureGroup[? _sprite];
        
        if (_texture_group != undefined)
            TexanFetch(_texture_group);
        
        _i++;
    }
}
