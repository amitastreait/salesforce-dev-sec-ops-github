public with sharing class AssetTriggerHandler {
    public static void run(){
        Account acc = [SELECT Id, Name FROM Account WHERE Name = 'PantherSchools.com' LIMIT 1];
        acc.Industry = 'Education';
        update acc;
    }
    public static void sleep(){
        Account acc = [SELECT Id, Name FROM Account WHERE Name = 'PantherSchools.com' LIMIT 1];
        acc.Industry = 'Education';
        update acc;
    }
}