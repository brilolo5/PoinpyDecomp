xDirection = sign(((room_width / 2) - x) + 0.1);

if (xDirection == 1)
    sprite_index = sDetail_JungleUpperLeft;
else
    sprite_index = sDetail_JungleUpperRight;

image_index = irandom(image_number - 2);
