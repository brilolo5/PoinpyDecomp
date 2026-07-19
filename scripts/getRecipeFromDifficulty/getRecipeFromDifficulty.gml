function getRecipeFromDifficulty(arg0, arg1)
{
    switch (arg0)
    {
        case 0:
            getFruitList(arg1, "apples_2");
            orderRatioAdd(1);
            orderRatioAdd(1);
            break;
        
        case 1:
            getFruitList(arg1, "apples_2");
            orderRatioAdd(1);
            orderRatioAdd(1);
            break;
        
        case 2:
            getFruitList(arg1, "apples_2");
            orderRatioAdd(1, 1);
            orderRatioAdd(2);
            break;
        
        case 3:
            getFruitList(arg1, "apples_3");
            orderRatioAdd(1, 2);
            orderRatioAdd(1, 1, 1);
            break;
        
        case 4:
            getFruitList(arg1, "apples_3");
            orderRatioAdd(2, 2);
            orderRatioAdd(1, 1, 2);
            orderRatioAdd(orFiller(5));
            break;
        
        case 5:
            getFruitList(arg1, "apples_3");
            orderRatioAdd(1, 2, 2);
            orderRatioAdd(1, 3);
            orderRatioAdd(2, orFiller(4));
            break;
        
        case 6:
            getFruitList(arg1, "cherries_4");
            orderRatioAdd(1, 2, 2);
            orderRatioAdd(1, 1, 2, 2);
            orderRatioAdd(1, 2, orFiller(3));
            orderRatioAdd(1, 2, orBanned(1));
            break;
        
        case 7:
            getFruitList(arg1, "cherries_4");
            orderRatioAdd(1, 1, 2, 2);
            orderRatioAdd(2, orFiller(5));
            orderRatioAdd(1, 1, 2, orFiller(3));
            orderRatioAdd(1, 2, orBanned(1));
            break;
        
        case 8:
            getFruitList(arg1, "cherries_4");
            orderRatioAdd(1, 2, 2, 2);
            orderRatioAdd(3);
            orderRatioAdd(1, 1, 2, orFiller(3));
            orderRatioAdd(2, 2, orBanned(1));
            break;
        
        case 9:
            getFruitList(arg1, "cherries_5");
            orderRatioAdd(1, 1, 1, orFiller(6));
            orderRatioAdd(2, 2, 2, orFiller(2));
            orderRatioAdd(1, 3);
            orderRatioAdd(orFiller(6), orBanned(1));
            break;
        
        case 10:
            getFruitList(arg1, "cherries_5");
            orderRatioAdd(1, 2, 2, orFiller(4));
            orderRatioAdd(3, orFiller(3));
            orderRatioAdd(orFiller(10));
            orderRatioAdd(orFiller(8), orBanned(1));
            break;
        
        case 11:
            getFruitList(arg1, "cherries_5");
            orderRatioAdd(1, 2, 2, orFiller(5));
            orderRatioAdd(3, orFiller(4));
            orderRatioAdd(1, 1, 3);
            orderRatioAdd(2, orFiller(5), orBanned(1));
            break;
        
        case 12:
            getFruitList(arg1, "veggies_6");
            orderRatioAdd(1, 2, 2, orFiller(6));
            orderRatioAdd(2, 3, orFiller(4));
            orderRatioAdd(2, 2, 2, 2);
            orderRatioAdd(2, 2, 2, orBanned(1));
            break;
        
        case 13:
            getFruitList(arg1, "veggies_6");
            orderRatioAdd(4, orFiller(6));
            orderRatioAdd(2, 3, orFiller(5));
            orderRatioAdd(2, 2, 3);
            orderRatioAdd(2, 2, 2, orBanned(2));
            orderRatioAdd(2, orFiller(6), orBanned(2));
            break;
        
        case 14:
            getFruitList(arg1, "veggies_6");
            orderRatioAdd(4, orFiller(7));
            orderRatioAdd(3, 3, orFiller(5));
            orderRatioAdd(2, 2, 3, orBanned(2));
            orderRatioAdd(3, orFiller(6), orBanned(2));
            break;
        
        case 15:
            getFruitList(arg1, "veggies_7");
            orderRatioAdd(2, 3, 4);
            orderRatioAdd(3, 3, orFiller(7));
            orderRatioAdd(2, 2, 2, orFiller(8));
            orderRatioAdd(3, 3, orBanned(2));
            orderRatioAdd(2, 2, orFiller(6), orBanned(2));
            break;
        
        case 16:
            getFruitList(arg1, "veggies_7");
            orderRatioAdd(1, 2, 3, 4);
            orderRatioAdd(2, 3, 3, orFiller(10));
            orderRatioAdd(3, 4, orBanned(2));
            orderRatioAdd(2, 3, orFiller(4), orBanned(2));
            break;
        
        case 17:
            getFruitList(arg1, "veggies_7");
            orderRatioAdd(2, 3, 4, orFiller(5));
            orderRatioAdd(3, 3, 3);
            orderRatioAdd(2, 3, 4, orBanned(2));
            orderRatioAdd(3, 3, orFiller(4), orBanned(2));
            break;
        
        case 18:
            getFruitList(arg1, "veggies_8");
            orderRatioAdd(2, 3, 4, orFiller(5));
            orderRatioAdd(3, 3, 3);
            orderRatioAdd(2, 3, 4, orBanned(2));
            orderRatioAdd(3, 3, orFiller(4), orBanned(2));
            break;
        
        case 19:
            getFruitList(arg1, "veggies_8");
            orderRatioAdd(2, 3, 4, orFiller(7));
            orderRatioAdd(3, 3, 3, orFiller(3));
            orderRatioAdd(2, 3, 4, orBanned(3));
            orderRatioAdd(3, 3, orFiller(6), orBanned(2));
            break;
        
        case 20:
        case 21:
        case 22:
        case 23:
        case 24:
        case 25:
        case 26:
        case 27:
        case 28:
        case 29:
        default:
            var _bunchAmount = round(arg0);
            getFruitList(arg1, "apples_9");
            orderRatioAdd(4, 4, 4, orFiller(_bunchAmount));
            orderRatioAdd(5, 7, orFiller(_bunchAmount));
            orderRatioAdd(3, 4, 5, orFiller(_bunchAmount));
            break;
    }
}

function getRecipeFromDifficultyForFinalArea(arg0, arg1)
{
    switch (arg0)
    {
        case 20:
            getFruitList(arg1, "stars_4");
            orderRatioAdd(3, 3);
            orderRatioAdd(1, 2, 3);
            orderRatioAdd(5);
            break;
        
        case 21:
            getFruitList(arg1, "stars_4");
            orderRatioAdd(3, 3, orBanned(1));
            orderRatioAdd(1, 2, 3, orBanned(1));
            break;
        
        case 22:
            getFruitList(arg1, "stars_5");
            orderRatioAdd(3, 3, 3, orBanned(2));
            orderRatioAdd(2, 3, 4, orBanned(2));
            orderRatioAdd(3, 5, orBanned(2));
            break;
        
        case 23:
            getFruitList(arg1, "stars_5");
            orderRatioAdd(2, 3, 4, 5, orBanned(1));
            orderRatioAdd(3, 3, 4, 4, orBanned(1));
            break;
        
        case 24:
            getFruitList(arg1, "stars_5");
            orderRatioAdd(5, 5, 5, orBanned(2));
            orderRatioAdd(4, 4, 4, 4, orBanned(1));
            break;
        
        case 25:
            getFruitList(arg1, "stars_6");
            orderRatioAdd(5, 5, 6, orBanned(2));
            orderRatioAdd(4, 4, 4, 5, orBanned(2));
            break;
        
        default:
            getFruitList(arg1, "stars_7");
            orderRatioAdd(3, 3, 4, 4, orBanned(3));
            orderRatioAdd(2, 3, 4, 5, orBanned(3));
            orderRatioAdd(5, 5, orBanned(3));
            break;
    }
}
