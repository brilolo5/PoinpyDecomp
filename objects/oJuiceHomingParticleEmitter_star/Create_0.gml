playSoundBeastEatStartLoop();
playSoundFruitPressLoop();
interval = 2;
alarm0 = 0;
alarm1 = 0;
initialized = 0;
spawnCount = 0;
receivedComboGrid = ds_grid_create(3, 2);
receivedComboGrid[# UnknownEnum.Value_0, 0] = UnknownEnum.Value_0;
receivedComboGrid[# UnknownEnum.Value_1, 0] = 5;
receivedComboGrid[# UnknownEnum.Value_2, 0] = 2;
receivedComboGrid[# UnknownEnum.Value_0, 1] = UnknownEnum.Value_4;
receivedComboGrid[# UnknownEnum.Value_1, 1] = 5;
receivedComboGrid[# UnknownEnum.Value_2, 1] = 1;
dewReceived = 0;
dewNumberWobble = 0;
emitterFruitNum = -1;
dewReceiveInterval = 0;
dewReceivedTween = 0;
var _totalTypes = ds_grid_height(receivedComboGrid);
totalFruit = ds_grid_get_sum(receivedComboGrid, UnknownEnum.Value_1, 0, UnknownEnum.Value_1, _totalTypes);
totalGold = ds_grid_get_sum(receivedComboGrid, UnknownEnum.Value_2, 0, UnknownEnum.Value_2, _totalTypes);
dewScale = totalFruit / 10;
dewScale = clamp(dewScale, 1, 3);
dewBaseScale = 1.2;
particleArray = [];
var _dx1 = 0;
var _dy1 = random_range(-30, -50);
var _dx2 = random_range(50, 80);
var _dy2 = random_range(-10, -40);
var _arcPeakHeight = 52;
splineX0 = x;
splineY0 = y;
splineX1 = undefined;
splineY1 = (y + _dy1) - _arcPeakHeight;
splineX2 = undefined;
splineY2 = (y + _dy2) - _arcPeakHeight;
splineX3 = global.viewWidth / 2;
splineY3 = (getViewy(global.cam) + global.viewHeight) - 48;
autoAdjustTrajectory = 1;

if (room == rmTutorialMovement2)
{
    _arcPeakHeight = 96;
    splineX0 = x;
    splineY0 = y;
    splineX1 = undefined;
    splineY1 = (y + _dy1) - _arcPeakHeight;
    splineX2 = undefined;
    splineY2 = (y + _dy2) - _arcPeakHeight;
    splineX3 = oTutJuiceAltar.x + 8;
    splineY3 = oTutJuiceAltar.y - 8;
    var _midwayx = (x + splineX3) / 2;
    splineX1 = x;
    splineX2 = splineX3;
    splineX1 = lerp(splineX1, _midwayx, 0.2);
    splineX2 = lerp(splineX2, _midwayx, 0.2);
    bezierSpeed = 0.021739130434782608;
    autoAdjustTrajectory = 0;
}
else
{
    if (x < max(_dx1, _dx2))
    {
        splineX1 = x + _dx1;
        splineX2 = x + _dx2;
    }
    else if (x > (global.viewWidth - max(_dx1, _dx2)))
    {
        splineX1 = x - _dx1;
        splineX2 = x - _dx2;
    }
    else
    {
        var _d = choose(-1, 1);
        splineX1 = x + (_dx1 * _d);
        splineX2 = x + (_dx2 * _d);
    }
    
    splineX2 = splineX3;
    bezierSpeed = 0.014285714285714285;
}

myAlarm0 = new makeAlarm(3, function()
{
    while (myAlarm0.alarmTimer <= 0)
    {
        if (!initialized)
        {
            var _totalTypes = ds_grid_height(receivedComboGrid);
            totalFruit = ds_grid_get_sum(receivedComboGrid, UnknownEnum.Value_1, 0, UnknownEnum.Value_1, _totalTypes);
            totalGold = ds_grid_get_sum(receivedComboGrid, UnknownEnum.Value_2, 0, UnknownEnum.Value_2, _totalTypes);
            emitterFruitArray[0] = sFruitDewWhite;
            emitterFruitNum = -1;
            
            for (i = 0; i < _totalTypes; i += 1)
            {
                var _amountInType = receivedComboGrid[# UnknownEnum.Value_1, i] * 1;
                var _type = receivedComboGrid[# UnknownEnum.Value_0, i];
                
                for (t = 0; t < _amountInType; t += 1)
                {
                    emitterFruitNum += 1;
                    emitterFruitArray[emitterFruitNum] = _type;
                }
            }
            
            var _extraScale = clamp(((totalFruit - 10) / 40) * 1, 0, 1) * 0.8;
            dewBaseScale += 0.75;
            lightCounter = 0;
            initialized = 1;
        }
        
        var _spawnCount = ceil(spawnCount);
        
        if (((spawnCount * 2) % 2) == 0 || spawnCount >= emitterFruitNum)
        {
            var _pitch = (spawnCount / emitterFruitNum) * 16;
            playSoundFruitPress(_pitch);
        }
        
        var _particle = array_create(UnknownEnum.Value_10, 0);
        array_set(_particle, UnknownEnum.Value_0, sStarJuiceDew);
        array_set(_particle, UnknownEnum.Value_1, getFruitDewColor(emitterFruitArray[_spawnCount]));
        array_set(_particle, UnknownEnum.Value_1, getAuroraColor(spawnCount / emitterFruitNum));
        array_set(_particle, UnknownEnum.Value_2, 10 * _spawnCount);
        var _array_length = array_length(particleArray);
        array_set(_particle, UnknownEnum.Value_9, (lightCounter % 4) == 0);
        colorArray[0] = make_color_rgb(248, 45, 97);
        colorArray[1] = make_color_rgb(255, 238, 96);
        colorArray[2] = make_color_rgb(254, 66, 113);
        colorArray[3] = make_color_rgb(255, 255, 255);
        colorArray[4] = make_color_rgb(255, 238, 96);
        colorMax = 3;
        var _col = colorArray[spawnCount % (colorMax + 1)];
        array_set(_particle, UnknownEnum.Value_1, _col);
        lightCounter += 1;
        var _dewColor = array_get(_particle, UnknownEnum.Value_1);
        
        repeat (2)
        {
            with (generateEffect(x, y, "temp juice splash", 0))
                setColor = _dewColor;
        }
        
        spawnCount += 0.5;
        
        if (spawnCount <= emitterFruitNum)
        {
            myAlarm0.addToTimer(interval);
        }
        else
        {
            myAlarm0.setTimer(9999);
            array_set(_particle, UnknownEnum.Value_9, true);
        }
        
        array_push(particleArray, _particle);
    }
});
myAlarm1 = new makeAlarm(25, function()
{
    while (myAlarm1.alarmTimer <= 0)
    {
        if (totalGold <= 0)
        {
            myAlarm1.setTimer(9999);
        }
        else
        {
            var _seedx = x;
            var _seedy = y;
            instance_create_depth(_seedx, _seedy, 0, effectGoldenSeedToWallet);
            totalGold -= 1;
            myAlarm1.addToTimer(6);
        }
    }
});
