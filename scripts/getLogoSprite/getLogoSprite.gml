function getLogoSprite()
{
    global.logoSprite = sLogo_Default;
    
    switch (locGetLanguage())
    {
        case "TChinese":
            global.logoSprite = sLogo_ChineseT;
            break;
        
        case "Korean":
            global.logoSprite = sLogo_Korean;
            break;
        
        case "Arabic":
            global.logoSprite = sLogo_Arabic;
            break;
        
        case "Portuguese":
            global.logoSprite = sLogo_Portuguese;
            break;
        
        default:
            global.logoSprite = sLogo_Default;
            break;
    }
    
    return global.logoSprite;
}

function getLogoScale()
{
    if (locGetLanguage() == "English")
        return 1;
    
    var _defaultWidth = sprite_get_width(sLogo_Default);
    var _defaultHeight = sprite_get_height(sLogo_Default);
    var _spriteWidth = sprite_get_width(global.logoSprite);
    var _spriteHeight = sprite_get_height(global.logoSprite);
    var _widthDiff = _defaultWidth / _spriteWidth;
    var _heightDiff = _defaultHeight / _spriteHeight;
    var _scaleDiff = min(_widthDiff, _heightDiff) * 0.9;
    return _scaleDiff;
}

function drawLogoFromParts(arg0, arg1, arg2, arg3)
{
    var _spriteNum = sprite_get_number(arg0);
    var i = 0;
    
    repeat (_spriteNum)
    {
        draw_sprite_ext(arg0, i, arg1, arg2, arg3, arg3, 0, c_white, 1);
        i += 1;
    }
}
