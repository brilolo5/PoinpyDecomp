myAlarm0.tick();

if (place_meeting(x, y, oPlayer) && !active)
{
    active = 1;
    
    with (oPlayer)
    {
        xsp = ((room_width / 2) - x) / 40;
        playerStateChange("free");
        ysp = -3;
    }
    
    with (oBeastInLobby)
    {
        beastBreatheCount = 0;
        breathState = "breathe in";
        breathStop = 0;
        breath = 4.71238898038469;
        beastFaceIndex = 0;
        breathStateInit = 1;
    }
    
    var _logoTimer = 240;
    var _musicTimer = _logoTimer + 240;
    myAlarm0.setTimer(_musicTimer);
    
    with (oPoinpyLogo)
        myAlarmPlayLeadIn.setTimer(_logoTimer);
    
    playerControlLock();
}
