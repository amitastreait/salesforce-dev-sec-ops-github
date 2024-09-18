@IsTest
public class MyFirstApexClassTest {

    @IsTest
    private static void constructorTest(){
        Test.startTest();
        MyFirstApexClass handler = new MyFirstApexClass();
        Test.stopTest();
    }
}