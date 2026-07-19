if (image_index == 0)
{
    flowerOpen = (flowerOpen > 0) ? flowerIndex : 0;
    var _flowerIndex = flowerOpen;
    draw_sprite_ext(flowerSprite, _flowerIndex, x + (8 * facingDirection), y - 10, (image_xscale * 1) / 10, (image_yscale * 1) / 10, 0, c_white, 1);
}
