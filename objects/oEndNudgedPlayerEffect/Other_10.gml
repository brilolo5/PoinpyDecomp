effectSpeed = 0.009523809523809525;
effectTimer = min(effectTimer + doDelta(effectSpeed), 1);
effectTimer %= 1;
goalx = (getViewx(global.cam) + (global.viewWidth / 2)) - 32;
xpos = lerp(xstart, goalx, effectTimer);
ypos = ystart + (sin(effectTimer * pi) * -128);
imageIndex += doDelta(0.5);
xDirection = -sign((xstart - goalx) + 0.5);
draw_sprite_ext(sPlayerSpin8, imageIndex, xpos, ypos, xscale * xDirection, yscale, imageAngle, c_white, 1);

if (effectTimer >= 0.9)
{
    with (oEndingSequence)
    {
        playerOnBeast = 1;
        beastFaceStateChange("end catch player");
    }
    
    instance_destroy();
}
