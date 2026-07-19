var gts = global.timeScale;

function handPlacement()
{
    handx = myFruitx_left;
    handy = myFruitLeft.y + 3;
    handangle = 0;
    handxscale = 0.1 * xDirection;
}

fruitOffsetx = 16;
fruitOffsety = -6;

if (hitStop)
    hitStop -= gts;

if (!hitStop)
{
    switch (enemyState)
    {
        case "initialize":
            if (getViewy(global.cam) < y)
            {
                myFruitLeft = instance_create_depth(x, y, depth, oFruitExt);
                myFruitLeft.suckResist = 0;
                myFruitLeft.fruitSet = 0;
                myFruitLeft.golden = 0;
                myFruitLeft.noWiggle = 1;
                myFruitRight = instance_create_depth(x, y, depth, oFruitExt);
                myFruitRight.suckResist = 0;
                myFruitRight.fruitSet = 0;
                myFruitRight.golden = 0;
                myFruitRight.noWiggle = 1;
                enemyState = "patrol";
            }
            
            break;
        
        case "patrol":
            xShrink = approach(xShrink, 1, 0.025 * gts);
            yShrink = approach(yShrink, 1, 0.025 * gts);
            image_index += (imageSpeed * gts);
            
            if (image_index >= 2)
                image_index -= 2;
            
            if (prvImageIndex != floor(image_index))
            {
                xShrink = 1.1;
                yShrink = 0.9;
            }
            
            xsp = maxSpeed * xDirection;
            prvImageIndex = floor(image_index);
            var _bothFruitsCheck = 0;
            
            if (instance_exists(myFruitLeft))
            {
                if (!myFruitLeft.gettingSuckedIn)
                {
                    var _xArmLength = fruitOffsetx;
                    var _yArmLength = fruitOffsety;
                    var _goalx = x + (-1 * _xArmLength) + cx;
                    var _goaly = y + _yArmLength;
                    var _colPoint = collisionLinePoint(x, _goaly, _goalx, _goaly, parentWall, 1, 0);
                    var _sway = ((floor(image_index) == 0) ? 1 : 0) * xDirection * swayAmount;
                    var _myFruitx = _goalx;
                    myFruitx_left = lerp(myFruitx_left, _colPoint[1] + xDirection + _sway, 0.25);
                    myFruitLeft.x = myFruitx_left;
                    myFruitLeft.y = _colPoint[2] - (_sway * xDirection);
                    myFruitLeft.cx = 0;
                    myFruitLeft.cy = cy;
                }
                
                _bothFruitsCheck += 1;
            }
            else if (!myFruitLeft_plateThrown)
            {
                myFruitLeft_plateThrown = 1;
                generateEffect(myFruitx_left, y, "fruit plate flying", -1);
            }
            
            if (instance_exists(myFruitRight))
            {
                if (!myFruitRight.gettingSuckedIn)
                {
                    var _xArmLength = fruitOffsetx;
                    var _yArmLength = fruitOffsety;
                    var _goalx = x + (1 * _xArmLength) + cx;
                    var _goaly = y + _yArmLength;
                    var _colPoint = collisionLinePoint(x, _goaly, _goalx, _goaly, parentWall, 1, 0);
                    var _sway = ((floor(image_index) == 0) ? 1 : 0) * xDirection * swayAmount;
                    myFruitx_right = lerp(myFruitx_right, (_colPoint[1] - xDirection) + _sway, 0.25);
                    myFruitRight.x = myFruitx_right;
                    myFruitRight.y = _colPoint[2] - (_sway * xDirection);
                    myFruitRight.cx = 0;
                    myFruitRight.cy = cy;
                }
                
                _bothFruitsCheck += 1;
            }
            else if (!myFruitRight_plateThrown)
            {
                myFruitRight_plateThrown = 1;
                generateEffect(myFruitx_right, y, "fruit plate flying", 1);
            }
            
            if (_bothFruitsCheck == 0)
            {
                enemyState = "fruit lost";
                xsp = 0;
                xShrink = 1.25;
                yShrink = 0.75;
            }
            
            break;
        
        case "fruit lost":
            xShrink = approach(xShrink, 1, 0.025 * gts);
            yShrink = approach(yShrink, 1, 0.025 * gts);
            xsp = 0;
            image_index = 3;
            animationTime = 90;
            animationTracker += gts;
            
            if (animationTracker >= animationTime)
                enemyState = "cry";
            
            if (instance_exists(myFruitLeft))
                enemyState = "patrol";
            
            break;
        
        case "cry":
            image_index = 4;
            xShrink = approach(xShrink, 1, 0.005 * gts);
            yShrink = approach(yShrink, 1, 0.005 * gts);
            animationTime = 30;
            animationTracker += gts;
            
            if (animationTracker >= animationTime)
            {
                xShrink = 1.1;
                yShrink = 0.9;
                animationTracker = 0;
            }
            
            if (instance_exists(myFruitLeft))
                enemyState = "patrol";
            
            break;
    }
    
    cx += (xsp * global.timeScale);
    cy += (ysp * global.timeScale);
    var xspRound = floor(abs(cx)) * sign(cx);
    var yspRound = floor(abs(cy)) * sign(cy);
    cx -= xspRound;
    cy -= yspRound;
    
    repeat (abs(xspRound))
    {
        target = instance_place(x + sign(xspRound), y, parentWall);
        var maskWidth = sprite_get_bbox_right(mask_index) - sprite_get_bbox_left(mask_index);
        
        if (target == -4)
        {
            if (!instance_place(x + sign(xspRound) + (sign(xspRound) * maskWidth), y + 1, parentWall) && !instance_place(x + sign(xspRound) + (sign(xspRound) * maskWidth), y + 1, oOnewayPlatform))
            {
                xDirection *= -1;
                xsp = maxSpeed * xDirection;
                hitStop = 6;
                xShrink = 0.9;
                yShrink = 1.1;
                break;
            }
            else
            {
                x += sign(xspRound);
            }
        }
        else
        {
            xDirection *= -1;
            xsp = maxSpeed * xDirection;
            hitStop = 6;
            xShrink = 0.9;
            yShrink = 1.1;
            break;
        }
    }
}

xscale = xDirection * xShrink * xscaleBase;
yscale = yDirection * yShrink * yscaleBase;
dcx = cx;
dcy = cy;
