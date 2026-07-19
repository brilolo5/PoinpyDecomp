if (!fruitSet)
{
    if ((getViewy(global.cam) - 16) < y)
    {
        var _goldSeedCountThreshold = 7;
        
        if (global.currentLevelChunkSet == UnknownEnum.Value_6)
            _goldSeedCountThreshold = 1;
        
        global.goldSeedAppearCount += 1;
        
        if (global.goldSeedAppearCount > _goldSeedCountThreshold)
        {
            golden = 1;
            global.goldSeedAppearCount = choose(0, 0, 0, 1, 2);
        }
        
        fruitType = fruitGetRandomFromCycle();
        sprIndex = getFruitSprite(fruitType);
        mask_index = sColorBall;
        fruitSet = 1;
        
        if (abilityCheck(UnknownEnum.Value_14) && random(15) <= 1)
        {
            golden = 0;
            var _xOffset = -10;
            var _yOffset = 3;
            var _twinx = x + (_xOffset / 2);
            var _twiny = y + (_yOffset / 2);
            var _myTwin = instance_create_depth(_twinx, _twiny, 0, oFruit);
            _myTwin.fruitType = fruitType;
            _myTwin.sprIndex = sprIndex;
            _myTwin.fruitSet = 1;
            _myTwin.golden = golden;
            _myTwin.mask_index = mask_index;
            x -= (_xOffset / 2);
            y -= (_yOffset / 2);
        }
        
        if (global.finalStretchSequence == UnknownEnum.Value_1 || global.finalStretchSequence == UnknownEnum.Value_2)
            instance_destroy();
    }
}
