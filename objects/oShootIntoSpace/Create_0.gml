if (live_call())
    return global.live_result;

playerControlLock();
magmaParticleSpawnTimer = 0;
sequenceIndex = "initial pause";
sequenceTimer = 0;
sequenceInit = 1;
magmaOffset = 160;
magmaTide = 0;
scrollSpeed = 0;
scrollSpeedDefault = 28;
startSlowingDown = 0;
skipHold = 0;
drawFakeWall = 1;

sequenceInitialize = function()
{
    if (sequenceInit)
    {
        sequenceInit = 0;
        return true;
    }
    else
    {
        return false;
    }
};

shadeAlpha = 0;

stopSequenceSounds = function()
{
    audio_stop_sound(sfx_magmaBurstSequence_rumble_lp);
    audio_stop_sound(sfx_magmaBurstSequence_burst_V5);
    audio_stop_sound(sfx_ending_magmaStarV2_01);
    audio_stop_sound(sfx_ending_magmaStarV2_02);
    audio_stop_sound(sfx_ending_magmaStarV2_03);
    audio_stop_sound(sfx_beast_mouth_open);
    audio_stop_sound(sfx_beast_mouth_close);
    audio_stop_sound(sfx_ending_beast_delicious_sparkle);
    audio_stop_sound(sfx_beast_mouth_chew);
};

skipSequence = function()
{
    if ((global.finalMixReached && skipHold < 1) || global.debugControl)
    {
        if (!(sequenceIndex == "launch - end?") && !(sequenceIndex == "final area entered"))
        {
            if (mouse_check_button_pressed(mb_left))
                skipHold = 0;
            
            if (mouse_check_button(mb_left) && skipHold >= 0)
            {
                var _mx = device_mouse_x_to_gui(0);
                var _my = device_mouse_y_to_gui(0) - 16 - 8;
                skipHold = approach(skipHold, 1, doDelta(0.013333333333333334));
                var _pieMax = 1;
                var _pieValue = skipHold;
                var _pieAngle = (_pieValue / _pieMax) * -360;
                var _pieRadius = 12;
                draw_set_color(make_color_rgb(46, 50, 59));
                draw_circle(_mx - (1 * (os_type == os_windows)), _my - (1 * (os_type == os_windows)), _pieRadius + 1, 0);
                drawPie(_mx, _my, _pieValue, _pieMax, make_color_rgb(255, 255, 255), _pieRadius, 1, _pieAngle + 90);
                draw_set_color(make_color_rgb(46, 50, 59));
                draw_circle(_mx - (1 * (os_type == os_windows)), _my - (1 * (os_type == os_windows)), _pieRadius / 2, 0);
                drawSetAlign(1, 2);
                drawTextOutlined(_mx, _my - _pieRadius, loc("ending skip UI"), make_color_rgb(255, 255, 255), make_color_rgb(46, 50, 59), 0, 0.6);
            }
            else
            {
                skipHold = -1;
            }
            
            if (skipHold >= 1)
            {
                stopSequenceSounds();
                
                if (!instance_exists(oMagma))
                    instance_create_depth(x, y, 0, oMagma);
                
                with (oGameBackground)
                    bgArea = UnknownEnum.Value_6;
                
                shadeAlpha = 0;
                oPlayer.currentState = "shot into space";
                oDraw.wallGlow = 1;
                sequenceIndex = "launch - end?";
                sequenceTimer = 0;
                sequenceInit = 1;
                beastGameStateChange("waiting");
            }
        }
    }
};

drawFakeSideWall = function()
{
    if (drawFakeWall)
    {
        draw_sprite_ext(sLevelTile00, 15, 0, getViewy() + (global.viewHeight / 2), 0.1, 3, 0, c_white, 1);
        draw_sprite_ext(sLevelTile00, 15, 160, getViewy() + (global.viewHeight / 2), 0.1, 3, 0, c_white, 1);
    }
};
