function areThereItemsLeftToGetFromGacha()
{
    var _randomPickArray = get3RandomizedAbility();
    return _randomPickArray[0] != -1;
}
