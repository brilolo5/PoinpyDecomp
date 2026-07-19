function abilityGetIndexName(arg0)
{
    var _indexNum = arg0;
    _indexNum = clamp(_indexNum, 0, 28);
    var _nameArray;
    _nameArray[UnknownEnum.Value_1] = "abilitydata slam fruit suction";
    _nameArray[UnknownEnum.Value_2] = "abilitydata wallkick fruit suction";
    _nameArray[UnknownEnum.Value_3] = "abilitydata spin fruit suction";
    _nameArray[UnknownEnum.Value_0] = "abilitydata damage jump recover";
    _nameArray[UnknownEnum.Value_4] = "abilitydata aim focus extend";
    _nameArray[UnknownEnum.Value_5] = "abilitydata wall jump higher";
    _nameArray[UnknownEnum.Value_6] = "abilitydata juice resurrection";
    _nameArray[UnknownEnum.Value_7] = "abilitydata extra jump orb";
    _nameArray[UnknownEnum.Value_8] = "abilitydata money pot";
    _nameArray[UnknownEnum.Value_9] = "abilitydata higher entity bounce";
    _nameArray[UnknownEnum.Value_10] = "abilitydata instant money";
    _nameArray[UnknownEnum.Value_11] = "abilitydata focus time freeze";
    _nameArray[UnknownEnum.Value_12] = "abilitydata spin wall jump";
    _nameArray[UnknownEnum.Value_13] = "abilitydata final screw attack";
    _nameArray[UnknownEnum.Value_14] = "abilitydata fruit twin";
    _nameArray[UnknownEnum.Value_15] = "abilitydata slam bounce angled";
    _nameArray[UnknownEnum.Value_16] = "abilitydata slam start fruit suction";
    _nameArray[UnknownEnum.Value_17] = "abilitydata fruit pot";
    _nameArray[UnknownEnum.Value_18] = "abilitydata more pot";
    _nameArray[UnknownEnum.Value_19] = "abilitydata enemy to fruit";
    _nameArray[UnknownEnum.Value_20] = "abilitydata fruit handler dual wield";
    _nameArray[UnknownEnum.Value_21] = "abilitydata more fruit handler";
    _nameArray[UnknownEnum.Value_27] = "abilitydata increase jump power";
    _nameArray[UnknownEnum.Value_28] = "abilitydata jump fruit suction";
    _nameArray[UnknownEnum.Value_22] = "abilitydata endless mode";
    _nameArray[UnknownEnum.Value_23] = "abilitydata pajamas 1";
    _nameArray[UnknownEnum.Value_24] = "abilitydata pajamas 2";
    _nameArray[UnknownEnum.Value_25] = "abilitydata pajamas 3";
    _nameArray[UnknownEnum.Value_26] = "abilitydata pajamas 4";
    
    if (abilityCheck(UnknownEnum.Value_22))
        _nameArray[UnknownEnum.Value_7] = "abilitydata extra jump orb sleep";
    
    return _nameArray[_indexNum];
}
