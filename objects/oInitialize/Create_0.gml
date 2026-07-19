trace("Init: Begin");
time = current_time;
splashState = 0;
splashTimer = 0;
splashText = "Devolver Digital";
hurryInput = 0;
targetDelta = 0.016666666666666666;
actualDelta = delta_time / 1000000;
deltaRate = actualDelta / targetDelta;
instance_create_depth(0, 0, 0, oNetflixControl);
randomize();
surface_depth_disable(true);
game_set_speed(60, gamespeed_fps);
device_mouse_dbclick_enable(false);
initializeGlobals();
switchInit();

if (os_type == os_ios || os_type == os_android)
    initializeWindow(false);

state_timer = 30;
state_index = 0;
loaded = false;
fade_alpha = 0;
delayAfterFadeOut = 1;
waitingForNetflix = false;
fadeSpeed = 0.016666666666666666;
splashScreenTimer = 0;
splashScreenDisplayTime = 2;
state_order = [UnknownEnum.Value_18, UnknownEnum.Value_5, UnknownEnum.Value_6, UnknownEnum.Value_7, UnknownEnum.Value_8, UnknownEnum.Value_9, UnknownEnum.Value_1, UnknownEnum.Value_2, UnknownEnum.Value_10, UnknownEnum.Value_11, UnknownEnum.Value_12, UnknownEnum.Value_13, UnknownEnum.Value_15, UnknownEnum.Value_14, UnknownEnum.Value_3, UnknownEnum.Value_4, UnknownEnum.Value_16, UnknownEnum.Value_19, UnknownEnum.Value_17];
initializeWindow(false);
