function audioSystemStopAsset(arg0)
{
    var _id;
    
    do
    {
        _id = audioGetByAsset(arg0);
        audioStop(_id);
    }
    until (_id == undefined);
}
