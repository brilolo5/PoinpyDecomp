function finalAreaGlow(arg0, arg1)
{
    var _parseGlow = wallGlow;
    var _col = make_color_rgb(13, 228, 219);
    
    with (oWall)
    {
        var _topCull = bbox_bottom < arg0;
        var _bottomCull = bbox_top > arg1;
        var _cull = _topCull || _bottomCull;
        
        if (!_cull)
        {
            if (object_index != oCogWall)
            {
                draw_set_color(make_color_rgb(13, 228, 219));
                var _wallSizeHalf = 8;
                var _outlineWidth = 1 * _parseGlow;
                var _outlineOffset = _wallSizeHalf + _outlineWidth;
                var _outlineOffsety = (image_yscale * 8) + _outlineWidth;
                var _x = x - (1 * (os_type == os_windows));
                var _y = y - (1 * (os_type == os_windows));
                draw_roundrect_ext(_x - _outlineOffset, _y - _outlineOffsety, _x + _outlineOffset, _y + _outlineOffsety, 3, 3, 0);
            }
        }
    }
}

function finalAreaGlowColor(arg0)
{
    arg0 = -(global.timeScaledTime / 0.3) + arg0;
    arg0 = (sin(arg0 / 35) + 1) / 2;
    var _color = merge_color(make_color_rgb(13, 228, 219), make_color_rgb(255, 255, 255), arg0);
    return _color;
}
