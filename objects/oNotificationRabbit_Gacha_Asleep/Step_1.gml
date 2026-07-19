notificationActive = checkGachaAvailability();

if (state == "initialize")
{
    rabbitStateChange("notification cleared - asleep");
    
    if (notificationActive)
        instance_destroy();
}
