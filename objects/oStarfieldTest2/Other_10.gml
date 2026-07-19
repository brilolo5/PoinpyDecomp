var viewy = getViewy(global.cam);
var viewx = getViewx(global.cam);
drawSpriteSetSize(sBgPart_OuterSpaceBack, 0, viewx, viewy, global.viewWidth, global.viewHeight);
var _centerx = viewx + (global.viewWidth / 2);
var _centery = viewy + (global.viewHeight / 2) + centeryOffset;
centeryOffset = lerp(centeryOffset, 0, 0.004);

for (var _i = 0; _i < starCount; _i += 1)
{
    star_z[_i] -= starSpeed;
    
    if (star_z[_i] <= 0)
    {
        star_z[_i] = zMax;
        star_pz[_i] = star_z[_i];
        star_x[_i] = random_range(posAvoidSpace, posOffsetRangex) * choose(-1, 1);
        star_y[_i] = random_range(posAvoidSpace, posOffsetRangey) * choose(-1, 1);
    }
    
    var _xpos = _centerx + map(star_x[_i] / star_z[_i], 0, 1, 0, 64);
    var _ypos = _centery + map(star_y[_i] / star_z[_i], 0, 1, 0, 128);
    var _zRatio = map(star_z[_i], 0, zMax, 1, 0);
    var _p_starSize = starBaseScale * map(star_pz[_i], 0, zMax, 1, 0);
    var _starSize = starBaseScale * _zRatio;
    var _px = _centerx + map(star_x[_i] / star_pz[_i], 0, 1, 0, 64);
    var _py = _centery + map(star_y[_i] / star_pz[_i], 0, 1, 0, 128);
    draw_set_color(c_white);
    var _alpha = _zRatio * 2;
    var _imageIndex = (star_x[_i] + star_y[_i]) % 3;
    draw_sprite_ext(sEndStar, _imageIndex, _px, _py, _p_starSize, _p_starSize, 0, c_white, _alpha);
    draw_sprite_ext(sEndStar, _imageIndex, _xpos, _ypos, _starSize, _starSize, 0, c_white, _alpha);
    star_pz[_i] = star_z[_i] - 2;
}

var _shakeValue = 0.2;
var _viewCenterx = _centerx + random_range(-_shakeValue, _shakeValue);
var _viewMiddley = _centery + random_range(-_shakeValue, _shakeValue);
appleSize += appleSizeIncreaseRate;
var _sunScale = baseAppleSize * appleSize * 2;
appleShadeAlpha = approach(appleShadeAlpha, 0, appleShadeClearRate);
drawSetInterpolation(false);
drawSetInterpolation(true);
