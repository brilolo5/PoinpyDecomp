if (!global.netflixEnabled)
    exit;

var eventID = async_load[? "id"];
show_debug_message("oNetflixControl Async Event: " + string(eventID));

switch (eventID)
{
    case "CurrentProfileRetrieved":
        global.netflixProfileid = async_load[? "userLoginId"];
        global.gameSaveFileName = "poinpy_" + string(global.netflixProfileid) + ".sav";
        
        if (!IsValidNetflixLoginId())
        {
            NetflixCheckUserAuth();
            exit;
        }
        
        show_debug_message("CurrentProfileRetrieved: " + string(global.netflixProfileid));
        
        if (global.languageSetByUser == -1 && global.netflixProfileLanguage == -1)
        {
            show_debug_message("Defaulting to language set in Netflix profile...");
            global.netflixProfileLanguage = async_load[? "language"];
            global.netflixProfileCountry = async_load[? "country"];
            show_debug_message("COUNTRY: " + string(global.netflixProfileCountry));
            show_debug_message("LANGUAGE: " + string(global.netflixProfileLanguage));
            initCheckAndSetLanguage();
        }
    
    case "netflixUserStateChange":
        var userChanged = async_load[? "userChanged"];
        var oldProfileId = global.netflixProfileid;
        global.netflixProfileid = async_load[? "userLoginId"];
        global.gameSaveFileName = "poinpy_" + string(global.netflixProfileid) + ".sav";
        show_debug_message("netflixUserStateChange: " + string(global.netflixProfileid));
        
        if (userChanged && (global.netflixProfileid == "" || global.netflixProfileid == pointer_null))
        {
            show_debug_message("userLoginId returned empty string, current user is null");
            global.netflixProfileid = "invalid";
            NetflixCheckUserAuth();
            exit;
        }
        
        if (global.languageSetByUser == -1 && global.netflixProfileLanguage == -1)
        {
            show_debug_message("Defaulting to language set in Netflix profile...");
            global.netflixProfileLanguage = async_load[? "language"];
            global.netflixProfileCountry = async_load[? "country"];
            show_debug_message("COUNTRY: " + string(global.netflixProfileCountry));
            show_debug_message("LANGUAGE: " + string(global.netflixProfileLanguage));
        }
        
        if (userChanged && global.netflixProfileid != oldProfileId && oldProfileId != "")
        {
            if (IsValidNetflixLoginId())
            {
                show_debug_message("NETFLIX NEW USER");
                global.netflixProfileLanguage = async_load[? "language"];
                global.netflixProfileCountry = async_load[? "country"];
                show_debug_message("COUNTRY: " + string(global.netflixProfileCountry));
                show_debug_message("LANGUAGE: " + string(global.netflixProfileLanguage));
                global.languageSetByUser = -1;
                initCheckAndSetLanguage();
                gameRestart();
                break;
            }
            
            show_debug_message("NETFLIX NO USER");
            global.netflixProfileid = "invalid";
            show_debug_message("NETFLIX INVALID");
            NetflixCheckUserAuth();
        }
    
    default:
}
