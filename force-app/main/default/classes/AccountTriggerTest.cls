@IsTest
public with sharing class AccountTriggerTest {
    @IsTest
    private static void insertAccountTest(){
        
        Account acc = new Account();
        acc.Name = 'PantherSchools.com';
        insert acc;
    }
}