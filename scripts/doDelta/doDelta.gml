function doDelta(arg0 = 1)
{
    return arg0 * global.deltaTimeRate;
}

function doDeltaWithAccessibility(arg0 = 1)
{
    var _accessibilityTimescaleMinimum = 0.7;
    var _accessibilityTimescale = lerp(_accessibilityTimescaleMinimum, 1, global.accessibilityTimeScale);
    return arg0 * global.deltaTimeRate * _accessibilityTimescale;
}
