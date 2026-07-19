var _pitchShift = 1 - (global.timeScale_noDelta / global.timeScaleDefault);
var _finalPitchShift = 1 - (1 * _pitchShift);
audioSystemPitchShiftSet(_finalPitchShift);
