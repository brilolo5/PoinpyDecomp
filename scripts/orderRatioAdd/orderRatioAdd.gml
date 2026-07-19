function orderRatioAdd()
{
    ds_list_add(orderRatioList, ds_list_create());
    var orListIndex = ds_list_size(orderRatioList) - 1;
    ds_list_mark_as_list(orderRatioList, orListIndex);
    
    for (var i = 0; i < argument_count; i += 1)
        ds_list_add(orderRatioList[| orListIndex], argument[i]);
}

function orFiller(arg0)
{
    return -arg0 - 100;
}

function orBanned(arg0)
{
    return -arg0 - 200;
}
