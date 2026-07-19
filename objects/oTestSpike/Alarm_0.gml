if (place_meeting(x, y + 16, parentWall))
    imageAngle = 90;
else if (place_meeting(x - 16, y, parentWall))
    imageAngle = 0;
else if (place_meeting(x + 16, y, parentWall))
    imageAngle = 180;
else if (place_meeting(x, y - 16, parentWall))
    imageAngle = 270;

image_angle = imageAngle;
