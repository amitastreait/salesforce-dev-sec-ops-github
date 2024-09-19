@IsTest
public class TrialCustomerPortalControllerTest {
    @IsTest
    static void testController(){
        TrialCustomerPortalHomePageController controller = new TrialCustomerPortalHomePageController();
    }
    
    @IsTest
    static void testSortProducts(){
        TrialCustomerPortalHomePageController controller = new TrialCustomerPortalHomePageController();
        controller.sortField1 = 'Name';
        controller.previousSortField1 = null;
        controller.SortProducts();
        controller.sortField1 = 'Name';
        controller.previousSortField1 = 'Name';
        controller.SortProducts();
    }
    
    @IsTest
    static void testSortCases(){
        TrialCustomerPortalHomePageController controller = new TrialCustomerPortalHomePageController();
        controller.sortField2 = 'CaseNumber';
        controller.previousSortField2 = null;
        controller.SortCases();
        controller.sortField2 = 'CaseNumber';
        controller.previousSortField2 = 'CaseNumber';
        controller.SortCases();
    }
    
    @IsTest
    static void testSortSolutions(){
        TrialCustomerPortalHomePageController controller = new TrialCustomerPortalHomePageController();
        controller.sortField3 = 'SolutionName';
        controller.previousSortField3 = null;
        controller.SortSolutions();
        controller.sortField3 = 'SolutionName';
        controller.previousSortField3 = 'SolutionName';
        controller.SortSolutions();
    }
    
    @IsTest
    static void testSortIdeas(){
        TrialCustomerPortalHomePageController controller = new TrialCustomerPortalHomePageController();
        controller.sortField4 = 'Title';
        controller.previousSortField4 = null;
        controller.SortIdeas();
        controller.sortField4 = 'Title';
        controller.previousSortField4 = 'Title';
        controller.SortIdeas();
    }
}