function IsValidNetflixLoginId()
{
    return variable_global_exists("netflixProfileid") && global.netflixProfileid != 0 && global.netflixProfileid != "";
}
