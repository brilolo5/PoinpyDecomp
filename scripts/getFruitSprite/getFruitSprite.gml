function getFruitSprite(arg0)
{
    var _fruitIndex = arg0;
    var _fruitSprite = sFruitApple;
    
    switch (_fruitIndex)
    {
        case UnknownEnum.Value_0:
            _fruitSprite = sFruitApple;
            break;
        
        case UnknownEnum.Value_1:
            _fruitSprite = sFruitCherry;
            break;
        
        case UnknownEnum.Value_2:
            _fruitSprite = sFruitStrawberry;
            break;
        
        case UnknownEnum.Value_3:
            _fruitSprite = sFruitTomato;
            break;
        
        case UnknownEnum.Value_4:
            _fruitSprite = sFruitLemon;
            break;
        
        case UnknownEnum.Value_5:
            _fruitSprite = sFruitBanana;
            break;
        
        case UnknownEnum.Value_6:
            _fruitSprite = sFruitBuntan;
            break;
        
        case UnknownEnum.Value_7:
            _fruitSprite = sFruitCorn;
            break;
        
        case UnknownEnum.Value_8:
            _fruitSprite = sFruitWatermelon;
            break;
        
        case UnknownEnum.Value_10:
            _fruitSprite = sFruitKiwi;
            break;
        
        case UnknownEnum.Value_9:
            _fruitSprite = sFruitMelon;
            break;
        
        case UnknownEnum.Value_11:
            _fruitSprite = sFruitLettuce;
            break;
        
        case UnknownEnum.Value_12:
            _fruitSprite = sFruitMangosteen;
            break;
        
        case UnknownEnum.Value_14:
            _fruitSprite = sFruitBlueberry;
            break;
        
        case UnknownEnum.Value_13:
            _fruitSprite = sFruitGrape;
            break;
        
        case UnknownEnum.Value_15:
            _fruitSprite = sFruitEggplant;
            break;
        
        case UnknownEnum.Value_16:
            _fruitSprite = sFruitBlueRed;
            break;
        
        case UnknownEnum.Value_17:
            _fruitSprite = sFruitYellowGreen;
            break;
        
        case UnknownEnum.Value_20:
            _fruitSprite = sFruitBloodGourd;
            break;
        
        case UnknownEnum.Value_19:
            _fruitSprite = sFruitYellowWatermelon;
            break;
        
        case UnknownEnum.Value_18:
            _fruitSprite = sFruitBlueApple;
            break;
        
        case UnknownEnum.Value_24:
            _fruitSprite = sFruitMushroom;
            break;
        
        case UnknownEnum.Value_32:
            _fruitSprite = sStarFruit_00;
            break;
        
        case UnknownEnum.Value_33:
            _fruitSprite = sStarFruit_01;
            break;
        
        case UnknownEnum.Value_34:
            _fruitSprite = sStarFruit_02;
            break;
        
        case UnknownEnum.Value_35:
            _fruitSprite = sStarFruit_03;
            break;
        
        case UnknownEnum.Value_36:
            _fruitSprite = sStarFruit_04;
            break;
        
        case UnknownEnum.Value_37:
            _fruitSprite = sStarFruit_05;
            break;
        
        default:
            _fruitSprite = sFruitApple;
            break;
    }
    
    return _fruitSprite;
}
