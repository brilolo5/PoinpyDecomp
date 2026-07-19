function playSoundAbilityOctopup()
{
    with (oPlayer)
    {
        var _octopupSound = playSfxWorld(sfx_octopup_activate);
        audioSetSlowmo(_octopupSound);
    }
}
