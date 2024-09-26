@IsTest
public class MetadataTriggerTest {
    @IsTest
    static void testMetadataTrigger() {
        // Insert an Account record
        Account acc = new Account(Name = 'Test Account');
        insert acc;
        
        // Retrieve the inserted Account record
        Account insertedAcc = [SELECT Id, Name FROM Account WHERE Id = :acc.Id];
        
        // Assert that the Account record was inserted and its name is as expected
        System.assertEquals('Test Account', insertedAcc.Name, 'Account name should match');
    }
}