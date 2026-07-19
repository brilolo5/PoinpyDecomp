if (live_call())
    return global.live_result;

spriteIndex = sNotifRabbit_Dance_Oneway;
eyeColor = make_color_rgb(248, 45, 97);
notificationActive = 1;
playerStateTracker = -1;
backToSleepTimer = 0;
holdPositionTimer = 0.1;
stateBuffer = -1;
state = "dancing - hold";
image_speed = 0;
imageIndex = 0;
imageSpeed = sprite_get_speed(spriteIndex);
image_xscale = 1;
startXdir = 1;
xDirection = 1;
xdirBuffer = xDirection;

getRabbitSpriteFromState = function(arg0 = state, arg1 = false)
{
    var _sprite = -1;
    
    switch (state)
    {
        case "notification - jumping":
        case "jump awake":
            _sprite = sNotifRabbit_Jump;
            break;
        
        case "notification - checking in":
        case "notification - checking back out":
            _sprite = sNotifRabbit_WalkIn;
            break;
        
        case "notification cleared - asleep":
            _sprite = sNotifRabbit_Asleep;
            break;
        
        case "dancing":
        case "dancing - hold":
            _sprite = sNotifRabbit_Dance_Oneway;
            break;
    }
    
    return _sprite;
};

getEyesSprite = function(arg0 = spriteIndex)
{
    switch (arg0)
    {
        case sNotifRabbit_Jump:
            arg0 = sNotifRabbit_Jump_Eyes;
            break;
        
        case sNotifRabbit_WalkIn:
            arg0 = sNotifRabbit_WalkIn_Eyes;
            break;
        
        case sNotifRabbit_Asleep:
            arg0 = sNotifRabbit_Asleep_Eyes;
            break;
        
        case sNotifRabbit_Blink:
            arg0 = sNotifRabbit_Blink_Eyes;
            break;
        
        case sNotifRabbit_Dance_Oneway:
            arg0 = sNotifRabbit_Dance_Oneway_Eyes;
            break;
    }
    
    return arg0;
};

rabbitStateBuffer = function(arg0, arg1)
{
    if (state != arg0)
    {
        stateBuffer = arg0;
        xdirBuffer = arg1;
    }
};

rabbitStateChange = function(arg0, arg1 = xdirBuffer)
{
    state = arg0;
    spriteIndex = getRabbitSpriteFromState();
    imageSpeed = sprite_get_speed(spriteIndex);
    imageIndex = 0;
    stateBuffer = -1;
    xDirection = arg1 * image_xscale;
};

jumpAwake = function()
{
    playerSlammed = 1;
    rabbitStateChange("jump awake", xDirection);
    imageIndex = 7;
};

if (areThereItemsLeftToGetFromGacha())
    instance_destroy();
