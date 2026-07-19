function drawTextOutlined()
{
    var _textx = argument[0];
    var _texty = argument[1];
    var _text = argument[2];
    var _colorMain = argument[3];
    var _colorShade = argument[4];
    var _textAngle = argument[5];
    var _textSize = 1;
    var _wrapWidth = 9999;
    
    if (argument_count > 6)
        _textSize = argument[6];
    
    if (argument_count > 7)
        _wrapWidth = argument[7];
    
    _textSize *= 0.5;
    return scribble(_text).starting_format(global.defaultFont, _colorMain).blend(16777215, 1).msdf_border(_colorShade, 3).transform(_textSize, _textSize, _textAngle).wrap(_wrapWidth / _textSize, -1, locIsAsian()).align(draw_get_halign(), draw_get_valign()).draw(_textx, _texty);
}
