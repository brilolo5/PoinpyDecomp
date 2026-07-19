function locGetLanguageNameInTheirLanguage(arg0)
{
    var _langtext = "[" + locGetFontFromLanguage(arg0) + "]";
    
    switch (arg0)
    {
        case "English":
            _langtext += loc("language english");
            break;
        
        case "Japanese":
            _langtext += loc("language japanese");
            break;
        
        case "Korean":
            _langtext += loc("language korean");
            break;
        
        case "TChinese":
            _langtext += loc("language tchinese");
            break;
        
        case "French":
            _langtext += loc("language french");
            break;
        
        case "German":
            _langtext += loc("language german");
            break;
        
        case "Spanish Spain":
            _langtext += loc("language spanish spain");
            break;
        
        case "Spanish LatAm":
            _langtext += loc("language spanish latam");
            break;
        
        case "Portuguese":
            _langtext += loc("language portuguese");
            break;
        
        case "Italian":
            _langtext += loc("language italian");
            break;
        
        case "Turkish":
            _langtext += loc("language turkish");
            break;
        
        case "Arabic":
            _langtext += loc("language arabic");
            break;
        
        case "Thai":
            _langtext += loc("language thai");
            break;
        
        case "Swedish":
            _langtext += loc("language swedish");
            break;
        
        case "Polish":
            _langtext += loc("language polish");
            break;
    }
    
    return _langtext;
}
