if (inPuzzleMode)
{
    drawSetAlign(0, 0);
    var _focusRectPosx = guiXToRoom(global.viewWidth / 2);
    var _focusRectPosy = guiYToRoom(global.windowMiddley);
    _focusRectPosy = guiYToRoom(global.windowTop + global.notchOffset + 64 + 12);
    var _focusSpriteScale = 0.1;
    var _focusSpriteAlpha = 0.3;
    var _focusRectSize = 80;
    var _focusRectWidth = _focusRectSize;
    var _focusRectHeight = _focusRectSize;
    var _focusRectLeft = _focusRectPosx - (_focusRectWidth / 2);
    var _focusRectTop = _focusRectPosy - (_focusRectHeight / 2);
    var _focusRectRight = _focusRectLeft + _focusRectWidth;
    var _focusRectBottom = _focusRectTop + _focusRectHeight;
    
    if (puzzleScrollMode)
    {
        puzzleBinocularAlpha = deltaLerp(puzzleBinocularAlpha, 1, 0.5);
    }
    else
    {
        puzzleBinocularAlpha = deltaLerp(puzzleBinocularAlpha, 0, 0.5);
        puzzleBinocularPupilOffset = 2;
    }
    
    puzzleBinocularPupilOffset = lerp(puzzleBinocularPupilOffset, 1, 0.2);
    _focusRectPosy = guiYToRoom(global.windowMiddley);
    var _vignetteScale = 0.2 * puzzleBinocularPupilOffset;
    draw_sprite_ext(sPuzzleViewVignette, 0, _focusRectPosx, _focusRectPosy, _vignetteScale, _vignetteScale, 0, c_white, puzzleBinocularAlpha);
    draw_sprite_ext(sPuzzleViewVignette, 0, _focusRectPosx, _focusRectPosy, _vignetteScale, -_vignetteScale, 0, c_white, puzzleBinocularAlpha);
    draw_sprite_ext(sPuzzleViewVignette, 0, _focusRectPosx, _focusRectPosy, _vignetteScale, _vignetteScale, 0, c_white, puzzleBinocularAlpha);
    draw_sprite_ext(sPuzzleViewVignette, 0, _focusRectPosx, _focusRectPosy, _vignetteScale, -_vignetteScale, 0, c_white, puzzleBinocularAlpha);
    draw_sprite_ext(sPuzzleViewVignette, 0, _focusRectPosx, _focusRectPosy, -_vignetteScale, _vignetteScale, 0, c_white, puzzleBinocularAlpha);
    draw_sprite_ext(sPuzzleViewVignette, 0, _focusRectPosx, _focusRectPosy, -_vignetteScale, -_vignetteScale, 0, c_white, puzzleBinocularAlpha);
    draw_sprite_ext(sPuzzleViewVignette, 0, _focusRectPosx, _focusRectPosy, -_vignetteScale, _vignetteScale, 0, c_white, puzzleBinocularAlpha);
    draw_sprite_ext(sPuzzleViewVignette, 0, _focusRectPosx, _focusRectPosy, -_vignetteScale, -_vignetteScale, 0, c_white, puzzleBinocularAlpha);
}

puzzleScrollUpInput = 0;
puzzleScrollDownInput = 0;
