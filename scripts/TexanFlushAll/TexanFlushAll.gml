function TexanFlushAll()
{
    var _i = 0;
    
    repeat (ds_list_size(global.__texanTextureGroups))
    {
        TexanFlush(global.__texanTextureGroups[| _i]);
        _i++;
    }
}
