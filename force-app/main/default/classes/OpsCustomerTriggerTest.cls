@IsTest
public class OpsCustomerTriggerTest {
    @IsTest
    static void testOpsCustomerTrigger() {
        // Insert an OPSCustomer__c record
        OPSCustomer__c customer = new OPSCustomer__c(Name = 'Test Customer');
        insert customer;
        
        // Retrieve the inserted OPSCustomer__c record
        OPSCustomer__c insertedCustomer = [SELECT Id, Name FROM OPSCustomer__c WHERE Id = :customer.Id];
        
        // Assert that the OPSCustomer__c record was inserted and its name is as expected
        System.assertEquals('Test Customer', insertedCustomer.Name, 'Customer name should match');
    }
}
