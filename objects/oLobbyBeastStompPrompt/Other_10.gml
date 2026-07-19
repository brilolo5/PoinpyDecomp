if (global.tutorialOver)
{
    timer += doDelta(1);
    var _timerThreshold = 720;
    
    if (timer >= _timerThreshold)
    {
        if (inRange(oPlayer.x, x, 16) && inRange(oPlayer.y, y, 32))
            isVisible = lerp(isVisible, 0.25, 0.2);
        else
            isVisible = lerp(isVisible, 1, 0.05);
    }
    else if (oCamera.playerHorizontalFrameNum != 0)
    {
        timer = clamp(timer, 0, _timerThreshold - 45);
    }
}

var _beastHeady = 0;
offset_y = sin(global.timeScaledTime / 10) * 1;

if (instance_exists(oBeastInLobby))
    _beastHeady = ((oBeastInLobby.y + oBeastInLobby.cy) - 32 - 14) + offset_y;

var _playerScale = 0.1;
draw_sprite_ext(sLobbyBeastStompPrompt_Player, 0, x, _beastHeady - 16 - 2, _playerScale, _playerScale, 0, c_white, isVisible * 0.7);
draw_sprite_ext(sprite_index, imageIndex, x, _beastHeady, image_xscale, image_yscale, 0, c_white, isVisible);
