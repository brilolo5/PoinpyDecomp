if (playerIn)
    portalSize = lerp(portalSize, portalSizeMax, 0.075);
else
    portalSize = lerp(portalSize, portalSizeMin, 0.075);

if (!surface_exists(mask_surface))
    mask_surface = surface_create_track(maskWidth, maskHeight);

surface_set_target(mask_surface);
draw_clear(make_color_rgb(46, 50, 59));
gpu_set_blendmode(bm_subtract);
draw_circle((drawx - getViewx(global.cam)) * maskMultiply, (global.viewHeight / 2) * maskMultiply, portalSize * maskMultiply, 0);
gpu_set_blendmode(bm_normal);
surface_reset_target();

if (!surface_exists(clip_surface))
    clip_surface = surface_create_track(maskWidth, maskHeight);

surface_set_target(clip_surface);
draw_clear_alpha(make_color_rgb(46, 50, 59), 0);
draw_surface_stretched(portalSurface, 0, 0, maskWidth, maskHeight);
gpu_set_blendmode(bm_subtract);
draw_surface(mask_surface, 0, 0);
gpu_set_blendmode(bm_normal);
surface_reset_target();
