function TextureManagerHighMemSet(arg0)
{
    trace("Texture Manager: Set high memory mode to ", arg0);
    global.__textureManagerHighMem = arg0;
}

TextureManagerHighMemSet(false);
