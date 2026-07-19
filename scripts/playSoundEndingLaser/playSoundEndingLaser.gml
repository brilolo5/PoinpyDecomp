function playSoundEndingLaser()
{
    with (oBeastMainGame)
    {
        var _beastLaserSound = playSfxWorld(sfx_ending_beast_laser);
        audioSetVolumeTarget(_beastLaserSound, 0.5, 0.005555555555555556);
    }
}
