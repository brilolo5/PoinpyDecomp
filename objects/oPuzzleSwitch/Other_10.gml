if (global.puzzleModeUnlocked)
{
    draw_sprite_ext(sPuzzleChair, 0, x, y, 0.1, 0.1, 0, c_white, 1);
    
    if (satOn)
    {
        mask_index = mask_nomask;
        
        if (oPlayer.currentState == "spin jump")
        {
            satOn = 0;
            mask_index = sprite_index;
        }
    }
}
