notificationActive = checkGachaAvailability();

if (state == "initialize")
{
    if (!notificationActive)
        instance_destroy();
}
