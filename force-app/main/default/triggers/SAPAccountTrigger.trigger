trigger SAPAccountTrigger on SAPAccount__e (after insert) {
    for(SAPAccount__e account: Trigger.New){
        System.debug(System.LoggingLevel.DEBUG, account.AccountId__c);
        System.debug(System.LoggingLevel.DEBUG, account.Name__c);
        System.debug(System.LoggingLevel.DEBUG, account.Active__c);
    }
}