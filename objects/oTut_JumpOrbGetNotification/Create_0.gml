pauseStart();
instance_deactivate_all(true);
instance_activate_object(oControl);
instance_activate_object(oDraw);
playSoundJumpOrbAcquired();
audio_pause_sound(audioGetAsset(global.areaMusic));
kill = 0;

with (uiCreate("results root"))
{
    eventAddFunction(UnknownEnum.Value_0, function()
    {
        setLTRBToWindow();
    });
    uiTemplateRectangle(make_color_rgb(46, 50, 59), 0);
    inTweenTime = 0;
    delayTime = 90;
    eventAddFunction(UnknownEnum.Value_1, function()
    {
        if (getVisible())
        {
            if (inTweenTime < 1)
            {
                inTweenTime = min(inTweenTime + doDelta(0.08), 1);
                visAlpha = 0.7 * inTweenTime;
            }
            
            delayTime = max(0, delayTime - doDelta(1));
        }
        
        if (mouse_check_button_released(mb_left) && (inTweenTime >= 1 && delayTime <= 0))
            rootInstance.kill = 1;
    });
    eventAddFunction(UnknownEnum.Value_5, function()
    {
    });
    eventAddFunction(UnknownEnum.Value_10, function()
    {
    });
    updateShape();
    
    with (newChild())
    {
        setActive(false);
        setChildrenActive(false);
        setX(getParent().getShapeWidth() / 2);
        setY((getParent().getShapeHeight() / 2) - 10);
        setWidth(min(getParent().getShapeWidth(), getParent().getShapeHeight()));
        setHeight(getRawWidth());
        eventAddFunction(UnknownEnum.Value_2, function()
        {
            var _tweenTime = getParent().inTweenTime;
            var _scale = (animcurve_tween(0, 1, curveBackInv, _tweenTime) * (outVisWidth + 20)) / 1506;
            drawRainbowSplash(outVisXCenter, outVisYCenter, _scale, current_time);
            draw_sprite_ext(sResultsRewardTutorial, 0, outVisXCenter, outVisYCenter, 0.25 * _tweenTime, 0.25 * _tweenTime, 0, c_white, 1);
            var _rewardText = getRewardText(UnknownEnum.Value_0);
            var _textElement = scribble(_rewardText).starting_format(locGetFontFromLanguage(), make_color_rgb(46, 50, 59)).align(1, 0);
            var _width = _textElement.get_width();
            _scale = (outVisWidth - 50) / _width;
            _scale = min(0.5, _scale);
            _textElement.transform(_scale, _scale, 0);
            var _bbox = _textElement.get_bbox(outVisXCenter, outVisYCenter + 38, 14, 2, 14, 2);
            drawPillWithOutline(_bbox.left, _bbox.top, _bbox.right, _bbox.bottom, make_color_rgb(255, 233, 1), make_color_rgb(46, 50, 59), _tweenTime);
            _textElement.blend(16777215, _tweenTime).draw(outVisXCenter, outVisYCenter + 38);
        });
    }
}
