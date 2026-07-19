global.mainGamePaused = 1;
printScreen = surface_create_track(surface_get_width(application_surface), surface_get_height(application_surface));
surface_copy(printScreen, 0, 0, application_surface);
instance_deactivate_all(1);
instance_activate_object(oControl);
trophyListSize = ds_list_size(global.achievementTrophyGotList);
var _debugMenuString = array_create(trophyListSize, "");

for (var i = 0; i < trophyListSize; i += 1)
    _debugMenuString[i] = getTrophyText(i);

_debugMenuString[trophyListSize] = "cancel";
trophyListSize += 1;
var _trophyListSize = trophyListSize;
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
        uiTemplateTextScaled("Trophy", 1.4);
        updateShape();
    }
    
    with (newChild())
    {
        uiTemplateRectangle(make_color_rgb(255, 255, 255), 0.2);
        setTop((uiGet("debug menu header").getShapeBottom() + 10) - uiGet("debug menu header").__calcOffsetY);
        setX(getParent().getShapeWidth() / 2);
        setWidth(160);
        setHeight(getParent().getShapeHeight() - shapeTop - 10);
        setFlow("list", "y");
        setFlowAlignment("center", "top", "left", "top");
        setFlowSpacing(20, 0, 20, 0, 0, 2);
        clipChildrenAllow = true;
        scrollAllow = true;
        var _i = 0;
        
        repeat (_trophyListSize)
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
                    trophyListSize = _trophyListSize - 1;
                    uiTemplateDebugButton_trophyRough(_i, _string, 1.1);
                }
            }
            
            _i++;
        }
        
        updateShape();
    }
}
