global.__leaderboardData = array_create(UnknownEnum.Value_20, undefined);
global.__leaderboardState = array_create(UnknownEnum.Value_20, undefined);
global.__leaderboardQueue = [];
global.__leaderboardsUpdating = undefined;
var _i = 0;

repeat (UnknownEnum.Value_20)
{
    var _array = array_create(100, undefined);
    array_resize(_array, 0);
    array_set(global.__leaderboardData, _i, _array);
    array_set(global.__leaderboardState, _i, 
    {
        pending: false,
        startTime: undefined,
        queueTime: undefined,
        receivedTime: undefined,
        failed: false
    });
    _i++;
}
