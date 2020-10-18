@isTest
private class AccountServiceTest {

    @testSetup 
    static void setup() {

        //Set the Account record
        Account acct = new Account();
        acct.Name = 'Unit Test Account';
        acct.AccountNumber = 'A123456';
        acct.BillingStreet = 'Unit Test Street 1';
        acct.BillingCity = 'Unit Test City';
        acct.BillingState = 'AB';
        acct.BillingPostalCode = 'A1A2A2';
        acct.BillingCountry = 'CA';

        insert acct;
    }

    @isTest
    static void test_getAccountInformation_with_valid_accountId() {
        Test.startTest();
        List<Account> accts = [SELECT Id FROM Account WHERE Name = 'Unit Test Account'];

        AccountService service = new AccountService();
        AccountService.AccountInfoWrapper wrapper = service.getAccountInformation(accts[0].Id);

        System.assertEquals('Unit Test Account', wrapper.accountName);
        System.assertEquals('A123456', wrapper.accountNumber);

        Test.stopTest();
    }

    @isTest
    static void test_getAccountInformation_with_contact_valid_accountId() {
        Test.startTest();
        List<Account> accts = [SELECT Id FROM Account WHERE Name = 'Unit Test Account'];

        Contact contact = new Contact();
        contact.AccountId = accts[0].Id;
        contact.Title = 'CEO';
        contact.FirstName = 'First'; 
        contact.LastName = 'Last'; 
        contact.Email = 'unit_test@unittest.com'; 
        contact.MobilePhone = '3214569988'; 
        contact.Phone = '7412589966';

        insert contact;        

        AccountService service = new AccountService();
        AccountService.AccountInfoWrapper wrapper = service.getAccountInformation(accts[0].Id);

        System.assertEquals('First Last', wrapper.mainContact.name);
        System.assertEquals('unit_test@unittest.com',  wrapper.mainContact.email);

        Test.stopTest();
    }    

    @isTest
    static void test_getAccountInformation_with_inValid_accountId() {
        Test.startTest();

        AccountService service = new AccountService();
        AccountService.AccountInfoWrapper wrapper = service.getAccountInformation('123654');        

        System.assertEquals(null, wrapper.accountName);
        System.assertEquals(null, wrapper.mainContact.name);

        Test.stopTest();
    }    

    @isTest
    static void test_getAccountInformation_with_null() {
        Test.startTest();

        AccountService service = new AccountService();
        AccountService.AccountInfoWrapper wrapper = service.getAccountInformation(null);        

        System.assertEquals(null, wrapper.accountName);
        System.assertEquals(null, wrapper.mainContact.name);

        Test.stopTest();
    }    
}
