if (surface_exists(portalSurface))
    surface_free(portalSurface);

if (surface_exists(mask_surface))
    surface_free(mask_surface);

if (surface_exists(clip_surface))
    surface_free(clip_surface);

view_visible[1] = 0;
