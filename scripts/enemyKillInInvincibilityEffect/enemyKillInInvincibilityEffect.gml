function enemyKillInInvincibilityEffect(arg0)
{
    addHitStop(12);
    screenShake(3, 3);
    var _inbetweenx = lerp(oPlayer.x, arg0.x, 0.5);
    var _inbetweeny = lerp(oPlayer.y, arg0.y, 0.5);
    generateEffect(_inbetweenx, _inbetweeny, "enemy death smoke", 0);
    generateEffect(_inbetweenx, _inbetweeny, "stomp impact flash", 0);
}
