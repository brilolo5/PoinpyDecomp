var gts = global.timeScale;

if (hitStop)
    hitStop -= gts;

if (!hitStop)
{
    switch (enemyState)
    {
        case "rest":
            xShrink = approach(xShrink, 1, 0.05 * gts);
            yShrink = approach(yShrink, 1, 0.05 * gts);
            image_index = 0;
            stateTimer += gts;
            
            if (stateTimer > 72)
            {
                enemyState = "charge up";
                stateTimer = 0;
            }
            
            break;
        
        case "charge up":
            xShrink = lerp(xShrink, 1.2, 0.05);
            yShrink = xShrink;
            image_index += (imageSpeed * gts);
            
            if (image_index >= 8)
            {
                if (audioVarAnemoneShooter == 0)
                {
                    playSoundEnemyAnemoneShooterShoot();
                    audioVarAnemoneShooter = 1;
                }
            }
            
            if (image_index >= 10)
            {
                audioVarAnemoneShooter = 0;
                enemyState = "shoot";
                stateTimer = 0;
                xShrink = 1.25;
                yShrink = 1.5;
                var _dir = point_direction(0, 0, xDirection, 0);
                var _shootx = x + (xDirection * 28);
                
                with (shootEnemyBullet(_shootx, y, sEnAnemoneShooterBullet, sHazardBall, 0.1, 0.1, _dir, 0.75, 0, 0, 1, 300, 0, 0))
                    imageSpeed = 0.4;
            }
            
            break;
        
        case "shoot":
            xShrink = lerp(xShrink, 0.9, 0.3 * gts);
            yShrink = lerp(yShrink, 1.1, 0.3 * gts);
            image_index += (imageSpeed * gts);
            
            if (image_index >= (image_number - 1))
            {
                enemyState = "rest";
                stateTimer = 0;
            }
            
            break;
    }
}

xShrink = 1;
yShrink = 1;
xscale = xscaleBase * xDirection * xShrink;
yscale = yscaleBase * yDirection * yShrink;
dcx = cx;
dcy = cy;
