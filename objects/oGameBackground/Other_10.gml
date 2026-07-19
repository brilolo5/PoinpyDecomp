var viewy = getViewy(global.cam);
var viewx = getViewx(global.cam);
draw_clear(make_color_rgb(255, 255, 255));

switch (bgArea)
{
    case UnknownEnum.Value_2:
        drawRectangleXYWH(viewx, viewy, global.viewWidth, global.viewHeight, bgLayerData[0], 1);
        drawBgVineLight(viewx, viewy, global.viewWidth, global.viewHeight);
        drawBgLoopScrollPartsAsWhole(sBgLayer_VineBush_parts, 0.5);
        break;
    
    case UnknownEnum.Value_3:
        drawRectangleXYWH(viewx, viewy, global.viewWidth, global.viewHeight, bgLayerData[0], 1);
        drawBgLoopScrollPartsAsWhole(sBgLayer_BubbleBackFog_parts, 0.2);
        drawBgLoopScrollPartsAsWhole(sBgLayer_BubbleFrontFog_parts, 0.5);
        break;
    
    case UnknownEnum.Value_4:
        drawRectangleXYWH(viewx, viewy, global.viewWidth, global.viewHeight, bgLayerData[0], 1);
        drawBgLoopScrollPartsAsWhole(sBgLayer_JumppadFar_parts, 0.2);
        drawBgLoopScrollPartsAsWhole(sBgLayer_JumppadFront_parts, 0.5);
        break;
    
    case UnknownEnum.Value_5:
        drawRectangleXYWH(viewx, viewy, global.viewWidth, global.viewHeight, bgLayerData[0], 1);
        drawBgLoopScrollPartsAsWhole(sBgLayer_CannonStars_parts, 0.1);
        drawBgMoon(viewx + (global.viewWidth / 2), viewy + 28, 0.1);
        drawBgLoopScrollPartsAsWhole(sBgLayer_CannonClouds_parts, 0.15);
        drawBgLoopScrollPartsAsWhole(sBgLayer_CannonStructure_parts, 0.8);
        break;
    
    case UnknownEnum.Value_6:
        var _finalAreaStage = global.difficultyLevel - 20;
        
        if (finalAreaHorizonOffset == 0)
            finalAreaHorizonOffset = getViewy(global.cam) - 1000;
        
        var _scrollSpeed = 0;
        var _scrollSpeedShift = 0.01;
        
        switch (_finalAreaStage)
        {
            case 0:
                _scrollSpeed = 0.025;
                break;
            
            case 1:
                _scrollSpeed = 1;
                break;
            
            case 2:
                _scrollSpeed = 4;
                break;
            
            case 3:
                _scrollSpeed = 10;
                break;
            
            case 4:
                _scrollSpeed = 20;
                break;
            
            case 5:
                _scrollSpeed = 0;
                _scrollSpeedShift = 0;
                finalAreaStarScrollSpeed = lerp(finalAreaStarScrollSpeed, 0.02, 0.025);
                break;
        }
        
        finalAreaStarScrollSpeed = approach(finalAreaStarScrollSpeed, _scrollSpeed, _scrollSpeedShift);
        drawSpriteSetSize(sBgPart_OuterSpaceBack, 0, viewx, viewy, global.viewWidth, global.viewHeight);
        var _horizonOffset = ((-finalAreaStarScrolly + finalAreaHorizonOffset) - viewy - 9000) / 256;
        var _horizonHeight = viewy + (global.viewHeight / 2);
        var _planetAsset = sBgPart_PlanetContinent;
        var _planetShrink = global.viewWidth / sprite_get_width(_planetAsset);
        var _alpha = 0;
        drawRectangleLTRB(viewx, viewy, viewx + global.viewWidth, viewy + global.viewHeight, 16777215, _alpha);
        finalAreaStarScrolly += (-finalAreaStarScrollSpeed * global.timeScale);
        drawBgLoopScrollPartsAsWhole(sBgPart_Stars3, 0.0005, finalAreaStarScrolly / 10);
        drawBgLoopScrollPartsAsWhole(sBgPart_Stars2, 0.005, finalAreaStarScrolly / 5);
        drawBgLoopScrollPartsAsWhole(sBgPart_Stars1, 0.02, finalAreaStarScrolly);
        
        if (drawPlanetHorizon)
        {
            drawSpriteSetSize(sBgPart_PlanetHorizon, 0, viewx + (global.viewWidth / 2), _horizonHeight, global.viewWidth / 2, sprite_get_height(sBgPart_PlanetContinent));
            drawSpriteSetSize(sBgPart_PlanetHorizon, 0, viewx + (global.viewWidth / 2), _horizonHeight, -global.viewWidth / 2, sprite_get_height(sBgPart_PlanetContinent));
            drawBgPartsAsWhole(sBgPart_PlanetContinent, viewx, _horizonHeight + 8, _planetShrink, _planetShrink);
        }
        
        var _starAsset = sBgLayer_SpaceStars;
        var _starShrink = global.viewWidth / sprite_get_width(_starAsset);
        gpu_set_blendmode_ext(bm_dest_color, bm_src_alpha);
        drawBgLoopScrollPartsAsWhole(sBgPart_SpaceFog, 0.1);
        gpu_set_blendmode(bm_normal);
        var _magmaHorizonOffset = 0;
        
        with (oMagma)
        {
        }
        
        var _magmaHorizon = viewy + (global.viewHeight / 2) + _magmaHorizonOffset;
        
        if (drawTestHorizon)
        {
            var _lineBasey = viewy + (global.viewHeight / 1.25);
            var _lineBasex = viewx + 0;
            var _vanishingPointx = global.viewWidth / 2;
            var _vanishingPointy = _magmaHorizon;
            var _horizonWidth = global.viewWidth * 16;
            var _horizonLeft = (global.viewWidth / 2) - (_horizonWidth / 2);
            var _horizonRight = (global.viewWidth / 2) + (_horizonWidth / 2);
            var _time = global.timeScaledTime;
            var _verticalPoints = 10;
            var _horizontalPoints = 17;
            draw_set_color(make_color_rgb(254, 66, 113));
            draw_primitive_begin(pr_linestrip);
            draw_vertex(_horizonLeft, _vanishingPointy);
            draw_vertex(_horizonRight, _vanishingPointy);
            draw_primitive_end();
            
            for (var t = 0; t <= _horizontalPoints; t += 1)
            {
                _lineBasex = lerp(_horizonLeft, _horizonRight, t / _horizontalPoints);
                _time += 32;
                draw_set_color(make_color_rgb(254, 66, 113));
                draw_primitive_begin(pr_linestrip);
                
                for (var i = 0; i <= _verticalPoints; i += 1)
                {
                    var _lerpValInv = (_verticalPoints - i) / _verticalPoints;
                    var _lerpVal = i / _verticalPoints;
                    var _timeScale = 40;
                    var _timeDif = 60;
                    var _offsetWidth = 3;
                    var _pointSize = 2 * _lerpValInv;
                    var _offsetx = sin((_time - (i * _timeDif)) / _timeScale) * _offsetWidth * _lerpValInv;
                    var _offsety = cos((_time - (i * _timeDif)) / _timeScale) * _offsetWidth * _lerpValInv;
                    var _curveVal = animcurveGetValueAtPos(curveCircInv, "curve1", _lerpVal);
                    var _pointx = lerp(_lineBasex, _vanishingPointx, _curveVal);
                    var _pointy = lerp(_lineBasey, _vanishingPointy, _curveVal) + _offsety;
                    draw_vertex(_pointx, _pointy);
                    drawCircleFast(_pointx, _pointy, _pointSize, make_color_rgb(254, 66, 113), 1);
                }
                
                draw_primitive_end();
            }
        }
        
        if (drawTestVerticalHorizon)
        {
            var _lineBasey = viewy;
            var _lineBasex = viewx;
            var _linePointLength = 24;
            var _time = global.timeScaledTime;
            draw_set_color(make_color_rgb(65, 162, 255));
            var _repeatLines = 6;
            
            for (var t = 1; t <= _repeatLines; t += 1)
            {
                var _lerpValue = t / _repeatLines;
                var _lerpValue_reverse = (_repeatLines - t) / _repeatLines;
                draw_primitive_begin(pr_linestrip);
                var _col = merge_color(make_color_rgb(65, 162, 255), make_color_rgb(46, 50, 59), t / 13);
                draw_set_color(_col);
                _lineBasex = lerp(_lineBasex, (global.viewWidth / 2) - 4, _lerpValue);
                _lineBasey -= 8;
                _linePointLength = lerp(24, 16, _lerpValue);
                var _repeatAmount = ceil(global.viewHeight / _linePointLength);
                var _ballSize = ((9 - t) / 9) * 1;
                var _xOffsetWidth = 10 * (_lerpValue_reverse - 0.1);
                
                for (var i = 0; i < _repeatAmount; i += 1)
                {
                    var _xOffset = sin((_time - (i * 30)) / 30) * _xOffsetWidth;
                    var _pointx = _lineBasex + _xOffset;
                    var _pointy = _lineBasey + (_linePointLength * i);
                    draw_vertex(_pointx, _pointy);
                    drawCircleFast(_pointx, _pointy, _ballSize, _col, 1);
                }
                
                draw_primitive_end();
                draw_primitive_begin(pr_linestrip);
                var _midpoint = global.viewWidth / 2;
                var _slineBasex = _midpoint + (_midpoint - _lineBasex);
                
                for (var s = 0; s < _repeatAmount; s += 1)
                {
                    var _xOffset = sin((_time - (s * 30)) / 30) * -_xOffsetWidth;
                    var _pointx = _slineBasex + _xOffset;
                    var _pointy = _lineBasey + (_linePointLength * s);
                    draw_vertex(_pointx, _pointy);
                    drawCircleFast(_pointx, _pointy, _ballSize, _col, 1);
                }
                
                draw_primitive_end();
            }
        }
        
        break;
    
    case UnknownEnum.Value_1:
        var _bg = sBgLobby;
        drawBgLoopScrollPartsAsWhole(_bg, 0.25);
        break;
    
    case 100:
        _bg = sBgLayer_Tutorial_parts;
        drawBgLoopScrollPartsAsWhole(_bg, 0.25);
        break;
    
    default:
        break;
}
