@IsTest
public with sharing class AssetTriggerTest {
    @IsTest
    private static void insertAssetTest(){
        // Step 1: Create an Account
        Account acc = new Account();
        acc.Name = 'PantherSchools.com';
        insert acc;

        // Step 2: Create a Contact and associate it with the Account
        Contact con = new Contact();
        con.FirstName = 'John';
        con.AccountId = acc.Id;
        con.LastName = 'Doe';
        insert con;

        // Step 3: Create a Product (Product2)
        Product2 prod = new Product2();
        prod.Name = 'Example Product';
        prod.IsActive = true;
        insert prod;

        // Step 4: Create an Asset and associate it with the Account, Contact, and Product
        Asset asset = new Asset();
        asset.Name = 'Sample Asset';
        asset.AccountId = acc.Id; // Linking the Asset to the Account
        asset.ContactId = con.Id; // Linking the Asset to the Contact
        asset.Product2Id = prod.Id; // Linking the Asset to the Product
        asset.Quantity = 1;
        asset.PurchaseDate = Date.today(); // Example Purchase Date
        asset.InstallDate = Date.today().addDays(1); // Example Install Date
        asset.Status = 'Active'; // Asset Status
        insert asset;

        System.debug('Asset Created: ' + asset.Id);
    }
}