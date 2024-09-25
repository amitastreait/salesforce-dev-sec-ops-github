@IsTest
public class SAPAccountTriggerTest {
    @IsTest
    static void testSAPAccountTrigger() {
        Account acc = new Account(Name = 'Test Account');
        insert acc;

        SAPAccount__e testEvent = new SAPAccount__e(
            AccountId__c = acc.Id,
            Name__c = acc.Name,
            Active__c = true
        );
        
        // Call the trigger handler method
        Test.startTest();
        EventBus.publish(testEvent);
        Test.stopTest();
        
        // Add assertions here to validate the expected behavior
    }
}
