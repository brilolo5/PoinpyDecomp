playerControlLock();
currentSequence = "init";
sequenceTimer = 0;
sequenceInit = 0;
recipeForceOff = 1;
darkOverlayTween = 0;

sequenceInitialize = function()
{
    if (sequenceInit)
    {
        sequenceInit = 0;
        return true;
    }
    else
    {
        return false;
    }
};
