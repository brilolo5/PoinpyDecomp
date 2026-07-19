function getMoneyWithAnimation(arg0)
{
    global.moneyJar += arg0;
    
    with (oControl)
    {
        moneyAmountCountUpDelay = 60;
        walletUIappearTime = 240;
        walletWobble = 1;
        walletChange(arg0);
    }
}

function shownMoneyAmountUpdate(arg0 = infinity)
{
    with (oControl)
        shownMoneyAmount = approach(shownMoneyAmount, global.moneyJar, arg0);
}
