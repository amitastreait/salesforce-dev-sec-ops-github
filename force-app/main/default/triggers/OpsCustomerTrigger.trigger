trigger OpsCustomerTrigger on OPSCustomer__c (after insert) {
    for(OPSCustomer__c customer: Trigger.New){
        System.debug(System.LoggingLevel.DEBUG, customer.Id);
    }
}