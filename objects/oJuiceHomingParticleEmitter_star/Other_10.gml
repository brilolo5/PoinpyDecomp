var _baseline = (getViewy(global.cam) + global.viewHeight) - 32;

if (autoAdjustTrajectory)
{
    splineY0 = min(splineY0, _baseline - 40);
    splineY1 = min(splineY1, _baseline - 80);
    splineY2 = min(splineY2, _baseline - 120);
    splineY3 = min(splineY3, _baseline);
    splineY0 = min(splineY0, _baseline - 40);
    splineY1 = min(splineY1, _baseline - 80);
    splineY2 = min(splineY2, _baseline - 120);
    splineY3 = _baseline;
}

colorArray[0] = make_color_rgb(248, 45, 97);
colorArray[1] = make_color_rgb(36, 145, 249);
colorArray[2] = make_color_rgb(65, 231, 125);
colorArray[3] = make_color_rgb(225, 223, 1);
colorArray[4] = make_color_rgb(255, 255, 255);
colorArray[5] = make_color_rgb(255, 238, 96);
colorArray[6] = make_color_rgb(255, 238, 96);
colorMax = 4;
var _arrayLength = array_length(particleArray);
var _i = array_length(particleArray) - 1;

repeat (_i + 1)
{
    var _particle = particleArray[_i];
    var _time = _particle[UnknownEnum.Value_3];
    _time += (bezierSpeed * global.deltaTimeRate);
    
    if (_time > 1)
    {
        array_delete(particleArray, _i, 1);
        _i--;
        
        with (oOrderControl)
        {
            satisfactionMeterTween_dewReceived = 1;
            beast_dewReceiveWobbleTween += 0.1;
            beast_sequenceTimer = 0;
            beastState = "glug";
        }
        
        with (oBeastMainGame)
            shrinkScaleOffset = fruitReceiveWobbleScale;
        
        with (oEndingSequence)
        {
            if (currentSequence == "gulp")
                beastShrinkRate += 0.05;
        }
    }
    else
    {
        array_set(_particle, UnknownEnum.Value_3, _time);
        var _image = _particle[UnknownEnum.Value_2];
        _image += 0.25;
        array_set(_particle, UnknownEnum.Value_2, _image);
        var _x = splineInterpolate4(_time, splineX0, splineX1, splineX2, splineX3);
        var _y = splineInterpolate4(_time, splineY0, splineY1, splineY2, splineY3);
        var _ydif = abs(array_get(_particle, UnknownEnum.Value_5) - _y);
        _ydif = clamp(((_ydif * 1) / 10) * 0.1, -0.1, 0.1);
        var _angle = 0;
        var _indivAngle = (global.time * 5) + ((_i * 10) % 360);
        array_set(_particle, UnknownEnum.Value_8, _indivAngle);
        var _col = colorArray[(floor(global.time / 10) + _i) % (colorMax + 1)];
        array_set(_particle, UnknownEnum.Value_1, _col);
        array_set(_particle, UnknownEnum.Value_4, _x);
        array_set(_particle, UnknownEnum.Value_5, _y);
        var _val = _y / 8;
        var _xscale = 0.1 * dewBaseScale * ((0.1 * sin(_val / 2)) + 0.9);
        var _yscale = (0.1 * dewBaseScale * ((0.1 * cos(_val + 1.5707963267948966)) + 0.9)) + _ydif;
        array_set(_particle, UnknownEnum.Value_6, _xscale);
        array_set(_particle, UnknownEnum.Value_7, _yscale);
        
        if (_time > 0.5 && _y > _baseline)
        {
            array_delete(particleArray, _i, 1);
            _i--;
            
            with (oOrderControl)
                satisfactionMeterTween_dewReceived = 1;
            
            with (oBeastMainGame)
                shrinkScaleOffset = fruitReceiveWobbleScale;
        }
        else
        {
            var _dewColor = _particle[UnknownEnum.Value_1];
            _dewColor = merge_color(_dewColor, make_color_rgb(46, 50, 59), 0.5);
            draw_sprite_ext(sStarJuiceDew_border, _image, _x, _y, _xscale, _yscale, _indivAngle, _dewColor, 1);
            _i -= 1;
        }
    }
}

var _old_interpolation = gpu_get_tex_filter();
gpu_set_tex_filter(false);
_i = 0;
var _array_length = array_length(particleArray);

repeat (_array_length)
{
    var _particle = particleArray[_i];
    draw_sprite_ext(_particle[UnknownEnum.Value_0], _particle[UnknownEnum.Value_2], _particle[UnknownEnum.Value_4], _particle[UnknownEnum.Value_5], _particle[UnknownEnum.Value_6], _particle[UnknownEnum.Value_7], _particle[UnknownEnum.Value_8], _particle[UnknownEnum.Value_1], 1);
    
    if (((_i + 1) % 6) == 0 && (global.time % 8) == 0)
    {
        var _dewColor = _particle[UnknownEnum.Value_1];
        
        with (generateEffect(_particle[UnknownEnum.Value_4], _particle[UnknownEnum.Value_5], "temp juice splash", 0))
        {
            sprite_index = sSplashEffectTest02;
            var _randDir = _particle[UnknownEnum.Value_8] - 90;
            _randDir += random_range(-10, 10);
            var _randSp = random_range(2, 4);
            fric = 0;
            grav = 0.2;
            xsp = lengthdir_x(_randSp, _randDir);
            ysp = lengthdir_y(_randSp, _randDir);
            imageAngle = _randDir;
            animationSpeed = 0.3;
            setColor = _dewColor;
        }
    }
    
    _i++;
}

_i = 0;
_array_length = array_length(particleArray);

repeat (_array_length)
{
    var _particle = particleArray[_i];
    _i++;
}

if (spawnCount >= emitterFruitNum && totalGold <= 0 && array_length(particleArray) <= 0)
{
    audioSystemStopAsset(sfx_fruit_press_lp);
    playSoundFruitPressTail();
    instance_destroy();
}

gpu_set_tex_filter(_old_interpolation);
