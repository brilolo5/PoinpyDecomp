myAlarm0.tick();
myAlarm1.tick();

if (oPlayer.bbox_bottom <= bbox_bottom)
{
    if (!active)
    {
        audioStop(global.areaMusic);
        active = 1;
        myAlarm0.setTimer(30);
        myAlarm1.setTimer(16);
    }
}
