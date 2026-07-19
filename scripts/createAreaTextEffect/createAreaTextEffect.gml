function createAreaTextEffect(arg0 = -1)
{
    with (instance_create_depth(getViewx(), getViewy(), 0, oDiscoverNewAreaText))
    {
        if (arg0 != -1)
            areaNameText = getAreaText(arg0);
    }
}
