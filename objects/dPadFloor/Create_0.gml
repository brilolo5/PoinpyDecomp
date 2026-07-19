image_speed = 0;
imageIndex = 0;
size = abs(image_xscale);
image_xscale = getHDirectionOnCreate(noFlip, oppositeSide, image_xscale);
xDirection = 1;
cornerOrigin = x - ((size - 1) * 8 * xDirection);
