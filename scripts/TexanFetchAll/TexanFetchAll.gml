function TexanFetchAll()
{
    var _i = 0;
    
    repeat (ds_list_size(global.__texanTextureGroups))
    {
        TexanFetch(global.__texanTextureGroups[| _i]);
        _i++;
    }
}
