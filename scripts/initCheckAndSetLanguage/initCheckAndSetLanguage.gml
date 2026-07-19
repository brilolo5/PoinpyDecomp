function initCheckAndSetLanguage()
{
    trace("init check and set language");
    
    if (global.languageSetByUser != -1)
    {
        locSetLanguage(global.languageSetByUser);
        trace("load save: language set by user preference");
    }
    else if (global.netflixEnabled && global.netflixProfileLanguage != -1)
    {
        locSetLanguageShort(global.netflixProfileLanguage, global.netflixProfileCountry);
        trace("load save: language set from Netflix profile:", global.netflixProfileLanguage, global.netflixProfileCountry);
    }
    else
    {
        trace("load save: language not loaded, set to default");
    }
}
