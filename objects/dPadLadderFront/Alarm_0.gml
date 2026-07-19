var _list = ds_list_create();

if (instance_place_list(x, y, oWall, _list, false))
{
    var _listNum = ds_list_size(_list);
    
    for (var i = 0; i < _listNum; i += 1)
    {
        with (_list[| i])
            wallSprite = mask_nomask;
    }
}

ds_list_destroy(_list);
