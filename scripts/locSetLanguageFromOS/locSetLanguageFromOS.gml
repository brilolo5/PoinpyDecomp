function locSetLanguageFromOS()
{
    var _language = os_get_language();
    locSetLanguageShort(_language);
}
