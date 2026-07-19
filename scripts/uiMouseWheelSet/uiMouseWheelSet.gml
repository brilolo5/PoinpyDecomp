function uiMouseWheelSet(arg0, arg1)
{
    if (arg0 != undefined)
        global.__uiScrollMouseWheelSpeed = arg0;
    
    if (arg1 != undefined)
        global.__uiScrollMouseWheelReverse = arg1;
}
