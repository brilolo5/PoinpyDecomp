timer += doDelta(0.009523809523809525);
baseScale = 1 + (animcurveGetValueAtPos(curveCircInv, "curve1", timer) * 2);
imageAlpha = 1 - animcurveGetValueAtPos(curveCircInv, "curve1", timer);
cy = -32 * animcurveGetValueAtPos(curveCircInv, "curve1", timer);
draw_sprite_ext(sprite_index, imageIndex, x + cx, y + cy, xscale * baseScale, yscale * baseScale, imageAngle, c_white, imageAlpha);

if (timer >= 1)
    instance_destroy();
