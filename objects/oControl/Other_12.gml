debugVarTrackDraw();
debugAudioEngineDraw();

if (!isGamepadEnabled() && global.uiFingerEnabled)
{
    var _mx = device_mouse_x_to_gui(0);
    var _my = device_mouse_y_to_gui(0);
    fingerx = lerp(fingerx, _mx, 0.5);
    fingery = lerp(fingery, _my, 0.5);
    var _fingerxdif = fingerx - _mx;
    var _fingerydif = -(fingery - _my);
    var _difTotal = (_fingerxdif + _fingerydif) * 10;
    var _tiltAngle = 20;
    var _fingerAngle = clamp(_difTotal, -_tiltAngle, _tiltAngle);
    fingerAngle = lerp(fingerAngle, _fingerAngle, 0.1);
    var _fingerOffAreaExtraWidth = global.viewWidth * 0.1;
    var _fingerOffAreaLeft = global.gameSurfaceLeft - _fingerOffAreaExtraWidth;
    var _fingerOffAreaRight = global.gameSurfaceRight + _fingerOffAreaExtraWidth;
    
    if (_mx > _fingerOffAreaLeft && _mx < _fingerOffAreaRight && !getPlayerControlLock() && !global.mainGamePaused)
        fingerAlpha = lerp(fingerAlpha, 0.25, 0.2);
    else
        fingerAlpha = lerp(fingerAlpha, 1, 0.2);
    
    draw_sprite_ext(sUIFingerTest, mouse_check_button(mb_left), fingerx, fingery, 0.1, 0.1, fingerAngle, c_white, fingerAlpha);
}

with (oEndingSequence)
{
    if (sceneSkipInputCheck(0.2))
    {
        TextureManagerGoto(rmEnding);
        audio_stop_all();
        room_goto(rmEnding);
    }
}

with (oEndCredit)
{
    if (!partOfEnding || global.endingReached > UnknownEnum.Value_1)
    {
        if (sceneSkipInputCheck(0.2, 1))
            nextSequence("stop");
    }
}

with (oEnding_PostEndCutscene)
{
    if (!skipped)
    {
        if (sceneSkipInputCheck())
        {
            darkAlpha = 1;
            thankYouTextDisappearTimer = 1;
            skipped = 1;
            sceneEnd = 1;
            dreamBubbleZoomOutSequence = -1;
            
            if (audioAssetIsPlaying(sfx_ending_full))
                audio_stop_sound(sfx_ending_full);
        }
    }
}

with (oShootIntoSpace)
    skipSequence();
