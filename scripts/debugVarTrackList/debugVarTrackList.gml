function debugVarTrackListInit()
{
    if (live_call())
        return global.live_result;
    
    global.debugDrawVariableTrackerArray[0][0] = "global";
    global.debugDrawVariableTrackerArray[0][1] = "moneyJar";
    global.debugDrawVariableTrackerArray[1][0] = 152;
    global.debugDrawVariableTrackerArray[1][1] = "bgArea";
}
