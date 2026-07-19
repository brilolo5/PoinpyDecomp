function textFloatCreate(arg0, arg1, arg2, arg3)
{
    var _x = arg0;
    var _y = arg1;
    var _textGoal_y = arg2;
    var _text = arg3;
    var _textObj = instance_create_depth(_x, _y, -10000, oTextFloat);
    
    with (_textObj)
    {
        text = _text;
        textGoal_y = _textGoal_y;
    }
    
    return _textObj;
}
