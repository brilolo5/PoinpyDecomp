var gts = global.timeScale;

if (hitStop)
    hitStop -= gts;

if (!hitStop)
{
    switch (enemyState)
    {
        case "initialize":
            ysp = 0;
            xsp = 0;
            
            if ((getViewy(global.cam) - 64) < y)
            {
                image_speed = 0;
                image_index = 0;
                enemyState = "flutter";
                
                if (fruitSpecify < -1)
                    enemyState = "flutter";
                
                if (fruitSpecify > -1)
                    enemyState = "flutter with fruit";
                
                if (enemyState == "flutter with fruit")
                {
                    if (getViewy(global.cam) < (y + 32))
                    {
                        myFruitInstance = instance_create_depth(x, y, depth, oFruitExt);
                        myFruitInstance.suckResist = 0;
                        myFruitInstance.fruitSet = 0;
                        flutterKeep_y = y;
                        
                        if (fruitSpecify != -1)
                        {
                            var _fruitSpecify = fruitSpecify;
                            
                            with (myFruitInstance)
                            {
                                fruitType = _fruitSpecify;
                                sprIndex = getFruitSprite(fruitType);
                                fruitSet = 1;
                            }
                        }
                    }
                }
                else
                {
                    ysp = -0.65;
                    xsp = xDirection * 0.2;
                }
            }
            
            break;
        
        case "flutter":
            sprite_index = sEnemyJelly_flutter;
            
            if (ysp < 0.25)
            {
                image_index = (xDirection == -1) ? 1 : 3;
            }
            else
            {
                xDirection = -sign(xsp + 0.1);
                image_index = (xDirection == -1) ? 0 : 2;
            }
            
            xShrink = approach(xShrink, 1, 0.01 * gts);
            yShrink = approach(yShrink, 1, 0.01 * gts);
            imageAngle = lerp(imageAngle, 0, 0.15);
            grav = 0.02;
            gravityEnabled = 1;
            maxFallSpeed = 10;
            stateTimer += gts;
            
            if (y > ystart && ysp > 0)
            {
                xShrink = 0.75;
                yShrink = 1.25;
                ysp = -0.65;
                xsp = xDirection * 0.2;
                stateTimer = 0;
            }
            
            break;
        
        case "flutter with fruit":
            sprite_index = sEnJelloWithFruit;
            xShrink = approach(xShrink, 1, 0.01 * gts);
            yShrink = approach(yShrink, 1, 0.01 * gts);
            imageAngle = 0;
            image_index = 1;
            grav = 0.01;
            gravityEnabled = 1;
            maxFallSpeed = 10;
            stateTimer += gts;
            
            if (y > flutterKeep_y)
            {
                y = flutterKeep_y;
                ysp = -0.45;
                xDirection *= -1;
                xsp = xDirection * 0.1;
                stateTimer = 0;
            }
            
            if (instance_exists(myFruitInstance))
            {
                if (!myFruitInstance.gettingSuckedIn)
                {
                    myFruitx = x;
                    myFruity = y + 10;
                    myFruitInstance.x = myFruitx;
                    myFruitInstance.y = myFruity;
                    myFruitInstance.cx = cx;
                    myFruitInstance.cy = cy;
                }
            }
            else
            {
                enemyState = "flutter";
                hitStop = 8;
                ysp = -0.8;
                stateTimer = 0;
            }
            
            break;
    }
    
    cx += (xsp * global.timeScale);
    cy += (ysp * global.timeScale);
    var xspRound = floor(abs(cx)) * sign(cx);
    var yspRound = floor(abs(cy)) * sign(cy);
    cx -= xspRound;
    cy -= yspRound;
    ysp += (((grav * gts) / 2) * gravityEnabled);
    
    repeat (abs(xspRound))
    {
        target = instance_place(x + sign(xspRound), y, parentWall);
        
        if (target == -4)
        {
            x += sign(xspRound);
        }
        else
        {
            xsp *= -0.5;
            break;
        }
    }
    
    repeat (abs(yspRound))
    {
        target = instance_place(x, y + sign(yspRound), parentWall);
        
        if (target == -4)
            y += sign(yspRound);
        else
            ysp = 0;
    }
    
    if (ysp >= 0 && place_meeting(x, y + 1, parentWall))
    {
        grounded = 1;
        cy = 0;
    }
    else
    {
        grounded = -1;
    }
    
    ysp += (((grav * global.timeScale) / 2) * gravityEnabled);
    
    if (ysp > maxFallSpeed)
        ysp = maxFallSpeed;
}

dcx = cx;
dcy = cy;
xShrink = 1;
yShrink = 1;
xscale = xShrink * xscaleBase;
yscale = yShrink * yDirection * yscaleBase;
