notificationActive = checkNewPuzzleAvailability();

if (state == "initialize")
{
    rabbitStateChange("notification cleared - asleep", xDirection);
    
    if (notificationActive)
        instance_destroy();
}
