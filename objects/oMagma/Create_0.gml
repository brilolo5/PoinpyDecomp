_magmaSound = playSoundMagma();
inLaunchSequence = 0;
cx = 0;
cy = 0;
xscale = 1;
yscale = 1;
imageAngle = 0;
image_speed = 0;
var _id = id;

with (oMagma)
{
    if (id != _id)
        instance_destroy();
}

endingSubside = 0;
puzzleModeInitialPause = 0;
puzzleMagmaSetInPlace = 0;

if (global.gameReinitializeState == "puzzle")
{
    puzzleModeInitialPause = 1;
    puzzleMagmaSetInPlace = 1;
}

magmaBodyCount = 6;
magmaOrange = make_color_rgb(255, 140, 76);
magmaRed = make_color_rgb(248, 49, 100);
magmaYellow = make_color_rgb(255, 222, 0);
magmaBodyGrid = ds_grid_create(UnknownEnum.Value_2, magmaBodyCount);

for (var _i = 0; _i < magmaBodyCount; _i += 1)
    magmaBodyGrid[# UnknownEnum.Value_0, _i] = _i / magmaBodyCount;

magmaBodyGrid[# UnknownEnum.Value_1, 0] = magmaOrange;
magmaBodyGrid[# UnknownEnum.Value_1, 1] = magmaRed;
magmaBodyGrid[# UnknownEnum.Value_1, 2] = magmaYellow;
magmaBodyGrid[# UnknownEnum.Value_1, 3] = magmaOrange;
magmaBodyGrid[# UnknownEnum.Value_1, 4] = magmaRed;
magmaBodyGrid[# UnknownEnum.Value_1, 5] = magmaYellow;
magmaParticleSpawnTimer = 0;
