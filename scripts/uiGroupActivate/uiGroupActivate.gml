function uiGroupActivate(arg0, arg1)
{
    uiForEachInGroup(arg0, arg1, function()
    {
        setVisible(true);
        setActive(true);
        setChildrenVisible(true);
        setChildrenActive(true);
    });
}
