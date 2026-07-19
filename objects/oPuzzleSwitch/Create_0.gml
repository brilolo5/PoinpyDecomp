event_inherited();
satOn = 0;
myWall = instance_create_depth(x, y, 0, oPuzzleSwitch_wall);

if (!global.puzzleModeUnlocked)
{
    instance_deactivate_object(myWall);
    instance_deactivate_object(self);
}
