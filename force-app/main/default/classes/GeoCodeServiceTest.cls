@IsTest
public class GeoCodeServiceTest {

    @IsTest
    private static void constructorTest(){
        Test.startTest();
        GeoCodeService handler = new GeoCodeService();
        Test.stopTest();
    }
}