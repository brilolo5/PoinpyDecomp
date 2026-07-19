event_inherited();
flipCheck = 0;
mask_index = sprite_index;
sprite_index = sEnemySpikeBox_spikeTop;
deadSprite = sEnemySpikeBox_dead;
enemyState = "rest";
stateTimer = 0;

getSpikeSpriteFromSide = function(arg0)
{
    var _ret = -1;
    
    switch (arg0)
    {
        case UnknownEnum.Value_0:
            _ret = sEnemySpikeBox_spikeTop;
            break;
        
        case UnknownEnum.Value_1:
            _ret = sEnemySpikeBox_spikeFront;
            break;
        
        case UnknownEnum.Value_2:
            _ret = sEnemySpikeBox_spikeBottom;
            break;
        
        case UnknownEnum.Value_3:
            _ret = sEnemySpikeBox_spikeBack;
            break;
    }
    
    return _ret;
};

spikeRoll = function(arg0)
{
    arg0 = (arg0 + 1) % 4;
    sprite_index = getSpikeSpriteFromSide(arg0);
    side = arg0;
    return arg0;
};

spikeMirror = function(arg0)
{
    var _ret;
    
    switch (arg0)
    {
        case UnknownEnum.Value_1:
            _ret = UnknownEnum.Value_3;
            break;
        
        case UnknownEnum.Value_3:
            _ret = UnknownEnum.Value_1;
            break;
        
        default:
            _ret = arg0;
            break;
    }
    
    sprite_index = getSpikeSpriteFromSide(_ret);
    side = _ret;
    return _ret;
};

side = irandom(UnknownEnum.Value_3);
image_index = 0;
image_speed = 0;

if (sideSpecify != -1)
    side = sideSpecify;

sprite_index = getSpikeSpriteFromSide(side);
unstompable = 0;
grounded = 0;
grav = 0.2;
gravityEnabled = 1;
maxFallSpeed = 16;
goalx = x;
xsp = 0;
ysp = 0;
cx = 0;
cy = 0;
hitStop = 0;

if (xDirection == 0)
    xDirection = choose(-1, 1);

yDirection = 1;
xscaleBase = 0.1;
yscaleBase = 0.1;
xShrink = 1;
yShrink = 1;
xscale = xShrink * xDirection * xscaleBase;
yscale = yShrink * yDirection * yscaleBase;
