pauseStart();
playSoundAbilityEquipMenuOpen();
global.notif_equipment = 0;
global.mainGamePaused = 1;
instance_deactivate_all(1);
instance_activate_object(oControl);
instance_activate_object(oDraw);
putPajamasInBack();
audioSetVolumeTarget(global.areaMusic, 0, 0.16666666666666666);
audioSetVolumeTarget(global.equipmentMusic, 1, 0.16666666666666666);
selectedAbility = -1;
selectedSlot = -1;

DeselectAll = function()
{
    DeselectAbility();
    DeselectSlot();
};

DeselectAbility = function()
{
    selectedAbility = -1;
    uiGet("AE selected slot overlay").borderT = 0;
};

DeselectSlot = function()
{
    selectedSlot = -1;
    uiGet("AE selected slot overlay").borderT = 0;
};

SelectAbility = function(arg0)
{
    if (selectedAbility != arg0)
        uiGet("AE selected ability overlay").borderT = 0;
    
    uiGet("AE selected slot overlay").borderT = 0;
    selectedAbility = arg0;
    selectedSlot = -1;
};

SelectSlot = function(arg0)
{
    uiGet("AE selected ability overlay").borderT = 0;
    
    if (selectedSlot != arg0)
        uiGet("AE selected slot overlay").borderT = 0;
    
    selectedAbility = global.equipmentSlot[| arg0];
    selectedSlot = arg0;
};

var _ability_box_size = 26;

with (uiCreate("AE root"))
{
    eventAddFunction(UnknownEnum.Value_0, function()
    {
        setLTRBToWindow();
    });
    eventAddFunction(UnknownEnum.Value_2, function()
    {
        drawSpriteTile(sAbilityEquipBackground, 0, getShapeLeft(), getShapeTop(), getShapeRight(), getShapeBottom(), 0.1, 0.1, current_time / 40, current_time / 70, 16777215, 1);
    });
    eventAddFunction(UnknownEnum.Value_14, function()
    {
        instance_destroy(rootInstance);
    });
    eventAddFunction(UnknownEnum.Value_10, function()
    {
        rootInstance.DeselectAll();
    });
    updateShape();
    
    with (newChild("AE divider"))
    {
        spriteIndex = sAbilityEquipDivider;
        setLeft(0);
        setRight(getParent().getShapeWidth());
        setHeight((sprite_get_height(sAbilityEquipDivider) * getParent().getShapeWidth()) / sprite_get_width(sAbilityEquipDivider));
        setBottom(0.58 * getParent().getShapeHeight());
        eventAddFunction(UnknownEnum.Value_2, function()
        {
            draw_sprite_stretched(sAbilityEquipDivider, 0, getDrawLeft(), getDrawTop(), getDrawWidth(), getDrawHeight());
        });
        updateShape();
    }
    
    with (newChild())
    {
        setLeft(0);
        setRight(getParent().getShapeWidth() - 1);
        setTop((0.58 * getParent().getShapeHeight()) + 1);
        setBottom(getParent().getShapeHeight());
        uiTemplateRectangle(make_color_rgb(46, 50, 59), 1);
        updateShape();
        
        with (newChild("AE scroll"))
        {
            setX(0.5 * getParent().getShapeWidth());
            setWidth((4 * _ability_box_size) + 30);
            setTop(0);
            setBottom(getParent().getShapeHeight() - 6);
            updateShape();
            setFlow("wrap", "x");
            setFlowSpacing(0, 13, 0, 0, 2.5, 2.5);
            setFlowAlignment("center", "top", "left", "top");
            flowWaveSize = 4;
            scrollAllow = true;
            scrollYMinOffset = ((global.windowRight - global.windowLeft) < 170) ? -33 : -24;
            clipChildrenAllow = true;
            var _i = 0;
            
            repeat (ds_list_size(global.unlockedAbilityList))
            {
                with (newChild(undefined, "AE unlocked group"))
                {
                    abilityIndex = _i;
                    setWidth(_ability_box_size);
                    setHeight(_ability_box_size);
                    eventAddFunction(UnknownEnum.Value_2, function()
                    {
                        var _ability = global.unlockedAbilityList[| abilityIndex];
                        
                        if (abilityEquippedIndex(_ability) >= 0)
                        {
                            drawSquircleWithOutline(getDrawLeft(), getDrawTop(), getDrawRight(), getDrawBottom(), 2, make_color_rgb(218, 221, 226), make_color_rgb(176, 183, 195), 1);
                            drawSpriteSize(global.upgradeIcon[| _ability], 3, getDrawX(), getDrawY(), 25, 0, 16777215, 1);
                        }
                        else
                        {
                            drawSquircleWithOutline(getDrawLeft(), getDrawTop(), getDrawRight(), getDrawBottom(), 2, make_color_rgb(245, 246, 247), make_color_rgb(255, 255, 255), 1);
                            drawSpriteSize(global.upgradeIcon[| _ability], 1, getDrawX(), getDrawY(), 25, 0, 16777215, 1);
                        }
                    });
                    eventAddFunction(UnknownEnum.Value_4, function()
                    {
                        if (input_player_source_get() == UnknownEnum.Value_2 && !uiGet("AE overlay").getActive())
                            rootInstance.SelectAbility(global.unlockedAbilityList[| abilityIndex]);
                    });
                    eventAddFunction(UnknownEnum.Value_10, function()
                    {
                        if (rootInstance.selectedSlot >= 0 || rootInstance.selectedAbility != global.unlockedAbilityList[| abilityIndex])
                        {
                            playSoundAbilityEquipMenuSelect();
                            rootInstance.SelectAbility(global.unlockedAbilityList[| abilityIndex]);
                        }
                        else if (abilityEquippedIndex(global.unlockedAbilityList[| abilityIndex]) < 0)
                        {
                            var _first_empty = abilityEquipFirstEmpty();
                            
                            if (_first_empty >= 0)
                            {
                                playSoundAbilityEquipMenuPutOn();
                                global.equipmentSlot[| _first_empty] = global.unlockedAbilityList[| abilityIndex];
                                
                                if (input_player_source_get() != UnknownEnum.Value_2)
                                    rootInstance.DeselectAll();
                                
                                toggleEquippedAbility();
                                uiGet("AE selected ability overlay").borderT = 0;
                            }
                            else
                            {
                                with (uiGet("AE overlay"))
                                {
                                    drawBlack = true;
                                    setActive(true);
                                }
                                
                                with (uiGet("AE scroll"))
                                    setChildrenActive(false);
                                
                                with (uiGet("AE slots"))
                                {
                                    drawReplace = true;
                                    playSfxUI(sfx_equip_replacePopup);
                                    var _old = getRawY();
                                    setY(0.45 * uiGet("AE root").getShapeHeight());
                                    visYOffset = _old - getRawY();
                                }
                                
                                uiForEachInGroup("AE root", "AE text group", function()
                                {
                                    setVisible(false);
                                });
                                
                                if (input_player_source_get() == UnknownEnum.Value_2)
                                    uiFocusNearestDecendent("AE root", uiGet("AE slots").getShapeX(), uiGet("AE slots").getShapeY());
                            }
                        }
                        
                        scrollTo();
                    });
                }
                
                _i++;
            }
            
            with (newChild("AE selected ability overlay"))
            {
                borderT = 0;
                eventAddFunction(UnknownEnum.Value_2, function()
                {
                    if (rootInstance.selectedSlot < 0 && rootInstance.selectedAbility >= 0)
                    {
                        borderT = approach(borderT, 1, 0.1);
                        uiForEachInGroup("AE root", "AE unlocked group", function(arg0)
                        {
                            var _ability = global.unlockedAbilityList[| abilityIndex];
                            
                            if (rootInstance.selectedAbility == _ability)
                            {
                                var _borderQ = animcurve_tween(0, 1, curveBackInv, arg0);
                                var _outer = lerp(2, 6, _borderQ);
                                var _inner = _outer - 2;
                                var _size = lerp(20, 32, _borderQ);
                                
                                if (abilityEquippedIndex(_ability) >= 0)
                                {
                                    drawSquircle(getDrawLeft() - _outer, getDrawTop() - _outer, getDrawRight() + _outer, getDrawBottom() + _outer, 0, make_color_rgb(46, 50, 59), 1);
                                    drawSquircleWithOutline(getDrawLeft() - _inner, getDrawTop() - _inner, getDrawRight() + _inner, getDrawBottom() + _inner, 0, make_color_rgb(218, 221, 226), make_color_rgb(176, 183, 195), 1);
                                    drawSpriteSize(global.upgradeIcon[| _ability], 2, getDrawX(), getDrawY(), _size, 0, 16777215, 1);
                                }
                                else
                                {
                                    drawSquircle(getDrawLeft() - _outer, getDrawTop() - _outer, getDrawRight() + _outer, getDrawBottom() + _outer, 0, make_color_rgb(46, 50, 59), 1);
                                    drawSquircleWithOutline(getDrawLeft() - _inner, getDrawTop() - _inner, getDrawRight() + _inner, getDrawBottom() + _inner, 0, make_color_rgb(255, 255, 255), make_color_rgb(255, 238, 96), 1);
                                    drawSpriteSize(global.upgradeIcon[| _ability], 0, getDrawX(), getDrawY(), _size, 0, 16777215, 1);
                                    scribble("[scale,0.27]" + loc("ability menu select equip")).starting_format(locGetFontFromLanguage(), make_color_rgb(46, 50, 59)).align(1, 1).msdf_border(make_color_rgb(255, 255, 255), 5).scale_to_box(getDrawWidth() + 5, -1).draw(getDrawX(), (getDrawTop() - _outer) + 0.5);
                                }
                            }
                        }, borderT);
                    }
                });
            }
        }
        
        with (newChild())
        {
            uiTemplateRectangle(make_color_rgb(46, 50, 59), 1);
            setLeft(0);
            setRight(getParent().getShapeWidth() - 1);
            setHeight((74 * getParent().getShapeWidth()) / 1600);
            setBottom(uiGet("AE scroll").getShapeHeight());
            eventAddFunction(UnknownEnum.Value_2, function()
            {
                var _uvs = sprite_get_uvs(sUIPixel, 0);
                var _u = _uvs[0];
                var _v = _uvs[1];
                draw_primitive_begin_texture(pr_trianglestrip, sprite_get_texture(sUIPixel, 0));
                draw_vertex_texture_color(getDrawLeft(), getDrawTop() - 4, _u, _v, visBlend, 0);
                draw_vertex_texture_color(getDrawRight(), getDrawTop() - 4, _u, _v, visBlend, 0);
                draw_vertex_texture_color(getDrawLeft(), getDrawTop(), _u, _v, visBlend, 1);
                draw_vertex_texture_color(getDrawRight(), getDrawTop(), _u, _v, visBlend, 1);
                draw_primitive_end();
            });
        }
    }
    
    with (newChild("AE overlay"))
    {
        drawBlack = false;
        visAlpha = 0;
        setActive(false);
        setLeft(0);
        setTop(0);
        setRight(getParent().getShapeWidth() - 1);
        setBottom(getParent().getShapeHeight() - 1);
        eventAddFunction(UnknownEnum.Value_2, function()
        {
            if (drawBlack)
                visAlpha = approach(visAlpha, 0.7, 0.1);
            else
                visAlpha = approach(visAlpha, 0, 0.1);
            
            drawRectangleFast(getDrawLeft(), getDrawTop(), getDrawRight(), getDrawBottom(), make_color_rgb(46, 50, 59), visAlpha);
        });
        eventAddFunction(UnknownEnum.Value_10, function()
        {
            with (uiGet("AE overlay"))
            {
                drawBlack = false;
                setActive(false);
            }
            
            with (uiGet("AE slots"))
            {
                drawReplace = false;
                var _old = getRawY();
                setY(0.25 * uiGet("AE root").getShapeHeight());
                visYOffset = _old - getRawY();
            }
            
            with (uiGet("AE scroll"))
                setChildrenActive(true);
            
            uiForEachInGroup("AE root", "AE text group", function()
            {
                setVisible(true);
            });
            
            if (input_player_source_get() == UnknownEnum.Value_2)
                uiFocusNearestDecendent("AE root", uiGet("AE scroll").getShapeX(), uiGet("AE scroll").getShapeY());
        });
    }
    
    with (newChild("AE back", "base group"))
    {
        uiTemplateSpriteScaled(sAbilityEquipBackButton, 0, 0.1);
        setLeft(4);
        setBottom(getParent().getShapeHeight() - 6);
        eventAddFunction(UnknownEnum.Value_4, function()
        {
            rootInstance.DeselectAll();
            visBlend = make_color_rgb(255, 238, 96);
        });
        eventAddFunction(UnknownEnum.Value_6, function()
        {
            visBlend = make_color_rgb(255, 255, 255);
        });
        eventAddFunction(UnknownEnum.Value_10, function()
        {
            playSoundBackButton();
            input_consume("select");
            instance_destroy(rootInstance);
        });
    }
    
    with (newChild("AE slots"))
    {
        drawReplace = false;
        setX(0.5 * getParent().getShapeWidth());
        setY(0.25 * getParent().getShapeHeight());
        eventAddFunction(UnknownEnum.Value_1, function()
        {
            visYOffset = lerp(visYOffset, 0, 0.5);
        });
        eventAddFunction(UnknownEnum.Value_2, function()
        {
            if (drawReplace)
                scribble("[scale,0.6]" + loc("ability menu header replace")).starting_format(locGetFontFromLanguage(), make_color_rgb(255, 255, 255)).fit_to_box(160, 64, locIsAsian()).align(1, 2).draw(getDrawX(), getDrawTop());
            
            drawRectangleFancy(getDrawLeft() + 5, getDrawTop() + 5, getDrawRight() + 5, getDrawBottom() + 5, make_color_rgb(46, 50, 59), make_color_rgb(46, 50, 59), 1);
            drawRectangleFancy(getDrawLeft(), getDrawTop(), getDrawRight(), getDrawBottom(), make_color_rgb(248, 45, 97), make_color_rgb(46, 50, 59), 1);
        });
        visBlend = make_color_rgb(255, 255, 255);
        setFlow("wrap", "x");
        setFlowSpacing(10, 10, 9, 9, 1, 1);
        setFlowAlignment("left", "top", "left", "top");
        setWidth((3 * _ability_box_size) + flowMarginLeft + flowMarginRight + 4);
        setHeight(120);
        var _i = 0;
        
        repeat (global.equipmentUnlockedSlotNum)
        {
            with (newChild(undefined, "AE slot group"))
            {
                slotIndex = _i;
                setWidth(_ability_box_size);
                setHeight(_ability_box_size);
                eventAddFunction(UnknownEnum.Value_5, function()
                {
                    var _element = uiGet("AE slots");
                    
                    if (_element.drawReplace)
                    {
                        if (input_player_source_get() == UnknownEnum.Value_2)
                        {
                            if (rootInstance.selectedSlot != slotIndex)
                                uiGet("AE selected slot overlay").borderT = 0;
                            
                            rootInstance.selectedSlot = slotIndex;
                        }
                    }
                    else if (input_player_source_get() == UnknownEnum.Value_2)
                    {
                        rootInstance.SelectSlot(slotIndex);
                    }
                });
                eventAddFunction(UnknownEnum.Value_7, function()
                {
                    visBlend = make_color_rgb(255, 255, 255);
                });
                eventAddFunction(UnknownEnum.Value_2, function()
                {
                    drawRectangleFancy(getDrawLeft() - 1, getDrawTop() - 1, getDrawRight() + 1, getDrawBottom() + 1, visBlend, make_color_rgb(46, 50, 59), 1);
                    var _abilityIndex = global.equipmentSlot[| slotIndex];
                    
                    if (_abilityIndex >= 0)
                        drawSpriteSize(global.upgradeIcon[| _abilityIndex], 1, getDrawX(), getDrawY(), 32, 0, 16777215, 1);
                });
                eventAddFunction(UnknownEnum.Value_10, function()
                {
                    var _element = uiGet("AE slots");
                    
                    if (!_element.drawReplace)
                    {
                        if (rootInstance.selectedSlot == slotIndex)
                        {
                            playSoundAbilityEquipMenuTakeOff();
                            global.equipmentSlot[| slotIndex] = -1;
                            rootInstance.DeselectAbility(slotIndex);
                            toggleEquippedAbility();
                        }
                        else
                        {
                            playSoundAbilityEquipMenuSelect();
                            rootInstance.SelectSlot(slotIndex);
                        }
                    }
                    else
                    {
                        if (rootInstance.selectedAbility >= 0)
                        {
                            playSfxUI(sfx_equip_replaceConfirm);
                            global.equipmentSlot[| slotIndex] = rootInstance.selectedAbility;
                            rootInstance.SelectSlot(slotIndex);
                            toggleEquippedAbility();
                        }
                        
                        with (uiGet("AE overlay"))
                        {
                            drawBlack = false;
                            setActive(false);
                        }
                        
                        with (uiGet("AE scroll"))
                            setChildrenActive(true);
                        
                        with (uiGet("AE slots"))
                        {
                            drawReplace = false;
                            var _old = getRawY();
                            setY(0.25 * uiGet("AE root").getShapeHeight());
                            visYOffset = _old - getRawY();
                        }
                        
                        uiForEachInGroup("AE root", "AE text group", function()
                        {
                            setVisible(true);
                        });
                        rootInstance.DeselectAll();
                        
                        if (input_player_source_get() == UnknownEnum.Value_2)
                            uiFocusNearestDecendent("AE root", uiGet("AE scroll").getShapeX(), uiGet("AE scroll").getShapeY());
                    }
                });
            }
            
            _i++;
        }
        
        updateShape();
        setWidth(outFlowAreaWidth + flowMarginLeft + flowMarginRight);
        setHeight(outFlowAreaHeight + flowMarginTop + flowMarginBottom);
    }
    
    with (newChild("AE selected slot overlay"))
    {
        borderT = 0;
        eventAddFunction(UnknownEnum.Value_2, function()
        {
            if (rootInstance.selectedSlot >= 0)
            {
                borderT = approach(borderT, 1, 0.1);
                uiForEachInGroup("AE root", "AE slot group", function(arg0)
                {
                    var _borderQ = animcurve_tween(0, 1, curveBackInv, arg0);
                    var _outer = lerp(2, 6, _borderQ);
                    var _inner = _outer - 2;
                    var _size = lerp(20, 32, _borderQ);
                    
                    if (rootInstance.selectedSlot == slotIndex)
                    {
                        var _ability_index = global.equipmentSlot[| slotIndex];
                        
                        if (_ability_index < 0)
                        {
                            if (input_player_source_get() == UnknownEnum.Value_2)
                            {
                                drawSquircle(getDrawLeft() - _outer, getDrawTop() - _outer, getDrawRight() + _outer, getDrawBottom() + _outer, 0, make_color_rgb(46, 50, 59), 1);
                                drawSquircleWithOutline(getDrawLeft() - _inner, getDrawTop() - _inner, getDrawRight() + _inner, getDrawBottom() + _inner, 0, make_color_rgb(255, 255, 255), make_color_rgb(255, 238, 96), 1);
                            }
                        }
                        else
                        {
                            drawSquircle(getDrawLeft() - _outer, getDrawTop() - _outer, getDrawRight() + _outer, getDrawBottom() + _outer, 0, make_color_rgb(46, 50, 59), 1);
                            drawSquircleWithOutline(getDrawLeft() - _inner, getDrawTop() - _inner, getDrawRight() + _inner, getDrawBottom() + _inner, 0, make_color_rgb(255, 255, 255), make_color_rgb(255, 238, 96), 1);
                            drawSpriteSize(global.upgradeIcon[| _ability_index], 0, getDrawX(), getDrawY(), _size, 0, 16777215, 1);
                            var _element = uiGet("AE slots");
                            var _phrase = _element.drawReplace ? loc("ability menu select replace") : loc("ability menu select remove");
                            scribble("[scale,0.27]" + _phrase).starting_format(locGetFontFromLanguage(), make_color_rgb(46, 50, 59)).align(1, 1).msdf_border(make_color_rgb(255, 255, 255), 5).draw(getDrawX(), (getDrawBottom() + _outer) - 0.5);
                        }
                    }
                }, borderT);
            }
        });
    }
    
    with (newChild())
    {
        setActive(false);
        setChildrenActive(false);
        setX(0.5 * getParent().getShapeWidth());
        setBottom((0.58 * getParent().getShapeHeight()) + 3);
        setWidth(min(160, getParent().getShapeWidth() - 20));
        setHeight(50);
        updateShape();
        
        with (newChild("AE ability description", "AE text group"))
        {
            setRight(getParent().getShapeWidth() - 1);
            setBottom(getParent().getShapeHeight() - 1);
            setWidth(min(getParent().getShapeWidth(), 120));
            setHeight(34);
            text = "";
            textElement = scribble(text);
            eventAddFunction(UnknownEnum.Value_2, function()
            {
                var _text = (rootInstance.selectedAbility < 0) ? "" : loc(abilityGetIndexName(rootInstance.selectedAbility) + " desc");
                
                if (_text != text)
                {
                    text = "[fa_middle][scale,0.33]" + _text;
                    textElement = scribble(text).starting_format(global.defaultFont, make_color_rgb(46, 50, 59)).fit_to_box(getRawWidth() - 10, getRawHeight() - 4, locIsAsian());
                }
                
                if (rootInstance.selectedAbility >= 0 && text != "" && text == textElement.text)
                {
                    drawSquircleWithOutline(getDrawLeft(), getDrawTop(), getDrawRight(), getDrawBottom(), 10, make_color_rgb(198, 203, 211), make_color_rgb(46, 50, 59), 1);
                    textElement.draw(getDrawX() - (textElement.get_width() / 2), getDrawY());
                }
            });
        }
        
        with (newChild("AE ability name", "AE text group"))
        {
            setLeft(0);
            setTop(0);
            setWidth(0);
            setHeight(0);
            text = "";
            textElement = scribble(text);
            eventAddFunction(UnknownEnum.Value_2, function()
            {
                var _text = (rootInstance.selectedAbility < 0) ? "" : loc(abilityGetIndexName(rootInstance.selectedAbility) + " name");
                
                if (_text != text)
                {
                    text = "[fa_left][fa_middle][scale,0.33]" + _text;
                    textElement = scribble(text).starting_format(global.defaultFont, make_color_rgb(46, 50, 59));
                    var _bbox = textElement.get_bbox();
                    setWidth(_bbox.width + 10);
                    setHeight(_bbox.height + 8);
                    updateVisual();
                }
                
                if (rootInstance.selectedAbility >= 0 && text != "" && text == textElement.text)
                {
                    drawSquircleWithOutline(getDrawLeft(), getDrawTop(), getDrawRight(), getDrawBottom(), getRawHeight() / 2, make_color_rgb(255, 233, 1), make_color_rgb(46, 50, 59), 1);
                    textElement.draw(getDrawLeft() + 6, getDrawY());
                }
            });
        }
    }
}
