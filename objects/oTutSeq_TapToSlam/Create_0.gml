event_inherited();

with (oNetflixControl)
    tutorial_allowNButtonAtStart = false;

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
    sprite: sTutorialFingerTap,
    string: loc("tutorial tap slam down"),
    gamepadSprite: sTutorialFingerSwipeBlue,
    gamepadString: loc("tutorial gamepad slam down")
};
