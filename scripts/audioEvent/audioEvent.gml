function audioEvent(arg0)
{
    switch (arg0)
    {
        case "vine initial contact":
            playSfxWorld(sfx_temp_leftClick, false, true);
            break;
        
        case "vine rolling":
            playSfxWorld(sfx_temp_leftClick, false, true);
            break;
        
        case "vine rolling stop":
            playSfxWorld(sfx_temp_leftClick, false, true);
            break;
        
        case "vine detach":
            playSfxWorld(sfx_temp_leftClick, false, true);
            break;
        
        case "vine flower bloom":
            playSfxWorld(sfx_temp_leftClick, false, true);
            break;
        
        case "bubble initial contact":
            playSfxWorld(sfx_temp_leftClick, false, true);
            break;
        
        case "bubble player in bubble":
            playSfxWorld(sfx_temp_leftClick, false, true);
            break;
        
        case "bubble exit and pop":
            playSfxWorld(sfx_temp_leftClick, false, true);
            break;
        
        case "cannon initial contact":
            playSfxWorld(sfx_temp_leftClick, false, true);
            break;
        
        case "cannon turning":
            break;
        
        case "cannon launch":
            playSfxWorld(sfx_temp_leftClick, false, true);
            break;
        
        case "jumppad explode":
            playSfxWorld(sfx_temp_leftClick, false, true);
            break;
        
        case "tutorial button press":
            playSfxWorld(sfx_temp_leftClick, false, true);
            break;
        
        case "tutorial platforms appear":
            playSfxWorld(sfx_temp_leftClick, false, true);
            break;
        
        case "tutorial jump orb get":
            playSfxWorld(sfx_temp_leftClick, false, true);
            break;
        
        case "golden seed appear":
            playSfxWorld(sfx_temp_leftClick, false, true);
            break;
        
        case "golden seed get":
            playSfxWorld(sfx_temp_leftClick, false, true);
            break;
        
        case "shiny fruit get":
        case "gourmet meter level up":
        case "lobby beast bonk":
        case "beast fire breath":
        case "beast become frustrated 1":
        case "beast become frustrated 2":
        case "enemy corpse disappear":
            playSfxWorld(sfx_temp_leftClick, false, true);
            break;
        
        case "enemy fruit handler step":
        case "enemy flat hopper jump":
        case "enemy flat hopper land":
        case "enemy spike box flip":
        case "enemy anemone shooter shoot":
        case "enemy cyclops worm alert":
        case "enemy hooded hopper jump":
        case "enemy hooded hopper land":
        case "enemy bungee boy bounce":
            var _enemySfx = playSfxWorld(sfx_temp_leftClick, false, true);
            audioSetSlowmo(_enemySfx);
            audioSetInViewOnly(_enemySfx, x, y);
            audioSetVolume(_enemySfx, 0.3);
            break;
        
        case "gacha menu appear":
        case "gacha lever press":
        case "gacha lever return":
        case "gacha left button press":
        case "gacha right button press":
        case "gacha get button press":
        case "gacha confirm button press":
        case "gacha ability name and buttons appear":
        case "puzzle menu level select":
        case "puzzle menu level confirm":
        case "puzzle failure wipe":
        case "puzzle complete screen appear":
        case "puzzle complete buttons appear":
        case "next recipe appear":
        case "recipe readied":
        case "result screen game over text appear":
        case "result screen reward appear":
        case "result screen rank meter appear":
        case "result screen padlock unlock":
        case "result screen meter start filling":
            var _sfx = playSfxWorld(sfx_temp_leftClick, false, true);
            audioSetVolume(_sfx, 0.5);
            break;
        
        default:
            break;
    }
    
    show_debug_message("audio event: " + arg0);
}
