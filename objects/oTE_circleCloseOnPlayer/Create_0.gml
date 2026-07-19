seqTimer = 0;
seqTimerLength = 60;
soundPlayed = 0;

if (instance_exists(oPlayer))
{
    focusPosx = roomXToGui(oPlayer.x);
    focusPosy = roomYToGui(oPlayer.y);
}
else
{
    focusPosx = global.viewWidth / 2;
    focusPosy = global.viewHeight / 2;
}

seqReverse = -1;
surf = -1;
