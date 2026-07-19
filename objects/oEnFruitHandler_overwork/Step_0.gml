var gts = global.timeScale;

function handPlacement()
{
    handx = myFruitx;
    handy = (myFruitInstance.y + 3) - 2 - 1;
    handangle = 0;
    handxscale = 0.1 * xDirection;
}

myFruitInstance_top_offsety = -9;

if (hitStop)
    hitStop -= gts;

if (!hitStop)
{
    drawTears = 0;
    
    switch (enemyState)
    {
        case "idle":
            if (getViewy(global.cam) < y)
            {
                myFruitInstance = instance_create_depth(x, y, depth, oFruitExt);
                myFruitInstance.suckResist = 0;
                myFruitInstance.fruitSet = 0;
                myFruitInstance.golden = 0;
                myFruitInstance.noWiggle = 1;
                
                with (myFruitInstance)
                {
                    fruitType = fruitGetRandomFromCycle();
                    sprIndex = getFruitSprite(fruitType);
                    fruitSet = 1;
                }
                
                myFruitInstance_top = instance_create_depth(x, y, depth, oFruitExt);
                myFruitInstance_top.suckResist = 0;
                myFruitInstance_top.fruitSet = 1;
                myFruitInstance_top.fruitType = myFruitInstance.fruitType;
                myFruitInstance_top.sprIndex = myFruitInstance.sprIndex;
                myFruitInstance_top.golden = 0;
                myFruitInstance_top.noWiggle = 1;
                enemyState = "patrol";
            }
            
            break;
        
        case "patrol":
            xShrink = approach(xShrink, 1, 0.025 * gts);
            yShrink = approach(yShrink, 1, 0.025 * gts);
            sprite_index = sHacobow_walk_body;
            animFrame += (sprite_get_speed(sprite_index) * gts * 1.5);
            image_index = animFrameToIndex(sprite_index, animFrame);
            handSprite = sHacobow_walk_arm;
            
            if (atImageIndex(image_index, 1, 5))
                playSoundEnemyFruitHandlerWalk();
            
            var _hasFruit = 0;
            
            if (instance_exists(myFruitInstance))
            {
                if (!myFruitInstance.gettingSuckedIn)
                {
                    var _xArmLength = fruitOffsetx;
                    var _yArmLength = fruitOffsety;
                    var _goalx = x + (xDirection * _xArmLength) + cx;
                    var _goaly = y + _yArmLength;
                    var _colPoint = collisionLinePoint(x, _goaly, _goalx, _goaly, parentWall, 1, 0);
                    var _sway = ((floor(image_index) == 0) ? 1 : 0) * xDirection * swayAmount;
                    myFruitx = lerp(myFruitx, (_colPoint[1] - xDirection) + _sway, 0.25);
                    myFruitInstance.x = myFruitx;
                    myFruitInstance.y = _colPoint[2] - (_sway * xDirection);
                    myFruitInstance.cx = 0;
                    myFruitInstance.cy = cy;
                    var _curvePos = image_index / 8;
                    handIndex = animcurveGetValueAtPos(acHacobowHandIndex, "index", _curvePos);
                    handx = x + (((animcurveGetValueAtPos(acHacobowHandPos, "x", _curvePos) * 1) / 10) * xDirection);
                    handy = y + ((animcurveGetValueAtPos(acHacobowHandPos, "y", _curvePos) * 1) / 10);
                    handx += cx;
                    handy += cy;
                    myFruitInstance.x = x + (((animcurveGetValueAtPos(acHacobowFruitBobPos, "x", _curvePos) * 1) / 10) * xDirection) + cx;
                    myFruitInstance.y = (y + ((animcurveGetValueAtPos(acHacobowFruitBobPos, "y", _curvePos) * 1) / 10)) - 3;
                    handxscale = 0.1 * xDirection;
                    _hasFruit += 1;
                }
                
                xsp = maxSpeed * xDirection;
            }
            
            if (instance_exists(myFruitInstance_top))
            {
                if (!myFruitInstance_top.gettingSuckedIn)
                {
                    var _xArmLength = fruitOffsetx;
                    var _yArmLength = fruitOffsety;
                    var _goalx = x + (xDirection * _xArmLength) + cx;
                    var _goaly = y + _yArmLength;
                    var _colPoint = collisionLinePoint(x, _goaly, _goalx, _goaly, parentWall, 1, 0);
                    var _sway = ((floor(image_index) == 0) ? 1 : 0) * xDirection * swayAmount;
                    myFruitx = lerp(myFruitx, (_colPoint[1] - xDirection) + _sway, 0.25);
                    myFruitInstance_top.x = myFruitx;
                    myFruitInstance_top.y = _colPoint[2] - (_sway * xDirection);
                    myFruitInstance_top.cx = 0;
                    myFruitInstance_top.cy = cy;
                    var _curvePos = image_index / 8;
                    _curvePos = _curvePos - 0.1;
                    handIndex = animcurveGetValueAtPos(acHacobowHandIndex, "index", _curvePos);
                    handx = x + (((animcurveGetValueAtPos(acHacobowHandPos, "x", _curvePos) * 1) / 10) * xDirection);
                    handy = y + ((animcurveGetValueAtPos(acHacobowHandPos, "y", _curvePos) * 1) / 10);
                    handx += cx;
                    handy += cy;
                    myFruitInstance_top.x = x + (((animcurveGetValueAtPos(acHacobowFruitBobPos, "x", _curvePos) * 1) / 10) * xDirection) + cx + (xDirection * -1);
                    myFruitInstance_top.y = ((y + ((animcurveGetValueAtPos(acHacobowFruitBobPos, "y", _curvePos) * 1) / 10)) - 3) + myFruitInstance_top_offsety;
                    handxscale = 0.1 * xDirection;
                }
                
                xsp = maxSpeed * xDirection;
            }
            
            if (_hasFruit == 0)
            {
                enemyState = "fruit lost";
                animFrame = 0;
                xsp = 0;
                xShrink = 1.25;
                yShrink = 0.75;
                var _goalx = x + (xDirection * 19) + cx;
                var _colPoint = collisionLinePoint(x, y - 2, _goalx, y - 2, parentWall, 1, 0);
                var _sway = ((floor(image_index) == 0) ? 1 : 0) * xDirection;
                myFruitx = lerp(myFruitx, (_colPoint[1] - (xDirection * 6)) + _sway, 0.25);
                var _platex = myFruitx;
                var _platey = _colPoint[2] - (_sway * xDirection);
                throwPlate(_platex, _platey, xDirection);
            }
            
            break;
        
        case "turn":
            xsp = 0;
            sprite_index = sHacobow_turn_body;
            animFrame += (sprite_get_speed(sprite_index) * gts);
            image_index = animFrameToIndex(sprite_index, animFrame);
            
            if (animFrame >= animFrameNumber(sprite_index))
            {
                xsp = maxSpeed * xDirection;
                enemyState = "patrol";
                animationTracker = 0;
                animFrame = 0;
            }
            
            handSprite = sHacobow_turn_arm;
            var _curvePos = round((animFrame / animFrameNumber(sprite_index)) * 24) / 24;
            handx = x + ((animcurveGetValueAtPos(acHandlerTurnHandPos, "x", _curvePos) * 1) / 10);
            handy = y + ((animcurveGetValueAtPos(acHandlerTurnHandPos, "y", _curvePos) * 1) / 10);
            handx += cx;
            handy += cy;
            _hasFruit = 0;
            
            if (instance_exists(myFruitInstance))
            {
                if (!myFruitInstance.gettingSuckedIn)
                {
                    fruitOffsety = 0;
                    var _goalx = x;
                    var _goaly = y + fruitOffsety;
                    myFruitx = lerp(myFruitx, _goalx, 0.5);
                    myFruitInstance.x = myFruitx;
                    myFruitInstance.y = _goaly;
                    myFruitInstance.cx = 0;
                    myFruitInstance.cy = cy;
                    myFruitInstance.x = x + (((animcurveGetValueAtPos(acHandlerTurnFruitPos, "x", _curvePos) * 1) / 10) * xDirection) + cx;
                    myFruitInstance.y = (y + ((animcurveGetValueAtPos(acHandlerTurnFruitPos, "y", _curvePos) * 1) / 10)) - 3;
                    _hasFruit += 1;
                }
            }
            
            if (instance_exists(myFruitInstance_top))
            {
                if (!myFruitInstance_top.gettingSuckedIn)
                {
                    fruitOffsety = 0;
                    var _goalx = x;
                    var _goaly = y + fruitOffsety;
                    myFruitx = lerp(myFruitx, _goalx, 0.5);
                    myFruitInstance_top.x = myFruitx;
                    myFruitInstance_top.y = _goaly;
                    myFruitInstance_top.cx = 0;
                    myFruitInstance_top.cy = cy;
                    myFruitInstance_top.x = x + (((animcurveGetValueAtPos(acHandlerTurnFruitPos, "x", _curvePos) * 1) / 10) * xDirection) + cx;
                    myFruitInstance_top.y = ((y + ((animcurveGetValueAtPos(acHandlerTurnFruitPos, "y", _curvePos - 0.05) * 1) / 10)) - 3) + myFruitInstance_top_offsety;
                }
            }
            
            if (_hasFruit == 0)
            {
                enemyState = "fruit lost";
                animFrame = 0;
                xsp = 0;
                var _goalx = x + (xDirection * 19) + cx;
                var _colPoint = collisionLinePoint(x, y - 2, _goalx, y - 2, parentWall, 1, 0);
                var _sway = ((floor(image_index) == 0) ? 1 : 0) * xDirection;
                myFruitx = lerp(myFruitx, (_colPoint[1] - (xDirection * 6)) + _sway, 0.25);
                var _platex = myFruitx;
                var _platey = _colPoint[2] - (_sway * xDirection);
                throwPlate(_platex, _platey, 0);
            }
            
            break;
        
        case "fruit lost":
            xShrink = approach(xShrink, 1, 0.025 * gts);
            yShrink = approach(yShrink, 1, 0.025 * gts);
            xsp = 0;
            sprite_index = sHacobow_ops;
            animFrame += (sprite_get_speed(sprite_index) * gts);
            image_index = animFrameToIndex(sprite_index, animFrame);
            
            if (animFrame >= animFrameNumber(sprite_index))
            {
                xsp = maxSpeed * xDirection;
                enemyState = "cry";
                animationTracker = 0;
                animFrame = 0;
            }
            
            if (instance_exists(myFruitInstance))
                enemyState = "patrol";
            
            break;
        
        case "cry":
            xsp = 0;
            sprite_index = sHacobow_cry_repeat;
            animFrame += (sprite_get_speed(sprite_index) * gts);
            image_index = animFrameToIndex(sprite_index, animFrame);
            drawTears = 1;
            tearFrame = animFrameToIndex(sHacobow_tears, animFrame);
            
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
        target = instance_place(x + (sign(xspRound) * 4), y, parentWall);
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
                {
                    enemyState = "turn";
                    animFrame = 0;
                }
                
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
            {
                enemyState = "turn";
                animFrame = 0;
            }
            
            break;
        }
    }
}

if (point_distance(oPlayer.x, oPlayer.y, x, y) < 120)
{
    if (!instance_exists(myFruitInstance) || myFruitInstance.gettingSuckedIn)
    {
        if (instance_exists(myFruitInstance_top) && !topFruitSuckIn)
        {
            topFruitSuckIn = 1;
            var _parseFruitId = myFruitInstance_top;
            
            with (oPlayer)
                ds_list_add(fruitVicinityList, _parseFruitId);
            
            myFruitInstance_top.suckResist = 1;
            myFruitInstance_top.suckResistTimer = 2;
        }
    }
}

xShrink = 1;
yShrink = 1;
xscale = xDirection * xShrink * xscaleBase;
yscale = yDirection * yShrink * yscaleBase;
dcx = cx;
dcy = cy;
