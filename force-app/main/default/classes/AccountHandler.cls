public with sharing class AccountHandler {
    public static void run() {
        System.debug('Hello');
    }
    public static void flush() {
        System.debug('Hello');
        System.debug('Hello');
    }
    public static void sleep() {
        System.debug('Hello');
        /* Generate the code to create the Account Record*/
        Account acc = new Account();
        acc.Name = 'PantherSchools.com';
        insert acc;
    }
    public static void createRecords() {
        String AccountName = 'pantherschools.com';
        System.debug('Hello'); 
        /* Generate the code to create the Account Record using Async Apex*/
        // Check if the user has the necessary permissions to create the record
        if (!Schema.sObjectType.Account.isCreateable()) {
            System.debug('Insufficient permissions to create the record');
            return;
        }
        // Check if the Name field is createable
        if (!Schema.sObjectType.Account.fields.Name.isCreateable()) {
            System.debug('Insufficient permissions to create the Name field');
            return;
        }
        // Create the Account record using async apex
        Account acc = new Account(Name = 'PantherSchools.com');
        insert acc;
    }
}