function locGetFontFromLanguage()
{
    var _lang = locGetLanguage();
    
    if (argument_count > 0)
        _lang = argument[0];
    
    switch (_lang)
    {
        case "Japanese":
            return "fontJapanese";
        
        case "Korean":
            return "fontKorean";
        
        case "SChinese":
            return "fontChineseS";
        
        case "TChinese":
            return "fontChineseT";
        
        case "Russian":
            return "fontRussian";
        
        case "Arabic":
            return "fontArabic";
        
        case "Thai":
            return "fontThai";
        
        case "Turkish":
            return "fontTurkish";
        
        case "Swedish":
            return "fontSwedish";
        
        case "Polish":
            return "fontPolish";
        
        case "English":
        default:
            return "fredoka";
    }
}
