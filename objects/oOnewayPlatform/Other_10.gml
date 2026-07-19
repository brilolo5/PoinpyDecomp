var _leftMostx = x - ((platformSize / 2) * 16);

for (var i = 0; i < platformSize; i += 1)
    draw_sprite_ext(platformIndex[i], platformRandomImageIndex[i], _leftMostx + (i * 16) + 8, y + cy, 0.1, 0.1, image_angle, c_white, image_alpha);
