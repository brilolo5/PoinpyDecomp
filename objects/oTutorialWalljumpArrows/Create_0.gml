image_speed = 0;
imageIndex = 0;
currentState = "inactive";
stateInitBuffer = 0;
isVisible = 0;
offsetRate_y = -1;
imageAlpha = 0;
stateTimer = 0;

stateChange = function(arg0)
{
    currentState = arg0;
    stateInitBuffer = 1;
};

stateInit = function()
{
    if (stateInitBuffer)
    {
        stateInitBuffer = 0;
        return true;
    }
    
    return false;
};
