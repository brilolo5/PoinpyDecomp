function playSoundEndingBeastText()
{
    with (oEndingSequence_BeastDialogue)
    {
        var _beastTextSound = playSfxWorld(choose(sfx_ending_beast_text_01, sfx_ending_beast_text_02, sfx_ending_beast_text_03, sfx_ending_beast_text_04, sfx_ending_beast_text_05, sfx_ending_beast_text_06, sfx_ending_beast_text_07, sfx_ending_beast_text_08, sfx_ending_beast_text_09, sfx_ending_beast_text_10, sfx_ending_beast_text_11));
        audioSetPitch(_beastTextSound, random_range(0.5, 1.5));
    }
}
