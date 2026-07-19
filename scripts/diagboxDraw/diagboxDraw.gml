function diagboxDraw()
{
    var _diagbox = argument[0];
    var _draw_symbol = (argument_count > 1 && argument[1] != undefined) ? argument[1] : true;
    return _diagbox.draw(_draw_symbol);
}
