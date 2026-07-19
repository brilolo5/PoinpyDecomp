function generateBeastEffect(arg0)
{
    switch (arg0)
    {
        case "delicious sparkle":
            beastEffect(sBeastPart_FxSparkle00, 32, -24, 0.2, 0.1, 0, 0);
            beastEffect(sBeastPart_FxSparkle01, 40, -16, 0.2, 0.1, 0, 4);
            beastEffect(sBeastPart_FxSparkle00, -40, -4, 0.2, 0.1, 0, 5);
            beastEffect(sBeastPart_FxSparkle00, 40, 8, 0.2, 0.1, 0, 10);
            break;
        
        case "super delicious sparkle":
            var _interval = 40;
            
            for (var i = 0; i < 3; i += 1)
            {
                var _delay = _interval * i;
                beastEffect(sBeastPart_FxSparkle00, 32, -24, 0.2, 0.1, 0, 0 + _delay);
                beastEffect(sBeastPart_FxSparkle01, 40, -16, 0.2, 0.1, 0, 4 + _delay);
                beastEffect(sBeastPart_FxSparkle00, -40, -4, 0.2, 0.1, 0, 5 + _delay);
                beastEffect(sBeastPart_FxSparkle00, 40, 8, 0.2, 0.1, 0, 10 + _delay);
            }
            
            break;
        
        case "frown breath x2":
            playSoundBeastHuff();
            beastEffect(sBeastPart_FxFrownSmoke, 3, 2, 0.3, 0.1, 0, 30);
            beastEffect(sBeastPart_FxFrownSmoke, 3, 2, 0.3, 0.1, 0, 50);
            break;
        
        case "worried sweat":
            beastEffect(sBeastPart_FxSweat00, 32, 2, 0.2, 0.1, 0, 60);
            break;
    }
}
