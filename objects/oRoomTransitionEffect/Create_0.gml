if (live_call())
    return global.live_result;

destination = rmPlayableMainMenu;
fadeInTimer = 0;
fadeInTimerMax = 15;
remainTimer = 0;
remainTimerMax = 30;
fadeOutDelayFrame = 2;
fadeOutTimer = 0;
fadeOutTimerMax = 15;
fadeColorShift = random(256);
fadeColor = make_color_hsv(fadeColorShift, 64, 256);
