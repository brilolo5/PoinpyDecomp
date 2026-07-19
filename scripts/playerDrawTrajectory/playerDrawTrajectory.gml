function playerDrawTrajectory(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
{
    var _trajDashTweenRate = 0.16666666666666666 * global.deltaTimeRate;
    trajecoryDashAppearTween = approach(trajecoryDashAppearTween, 0, _trajDashTweenRate);
    var _trajExtendRate = 0.1111111111111111 * global.deltaTimeRate;
    trajectoryExtend = min(1, trajectoryExtend + _trajExtendRate);
    var _platformBoost = -1;
    var _dashScale = 1/15;
    var _dashXScale = _dashScale * (1 + (trajecoryDashAppearTween * 0.5));
    var _dashYScale = _dashScale * (1 + trajecoryDashAppearTween);
    var _dashShadowYOffset = 0.5;
    var _dashOffset = current_time / 30;
    _dashOffset = current_time / 70;
    _dashOffset = current_time / 50;
    var _dashLength = _dashScale * sprite_get_width(sTrajectoryDash);
    var _dashSpacing = 1.25 * _dashLength * 0.5;
    var _wallBouncePointx = -1;
    var _wallBouncePointy = -1;
    var px = arg0 + arg1;
    var py = arg2 + arg3;
    var _trajTweenLerpRate = 0.75;
    trajectoryTweenXsp = lerp(trajectoryTweenXsp, arg5, _trajTweenLerpRate);
    trajectoryTweenYsp = lerp(trajectoryTweenYsp, arg6, _trajTweenLerpRate);
    var _tempXsp = trajectoryTweenXsp;
    var _tempYsp = trajectoryTweenYsp;
    var _trajx = px;
    var _trajy = py;
    var _grv = grv;
    var _wallBounce = false;
    var _verticalCollision = false;
    var _trajectoryDrawLength = arg4 * 4 * trajectoryExtend * 1.25;
    var _trajectoryPoints = [];
    array_push(_trajectoryPoints, _trajx, _trajy);
    
    if (instance_place_with(px, py + 1, parentOnewayPlatform, oPlayer) && arg6 > 0)
        _trajectoryDrawLength = 0;
    
    if ((oPlayer.currentState == "ground" || oPlayer.currentState == "slam bounce") && arg6 > 0)
    {
        _tempYsp = 0;
        _tempXsp = sign(_tempXsp) * 10;
        _trajx += _tempXsp;
        _grv = 0;
        _trajectoryDrawLength = 4;
    }
    else
    {
        repeat (2)
        {
            _trajx += _tempXsp;
            _trajy += _tempYsp;
            _tempYsp += _grv;
        }
    }
    
    for (var i = 0; i < _trajectoryDrawLength; i++)
    {
        if (instance_place_with(_trajx, _trajy + _tempYsp, oGimCannon, oPlayer))
            break;
        
        var _wall = instance_place_with(_trajx, _trajy + _tempYsp, parentWall, oPlayer);
        var _onewayPlatformAhead = instance_place_with(_trajx, _trajy + _tempYsp, parentOnewayPlatform, oPlayer);
        var _onewayPlatform = _tempYsp > 0 && _onewayPlatformAhead && !instance_place_with(_trajx, _trajy, parentOnewayPlatform, oPlayer);
        
        if (_wall || _onewayPlatform)
        {
            _verticalCollision = true;
        }
        else
        {
            _wall = instance_place_with(_trajx + _tempXsp, _trajy, parentWall, oPlayer);
            
            if (_wall)
            {
                if (_wall.object_index == oCogWall)
                {
                    _wallBounce = true;
                    _trajx = (floor(_wall.x / 8) * 8) - (sign(_tempXsp) * 15);
                    _trajy -= 3;
                    _tempXsp = 0;
                    _tempYsp = -4;
                    _grv = 0;
                    _wallBouncePointx = -1000;
                    _wallBouncePointy = 1000;
                    i = clamp(i, _trajectoryDrawLength / 1.3, _trajectoryDrawLength);
                }
                
                if (instance_place(_trajx + _tempXsp, _trajy, oSoftPadding) || _wall.object_index == oSoftWall)
                    break;
                
                if (!_wallBounce)
                {
                    _wallBounce = true;
                    var _bboxEdge = (sign(_tempXsp) > 0) ? _wall.bbox_left : _wall.bbox_right;
                    _trajx = _bboxEdge - (sign(_tempXsp) * 6);
                    
                    if (abilityCheck(UnknownEnum.Value_5))
                    {
                        _tempXsp = 1.6 * sign(-_tempXsp);
                        _tempYsp = -5.25;
                    }
                    else
                    {
                        _tempXsp = 1.75 * sign(-_tempXsp);
                        _tempYsp = -4;
                    }
                    
                    i = clamp(i, _trajectoryDrawLength / 2, _trajectoryDrawLength / 1.25);
                    _wallBouncePointx = _trajx;
                    _wallBouncePointy = _trajy + (_tempYsp / 2);
                }
            }
        }
        
        _trajx += _tempXsp;
        _trajy += _tempYsp;
        array_push(_trajectoryPoints, _trajx, _trajy);
        
        if (_verticalCollision)
            break;
        
        _tempYsp += _grv;
    }
    
    if (array_length(_trajectoryPoints) >= 4)
    {
        var _goalDist = (0.5 * _dashLength) + (_dashOffset % (_dashSpacing + _dashLength));
        var _travelledDist = 0;
        var _nextDist = 0;
        var _x1 = undefined;
        var _y1 = undefined;
        var _x2 = _trajectoryPoints[0];
        var _y2 = _trajectoryPoints[1];
        var _i = 2;
        var _trajectoryRepeatAmount = (array_length(_trajectoryPoints) div 2) - 1;
        
        repeat (_trajectoryRepeatAmount)
        {
            _x1 = _x2;
            _y1 = _y2;
            _x2 = _trajectoryPoints[_i];
            _y2 = _trajectoryPoints[_i + 1];
            var _length = point_distance(_x1, _y1, _x2, _y2);
            _nextDist = _travelledDist + _length;
            
            if (_nextDist > _goalDist)
            {
                var _dir = point_direction(_x1, _y1, _x2, _y2);
                var _t = (_goalDist - _travelledDist) / _length;
                var _dashX = lerp(_x1, _x2, _t);
                var _dashY = lerp(_y1, _y2, _t);
                var _shadowScale = 1;
                draw_sprite_ext(sTrajectoryDash, 0, _dashX, _dashY + _dashShadowYOffset, _dashXScale * _shadowScale, _dashYScale * _shadowScale, _dir, make_color_rgb(46, 50, 59), 1);
                draw_sprite_ext(sTrajectoryDash, 1, _dashX, _dashY, _dashXScale, _dashYScale, _dir, make_color_rgb(255, 255, 255), 1);
                _goalDist += (_dashSpacing + _dashLength);
            }
            
            _travelledDist = _nextDist;
            _i += 2;
        }
        
        if (_wallBounce)
        {
            var _circRadius = 4;
            draw_set_color(make_color_rgb(46, 50, 59));
            draw_circle(_wallBouncePointx, _wallBouncePointy, _circRadius + 1, 0);
            draw_circle(_wallBouncePointx, _wallBouncePointy + _dashShadowYOffset, _circRadius + 1, 0);
            draw_set_color(make_color_rgb(255, 255, 255));
            draw_circle(_wallBouncePointx, _wallBouncePointy, _circRadius, 0);
        }
    }
}

function playerDrawTrajectory_invincible(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
{
    var _trajDashTweenRate = 0.16666666666666666 * global.deltaTimeRate;
    trajecoryDashAppearTween = approach(trajecoryDashAppearTween, 0, _trajDashTweenRate);
    var _trajExtendRate = 0.1111111111111111 * global.deltaTimeRate;
    trajectoryExtend = min(1, trajectoryExtend + _trajExtendRate);
    var _dashScale = 1/15;
    var _dashXScale = _dashScale * (1.2 + (trajecoryDashAppearTween * 0.5));
    var _dashYScale = _dashScale * (1.2 + trajecoryDashAppearTween);
    var _dashShadowYOffset = 0.5;
    var _dashOffset = current_time / 30;
    _dashOffset = current_time / 70;
    _dashOffset = 0;
    var _dashLength = _dashScale * sprite_get_width(sTrajectoryDash);
    var _dashSpacing = 1.25 * _dashLength * 0.5;
    var _wallBouncePointx = -1;
    var _wallBouncePointy = -1;
    var px = arg0 + arg1;
    var py = arg2 + arg3;
    var _trajTweenLerpRate = 0.75;
    trajectoryTweenXsp = lerp(trajectoryTweenXsp, arg5, _trajTweenLerpRate);
    trajectoryTweenYsp = lerp(trajectoryTweenYsp, arg6, _trajTweenLerpRate);
    var _tempXsp = trajectoryTweenXsp;
    var _tempYsp = trajectoryTweenYsp;
    var _trajx = px;
    var _trajy = py;
    var _grv = grv;
    var _wallBounce = false;
    var _verticalCollision = false;
    var _trajectoryDrawLength = arg4 * 4 * trajectoryExtend * 1.25;
    var _wallBounceAt = 99;
    var _trajectoryPoints = [];
    array_push(_trajectoryPoints, _trajx, _trajy);
    
    if (instance_place_with(px, py + 1, parentOnewayPlatform, oPlayer) && arg6 > 0)
        _trajectoryDrawLength = 0;
    
    if ((oPlayer.currentState == "ground" || oPlayer.currentState == "slam bounce") && arg6 > 0)
    {
        _tempYsp = 0;
        _tempXsp = sign(_tempXsp) * 10;
        _trajx += _tempXsp;
        _grv = 0;
        _trajectoryDrawLength = 4;
    }
    else
    {
        repeat (2)
        {
            _trajx += _tempXsp;
            _trajy += _tempYsp;
            _tempYsp += _grv;
        }
    }
    
    for (var i = 0; i < _trajectoryDrawLength; i++)
    {
        if (instance_place_with(_trajx, _trajy + _tempYsp, oGimCannon, oPlayer))
            break;
        
        var _wall = instance_place_with(_trajx, _trajy + _tempYsp, parentWall, oPlayer);
        var _onewayPlatform = _tempYsp > 0 && instance_place_with(_trajx, _trajy + _tempYsp, parentOnewayPlatform, oPlayer) && !instance_place_with(_trajx, _trajy, parentOnewayPlatform, oPlayer);
        
        if (_wall || _onewayPlatform)
        {
            _verticalCollision = true;
        }
        else
        {
            _wall = instance_place_with(_trajx + _tempXsp, _trajy, parentWall, oPlayer);
            
            if (_wall)
            {
                if (_wall.object_index == oCogWall)
                {
                    _wallBounce = true;
                    _trajx = (floor(_wall.x / 8) * 8) - (sign(_tempXsp) * 15);
                    _trajy -= 3;
                    _tempXsp = 0;
                    _tempYsp = -4;
                    _grv = 0;
                    _wallBouncePointx = -1000;
                    _wallBouncePointy = 1000;
                    i = clamp(i, _trajectoryDrawLength / 1.3, _trajectoryDrawLength);
                }
                
                if (instance_place(_trajx + _tempXsp, _trajy, oSoftPadding) || _wall.object_index == oSoftWall)
                    break;
                
                if (!_wallBounce)
                {
                    _wallBounce = true;
                    var _bboxEdge = (sign(_tempXsp) > 0) ? _wall.bbox_left : _wall.bbox_right;
                    _trajx = _bboxEdge - (sign(_tempXsp) * 6);
                    
                    if (abilityCheck(UnknownEnum.Value_5))
                    {
                        _tempXsp = 1.6 * sign(-_tempXsp);
                        _tempYsp = -5.25;
                    }
                    else
                    {
                        _tempXsp = 1.75 * sign(-_tempXsp);
                        _tempYsp = -4;
                    }
                    
                    _wallBounceAt = (i * 2) + 2;
                    i = clamp(i, _trajectoryDrawLength / 2, _trajectoryDrawLength / 1.25);
                    _wallBouncePointx = _trajx;
                    _wallBouncePointy = _trajy + (_tempYsp / 2);
                }
            }
        }
        
        _trajx += _tempXsp;
        _trajy += _tempYsp;
        array_push(_trajectoryPoints, _trajx, _trajy);
        
        if (_verticalCollision)
            break;
        
        _tempYsp += _grv;
    }
    
    if (array_length(_trajectoryPoints) >= 4)
    {
        var _goalDist = (0.5 * _dashLength) + (_dashOffset % (_dashSpacing + _dashLength));
        var _travelledDist = 0;
        var _nextDist = 0;
        var _x1 = undefined;
        var _y1 = undefined;
        var _x2 = _trajectoryPoints[0];
        var _y2 = _trajectoryPoints[1];
        var colorArray;
        colorArray[0] = make_color_rgb(248, 45, 97);
        colorArray[1] = make_color_rgb(255, 238, 96);
        colorArray[2] = make_color_rgb(254, 66, 113);
        colorArray[3] = make_color_rgb(255, 255, 255);
        colorArray[4] = make_color_rgb(255, 238, 96);
        var _colorMax = 3;
        var _i = 2;
        var _trajectoryRepeatAmount = (array_length(_trajectoryPoints) div 2) - 1;
        
        repeat (_trajectoryRepeatAmount)
        {
            _x1 = _x2;
            _y1 = _y2;
            _x2 = _trajectoryPoints[_i];
            _y2 = _trajectoryPoints[_i + 1];
            var _length = point_distance(_x1, _y1, _x2, _y2);
            _nextDist = _travelledDist + _length;
            
            if (_nextDist > _goalDist)
            {
                var _dir = point_direction(_x1, _y1, _x2, _y2);
                var _t = (_goalDist - _travelledDist) / _length;
                var _dashX = lerp(_x1, _x2, _t);
                var _dashY = lerp(_y1, _y2, _t);
                var _shadowScale = 1;
                draw_sprite_ext(sTrajectoryDash, 0, _dashX, _dashY + _dashShadowYOffset, _dashXScale * _shadowScale, _dashYScale * _shadowScale, _dir, make_color_rgb(46, 50, 59), 1);
                var _col = colorArray[((global.time / 1.5) - (_i / 4)) % (_colorMax + 1)];
                
                if (_i >= _wallBounceAt)
                    _col = make_color_rgb(255, 255, 255);
                
                draw_sprite_ext(sTrajectoryDash, 1, _dashX, _dashY, _dashXScale, _dashYScale, _dir, _col, 1);
                _goalDist += (_dashSpacing + _dashLength);
            }
            
            _travelledDist = _nextDist;
            _i += 2;
        }
        
        if (_wallBounce)
        {
            var _circRadius = 4;
            draw_set_color(make_color_rgb(46, 50, 59));
            draw_circle(_wallBouncePointx, _wallBouncePointy, _circRadius + 1, 0);
            draw_circle(_wallBouncePointx, _wallBouncePointy + _dashShadowYOffset, _circRadius + 1, 0);
            draw_set_color(make_color_rgb(255, 255, 255));
            draw_circle(_wallBouncePointx, _wallBouncePointy, _circRadius, 0);
        }
    }
}
