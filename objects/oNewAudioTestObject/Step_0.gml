if (mouse_check_button_pressed(mb_right))
{
    var _sfx = playSfxWorld(sfx_player_slam_tail_02, false, true);
    audioSetSlowmo(_sfx);
    audioSetDuck(_sfx);
    audioSetInViewOnly(_sfx, x, y);
}
