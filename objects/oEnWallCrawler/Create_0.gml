event_inherited();
neckx = x;
necky = y;
enemyState = "idle";
clockwiseOrNo = -1;

if (x > 80)
    clockwiseOrNo = 1;
else
    clockwiseOrNo = -1;

if (clockwiseOrNo)
    crawlDirection = 0;
else
    crawlDirection = 180;

crawlSpeed = 0.35;
turnInterval = 0;
stop = 0;
deadSprite = sEnWallCrawlerDead;
grounded = 0;
grav = 0;
gravityEnabled = 0;
maxFallSpeed = 16;
xsp = 0;
ysp = 0;
cx = 0;
cy = 0;
hitStop = 0;
xscaleBase = 0.1;
yscaleBase = 0.1;
xDirection = clockwiseOrNo;
yDirection = clockwiseOrNo;
xShrink = 1;
yShrink = 1;
xscale = xscaleBase * xDirection * xShrink;
yscale = yscaleBase * yDirection * yShrink;
mask_index = sprite_index;
sprite_index = sTentoBall_Shell;
imageAngleTween = 0;
turnAnimationTimer = 0;

turncheck = function()
{
    var _checkLength = 1;
    var _outWallCheck_x = x + lengthdir_x(_checkLength, crawlDirection - (90 * clockwiseOrNo));
    var _outWallCheck_y = y + lengthdir_y(_checkLength, crawlDirection - (90 * clockwiseOrNo));
    var _outWallCheck_xDiagonal = x + lengthdir_x(_checkLength, crawlDirection - (135 * clockwiseOrNo));
    var _outWallCheck_yDiagonal = y + lengthdir_y(_checkLength, crawlDirection - (135 * clockwiseOrNo));
    var _inWallCheck_x = x + lengthdir_x(_checkLength, crawlDirection);
    var _inWallCheck_y = y + lengthdir_y(_checkLength, crawlDirection);
    
    if (!place_meeting(_outWallCheck_x, _outWallCheck_y, parentWall) && place_meeting(_outWallCheck_xDiagonal, _outWallCheck_yDiagonal, parentWall) && !turnInterval)
    {
        crawlDirection -= (90 * clockwiseOrNo);
        crawlDirection %= 360;
        cx = 0;
        cy = 0;
        turnInterval = 10;
        return true;
    }
    else if (place_meeting(_inWallCheck_x, _inWallCheck_y, parentWall))
    {
        crawlDirection += (90 * clockwiseOrNo);
        crawlDirection %= 360;
        cx = 0;
        cy = 0;
        turnInterval = 10;
        return true;
    }
    else
    {
        return false;
    }
};

turnCheckOnly = function()
{
    var _checkLength = 1;
    var _outWallCheck_x = x + lengthdir_x(_checkLength, crawlDirection - (90 * clockwiseOrNo));
    var _outWallCheck_y = y + lengthdir_y(_checkLength, crawlDirection - (90 * clockwiseOrNo));
    var _outWallCheck_xDiagonal = x + lengthdir_x(_checkLength, crawlDirection - (135 * clockwiseOrNo));
    var _outWallCheck_yDiagonal = y + lengthdir_y(_checkLength, crawlDirection - (135 * clockwiseOrNo));
    var _inWallCheck_x = x + lengthdir_x(_checkLength, crawlDirection);
    var _inWallCheck_y = y + lengthdir_y(_checkLength, crawlDirection);
    
    if (!place_meeting(_outWallCheck_x, _outWallCheck_y, parentWall) && place_meeting(_outWallCheck_xDiagonal, _outWallCheck_yDiagonal, parentWall) && !turnInterval)
        return true;
    else if (place_meeting(_inWallCheck_x, _inWallCheck_y, parentWall))
        return true;
    else
        return false;
};
