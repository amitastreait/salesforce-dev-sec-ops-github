@IsTest
public class AssetTriggerHandlerTest {

    @IsTest
    private static void sleepTest(){
        Account acc = new Account();
        acc.Name = 'PantherSchools.com';
        insert acc;
        Test.startTest();
        AssetTriggerHandler.sleep();
        Test.stopTest();
    }
}