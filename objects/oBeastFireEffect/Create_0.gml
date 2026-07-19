effectProgress = 0;
effectDuration = 90;
imageIndex = 0;
screenShake(4, 12);
playSoundBeastFlames();
myAlarm0 = new makeAlarm(7, function()
{
    if (!oPlayer.damageInvincibility)
        playerDamage(oPlayer);
});
