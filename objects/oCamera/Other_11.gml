if (live_call())
    return global.live_result;

inPuzzleMode = global.gameReinitializeState == "puzzle" && !puzzleStarted && scrollButtonActive;

if (inPuzzleMode)
{
    drawSetAlign(1, 1);
    var _puzzleScrollButtonWidth = 24;
    var _puzzleScrollButtonHeight = 24;
    var _puzzleScrollButtonSpaceInbetween = 6;
    var _slingPulled = instance_exists(oPlayer) && oPlayer.slingPulled;
    var _scrollButtonAlpha = 0.75;
    
    if (_slingPulled)
        _scrollButtonAlpha = 0.25;
    
    var _puzScrollButtonDownPosx = global.windowLeft + _puzzleScrollButtonWidth + 1;
    var _puzScrollButtonDownPosy = global.windowBottom - _puzzleScrollButtonHeight - 2;
    var _puzScrollButtonDownColor = make_color_rgb(36, 145, 249);
    var _psbdLeft = _puzScrollButtonDownPosx - (_puzzleScrollButtonWidth / 2);
    var _psbdRight = _puzScrollButtonDownPosx + (_puzzleScrollButtonWidth / 2);
    var _psbdTop = _puzScrollButtonDownPosy - (_puzzleScrollButtonHeight / 2);
    var _psbdBottom = _puzScrollButtonDownPosy + (_puzzleScrollButtonHeight / 2);
    var _puzScrollButtonUpPosx = _puzScrollButtonDownPosx;
    var _puzScrollButtonUpPosy = _puzScrollButtonDownPosy - _puzzleScrollButtonHeight - _puzzleScrollButtonSpaceInbetween;
    var _puzScrollButtonUpColor = make_color_rgb(36, 145, 249);
    var _psbuLeft = _puzScrollButtonUpPosx - (_puzzleScrollButtonWidth / 2);
    var _psbuRight = _puzScrollButtonUpPosx + (_puzzleScrollButtonWidth / 2);
    var _psbuTop = _puzScrollButtonUpPosy - (_puzzleScrollButtonHeight / 2);
    var _psbuBottom = _puzScrollButtonUpPosy + (_puzzleScrollButtonHeight / 2);
    mousex = device_mouse_x_to_gui(0);
    mousey = device_mouse_y_to_gui(0);
    
    if (mouse_check_button(mb_left) && !_slingPulled)
    {
        var _puzzleInput = 0;
        
        if (inRange(mousex, _puzScrollButtonDownPosx, _puzzleScrollButtonWidth / 2) && inRange(mousey, _puzScrollButtonDownPosy, _puzzleScrollButtonHeight / 2))
        {
            puzzleScrollDownInput = 1;
            puzzleScrollInputPressed = mouse_check_button_pressed(mb_left);
            _puzScrollButtonDownPosy += 2;
            _puzScrollButtonDownColor = make_color_rgb(65, 162, 255);
            _puzzleInput = 1;
        }
        else if (inRange(mousex, _puzScrollButtonUpPosx, _puzzleScrollButtonWidth / 2) && inRange(mousey, _puzScrollButtonUpPosy, _puzzleScrollButtonHeight / 2))
        {
            puzzleScrollUpInput = 1;
            puzzleScrollInputPressed = mouse_check_button_pressed(mb_left);
            _puzScrollButtonUpPosy += 2;
            _puzScrollButtonUpColor = make_color_rgb(65, 162, 255);
            _puzzleInput = 1;
        }
        else if (mouse_check_button_pressed(mb_left) && puzzleScrollMode)
        {
            puzzleScrollExit = 1;
        }
        
        if (_puzzleInput)
        {
        }
    }
    
    var _cameraArrowScale = 0.2;
    var _cameraArrowAlpha = 0.5;
    draw_sprite_ext(sPuzzleCameraArrow, 0, _puzScrollButtonDownPosx, _puzScrollButtonDownPosy, _cameraArrowScale, -_cameraArrowScale, 0, c_white, _cameraArrowAlpha);
    draw_sprite_ext(sPuzzleCameraArrow, 0, _puzScrollButtonUpPosx, _puzScrollButtonUpPosy, _cameraArrowScale, _cameraArrowScale, 0, c_white, _cameraArrowAlpha);
    
    if (global.playerControlLock)
        drawSetAlign(0, 0);
    
    if (instance_exists(oPlayer))
    {
        if (oPlayer.currentState != "ground - puzzle prepare")
        {
            puzzleStarted = 1;
            
            with (oMagma)
                puzzleModeInitialPause = 0;
        }
        
        oPlayer.staticHoldCharge = global.staticHoldChargeMax;
    }
}
else if (puzzleStarted)
{
    with (oMagma)
        puzzleModeInitialPause = 0;
}
