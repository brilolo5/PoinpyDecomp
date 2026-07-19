function uiGroupDeactivate(arg0, arg1)
{
    uiForEachInGroup(arg0, arg1, function()
    {
        setVisible(false);
        setActive(false);
        setChildrenVisible(false);
        setChildrenActive(false);
    });
}
