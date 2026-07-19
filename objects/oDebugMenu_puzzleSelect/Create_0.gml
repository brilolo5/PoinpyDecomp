global.mainGamePaused = 1;
printScreen = surface_create_track(surface_get_width(application_surface), surface_get_height(application_surface));
surface_copy(printScreen, 0, 0, application_surface);
instance_deactivate_all(1);
instance_activate_object(oControl);
puzzleListSize = (array_length(global.puzzleRoomList) - 1) * array_length(global.puzzleRoomList[UnknownEnum.Value_1]);
var _puzzleListSize = puzzleListSize;
var _debugMenuString = array_create(puzzleListSize, "");

for (var i = 0; i < puzzleListSize; i += 1)
{
    var _levelIndexModulo = (i % 5) + 1;
    var _areaIndexDiv = (i div 5) + 1;
    _debugMenuString[i] = global.areaNames[_areaIndexDiv] + "-" + string(_levelIndexModulo);
    
    if (puzzleDataClearedGet(_areaIndexDiv, _levelIndexModulo - 1))
        _debugMenuString[i] += " cleared! ";
    
    if (!puzzleDataUnlockedGet(_areaIndexDiv, _levelIndexModulo - 1))
        _debugMenuString[i] = "[ER_GREY3]" + _debugMenuString[i];
    
    if (!puzzleDataRoomExists(_areaIndexDiv, _levelIndexModulo - 1))
    {
        _debugMenuString[i] += "(nodata)";
        _debugMenuString[i] = "[ER_GREY2]" + _debugMenuString[i];
    }
}

_debugMenuString[puzzleListSize] = "cancel";
_puzzleListSize += 1;
draw_set_halign(fa_left);
draw_set_valign(fa_top);

with (uiCreate("debug menu root"))
{
    eventAddFunction(UnknownEnum.Value_0, function()
    {
        setLTRBToWindow();
    });
    updateShape();
    
    with (newChild("debug menu header"))
    {
        setX(getParent().getShapeWidth() / 2);
        setTop(20);
        uiTemplateTextScaled("[wave]puzzle mode", 1.4);
        updateShape();
    }
    
    with (newChild())
    {
        uiTemplateRectangle(make_color_rgb(255, 255, 255), 0.2);
        setTop((uiGet("debug menu header").getShapeBottom() + 10) - uiGet("debug menu header").__calcOffsetY);
        setX(getParent().getShapeWidth() / 2);
        setHeight(getParent().getShapeHeight() - getRawTop() - 10);
        setFlow("list", "y");
        setFlowAlignment("center", "top", "left", "top");
        setFlowSpacing(20, 0, 20, 0, 0, 2);
        clipChildrenAllow = true;
        scrollAllow = true;
        var _i = 0;
        
        repeat (_puzzleListSize)
        {
            var _string = _debugMenuString[_i];
            
            if (_string == "")
            {
                with (newChild())
                    uiTemplateSpacer(getParent().outFlowWidth, 5);
            }
            else
            {
                with (newChild())
                {
                    puzzleListSize = _puzzleListSize - 1;
                    uiTemplateDebugButton_puzzleSelect(_i, _string, 1.1);
                }
            }
            
            _i++;
        }
        
        updateShape();
    }
}
