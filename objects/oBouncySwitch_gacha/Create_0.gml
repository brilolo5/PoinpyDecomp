myAlarm0 = new makeAlarm(0, function()
{
    set = 1;
});
myAlarm1 = new makeAlarm(0, function()
{
    playSoundLeverUp();
    pressed = 0;
    origy = ystart;
    myAlarm2.setTimer(90);
});
myAlarm2 = new makeAlarm(0, function()
{
    instance_create_depth(x, y, 0, oShopMenu);
});
myAlarm3 = new makeAlarm(0, function()
{
    with (oPlayer)
    {
        playerStateChange("free");
        xsp = 0;
        ysp = -2;
        oPlayer.xDirection = -1;
    }
    
    mask_index = mask_nomask;
    myAlarm4.setTimer(120);
});
myAlarm4 = new makeAlarm(0, function()
{
    mask_index = sGachaBodyLever_editor;
});
image_speed = 0;
curvePos = 0;
noMoneyAlarmShake = 0;
wallState = "moving";
stop = 0;
set = 0;
switchTravelLength = 40;
recJumpTimes = global.jumpTimes;
recGrounded = -1;
pressed = 0;
origx = xstart;
origy = ystart;
cx = 0;
cy = 0;
xsp = 0;
ysp = 0;
moveSpeed = 0;
timer = 60;
wallSizex = 1;
wallSizey = 1;
alarmo[0] = timer;
myAlarm0.setTimer(4);
set = 0;
mask_index = sGachaBodyLever_editor;
