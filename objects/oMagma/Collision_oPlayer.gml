if (live_call())
    return global.live_result;

with (oPlayer)
{
    ysp = -6;
    y = min(other.bbox_top, y);
    playerStateChange("damage knocked");
    global.jumpTimes = max(global.jumpTimes, 1);
}
