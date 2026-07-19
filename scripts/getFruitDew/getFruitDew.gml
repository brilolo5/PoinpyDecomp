function getFruitDew(arg0)
{
    var _fruitIndex = arg0;
    var _fruitSprite = sFruitDewWhite;
    return _fruitSprite;
}

function getFruitDewColor(arg0)
{
    var _fruitIndex = arg0;
    var _fruitSprite = make_color_rgb(248, 45, 97);
    
    switch (_fruitIndex)
    {
        case UnknownEnum.Value_0:
        case UnknownEnum.Value_1:
        case UnknownEnum.Value_2:
        case UnknownEnum.Value_3:
            _fruitSprite = make_color_rgb(248, 45, 97);
            break;
        
        case UnknownEnum.Value_4:
        case UnknownEnum.Value_5:
        case UnknownEnum.Value_6:
        case UnknownEnum.Value_7:
            _fruitSprite = make_color_rgb(225, 223, 1);
            break;
        
        case UnknownEnum.Value_8:
        case UnknownEnum.Value_10:
        case UnknownEnum.Value_9:
        case UnknownEnum.Value_11:
            _fruitSprite = make_color_rgb(65, 231, 125);
            break;
        
        case UnknownEnum.Value_12:
        case UnknownEnum.Value_14:
        case UnknownEnum.Value_13:
        case UnknownEnum.Value_15:
            _fruitSprite = make_color_rgb(36, 145, 249);
            break;
        
        default:
            _fruitSprite = make_color_rgb(248, 45, 97);
            break;
    }
    
    return _fruitSprite;
}
