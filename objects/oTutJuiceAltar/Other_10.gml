image_index = instance_exists(oJuiceHomingParticleEmitter);

if (speakTime > 0)
{
    if (audioVarSpeakLoop == 0)
        audioVarSpeakLoop = 1;
    
    nomzoSpeakTime += doDelta(1);
    imageIndex = (nomzoSpeakTime / 5) % 2;
    speakTime -= doDelta(1);
}

if (speakTime <= 0)
{
    nomzoSpeakTime = 0;
    imageIndex = max(0, imageIndex - doDelta(0.2));
    audioVarSpeakLoop = 0;
}

if (instance_exists(oJuiceHomingParticleEmitter))
{
    if (!mouthOpenSound)
    {
        mouthOpenSound = 1;
        mouthCloseSound = 0;
        playSoundTutorialGuyEatStart();
    }
    
    imageIndex = 6;
}
else if (!mouthCloseSound && imageIndex <= 3)
{
    mouthCloseSound = 1;
    mouthOpenSound = 0;
    playSoundTutorialGuyEatEnd();
}

xwobble = approach(xwobble, 1, 0.05);
ywobble = approach(ywobble, 1, 0.05);

if (dewReceived)
{
    dewReceived = 0;
    xwobble = 1.1;
    ywobble = 1.1;
}

var _xscale = 0.1 * xwobble;
var _yscale = 0.1 * ywobble;
var _imageIndexFinal = clamp(imageIndex, 0, 3);

if (forceSmile)
{
    _imageIndexFinal = 2;
    forceSmile -= doDelta(1);
}

draw_sprite_ext(sNomzo, _imageIndexFinal, x + 8 + 2 + 1, y + 16 + 4 + 4, _xscale, _yscale, 0, c_white, 1);
