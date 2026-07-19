function phcol_CogBoostWall()
{
    if (instance_place(argument[0], argument[1], oCogWall))
    {
        playSoundPlayerVineRollHeadLp();
        currentState = "cog cling";
        wallClingDirection = sign(xsp);
        xsp = 0;
        return true;
    }
    else
    {
        return false;
    }
}
