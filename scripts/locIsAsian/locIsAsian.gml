function locIsAsian()
{
    switch (locGetLanguage())
    {
        case "Japanese":
        case "Korean":
        case "TChinese":
        case "SChinese":
            return true;
        
        default:
            return false;
    }
}
