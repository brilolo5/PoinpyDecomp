notificationActive = checkNewPuzzleAvailability();

if (state == "initialize")
{
    if (!notificationActive)
        instance_destroy();
}
