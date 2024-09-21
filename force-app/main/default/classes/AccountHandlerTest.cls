@IsTest
public class AccountHandlerTest {

    @IsTest
    private static void allMethods(){
        Test.startTest();
        AccountHandler.flush();
        AccountHandler.sleep();
        Test.stopTest();
    }
    @IsTest
    private static void createRecordsTest(){
        Test.startTest();
        AccountHandler.createRecords();
        Test.stopTest();
    }
}