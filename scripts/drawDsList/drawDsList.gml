function drawDsList(arg0, arg1, arg2, arg3)
{
    var _drawx = arg0;
    var _drawy = arg1;
    var _listText = arg2;
    var _list = arg3;
    
    if (ds_exists(_list, ds_type_list))
    {
        var _listSize = ds_list_size(_list);
        _listText += (" (" + string(_listSize) + ") \n");
        
        for (var i = 0; i < _listSize; i += 1)
            _listText += (string(_list[| i]) + "\n");
    }
    else
    {
        _listText += "-no data";
    }
    
    drawSetAlign(0, 0);
    drawTextOutlined(_drawx, _drawy, _listText, make_color_rgb(255, 255, 255), make_color_rgb(46, 50, 59), 0, 1);
}
