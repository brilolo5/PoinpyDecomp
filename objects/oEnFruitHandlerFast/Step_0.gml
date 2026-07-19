var gts = global.timeScale;

if (hitStop)
    hitStop -= gts;

if (!hitStop)
{
    switch (enemyState)
    {
        case "replace":
            instance_create_depth(x, y, 0, oEnFruitHandler);
            instance_destroy();
            break;
        
        case "idle":
            if (getViewy(global.cam) < y)
            {
                myFruitInstance = instance_create_depth(x, y, depth, oFruitExt);
                myFruitInstance.suckResist = 0;
                myFruitInstance.fruitSet = 0;
                enemyState = "patrol";
            }
            
            break;
        
        case "patrol":
            xShrink = approach(xShrink, 1, 0.05 * gts);
            yShrink = approach(yShrink, 1, 0.05 * gts);
            maxSpeed = 0.4;
            image_index += (0.1 * gts);
            
            if (image_index >= 2)
                image_index -= 2;
            
            if (prvImageIndex != floor(image_index))
                yShrink = 0.9;
            
            prvImageIndex = floor(image_index);
            
            if (instance_exists(myFruitInstance))
            {
                if (!myFruitInstance.gettingSuckedIn)
                {
                    var _goaly = y - 12;
                    var _goalx = x + (xDirection * 19) + cx;
                    var _colPoint = collisionLinePoint(x, _goaly, _goalx, _goaly, parentWall, 1, 0);
                    var _sway = ((floor(image_index) == 0) ? 1 : 0) * xDirection;
                    myFruitx = lerp(myFruitx, (_colPoint[1] - (xDirection * 6)) + _sway, 0.25);
                    myFruitInstance.x = myFruitx;
                    myFruitInstance.y = _colPoint[2] - (_sway * xDirection);
                    myFruitInstance.cx = 0;
                    myFruitInstance.cy = cy;
                }
                
                xsp = maxSpeed * xDirection;
            }
            else
            {
                enemyState = "fruit lost";
                xsp = 0;
                xShrink = 1.25;
                yShrink = 0.75;
                var _goalx = x + (xDirection * 19) + cx;
                var _colPoint = collisionLinePoint(x, y - 2, _goalx, y - 2, parentWall, 1, 0);
                var _sway = ((floor(image_index) == 0) ? 1 : 0) * xDirection;
                myFruitx = lerp(myFruitx, (_colPoint[1] - (xDirection * 6)) + _sway, 0.25);
                var _platex = myFruitx;
                var _platey = _colPoint[2] - (_sway * xDirection);
                generateEffect(_platex, _platey, "fruit plate flying", xDirection);
            }
            
            break;
        
        case "turn":
            image_index = 2;
            xShrink = approach(xShrink, 1, 0.025 * gts);
            yShrink = approach(yShrink, 1, 0.025 * gts);
            xsp = 0;
            animationTime = 30;
            animationTracker += gts;
            
            if (animationTracker >= animationTime)
            {
                xsp = maxSpeed * xDirection;
                enemyState = "patrol";
                animationTracker = 0;
            }
            
            if (instance_exists(myFruitInstance))
            {
                if (!myFruitInstance.gettingSuckedIn)
                {
                    var _goalx = x;
                    var _goaly = y - 14;
                    myFruitx = lerp(myFruitx, _goalx, 0.5);
                    myFruitInstance.x = myFruitx;
                    myFruitInstance.y = _goaly;
                    myFruitInstance.cx = 0;
                    myFruitInstance.cy = cy;
                }
            }
            else
            {
                enemyState = "fruit lost";
                xsp = 0;
                var _goalx = x + (xDirection * 19) + cx;
                var _colPoint = collisionLinePoint(x, y - 2, _goalx, y - 2, parentWall, 1, 0);
                var _sway = ((floor(image_index) == 0) ? 1 : 0) * xDirection;
                myFruitx = lerp(myFruitx, (_colPoint[1] - (xDirection * 6)) + _sway, 0.25);
                var _platex = myFruitx;
                var _platey = _colPoint[2] - (_sway * xDirection);
                generateEffect(_platex, _platey, "fruit plate flying", 0);
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
            
            if (instance_exists(myFruitInstance))
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
            
            if (instance_exists(myFruitInstance))
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
                
                if (enemyState == "patrol")
                    enemyState = "turn";
                
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
            
            if (enemyState == "patrol")
                enemyState = "turn";
            
            break;
        }
    }
}

xscale = xDirection * xShrink * xscaleBase;
yscale = yDirection * yShrink * yscaleBase;
dcx = cx;
dcy = cy;
