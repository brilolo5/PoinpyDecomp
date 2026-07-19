currentSequence = "appear";
sequenceTimer = 0;
guide = 
{
    x: global.windowCenterx,
    y: global.windowMiddley - (global.windowMiddley / 2),
    drawx: x,
    drawy: y,
    sequence: 0,
    yTweenOffset: 16,
    scale: 0.15000000000000002,
    alpha: 0,
    frame: 0,
    sprite: sTutorialFingerSwipeBlue,
    string: loc("tutorial swipe to jump"),
    gamepadSprite: sTutorialFingerSwipeBlue,
    gamepadString: loc("tutorial gamepad ls to jump")
};
