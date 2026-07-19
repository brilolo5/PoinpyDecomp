function uiScrollModeSet(arg0, arg1)
{
    if (arg0 != undefined)
        global.__uiScrollMode = arg0;
    
    if (arg1 != undefined)
        global.__uiScrollThreshold = arg1;
}
