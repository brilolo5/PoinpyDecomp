function TextureManagerGoto()
{
    var _gameMode = argument[0];
    var _commit = (argument_count > 1 && argument[1] != undefined) ? argument[1] : true;
    
    if (global.__textureManagerForceFull)
    {
        TexanFetchAll();
        exit;
    }
    
    if (is_string(_gameMode))
    {
        trace("TextureManager: Swapping textures for game mode \"", _gameMode, "\"");
        
        switch (_gameMode)
        {
            case "gameplay":
                if (!global.__textureManagerHighMem)
                    TexanFlushAll();
                
                TexanFetch("Default", "Backgrounds", "BeastInGame", "UI_Trophy", "Details", "ResultsScreen", "Enemies", "Abilities", getLangTexturePageNameString());
                
                if (_commit)
                    TexanCommit();
                
                break;
            
            case "tutorial":
                if (!global.__textureManagerHighMem)
                    TexanFlushAll();
                
                TexanFetch("Default", "Backgrounds", "Tutorial", getLangTexturePageNameString());
                
                if (_commit)
                    TexanCommit();
                
                break;
            
            case "final area":
                if (!global.__textureManagerHighMem)
                    TexanFlushAll();
                
                TexanFetch("Default", "FinalArea", "BeastInGame", "Enemies", "Abilities", getLangTexturePageNameString());
                
                if (_commit)
                    TexanCommit();
                
                break;
            
            case "main menu":
                if (!global.__textureManagerHighMem)
                    TexanFlushAll();
                
                TexanFetch("Default", "UI_AbilityEquip", "UI_Gacha", "UI_Puzzle", "UI_Trophy", "Lobby", getLangTexturePageNameString());
                
                if (_commit)
                    TexanCommit();
                
                break;
            
            case "ending":
                if (!global.__textureManagerHighMem)
                    TexanFlushAll();
                
                TexanFlushAll();
                TexanFetch("EndingCutscene", getLangTexturePageNameString());
                
                if (_commit)
                    TexanCommit();
                
                break;
            
            default:
                trace("TextureManager: Warning! Game mode not supported");
                break;
        }
    }
    else if (is_numeric(_gameMode))
    {
        trace("TextureManager: Got number, presuming it's a room (", _gameMode, " = ", room_get_name(_gameMode), ")");
        
        switch (_gameMode)
        {
            case 2:
            case 144:
                TextureManagerGoto("gameplay", _commit);
                break;
            
            case 1:
                TextureManagerGoto("main menu", _commit);
                break;
            
            case 200:
                TextureManagerGoto("tutorial", _commit);
                break;
            
            case 3:
            case 143:
                TextureManagerGoto("ending", _commit);
                break;
            
            default:
                trace("TextureManager: Warning! Room not supported");
                break;
        }
    }
    else
    {
        trace("TextureManager: Warning! Game mode was not recognised: \"", _gameMode, "\"");
    }
}

function getLangTexturePageNameString()
{
    switch (locGetLanguage())
    {
        case "Japanese":
            return "langJapanese";
        
        case "Korean":
            return "langKorean";
        
        case "TChinese":
            return "langChinese";
        
        case "Arabic":
            return "langArabic";
        
        default:
            return -1;
    }
}
