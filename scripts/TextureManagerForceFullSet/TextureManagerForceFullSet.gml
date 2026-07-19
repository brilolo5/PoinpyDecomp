function TextureManagerForceFullSet(arg0)
{
    trace("Texture Manager: Set force full mode to ", arg0);
    global.__textureManagerForceFull = arg0;
}

TextureManagerForceFullSet(false);
