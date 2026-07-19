function pcol_Cannon()
{
    var _target = instance_place(argument[0], argument[1], oGimCannon);
    
    if (_target)
    {
        playSoundCannonLaunch();
        noStompFor(12);
        myCannon = _target;
        playerStateChange("in cannon");
        myCannon.cannonMotionActive = 0;
        myAlarm6.setTimer(6);
        return true;
    }
}
