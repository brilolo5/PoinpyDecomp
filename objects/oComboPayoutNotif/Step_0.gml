y = lerp(y, ystart + textGoal_y, 0.1);

if (round(y) == round(ystart + textGoal_y))
{
    if (bonusTextTimer && !--bonusTextTimer)
    {
        destroyTimer += 10;
        
        if (bonusScore > 0)
        {
            var _bonusText = bonusScore;
            _bonusText = "+¢" + string(_bonusText);
            myBonusText = instance_create_depth(x, y + 12 + 10 + 16, -10000, oTextFloat);
            
            with (myBonusText)
            {
                bonusPink = make_color_rgb(241, 110, 170);
                mainColor = bonusPink;
                subColor = make_color_rgb(46, 50, 59);
                text = _bonusText;
                textGoal_y = -16;
            }
        }
    }
    
    if (destroyTimer && !--destroyTimer)
    {
        if (instance_exists(myBonusText))
        {
            with (myBonusText)
                instance_destroy();
        }
        
        instance_destroy();
    }
}
