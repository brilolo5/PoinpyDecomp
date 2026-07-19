function drawTextShaded()
{
    var _textx = argument[0];
    var _texty = argument[1];
    var _text = argument[2];
    var _colorMain = argument[3];
    var _colorShade = argument[4];
    var _textAngle = argument[5];
    var _textSize = 1;
    
    if (argument_count > 6)
        _textSize = argument[6];
    
    _textSize *= 0.5;
    return scribble(_text).starting_format("fredoka", _colorMain).msdf_shadow(_colorShade, _colorShade >= 0, 6 * _textSize, 6 * _textSize).align(draw_get_halign(), draw_get_valign()).transform(_textSize, _textSize, _textAngle).draw(_textx, _texty);
}
