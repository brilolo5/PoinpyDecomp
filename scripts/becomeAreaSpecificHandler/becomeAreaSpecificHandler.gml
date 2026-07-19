function becomeAreaSpecificHandler(arg0)
{
    switch (-1)
    {
        case UnknownEnum.Value_1:
        case UnknownEnum.Value_2:
            fruitOffsetx = 18;
            fruitOffsety = -2;
            swayAmount = 1;
            imageSpeed = 0.058333333333333334;
            maxSpeed = 0.15;
            sprite_index = sEnFruitHandler;
            deadSprite = sHacobowDead;
            break;
        
        case UnknownEnum.Value_4:
            fruitOffsetx = -13;
            fruitOffsety = -3;
            swayAmount = -0.5;
            imageSpeed = 0.058333333333333334;
            maxSpeed = 0.15;
            sprite_index = sEnFruitHandler;
            deadSprite = sHacobowDead;
            break;
        
        case UnknownEnum.Value_3:
            fruitOffsetx = 10;
            fruitOffsety = -15;
            swayAmount = 1;
            imageSpeed = 0.058333333333333334;
            maxSpeed = 0.15;
            sprite_index = sEnFruitHandler;
            deadSprite = sHacobowDead;
            break;
        
        case UnknownEnum.Value_5:
            fruitOffsetx = 18;
            fruitOffsety = -2;
            swayAmount = 1;
            imageSpeed = 0.1;
            maxSpeed = 0.35;
            sprite_index = sEnFruitHandler;
            deadSprite = sHacobowDead;
            break;
        
        default:
            fruitOffsetx = 18;
            fruitOffsety = -2;
            swayAmount = 1;
            imageSpeed = 0.058333333333333334;
            maxSpeed = 0.15;
            sprite_index = sEnFruitHandler;
            deadSprite = sHacobowDead;
            break;
    }
}
