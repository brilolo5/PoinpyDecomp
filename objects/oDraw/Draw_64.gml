application_surface_draw_enable(false);
drawSetAlign(0, 1);
var asHeight = global.viewHeight;
var asWidthRatio = clamp(global.viewWidth / global.viewHeight / (window_get_width() / window_get_height()), 0, 1);
var asHeightRatio = clamp(global.viewHeight / global.viewWidth / (window_get_height() / window_get_width()), 0, 1);
var asWidth = global.viewWidth;
var asCenterPoint = asWidth / asWidthRatio / 2;
var asMiddlePoint = asHeight / asHeightRatio / 2;
var asLeft = asCenterPoint - (asWidth / 2);
var asTop = asMiddlePoint - (asHeight / 2);
global.gameSurfaceLeft = asLeft;
global.gameSurfaceTop = asTop;
global.gameSurfaceRight = asLeft + asWidth;
global.gameSurfaceBottom = asTop + asHeight;
display_set_gui_size(global.viewWidth / asWidthRatio, global.viewHeight / asHeightRatio);
global.windowCenterx = asWidth / asWidthRatio / 2;
global.windowLeft = (asWidth / asWidthRatio / 2) - (asWidth / 2);
global.windowRight = (asWidth / asWidthRatio / 2) + (asWidth / 2);
global.windowMiddley = asHeight / asHeightRatio / 2;
global.windowTop = (asHeight / asHeightRatio / 2) - (asHeight / 2);
global.windowBottom = (asHeight / asHeightRatio / 2) + (asHeight / 2);
var _gameAspectRatio = global.viewWidth / global.viewHeight;
var _windowAspectRatio = window_get_width() / window_get_height();
var _needsHorizontalBorder = 0;

if (abs(_gameAspectRatio - _windowAspectRatio) > 0.02)
{
    if (_gameAspectRatio < _windowAspectRatio)
        _needsHorizontalBorder = 1;
    else if (_gameAspectRatio > _windowAspectRatio)
        _needsHorizontalBorder = -1;
    
    global.applicationSurfaceDrawWidth = global.viewWidth;
    global.applicationSurfaceDrawHeight = global.viewHeight;
}
else
{
    asLeft = 0;
    asTop = 0;
    global.applicationSurfaceDrawWidth = display_get_gui_width();
    global.applicationSurfaceDrawHeight = display_get_gui_height();
    global.windowLeft = 0;
    global.windowTop = 0;
}

global.windowRight = global.windowLeft + global.applicationSurfaceDrawWidth;
global.windowBottom = global.windowTop + global.applicationSurfaceDrawHeight;

if (!is_nan(global.windowLeft))
    global.lastValidWindowLeft = global.windowLeft;

if (!is_nan(global.windowTop))
    global.lastValidWindowTop = global.windowTop;

if (!is_nan(global.windowRight))
    global.lastValidWindowRight = global.windowRight;

if (!is_nan(global.windowBottom))
    global.lastValidWindowBottom = global.windowBottom;

global.surfaceCompressionRateUpdate = 0;
global.surfaceCompressionRate = 5;

if (rec_surfaceCompressionRate != global.surfaceCompressionRate)
{
    global.surfaceCompressionRateUpdate = 1;
    rec_surfaceCompressionRate = global.surfaceCompressionRate;
}

draw_enable_alphablend(1);
shader_reset_track();
draw_set_alpha(1);
var borderWidth = 0;
var borderRectWidth = asWidth + (borderWidth * 2);
var borderRectHeight = asHeight + (borderWidth * 2);
var borderLeft = asCenterPoint - (borderRectWidth / 2);
var borderRight = (asCenterPoint + (borderRectWidth / 2)) - 1;
var borderTop = asMiddlePoint - (borderRectHeight / 2);
var borderBottom = asMiddlePoint + (borderRectHeight / 2);
draw_clear(c_lime);
draw_set_alpha(1);
texture_set_interpolation(true);
draw_enable_alphablend(0);
draw_surface_stretched(application_surface, global.windowLeft, global.windowTop, global.applicationSurfaceDrawWidth, global.applicationSurfaceDrawHeight);
draw_enable_alphablend(1);

with (parentEnding)
    event_user(1);

drawSetInterpolation(false);

with (parentEffect)
    event_user(1);

drawSetInterpolation(true);

with (oBeastInLobby)
{
}

with (oControl)
{
    event_user(1);
    event_user(5);
}

with (oOrderControl)
    event_user(1);

with (parentMenu)
    event_user(1);

with (oControl)
{
    event_user(4);
    event_user(6);
    event_user(7);
}

with (oCamera)
    event_user(1);

drawSetInterpolation(false);

with (parentEffect)
    event_user(1);

drawSetInterpolation(true);

with (parentGUIEffect)
    event_user(1);

drawSetInterpolation(false);

drawBorderTiled = function(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
{
    var _tileSprite = arg0;
    var _tilexScale = arg5;
    var _tileyScale = arg6;
    var _tilePartWidth = sprite_get_width(_tileSprite) * _tilexScale;
    var _tilePartHeight = sprite_get_height(_tileSprite) * _tileyScale;
    var _tileHorizontalRepeat = (arg1 / _tilePartWidth) + 1;
    var _tileVerticalRepeat = (arg4 / _tilePartHeight) + 1;
    
    for (var i = 1; i < _tileHorizontalRepeat; i += 1)
    {
        for (var t = 0; t < _tileVerticalRepeat; t += 1)
        {
            draw_sprite_ext(_tileSprite, 0, arg1 + (-_tilePartWidth * i), 0 + (_tilePartHeight * t), _tilexScale, _tileyScale, 0, c_white, 1);
            draw_sprite_ext(_tileSprite, 0, arg2 + 1 + (_tilePartWidth * (i - 1)), 0 + (_tilePartHeight * t), _tilexScale, _tileyScale, 0, c_white, 1);
        }
    }
};

if (_needsHorizontalBorder == 1)
{
    var _bgBaseColor = make_color_rgb(136, 147, 161);
    drawRectangleFast(0, 0, borderLeft - 1, borderBottom, _bgBaseColor, 1);
    drawRectangleFast(borderRight + 1, 0, borderRight + borderLeft, borderBottom, _bgBaseColor, 1);
    drawBorderTiled(sGuiBorder_border, borderLeft, borderRight, borderTop, borderBottom, 10, 0.085);
    drawBorderTiled(sGuiBorderFruits_shadow, borderLeft, borderRight, borderTop, borderBottom, 0.37000000000000005, 0.37000000000000005);
    var _borderSprite = sGuiBorder_gradientShadow;
    var _borderSpriteHeight = sprite_get_height(_borderSprite);
    var _borderSpriteScale = asHeight / _borderSpriteHeight;
    var _shadowXscale = 0.1;
    var _shadowAlpha = 0.3;
    var _shadowColor = 16777215;
    draw_sprite_ext(_borderSprite, 0, borderLeft, 0, _shadowXscale, _borderSpriteScale, 0, _shadowColor, _shadowAlpha);
    draw_sprite_ext(_borderSprite, 0, borderRight + 1, 0, -_shadowXscale, _borderSpriteScale, 0, _shadowColor, _shadowAlpha);
}

if (_needsHorizontalBorder == -1)
{
    var _bgBaseColor = make_color_rgb(136, 147, 161);
    drawRectangleFast(borderLeft, 0, borderRight, borderTop - 1, _bgBaseColor, 1);
    drawRectangleFast(borderLeft, borderBottom, borderRight, borderBottom + borderTop, _bgBaseColor, 1);
    var _tileSprite = sGuiBorderFruits_shadow;
    var _tilexScale = 2/3;
    var _tileyScale = 2/3;
    var _tilePartWidth = sprite_get_width(_tileSprite) * _tilexScale;
    var _tilePartHeight = sprite_get_height(_tileSprite) * _tileyScale;
    var _tileHorizontalRepeat = (borderRight / _tilePartWidth) + 1;
    var _tileVerticalRepeat = (borderTop / _tilePartHeight) + 1;
    
    for (var i = 0; i < _tileHorizontalRepeat; i += 1)
    {
        for (var t = 0; t < _tileVerticalRepeat; t += 1)
        {
            draw_sprite_ext(_tileSprite, 0, borderLeft + (_tilePartWidth * i), borderTop - (_tilePartHeight * (t + 1)), _tilexScale, _tilexScale, 0, c_white, 1);
            draw_sprite_ext(_tileSprite, 0, borderLeft + (_tilePartWidth * i), borderBottom + (_tilePartHeight * t), _tilexScale, _tilexScale, 0, c_white, 1);
        }
    }
    
    var _borderSprite = sGuiBorder_gradientShadow;
    var _borderSpriteHeight = sprite_get_height(_borderSprite);
    var _borderSpriteScale = asWidth / _borderSpriteHeight;
    var _shadowXscale = 0.1;
    draw_sprite_ext(_borderSprite, 0, borderRight + 1, borderTop, _shadowXscale, _borderSpriteScale, -90, c_white, 0.25);
    draw_sprite_ext(_borderSprite, 0, borderLeft, borderBottom, _shadowXscale, _borderSpriteScale, 90, c_white, 0.25);
}

drawSetInterpolation(true);

with (oLevelBuilder)
    event_user(1);

with (oTestThoughtCloud)
    event_user(1);

with (oPlayer)
    event_user(1);

with (parentTutorial)
    event_user(1);

with (parentTutorialSequence)
    event_user(1);

with (parentScreenEffect)
    event_user(1);

with (oControl)
    event_user(2);

with (oNetflixControl)
    event_user(1);
