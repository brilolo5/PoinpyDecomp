myAlarm0 = new makeAlarm(0, function()
{
    instance_destroy();
});
active = 0;

if (global.tutorialOver)
    instance_destroy();
