pauseStart();
draw_set_halign(fa_left);
draw_set_valign(fa_top);
leaderboardIndex = 0;
leaderboardData = [
{
    name: "Quest Mode",
    internalName: "mainGame",
    scores: [
    {
        name: "First player",
        points: 10000
    }, 
    {
        name: "Second player",
        points: 9000
    }, 
    {
        name: "Third player",
        points: 8000
    }, 
    {
        name: "wwoooooowww long name!",
        points: 7000
    }, 
    {
        name: "wwoooooowww long name!",
        points: 6000
    }, 
    {
        name: "wwoooooowww long name!",
        points: 5000
    }, 
    {
        name: "wwoooooowww long name!",
        points: 4000
    }, 
    {
        name: "wwoooooowww long name!",
        points: 3000
    }, 
    {
        name: "wwoooooowww long name!",
        points: 2000
    }, 
    {
        name: "wwoooooowww long name!",
        points: 1000
    }]
}, 
{
    name: "Puzzle Mode",
    internalName: "puzzleMode",
    scores: [
    {
        name: "First player",
        points: 20000
    }, 
    {
        name: "Second player",
        points: 19000
    }, 
    {
        name: "Third player",
        points: 18000
    }]
}, 
{
    name: "A Third Mode I Guess?",
    internalName: "thirdMode",
    scores: [
    {
        name: "First player",
        points: 20000
    }, 
    {
        name: "Second player",
        points: 19000
    }, 
    {
        name: "Third player",
        points: 18000
    }]
}];
var _leaderboardData = leaderboardData;

showLeaderboard = function(arg0)
{
    var _length = array_length(leaderboardData);
    leaderboardIndex = (floor(arg0) + (20 * _length)) % _length;
    var _i = 0;
    
    repeat (_length)
    {
        var _leaderboard_struct = leaderboardData[_i];
        
        if (_i == leaderboardIndex)
            uiGroupActivate("leaderboards root", concat(_leaderboard_struct.internalName, " group"));
        else
            uiGroupDeactivate("leaderboards root", concat(_leaderboard_struct.internalName, " group"));
        
        _i++;
    }
};

with (uiCreate("leaderboards root"))
{
    eventAddFunction(UnknownEnum.Value_0, function()
    {
        setLTRBToWindow();
    });
    updateShape();
    eventAddFunction(UnknownEnum.Value_14, function()
    {
        instance_destroy(rootInstance);
        instance_create_depth(0, 0, 0, oPauseMenu);
    });
    
    with (newChild("leaderboards title"))
    {
        setX(getParent().getShapeWidth() / 2);
        setY(0.14 * getParent().getShapeHeight());
        uiTemplateTextScaledLimit("[wave]Leaderboards", 1.7, getParent().getShapeWidth() - 20);
        updateShape();
    }
    
    with (newChild())
    {
        setX(getParent().getShapeWidth() / 2);
        setY(uiGet("leaderboards title").getRawY() + 1);
        uiTemplateTextScaledLimit("[wave]Leaderboards", 1.7, getParent().getShapeWidth() - 20);
    }
    
    with (newChild("leaderboards back"))
    {
        uiTemplateButtonLimit("Back", 1.3, getParent().getShapeWidth() - 70);
        setHeight(20);
        setX(getParent().getShapeWidth() / 2);
        setY(0.9 * getParent().getShapeHeight());
        eventAddFunction(UnknownEnum.Value_10, function()
        {
            callEventInChildren();
            instance_destroy(rootInstance);
            instance_create_depth(0, 0, 0, oPauseMenu);
        });
        updateShape();
    }
    
    with (newChild("leaderboards previous"))
    {
        setLeft(0.05 * getParent().getShapeWidth());
        setY(0.23 * getParent().getShapeHeight());
        setWidth(17);
        setHeight(17);
        selected = false;
        eventAddFunction(UnknownEnum.Value_4, function()
        {
            if (input_player_source_get() == UnknownEnum.Value_2 || !(os_type == os_ios || os_type == os_android))
                selected = true;
        });
        eventAddFunction(UnknownEnum.Value_7, function()
        {
            selected = false;
        });
        eventAddFunction(UnknownEnum.Value_10, function()
        {
            rootInstance.showLeaderboard(rootInstance.leaderboardIndex - 1);
        });
        eventAddFunction(UnknownEnum.Value_2, function()
        {
            if (selected)
                drawRectangleFast(getDrawLeft() - 1, getDrawTop() - 1, getDrawRight() + 1, getDrawBottom() + 1, make_color_rgb(255, 255, 255), 1);
            
            drawRectangleFast(getDrawLeft(), getDrawTop(), getDrawRight(), getDrawBottom(), make_color_rgb(255, 233, 1), 1);
        });
        updateShape();
    }
    
    with (newChild("leaderboards next"))
    {
        setRight(0.95 * getParent().getShapeWidth());
        setY(0.23 * getParent().getShapeHeight());
        setWidth(17);
        setHeight(17);
        selected = false;
        eventAddFunction(UnknownEnum.Value_4, function()
        {
            if (input_player_source_get() == UnknownEnum.Value_2 || !(os_type == os_ios || os_type == os_android))
                selected = true;
        });
        eventAddFunction(UnknownEnum.Value_7, function()
        {
            selected = false;
        });
        eventAddFunction(UnknownEnum.Value_10, function()
        {
            rootInstance.showLeaderboard(rootInstance.leaderboardIndex + 1);
        });
        eventAddFunction(UnknownEnum.Value_2, function()
        {
            if (selected)
                drawRectangleFast(getDrawLeft() - 1, getDrawTop() - 1, getDrawRight() + 1, getDrawBottom() + 1, make_color_rgb(255, 233, 1), 1);
            
            drawRectangleFast(getDrawLeft(), getDrawTop(), getDrawRight(), getDrawBottom(), make_color_rgb(65, 162, 255), 1);
        });
        updateShape();
    }
    
    var _i = 0;
    
    repeat (array_length(_leaderboardData))
    {
        var _leaderboard_struct = _leaderboardData[_i];
        var _scores = _leaderboard_struct.scores;
        
        with (newChild(concat(_leaderboard_struct.internalName, " title"), concat(_leaderboard_struct.internalName, " group")))
        {
            setLeft((uiGet("leaderboards previous").getShapeRight() + 10) - getParent().getShapeLeft());
            setRight(uiGet("leaderboards next").getShapeLeft() - 10 - getParent().getShapeLeft());
            setY(0.23 * getParent().getShapeHeight());
            setHeight(27);
            leaderboardName = _leaderboard_struct.name;
            eventAddFunction(UnknownEnum.Value_2, function()
            {
                var _textElement = scribble(leaderboardName).starting_format(undefined, make_color_rgb(255, 255, 255)).align(1, 1).msdf_border(make_color_rgb(46, 50, 59), 3);
                var _factor = min(1, getShapeWidth() / _textElement.get_width());
                _textElement.transform(_factor, _factor, 0);
                _textElement.draw(getShapeX(), getShapeY());
            });
            updateShape();
        }
        
        with (newChild(concat(_leaderboard_struct.internalName, " panel"), concat(_leaderboard_struct.internalName, " group")))
        {
            setX(getParent().getShapeWidth() / 2);
            setWidth(getParent().getShapeWidth() - 20);
            setTop(uiGet(concat(_leaderboard_struct.internalName, " title")).getShapeBottom() + 10);
            setBottom(uiGet("leaderboards back").getShapeTop() - 10);
            setFlow("list", "y");
            setFlowAlignment("center", "top", "center", "middle");
            setFlowSpacing(0, 0, 0, 0, 0, 4);
            scrollAllow = true;
            clipChildrenAllow = true;
            updateShape();
            var _j = 0;
            
            repeat (array_length(_scores))
            {
                var _score_struct = _scores[_j];
                
                with (newChild(undefined, concat(_leaderboard_struct.internalName, " group")))
                {
                    if (_j == 0)
                    {
                        visBlend = make_color_rgb(255, 238, 96);
                        setHeight(30);
                    }
                    else if (_j == 1)
                    {
                        visBlend = make_color_rgb(65, 162, 255);
                        setHeight(30);
                    }
                    else if (_j == 2)
                    {
                        visBlend = make_color_rgb(254, 66, 113);
                        setHeight(30);
                    }
                    else
                    {
                        setHeight(20);
                    }
                    
                    setWidth(getParent().getShapeWidth() - getRawHeight());
                    playerName = _score_struct.name;
                    playerPoints = _score_struct.points;
                    selected = false;
                    eventAddFunction(UnknownEnum.Value_4, function()
                    {
                        if (input_player_source_get() == UnknownEnum.Value_2)
                            selected = true;
                    });
                    eventAddFunction(UnknownEnum.Value_7, function()
                    {
                        selected = false;
                    });
                    eventAddFunction(UnknownEnum.Value_2, function()
                    {
                        if (selected)
                            drawPillWithOutline((getDrawLeft() - (getDrawHeight() / 2)) + 2, getDrawTop() + 2, (getDrawRight() + (getDrawHeight() / 2)) - 2, getDrawBottom() - 2, visBlend, make_color_rgb(46, 50, 59), 2);
                        else
                            drawPill(getDrawLeft() - (getDrawHeight() / 2), getDrawTop(), getDrawRight() + (getDrawHeight() / 2), getDrawBottom(), visBlend, visAlpha);
                        
                        var _nameText = scribble(playerName).starting_format(undefined, make_color_rgb(46, 50, 59)).align(0, 1);
                        var _scoreText = scribble(playerPoints).starting_format(undefined, make_color_rgb(46, 50, 59)).align(2, 1);
                        var _factor = min(1, ((0.66 * getShapeWidth()) - 3) / _nameText.get_width());
                        _nameText.transform(_factor, _factor, 0);
                        _factor = min(1, ((0.33 * getShapeWidth()) - 3) / _scoreText.get_width());
                        _scoreText.transform(_factor, _factor, 0);
                        _nameText.draw(getDrawLeft(), getDrawY());
                        _scoreText.draw(getDrawRight(), getDrawY());
                    });
                }
                
                _j++;
            }
        }
        
        _i++;
    }
}

showLeaderboard(leaderboardIndex);
