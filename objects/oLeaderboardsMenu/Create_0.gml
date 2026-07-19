pauseStart();
draw_set_halign(fa_left);
draw_set_valign(fa_top);
leaderboardsPull(leaderboardsFindID(UnknownEnum.Value_0, false), false);
var _buttonTextSize = 0.85;
leaderboardJumps = 10;
leaderboardMode = "highest";
leaderboardScope = "global";
leaderboardIndex = UnknownEnum.Value_0;
leaderboardSurface = -1;

updateLeaderboard = function()
{
    var _newIndex = undefined;
    
    switch (leaderboardJumps)
    {
        case 2:
            if (leaderboardMode == "highest")
            {
                if (leaderboardScope == "global")
                    _newIndex = UnknownEnum.Value_8;
                
                if (leaderboardScope == "friends")
                    _newIndex = UnknownEnum.Value_18;
            }
            
            if (leaderboardMode == "average")
            {
                if (leaderboardScope == "global")
                    _newIndex = UnknownEnum.Value_9;
                
                if (leaderboardScope == "friends")
                    _newIndex = UnknownEnum.Value_19;
            }
            
            break;
        
        case 4:
            if (leaderboardMode == "highest")
            {
                if (leaderboardScope == "global")
                    _newIndex = UnknownEnum.Value_6;
                
                if (leaderboardScope == "friends")
                    _newIndex = UnknownEnum.Value_16;
            }
            
            if (leaderboardMode == "average")
            {
                if (leaderboardScope == "global")
                    _newIndex = UnknownEnum.Value_7;
                
                if (leaderboardScope == "friends")
                    _newIndex = UnknownEnum.Value_17;
            }
            
            break;
        
        case 6:
            if (leaderboardMode == "highest")
            {
                if (leaderboardScope == "global")
                    _newIndex = UnknownEnum.Value_4;
                
                if (leaderboardScope == "friends")
                    _newIndex = UnknownEnum.Value_14;
            }
            
            if (leaderboardMode == "average")
            {
                if (leaderboardScope == "global")
                    _newIndex = UnknownEnum.Value_5;
                
                if (leaderboardScope == "friends")
                    _newIndex = UnknownEnum.Value_15;
            }
            
            break;
        
        case 8:
            if (leaderboardMode == "highest")
            {
                if (leaderboardScope == "global")
                    _newIndex = UnknownEnum.Value_2;
                
                if (leaderboardScope == "friends")
                    _newIndex = UnknownEnum.Value_12;
            }
            
            if (leaderboardMode == "average")
            {
                if (leaderboardScope == "global")
                    _newIndex = UnknownEnum.Value_3;
                
                if (leaderboardScope == "friends")
                    _newIndex = UnknownEnum.Value_13;
            }
            
            break;
        
        case 10:
            if (leaderboardMode == "highest")
            {
                if (leaderboardScope == "global")
                    _newIndex = UnknownEnum.Value_0;
                
                if (leaderboardScope == "friends")
                    _newIndex = UnknownEnum.Value_10;
            }
            
            if (leaderboardMode == "average")
            {
                if (leaderboardScope == "global")
                    _newIndex = UnknownEnum.Value_1;
                
                if (leaderboardScope == "friends")
                    _newIndex = UnknownEnum.Value_11;
            }
            
            break;
    }
    
    if (_newIndex == undefined)
    {
        traceError("Could not find leaderboard index for jumps=\"", leaderboardJumps, "\", mode=\"", leaderboardMode, "\", scope=\"", leaderboardScope, "\"");
    }
    else
    {
        leaderboardIndex = _newIndex;
        
        with (uiGet("leaderboards central panel"))
            lbScrollYOffsetTarget = 0;
        
        trace("Set leaderboard index to \"", leaderboardsGetName(leaderboardIndex), "\" (", leaderboardIndex, ")");
        leaderboardsPull(_newIndex);
        
        with (uiGet("leaderboards central panel"))
        {
            __callEvent(UnknownEnum.Value_1);
            lbRedrawSurface = true;
        }
    }
};

leaderboardData = [];
var _leaderboardData = leaderboardData;

showLeaderboard = function(arg0)
{
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
        setY(0.08 * getParent().getShapeHeight());
        uiTemplateTextScaledLimit("[wave]" + loc("leaderboards title"), 1.7, getParent().getShapeWidth() - 20);
        updateShape();
    }
    
    with (newChild("leaderboards back button"))
    {
        uiTemplateSpriteScaled(sResultsLobbyButton, 0, 0.1);
        setX(getParent().getShapeWidth() / 2);
        setBottom(getParent().getShapeHeight() - 20);
        eventAddFunction(UnknownEnum.Value_5, function()
        {
        });
        eventAddFunction(UnknownEnum.Value_9, function()
        {
            imageIndex = 1;
        });
        eventAddFunction(UnknownEnum.Value_11, function()
        {
            imageIndex = 0;
        });
        eventAddFunction(UnknownEnum.Value_10, function()
        {
            if (imageIndex == 1)
            {
                playSoundBackButton();
                instance_destroy(rootInstance);
                instance_create_depth(0, 0, 0, oPauseMenu);
            }
        });
        updateShape();
    }
    
    with (newChild("leaderboards jump button group"))
    {
        setX(getParent().getShapeWidth() / 2);
        setWidth(getParent().getShapeWidth() - 10);
        setTop(uiGet("leaderboards title").getShapeBottom() + 10);
        setFlow("list", "x");
        setFlowAlignment("center", "middle", "center", "middle");
        setFlowSpacing(0, 0, 0, 0, 9, 0);
        scrollAllow = false;
        clipChildrenAllow = false;
        updateShape();
        var _i = 0;
        
        repeat (5)
        {
            var _jumpCount = 10 - (2 * _i);
            
            with (newChild(concat("leaderboards ", _jumpCount, " jumps button")))
            {
                jumpCount = _jumpCount;
                uiTemplateTextScaledLimit("[scale,0.15][sJumpCounts00,0][/scale] " + string(_jumpCount), _buttonTextSize, infinity);
                eventAddFunction(UnknownEnum.Value_10, function()
                {
                    rootInstance.leaderboardJumps = jumpCount;
                    rootInstance.updateLeaderboard();
                });
                eventInsertFunction(UnknownEnum.Value_2, 0, function()
                {
                    visBlend = (rootInstance.leaderboardJumps == jumpCount) ? make_color_rgb(90, 243, 145) : 16777215;
                    drawPill(getDrawLeft() - 3, getDrawTop() - 1.5, getDrawRight() + 3, getDrawBottom() + 1.5, 16777215, 0.4);
                });
            }
            
            _i++;
        }
        
        updateShape();
    }
    
    with (newChild("leaderboards mode button group"))
    {
        setX(getParent().getShapeWidth() / 2);
        setWidth(getParent().getShapeWidth() - 10);
        setTop(uiGet("leaderboards jump button group").getShapeBottom() + 7);
        setFlow("list", "x");
        setFlowAlignment("center", "middle", "center", "middle");
        setFlowSpacing(0, 0, 0, 0, 9, 0);
        scrollAllow = false;
        clipChildrenAllow = false;
        updateShape();
        
        with (newChild(concat("leaderboards single mode button")))
        {
            uiTemplateTextScaledLimit(loc("leaderboards highest"), _buttonTextSize, infinity);
            eventAddFunction(UnknownEnum.Value_10, function()
            {
                if (rootInstance.leaderboardMode != "highest")
                    rootInstance.leaderboardMode = "highest";
                else if (rootInstance.leaderboardScope != "global")
                    rootInstance.leaderboardScope = "global";
                else
                    rootInstance.leaderboardScope = "friends";
                
                rootInstance.updateLeaderboard();
            });
            eventInsertFunction(UnknownEnum.Value_2, 0, function()
            {
                visBlend = (rootInstance.leaderboardMode == "highest") ? make_color_rgb(90, 243, 145) : 16777215;
                drawPill(getDrawLeft() - 3, getDrawTop() - 1.5, getDrawRight() + 3, getDrawBottom() + 1.5, 16777215, 0.4);
            });
        }
        
        with (newChild(concat("leaderboards average mode button")))
        {
            uiTemplateTextScaledLimit(loc("leaderboards average"), _buttonTextSize, infinity);
            eventAddFunction(UnknownEnum.Value_10, function()
            {
                if (rootInstance.leaderboardMode != "average")
                    rootInstance.leaderboardMode = "average";
                else if (rootInstance.leaderboardScope != "global")
                    rootInstance.leaderboardScope = "global";
                else
                    rootInstance.leaderboardScope = "friends";
                
                rootInstance.updateLeaderboard();
            });
            eventInsertFunction(UnknownEnum.Value_2, 0, function()
            {
                visBlend = (rootInstance.leaderboardMode == "average") ? make_color_rgb(90, 243, 145) : 16777215;
                drawPill(getDrawLeft() - 3, getDrawTop() - 1.5, getDrawRight() + 3, getDrawBottom() + 1.5, 16777215, 0.4);
            });
        }
        
        updateShape();
    }
    
    with (newChild("leaderboards central panel"))
    {
        setX(getParent().getShapeWidth() / 2);
        setWidth(getParent().getShapeWidth() - 10);
        setTop(uiGet("leaderboards mode button group").getShapeBottom() + 10);
        setBottom(uiGet("leaderboards back button").getShapeTop() - 10);
        setFlow("list", "y");
        setFlowAlignment("center", "top", "center", "middle");
        setFlowSpacing(0, 0, 0, 0, 0, 4);
        scrollAllow = true;
        updateShape();
        lbRedrawSurface = true;
        lbScrollYOffset = 0;
        lbScrollYOffsetTarget = 0;
        lbScrollStartIndex = 0;
        lbBorder = 6;
        lbActiveArea = getDrawHeight() - (2 * lbBorder);
        lbClick = false;
        lbClickX = undefined;
        lbClickY = undefined;
        lbScoreHeight = 21;
        lbScoreSpacing = 5;
        lbScoreMaxOnScreen = ceil((lbActiveArea + lbScoreSpacing) / (lbScoreHeight + lbScoreSpacing));
        eventAddFunction(UnknownEnum.Value_1, function()
        {
            var _startYOffset = lbScrollYOffset;
            var _startIndex = lbScrollStartIndex;
            var _leaderboardArray = global.__leaderboardData[rootInstance.leaderboardIndex];
            var _scoreCount = array_length(_leaderboardArray);
            var _scrollLimit = (lbScoreHeight + lbScoreSpacing) * (_scoreCount - (lbScoreMaxOnScreen - 1));
            
            if (_scrollLimit < 0)
                _scrollLimit = 0;
            
            lbScrollYOffsetTarget = clamp(lbScrollYOffsetTarget, -_scrollLimit, 0);
            lbScrollYOffset = lerp(lbScrollYOffset, lbScrollYOffsetTarget, 0.02 * scrollSpeed);
            lbScrollYOffset = clamp(lbScrollYOffset, -_scrollLimit, 0);
            
            if (_startYOffset != lbScrollYOffset || _startIndex != lbScrollStartIndex)
                lbRedrawSurface = true;
        });
        eventAddFunction(UnknownEnum.Value_20, function()
        {
            lbScrollYOffsetTarget += global.__uiScrollMouseWheelSpeed;
        });
        eventAddFunction(UnknownEnum.Value_21, function()
        {
            lbScrollYOffsetTarget -= global.__uiScrollMouseWheelSpeed;
        });
        eventAddFunction(UnknownEnum.Value_17, function(arg0, arg1)
        {
            lbScrollYOffsetTarget += arg1;
        });
        eventAddFunction(UnknownEnum.Value_10, function()
        {
            lbClick = true;
            lbClickX = device_mouse_x_to_gui(0) - getDrawLeft();
            lbClickY = device_mouse_y_to_gui(0) - getDrawTop();
            lbRedrawSurface = true;
        });
        eventAddFunction(UnknownEnum.Value_2, function()
        {
            var _surface = rootInstance.leaderboardSurface;
            var _surfaceW = ceil(getDrawWidth());
            var _surfaceH = ceil(getDrawHeight());
            var _surfaceRealW = ceil(global.surfaceCompressionRate * _surfaceW);
            var _surfaceRealH = ceil(global.surfaceCompressionRate * _surfaceH);
            
            if (surface_exists(_surface) && (surface_get_width(_surface) != _surfaceRealW || surface_get_height(_surface) != _surfaceRealH))
                surface_free(_surface);
            
            if (!surface_exists(_surface))
            {
                _surface = surface_create_track(_surfaceRealW, _surfaceRealH);
                rootInstance.leaderboardSurface = _surface;
                lbRedrawSurface = true;
            }
            
            switch (leaderboardsGetState(rootInstance.leaderboardIndex))
            {
                case 1:
                    if (lbRedrawSurface)
                    {
                        surface_set_target(_surface);
                        draw_clear_alpha(c_white, 0);
                        var _flip = (os_type == os_windows || os_type == os_xboxone || os_type == os_uwp || os_type == os_win8native || os_type == os_winphone) ? 1 : -1;
                        matrix_set(0, matrix_build_lookat(_surfaceW / 2, _surfaceH / 2, 0, _surfaceW / 2, _surfaceH / 2, -16000, 0, -1 * _flip, 0));
                        matrix_set(1, matrix_build_projection_ortho(_flip * _surfaceW, _surfaceH, -16000, 16000));
                        var _scoreWidth = _surfaceW;
                        var _leaderboardArray = global.__leaderboardData[rootInstance.leaderboardIndex];
                        var _leaderboardSingle = leaderboardsGetSingle(rootInstance.leaderboardIndex);
                        var _scoreA = -lbScrollYOffset div (lbScoreHeight + lbScoreSpacing);
                        var _scoreB = min(_scoreA + lbScoreMaxOnScreen, array_length(_leaderboardArray) - 1);
                        var _l = 0;
                        var _t = lbBorder - (-lbScrollYOffset % (lbScoreHeight + lbScoreSpacing));
                        var _r = _l + _scoreWidth;
                        var _b = _t + lbScoreHeight;
                        var _i = _scoreA;
                        var _scoreTextSize = 0.7;
                        var _rankTextSize = 0.6;
                        var _playerNameSize = 0.5;
                        
                        repeat ((1 + _scoreB) - _scoreA)
                        {
                            var _data = _leaderboardArray[_i];
                            var _pillAlpha = 0.8;
                            
                            if (_data.isPlayer)
                                _pillAlpha = 1;
                            
                            drawPill(_l, _t, _r, _b, visBlend, _pillAlpha * visAlpha);
                            
                            if (!_leaderboardSingle && lbClick)
                            {
                                if (point_in_rectangle(lbClickX, lbClickY, _l, _t, _r, _b))
                                    _data.showHistoric = !_data.showHistoric;
                            }
                            
                            var _rank_l = _l + 4;
                            var _rank_w = 0.6 * lbScoreHeight;
                            var _rank_r = _rank_l + _rank_w;
                            var _score_r = _r - 4;
                            var _score_w = 1.5 * lbScoreHeight;
                            var _score_l = _score_r - _score_w;
                            var _rankText = scribble(string(_data.rank) + ".").starting_format(undefined, make_color_rgb(69, 80, 97)).align(1, 1);
                            var _factor = min(_rankTextSize, _rank_w / _rankText.get_width());
                            _rankText.transform(_factor, _factor, 0);
                            _rankText.draw(0.5 * (_rank_l + _rank_r), 0.5 * (_t + _b));
                            var _scoreText = scribble(_leaderboardSingle ? _data.points : string_format(_data.points, 0, 1)).starting_format(undefined, make_color_rgb(69, 80, 97)).align(1, 1);
                            _factor = min(_scoreTextSize, _score_w / _scoreText.get_width());
                            _scoreText.transform(_factor, _factor, 0);
                            _scoreText.draw(0.5 * (_score_l + _score_r), 0.5 * (_t + _b));
                            var _name_l = _rank_r + 7;
                            var _name_r = _score_l - 7;
                            var _name_w = 1 + (_name_r - _name_l);
                            var _nameColor = make_color_rgb(69, 80, 97);
                            var _nameText = scribble(_data.player).starting_format(undefined, make_color_rgb(69, 80, 97)).align(1, 1);
                            _factor = min(_playerNameSize, _name_w / _nameText.get_width(), (lbScoreHeight - 4) / _nameText.get_height());
                            _nameText.transform(_factor, _factor, 0);
                            _nameText.draw(0.5 * (_name_l + _name_r), 0.5 * (_t + _b));
                            _t = _b + lbScoreSpacing;
                            _b = _t + lbScoreHeight;
                            _i++;
                        }
                        
                        gpu_set_colorwriteenable(false, false, false, true);
                        gpu_set_blendmode_ext(bm_zero, bm_src_alpha);
                        draw_primitive_begin(pr_trianglelist);
                        draw_vertex_color(0, 0, c_white, 0);
                        draw_vertex_color(_surfaceW, 0, c_white, 0);
                        draw_vertex_color(_surfaceW, lbBorder, c_white, 1);
                        draw_vertex_color(0, 0, c_white, 0);
                        draw_vertex_color(_surfaceW, lbBorder, c_white, 1);
                        draw_vertex_color(0, lbBorder, c_white, 1);
                        draw_vertex_color(0, _surfaceH, c_white, 0);
                        draw_vertex_color(_surfaceW, _surfaceH, c_white, 0);
                        draw_vertex_color(_surfaceW, _surfaceH - lbBorder, c_white, 1);
                        draw_vertex_color(0, _surfaceH, c_white, 0);
                        draw_vertex_color(_surfaceW, _surfaceH - lbBorder, c_white, 1);
                        draw_vertex_color(0, _surfaceH - lbBorder, c_white, 1);
                        draw_primitive_end();
                        gpu_set_colorwriteenable(true, true, true, true);
                        gpu_set_blendmode(bm_normal);
                        surface_reset_target();
                    }
                    
                    draw_surface_stretched(_surface, getDrawLeft(), getDrawTop(), getDrawWidth(), getDrawHeight());
                    lbRedrawSurface = false;
                    break;
                
                case 0:
                    var _lbLoadText = scribble("[wave][rainbow]" + loc("leaderboards loading"));
                    var _lbLoadTextSize = 1;
                    var _factor = min(_lbLoadTextSize, (_surfaceW - 16) / _lbLoadText.get_width());
                    _lbLoadText.align(1, 1).starting_format(locGetFontFromLanguage(), make_color_rgb(255, 255, 255)).msdf_border(make_color_rgb(46, 50, 59), 3);
                    _lbLoadText.transform(_factor, _factor, 0);
                    _lbLoadText.draw(getDrawX(), getDrawY());
                    break;
                
                case -1:
                    var _loadFailText = scribble("[scale,0.5][cycle,0,15]" + loc("leaderboards failed title") + "[/cycle]\n" + loc("leaderboards failed text"));
                    var _loadFailTextSize = 1;
                    _factor = min(_loadFailTextSize, (_surfaceW - 16) / _loadFailText.get_width());
                    _loadFailText.wrap(getDrawWidth() - 10).align(1, 1).starting_format(locGetFontFromLanguage(), make_color_rgb(255, 255, 255)).msdf_border(make_color_rgb(46, 50, 59), 3);
                    _loadFailText.transform(_factor, _factor, 0);
                    _loadFailText.draw(getDrawX(), getDrawY());
                    break;
            }
            
            lbClick = false;
            lbClickX = undefined;
            lbClickY = undefined;
        });
        updateShape();
    }
}

updateLeaderboard();
