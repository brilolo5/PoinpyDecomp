if (!noDraw)
{
    draw_sprite_ext(spriteIndex, imageIndex, x, bbox_top + 8, 0.1, 0.1, 0, c_white, 1);
    
    for (var i = 0; i < extraTiles; i += 1)
        draw_sprite_ext(sDetailCannonPillar_middle, 0, x, bbox_top + 48 + 8 + (16 * i), 0.1, 0.1, 0, c_white, 1);
    
    draw_sprite_ext(sDetailCannonPillar_middle, 1, x, bbox_bottom - 8, 0.1, 0.1, 0, c_white, 1);
}
