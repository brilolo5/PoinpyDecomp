sprite_index = sTestBallEnemy;
draw_set_color(c_white);
texture_set_interpolation(false);

function drawEllipseCirclingEllipse(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
{
    var _circlex = arg0 + lengthdir_x(arg2 / 2, arg4);
    var _circley = arg1 + lengthdir_y(arg3 / 2, arg4);
    drawEllipse(_circlex, _circley, arg5, arg6, 0);
}

var cr = global.surfaceCompressionRate;
texture_set_interpolation(true);
var _wobbleTempo = 50;
var _wobbleScalex = sin(global.time / _wobbleTempo);
var _wobbleScaley = cos((global.time / _wobbleTempo) + 1.5707963267948966);
var _wobbleValue = 0.05;
var _cloudScalex = 1.25 + (_wobbleValue * _wobbleScalex);
var _cloudScaley = 1.25 + (_wobbleValue * _wobbleScaley);
_cloudScalex *= (0.1 * cr);
_cloudScaley *= (0.1 * cr);
var _spriteWidth = (sprite_get_width(sUItestThoughtCloud) * _cloudScalex) / cr;
var _spriteHeight = (sprite_get_height(sUItestThoughtCloud) * _cloudScaley) / cr;
var _pieCloudSurfW = _spriteWidth * cr;
var _pieCloudSurfH = _spriteHeight * cr;
var _pieCloudSurface = surface_create_track(_pieCloudSurfW, _pieCloudSurfH);
surface_set_target(_pieCloudSurface);
var _surfCenterx = _pieCloudSurfW / 2;
var _surfMiddley = _pieCloudSurfH / 2;
draw_sprite_ext(sUItestThoughtCloud, 0, _surfCenterx, _surfMiddley, _cloudScalex, _cloudScaley, 0, c_white, 1);
drawPie(_surfCenterx, _surfMiddley, (global.time / 100) % 1, 1, 65280, _pieCloudSurfW, 1, 90);
gpu_set_blendmode(bm_subtract);
draw_sprite_ext(sUItestThoughtCloud, 3, _surfCenterx, _surfMiddley, _cloudScalex, _cloudScaley, 0, c_white, 1);
gpu_set_blendmode(bm_normal);
draw_sprite_ext(sUItestThoughtCloud, 1, _surfCenterx, _surfMiddley, _cloudScalex, _cloudScaley, 0, c_white, 1);
surface_reset_target();
var _pieSurfDrawx = global.windowCenterx;
var _pieSurfDrawy = global.windowMiddley;
_pieSurfDrawx -= (_pieCloudSurfW / 2 / cr);
_pieSurfDrawy -= (_pieCloudSurfH / 2 / cr);
outline_start_surface(10, 0, _pieCloudSurface, 16, 0.9);
draw_surface_ext(_pieCloudSurface, _pieSurfDrawx, _pieSurfDrawy, 1 / cr, 1 / cr, 0, c_white, 1);
outline_end();
surface_free(_pieCloudSurface);
