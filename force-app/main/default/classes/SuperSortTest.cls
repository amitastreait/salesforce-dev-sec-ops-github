@IsTest
public class SuperSortTest {

	@IsTest
    public static void sortAscendingTest(){
        Account acc = new Account();
        acc.Name = 'PantherSchools.com';
        insert acc;
        List<Opportunity> opps = new List<Opportunity>();
        for(integer i = 0; i<1000; i++){
            opps.add(new Opportunity(AccountId = acc.Id, Name = 'test' + i, Amount = 1000 * Math.random()));
        }
        
        Test.startTest();
        Long start = system.currentTimeMillis();
        superSort.sortList(opps,'Amount','asc');
        system.debug(system.currentTimeMillis() - start);
        Test.stopTest();
        
        //Assert the list was sorted correctly
        Decimal assertValue = -1;
        for(Opportunity o : opps) {
            System.debug('Opp value: ' + o.amount);
            System.assert(assertValue <= o.amount);
            assertValue = o.amount;
        }  
    }
    
    @IsTest
    public static void sortDescendingTest(){
        Account acc = new Account();
        acc.Name = 'PantherSchools.com';
        insert acc;
        List<Opportunity> opps = new List<Opportunity>();
        for(integer i = 0; i<1000; i++){
            opps.add(new Opportunity(AccountId = acc.Id, Name = 'test' + i, Amount = 1000 * Math.random()));
        }
        
        Test.startTest();
        superSort.sortList(opps,'Amount','desc');
        Test.stopTest();
        
        //Assert the list was sorted correctly
        Decimal assertValue = 1001;
        for(Opportunity o : opps) {
            System.debug('Opp value: ' + o.amount);
            System.assert(assertValue >= o.amount);
            assertValue = o.amount;
        }  
    }
    @IsTest
    public static void sortDescendingReferenceTest(){
        Account acc = new Account();
        acc.Name = 'PantherSchools.com';
        insert acc;
        List<Opportunity> opps = new List<Opportunity>();
        for(integer i = 0; i<1000; i++){
            opps.add(new Opportunity(AccountId = acc.Id, Name = 'test' + i, Amount = 1000 * Math.random()));
        }
        
        Test.startTest();
        superSort.sortList(opps,'AccountId','desc');
        Test.stopTest();
        
        //Assert the list was sorted correctly
        Decimal assertValue = 1001;
        for(Opportunity o : opps) {
            System.debug('Opp value: ' + o.amount);
            System.debug('Opp value: ' + o.amount);
            //System.assert(assertValue >= o.amount);
            assertValue = o.amount;
        }  
    }
}