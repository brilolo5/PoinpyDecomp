function audioEventEnemyStomped()
{
    var _fruitHandlerStompedSound = sfx_enemy_fruitHandler_stomped;
    var _ladybugStompedSound = choose(sfx_enemy_ladybug_stomped_01, sfx_enemy_ladybug_stomped_02, sfx_enemy_ladybug_stomped_03, sfx_enemy_ladybug_stomped_04, sfx_enemy_ladybug_stomped_05);
    var _redBirdStompedSound = sfx_enemy_redBird_stomped;
    var _flathopperStompedSound = sfx_enemy_flatHopper_stomped;
    var _jellyfishStompedSound = sfx_enemy_jellyFish_stomped;
    var _spikeBoxStompedSound = sfx_enemy_spikeBox_stomped;
    var _anemoneShoopterStompedSound = sfx_enemy_anemoneShooter_stomped;
    var _cyclopsWormStompedSound = sfx_enemy_cyclopsWorm_stomped;
    var _hoodedHopperStompedSound = sfx_enemy_hoodedHopper_stomped;
    var _bungeeBoyStompedSound = sfx_enemy_bungeeBoy_stomped;
    var _drillFishStompedSound = sfx_enemy_drillFish_stomped;
    var _selfIndex = object_index;
    
    switch (_selfIndex)
    {
        case 208:
        case 72:
            var _sfx = playSfxWorld(_fruitHandlerStompedSound, false, true);
            break;
        
        case 212:
            _sfx = playSfxWorld(_ladybugStompedSound, false, true);
            break;
        
        case 209:
            _sfx = playSfxWorld(_redBirdStompedSound, false, true);
            break;
        
        case 210:
            _sfx = playSfxWorld(_flathopperStompedSound, false, true);
            break;
        
        case 215:
            _sfx = playSfxWorld(_jellyfishStompedSound, false, true);
            break;
        
        case 216:
            _sfx = playSfxWorld(_spikeBoxStompedSound, false, true);
            break;
        
        case 217:
            _sfx = playSfxWorld(_anemoneShoopterStompedSound, false, true);
            break;
        
        case 229:
            _sfx = playSfxWorld(_cyclopsWormStompedSound, false, true);
            break;
        
        case 218:
            _sfx = playSfxWorld(_hoodedHopperStompedSound, false, true);
            break;
        
        case 224:
            _sfx = playSfxWorld(_bungeeBoyStompedSound, false, true);
            break;
        
        case 214:
            _sfx = playSfxWorld(_drillFishStompedSound, false, true);
            audio_stop_sound(sfx_enemy_drillFish_move_lp);
            break;
        
        default:
            break;
    }
    
    show_debug_message("audio enstomp: " + string(object_get_name(_selfIndex)));
}
