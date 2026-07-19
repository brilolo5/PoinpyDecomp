pauseDrawSurface();
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_colour(c_white);
uiDraw("results root");

if (kill)
{
    playerControlLockTimer(240);
    global.jumpTimes = global.jumpTimesMax;
    instance_destroy();
    pauseEnd();
    exit;
}
