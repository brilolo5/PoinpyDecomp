function locSetLanguageShort(arg0, arg1 = -1)
{
    switch (arg0)
    {
        case "ja":
            locSetLanguage("Japanese");
            break;
        
        case "en":
            locSetLanguage("English");
            break;
        
        case "ko":
            locSetLanguage("Korean");
            break;
        
        case "zh":
        case "zh-Hant":
            locSetLanguage("TChinese");
            break;
        
        case "fr":
            locSetLanguage("French");
            break;
        
        case "de":
            locSetLanguage("German");
            break;
        
        case "es":
            if (arg1 == "ES" || arg1 == "es")
                locSetLanguage("Spanish Spain");
            else
                locSetLanguage("Spanish LatAm");
            
            break;
        
        case "pt":
            locSetLanguage("Portuguese");
            break;
        
        case "it":
            locSetLanguage("Italian");
            break;
        
        case "tr":
            locSetLanguage("Turkish");
            break;
        
        case "ar":
            locSetLanguage("Arabic");
            break;
        
        case "th":
            locSetLanguage("Thai");
            break;
        
        case "sv":
            locSetLanguage("Swedish");
            break;
        
        case "pl":
            locSetLanguage("Polish");
            break;
        
        default:
            __locTrace("Unsupported OS language (", arg0, "), defaulting to English");
            locSetLanguage("English");
            break;
    }
}
