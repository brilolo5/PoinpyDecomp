xDirection = sign(((room_width / 2) - x) + 0.1);

if (xDirection == 1)
    sprite_index = sDetail_JungleLowerLeft;
else
    sprite_index = sDetail_JungleLowerRight;

image_index = irandom(image_number - 2);
