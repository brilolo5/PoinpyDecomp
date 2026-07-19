var gts = global.timeScale;

switch (enemyState)
{
    case "idle":
        image_index = 8;
        
        if (abs(y - oPlayer.y) < activationRange)
        {
            boostTimer = 20;
            enemyState = "boost";
            xShrink = xScaleDefault * 1.75;
            yShrink = yScaleDefault * 1.75;
            image_index = 6;
        }
        
        break;
    
    case "inflate":
        if (inflateTimer > 0)
        {
            followDirection = point_direction(x, y, oPlayer.x, oPlayer.y);
            image_index = floor((followDirection / 45) + 0.5);
            
            if (image_index >= 8)
                image_index -= 8;
            
            inflateTimer -= gts;
            var _inflationMax = 0.4 * xScaleDefault;
            var _inflatedAmount = (abs(inflateTimer - inflateTimerMax) / inflateTimerMax) * _inflationMax;
            xShrink = xScaleDefault + _inflatedAmount;
            yShrink = xShrink;
            
            if (inflateTimer <= 0)
            {
                enemyState = "boost";
                dir = point_direction(x, y, oPlayer.x, oPlayer.y);
                xsp = accel * dcos(dir);
                ysp = accel * dsin(-dir);
                inflateTimer = inflateTimerMax;
                boostTimer = boostTimerMax;
                xShrink = xScaleDefault * 1.75;
                yShrink = yScaleDefault * 1.75;
            }
        }
        
        break;
    
    case "boost":
        xShrink = approach(xShrink, xScaleDefault, xScaleDefault * 0.1 * gts);
        yShrink = approach(yShrink, yScaleDefault, xScaleDefault * 0.1 * gts);
        
        if (boostTimer > 0)
        {
            boostTimer -= gts;
            
            if (boostTimer <= 0)
            {
                enemyState = "inflate";
                inflateTimer = inflateTimerMax;
                boostTimer = boostTimerMax;
            }
        }
        
        break;
}
