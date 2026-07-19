function orderRatioGetListOf(arg0)
{
    var _amount = arg0;
    
    switch (_amount)
    {
        case 1:
            orderRatioAdd(1);
            break;
        
        case 2:
            orderRatioAdd(1, 1);
            orderRatioAdd(2);
            break;
        
        case 3:
            orderRatioAdd(1, 2);
            orderRatioAdd(1, 1, 1);
            break;
        
        case 4:
            orderRatioAdd(2, 2);
            orderRatioAdd(1, 1, 2);
            break;
        
        case 5:
            orderRatioAdd(1, 1, 1, 2);
            orderRatioAdd(1, 1, 3);
            orderRatioAdd(2, 2, 1);
            break;
        
        case 6:
            orderRatioAdd(1, 1, 1, 3);
            orderRatioAdd(1, 1, 2, 2);
            orderRatioAdd(1, 2, 3);
            orderRatioAdd(2, 2, 2);
            break;
        
        case 7:
            orderRatioAdd(2, 2, 3);
            orderRatioAdd(1, 2, 2, 2);
            orderRatioAdd(1, 1, 2, 3);
            break;
        
        case 8:
            orderRatioAdd(2, 3, 3);
            orderRatioAdd(2, 2, 2, 2);
            orderRatioAdd(1, 2, 2, 3);
            break;
        
        case 9:
            orderRatioAdd(3, 3, 3);
            orderRatioAdd(2, 3, 4);
            orderRatioAdd(2, 2, 2, 3);
            break;
        
        case 10:
            orderRatioAdd(3, 3, 4);
            orderRatioAdd(2, 4, 4);
            orderRatioAdd(2, 2, 2, 4);
            orderRatioAdd(1, 2, 3, 4);
            break;
        
        case 11:
            orderRatioAdd(2, 3, 3, 3);
            orderRatioAdd(1, 3, 3, 4);
            orderRatioAdd(2, 2, 3, 4);
            orderRatioAdd(2, 2, 3, 4);
            break;
        
        case 12:
            orderRatioAdd(2, 3, 3, 4);
            orderRatioAdd(2, 2, 4, 4);
            orderRatioAdd(3, 3, 3, 3);
            break;
        
        case 13:
            orderRatioAdd(3, 3, 3, 4);
            orderRatioAdd(2, 3, 4, 4);
            orderRatioAdd(1, 4, 4, 4);
            break;
        
        case 14:
            orderRatioAdd(3, 3, 4, 4);
            orderRatioAdd(2, 3, 3, 3, 3);
            orderRatioAdd(2, 2, 3, 3, 4);
            orderRatioAdd(1, 2, 3, 4, 4);
            break;
        
        case 15:
            orderRatioAdd(3, 3, 3, 3, 3);
            orderRatioAdd(2, 2, 3, 4, 4);
            orderRatioAdd(1, 2, 3, 4, 5);
            orderRatioAdd(3, 4, 4, 4);
            break;
        
        case 16:
            orderRatioAdd(3, 3, 3, 3, 4);
            orderRatioAdd(2, 3, 3, 4, 4);
            orderRatioAdd(2, 2, 3, 4, 5);
            break;
        
        case 17:
            orderRatioAdd(3, 3, 3, 4, 4);
            orderRatioAdd(2, 3, 4, 4, 4);
            orderRatioAdd(1, 4, 4, 4, 4);
            orderRatioAdd(2, 3, 3, 3, 3, 3);
            orderRatioAdd(2, 2, 3, 3, 3, 4);
            orderRatioAdd(4, 4, 4, 5);
            break;
        
        case 18:
            orderRatioAdd(2, 3, 3, 3, 3, 4);
            orderRatioAdd(3, 3, 3, 3, 3, 3);
            orderRatioAdd(3, 3, 4, 4, 4);
            break;
        
        case 19:
            orderRatioAdd(3, 3, 3, 3, 3, 4);
            orderRatioAdd(2, 3, 3, 3, 4, 4);
            orderRatioAdd(1, 2, 3, 4, 4, 5);
            break;
        
        case 20:
            orderRatioAdd(5, 5, 5, 5);
            orderRatioAdd(2, 6, 6, 6);
            orderRatioAdd(4, 4, 6, 6);
            break;
        
        case 21:
            orderRatioAdd(5, 5, 5, 6);
            orderRatioAdd(3, 6, 6, 6);
            orderRatioAdd(4, 4, 6, 7);
            break;
    }
}
