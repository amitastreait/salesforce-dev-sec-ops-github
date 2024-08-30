trigger AssetTrigger on Asset (before insert) {
    AssetTriggerHandler.run();
    for (Asset asset : Trigger.New) {
        System(' Asset: Account ID '+asset.AccountId);
    }
}