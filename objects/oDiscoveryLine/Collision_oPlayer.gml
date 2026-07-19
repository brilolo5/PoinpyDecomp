var _textKillTimer = 240;

with (oOrderControl)
{
    drawSideGoalText = 0;
    sideGoalTextAppearAnimTracker = 0;
    myAlarm1.setTimer(_textKillTimer + 60);
    angerTimer = angerTimerMax;
    thresholdOfAreaBeingDiscovered = getAreaDiscoveryThreshold();
}

instance_destroy();
