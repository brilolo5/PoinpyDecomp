function uiTemplateDebugButton_puzzleSelect(arg0, arg1, arg2)
{
    buttonIndex = arg0;
    uiTemplateRectangle(make_color_rgb(218, 221, 226), 0.6);
    eventAddFunction(UnknownEnum.Value_4, function()
    {
        visBlend = make_color_rgb(255, 255, 255);
        callEventInChildren();
    });
    eventAddFunction(UnknownEnum.Value_6, function()
    {
        visBlend = make_color_rgb(218, 221, 226);
        callEventInChildren();
    });
    eventAddFunction(UnknownEnum.Value_8, function()
    {
        callEventInChildren();
    });
    eventAddFunction(UnknownEnum.Value_10, function()
    {
        callEventInChildren();
        
        switch (buttonIndex)
        {
            case puzzleListSize:
                instance_destroy(rootInstance);
                break;
            
            default:
                var _areaIndexDiv = (buttonIndex div 5) + 1;
                var _levelIndexModulo = buttonIndex % 5;
                global.puzzleCurrentTheme = _areaIndexDiv;
                global.puzzleCurrentIndex = _levelIndexModulo;
                var _targetRoom = global.puzzleRoomList[global.puzzleCurrentTheme][global.puzzleCurrentIndex];
                
                if (puzzleDataUnlockedGet(_areaIndexDiv, _levelIndexModulo))
                {
                    if (_targetRoom != -1)
                    {
                        roomTransitionTo(_targetRoom, "");
                        instance_destroy(rootInstance);
                    }
                }
        }
    });
    
    with (newChild())
    {
        setActive(false);
        setLeft(4);
        uiTemplateTextScaled(arg1, arg2);
        eventAddFunction(UnknownEnum.Value_2, function()
        {
            drawTextOutlined(outVisLeft, outVisTop, text, visBlend, make_color_rgb(46, 50, 59), 0, textSize);
        });
        eventAddFunction(UnknownEnum.Value_4, function()
        {
            visBlend = make_color_rgb(255, 238, 96);
        });
        eventAddFunction(UnknownEnum.Value_6, function()
        {
            visBlend = make_color_rgb(255, 255, 255);
            visXOffset = 0;
            visYOffset = 0;
        });
        eventAddFunction(UnknownEnum.Value_8, function()
        {
            visBlend = make_color_rgb(248, 45, 97);
            visXOffset = -2;
            visYOffset = -2;
        });
        eventAddFunction(UnknownEnum.Value_10, function()
        {
            visBlend = make_color_rgb(255, 238, 96);
            visXOffset = 0;
            visYOffset = 0;
        });
    }
}

function uiTemplateDebugButton_trophyRough(arg0, arg1, arg2)
{
    buttonIndex = arg0;
    uiTemplateRectangle(make_color_rgb(218, 221, 226), 0.6);
    eventAddFunction(UnknownEnum.Value_4, function()
    {
        visBlend = make_color_rgb(255, 255, 255);
        callEventInChildren();
    });
    eventAddFunction(UnknownEnum.Value_6, function()
    {
        visBlend = make_color_rgb(218, 221, 226);
        callEventInChildren();
    });
    eventAddFunction(UnknownEnum.Value_8, function()
    {
        callEventInChildren();
    });
    eventAddFunction(UnknownEnum.Value_10, function()
    {
        callEventInChildren();
        
        switch (buttonIndex)
        {
            case trophyListSize:
                instance_destroy(rootInstance);
                break;
            
            default:
                break;
        }
    });
    
    with (newChild())
    {
        setActive(false);
        setLeft(4);
        eventAddFunction(UnknownEnum.Value_2, function()
        {
            drawTextOutlined(getDrawLeft(), getDrawTop(), text, visBlend, make_color_rgb(46, 50, 59), 0, textSize);
        });
        eventAddFunction(UnknownEnum.Value_4, function()
        {
            visBlend = make_color_rgb(255, 238, 96);
        });
        eventAddFunction(UnknownEnum.Value_6, function()
        {
            visBlend = make_color_rgb(255, 255, 255);
            visXOffset = 0;
            visYOffset = 0;
        });
        eventAddFunction(UnknownEnum.Value_8, function()
        {
            visBlend = make_color_rgb(248, 45, 97);
            visXOffset = -2;
            visYOffset = -2;
        });
        eventAddFunction(UnknownEnum.Value_10, function()
        {
            visBlend = make_color_rgb(255, 238, 96);
            visXOffset = 0;
            visYOffset = 0;
        });
    }
}
