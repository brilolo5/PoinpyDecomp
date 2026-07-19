global.netflixEnabled = os_type == os_android || os_type == os_ios;

if (!global.netflixEnabled)
    instance_destroy(id);

global.languageSetByUser = -1;
global.allowNetflixButton = false;
global.netflixProfileDataLoaded = -1;
global.netflixProfileLanguage = -1;
global.netflixProfileCountry = -1;
tutorial_allowNButtonAtStart = true;

if (!IsValidNetflixLoginId())
{
    global.netflixProfileid = "";
    global.gameSaveFileName = "poinpy_" + string(global.netflixProfileid) + ".sav";
}
