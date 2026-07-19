function initializeSpriteAnimationData()
{
    global.animDataMap = ds_map_create();
    addToAnimDataMap(sBeastPart_FaceWaitLevel1);
    addToAnimDataMap(sBeastPart_FaceWaitLevel4_Smooth);
}

function addToAnimDataMap(arg0)
{
    if (!ds_map_exists(global.animDataMap, arg0))
        ds_map_add(global.animDataMap, arg0, makeAnimationArrayFromSprite(arg0));
}
