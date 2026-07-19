function initializeLocalisation()
{
    if (!variable_global_exists("__loc_loaded"))
    {
        global.__loc_loaded = true;
        locLoad("poinpytext_loc_041922.csv");
        locLoad("poinpytext_languageNames.csv");
        initializeCustomLoc();
        locSetLanguageFromOS();
    }
}
