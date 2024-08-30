trigger AssetTrigger on Asset (before insert) {
    for (Asset asset : Trigger.New) {
        System(' Asset: Account ID '+asset.AccountId);
    }
}