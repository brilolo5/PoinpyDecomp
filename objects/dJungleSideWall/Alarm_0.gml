var xDirection = place_meeting(x + 8, y, parentWall) ? -1 : 1;

if (xDirection == 1)
    sprite_index = sDetail_JungleSideLeft;
else
    sprite_index = sDetail_JungleSideRight;

image_index = irandom(image_number - 2);
