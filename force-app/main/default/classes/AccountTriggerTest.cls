@IsTest
public with sharing class AccountTriggerTest {
    @IsTest
    private static void insertAccountTest(){
        // Step 1: Create an Account
        Account acc = new Account();
        acc.Name = 'PantherSchools.com'; 
        insert acc;
    }
}