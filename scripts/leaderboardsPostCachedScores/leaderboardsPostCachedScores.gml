function leaderboardsPostCachedScores()
{
    if (!(os_type == os_ios || os_type == os_android))
        exit;
    
    if (global.savedataFingerprintFailed)
    {
        trace("Not submitting scores found in savedata as the fingerprint check failed");
    }
    else
    {
        trace("Submitting scores found in savedata");
        var _i = 0;
        
        repeat (ds_list_size(global.endlessPackedScoreList))
        {
            if (leaderboardsGetGlobal(_i))
                leaderboardsPostRaw(_i, global.endlessPackedScoreList[| _i]);
            
            _i++;
        }
    }
}
