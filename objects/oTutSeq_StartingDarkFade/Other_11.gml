var _screenLeft = 0;
var _screenRight = window_get_width();
var _screenTop = 0;
var _screenBottom = window_get_height();
var _forceSkip = mouse_check_button_pressed(mb_right);

if (_forceSkip && global.debugControl)
    nextSequence("end sequence");

function nextSequence(arg0)
{
    currentSequence = arg0;
    sequenceTimer = 0;
}

switch (currentSequence)
{
    case "dark":
        draw_set_color(c_black);
        draw_set_alpha(1);
        draw_rectangle(_screenLeft, _screenTop, _screenRight, _screenBottom, 0);
        sequenceTimer += doDelta(1);
        
        if (sequenceTimer >= 20 || _forceSkip)
            nextSequence("dark fade");
        
        playerControlLockTimer(10);
        break;
    
    case "dark fade":
        darkAlpha = approach(darkAlpha, 0, doDelta(0.004166666666666667));
        var _darkFrames = 4;
        var _darkAlpha = round(darkAlpha * _darkFrames) / _darkFrames;
        alphaTween = deltaLerp(alphaTween, _darkAlpha, 0.75);
        draw_set_color(c_black);
        draw_set_alpha(alphaTween);
        draw_rectangle(_screenLeft, _screenTop, _screenRight, _screenBottom, 0);
        draw_set_alpha(1);
        
        if (alphaTween <= 0.01 || _forceSkip)
        {
            nextSequence("end sequence");
            guide = 
            {
                x: global.windowCenterx,
                y: global.windowMiddley - (global.windowMiddley / 2),
                scale: 0.15000000000000002,
                alpha: 0,
                frame: 0
            };
        }
        
        playerControlLockTimer(10);
        break;
    
    case "swipe guide":
        guide.alpha = deltaLerp(guide.alpha, 1, 0.025);
        
        if (guide.alpha > 0.95)
            guide.frame += doDelta(0.175);
        
        var _guidey = guide.y + (-8 * guide.alpha);
        draw_sprite_ext(sTutorialFingerSwipeBlue, guide.frame, guide.x, _guidey, guide.scale, guide.scale, 0, c_white, guide.alpha);
        scribble("Swipe to jump").starting_format("default", make_color_rgb(255, 255, 255)).blend(make_color_rgb(255, 255, 255), guide.alpha).msdf_border(make_color_rgb(46, 50, 59), 3).transform(0.4, 0.4, 0).align(1, 1).draw(guide.x, _guidey + 32 + 8);
        var _guideStop = 0;
        
        with (oPlayer)
        {
            if (place_meeting(x, y, oTutorialGuideStopArea))
                _guideStop = 1;
        }
        
        if (_guideStop)
            nextSequence("end sequence");
        
        break;
    
    case "fade":
    case "end sequence":
        global.areaMusic = playMusicUI(music_tutorial, true, true);
        playerControlLockTimer(10);
        instance_create_depth(x, y, depth, oTutSeq_SwipeToJump);
        instance_destroy();
        break;
}
