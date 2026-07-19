pauseStart();
var _debugMenuString = array_create(UnknownEnum.Value_44, "");
_debugMenuString[UnknownEnum.Value_0] = "resume game";
_debugMenuString[UnknownEnum.Value_1] = concat("recipe level: ", global.difficultyLevel);
_debugMenuString[UnknownEnum.Value_2] = "skip to level 20";
_debugMenuString[UnknownEnum.Value_3] = concat("area lock: ", global.areaNames[global.debugAreaLock]);
_debugMenuString[UnknownEnum.Value_5] = concat("no damage mode: ", global.debugNoDamage);
_debugMenuString[UnknownEnum.Value_8] = concat("variable tracker: ", global.debugDrawVariableTracker);
_debugMenuString[UnknownEnum.Value_9] = concat("audio engine debug: ", global.debugDrawAudioEngine);
_debugMenuString[UnknownEnum.Value_10] = concat("toggleObjectiveUI: ", global.toggleObjectiveUI);
_debugMenuString[UnknownEnum.Value_11] = concat("toggleDebugControl: ", global.debugControl);
_debugMenuString[UnknownEnum.Value_12] = concat("get exp : ", global.mainGameFruitProgress_total);
_debugMenuString[UnknownEnum.Value_13] = "DIE";
_debugMenuString[UnknownEnum.Value_15] = "log in to leaderboards";
_debugMenuString[UnknownEnum.Value_16] = "show OS leaderboards";
_debugMenuString[UnknownEnum.Value_17] = "post dummy score";
_debugMenuString[UnknownEnum.Value_18] = "pulling leaderboard";
_debugMenuString[UnknownEnum.Value_19] = "fill leaderboard data";
_debugMenuString[UnknownEnum.Value_20] = "enable leaderboards";
_debugMenuString[UnknownEnum.Value_22] = "go to main game";
_debugMenuString[UnknownEnum.Value_23] = "go to lobby";
_debugMenuString[UnknownEnum.Value_25] = "go to wip tutorial";
_debugMenuString[UnknownEnum.Value_27] = "go to gobo cutscene";
_debugMenuString[UnknownEnum.Value_28] = "go to credit (end)";
_debugMenuString[UnknownEnum.Value_29] = "go to debug room";
_debugMenuString[UnknownEnum.Value_26] = "go to ending full sequence";
_debugMenuString[UnknownEnum.Value_24] = "go to enemy showroom";
_debugMenuString[UnknownEnum.Value_30] = "select puzzle";
_debugMenuString[UnknownEnum.Value_31] = "puzzle debug unlock";
_debugMenuString[UnknownEnum.Value_4] = concat("jump times: ", global.jumpTimesMax);
_debugMenuString[UnknownEnum.Value_45] = "wide mode (unstable)";
_debugMenuString[UnknownEnum.Value_33] = concat("force short screen :", global.debugForceShorterPortraitScreen);
_debugMenuString[UnknownEnum.Value_34] = concat("change to " + locNextLanguage());
_debugMenuString[UnknownEnum.Value_35] = "output charset files";
_debugMenuString[UnknownEnum.Value_36] = "get 100 gold";
_debugMenuString[UnknownEnum.Value_6] = concat("show fps :", global.debugFps);
_debugMenuString[UnknownEnum.Value_7] = concat("show hitbox :", global.debugHitbox);
_debugMenuString[UnknownEnum.Value_37] = "gameRestart";
_debugMenuString[UnknownEnum.Value_38] = "getAllTrophy";
_debugMenuString[UnknownEnum.Value_41] = "reset save";
_debugMenuString[UnknownEnum.Value_39] = "unlockAbilities";
_debugMenuString[UnknownEnum.Value_40] = "unlock all";
_debugMenuString[UnknownEnum.Value_43] = "resume game";
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
        uiTemplateTextScaled("DEBUG MENU", 1.4);
        updateShape();
    }
    
    with (newChild())
    {
        uiTemplateRectangle(make_color_rgb(255, 255, 255), 0.2);
        setTop((uiGet("debug menu header").getShapeBottom() + 10) - uiGet("debug menu header").__calcOffsetY);
        setX(getParent().getShapeWidth() / 2);
        setHeight(getParent().getShapeHeight() - shapeTop - 10);
        setFlow("list", "y");
        setFlowAlignment("center", "top", "left", "top");
        setFlowSpacing(20, 0, 20, 0, 0, 2);
        clipChildrenAllow = true;
        scrollAllow = true;
        var _i = 0;
        
        repeat (UnknownEnum.Value_44)
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
                    uiTemplateDebugButton(_i, _string, 0.8);
            }
            
            _i++;
        }
        
        updateShape();
    }
}
