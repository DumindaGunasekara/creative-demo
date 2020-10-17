public inherited sharing class AccountService {

    public AccountService() {

    }

    /**
     * @description get Account, Contact and Case information by account id
     * @param accountId Account record Id
     * @return AccountInfoWrapper wrapper class with Account, Contact and Case information
     */    
    public AccountInfoWrapper getAccountInformation (String accountId){
        
        return null;
    } 

    private AccountInfoWrapper buildAccountInfoWrapper(String accountId) {
        return null;
    }

    /**
     * @description construct the AccountAddress wrapper class based on Account information
     * @param Account object with information
     * @return AccountAddress wrapper class 
     */
    private AccountAddress buildAccountAddress(Account acct) {
        AccountAddress accountAddress = new AccountAddress(
            acct?.BillingStreet,
            acct?.BillingCity,
            acct?.BillingState,
            acct?.BillingPostalCode,
            acct?.BillingCountry
        );

        return accountAddress;
    }

    /**
     * @description construct the ContactInfo wrapper class based on Contact information
     * @param Contact object with information
     * @return ContactInfo wrapper class 
     */    
    private ContactInfo buildContactInfo(Contact contact) {
        ContactInfo contactInfo = new ContactInfo(
            contact?.Title,
            contact?.Name,
            contact?.Email,
            contact?.MobilePhone,
            contact?.Phone
        );

        return contactInfo;
    }

    /**
     * @description construct the CaseSummary wrapper class based on Case list
     * @param List of Case records
     * @return CaseSummary wrapper class 
     */      
    private CaseSummary buildCaseSummary(List<Case> cases) {
        CaseSummary caseSummary = new CaseSummary(
            cases?.size(),
            cases[0]?.CreatedDate
        );

        return caseSummary;
    }

    /**
     * @description run SOQL to return Account information
     * @param accountId Account record Id
     * @return Account object with required information. returns null on exception
     */
    private Account getAccountInfoById(String accountId) {
        try{
            return [SELECT Id, Name, AccountNumber, BillingStreet, BillingCity, 
                            BillingState, BillingPostalCode, BillingCountry 
                    FROM Account
                    WHERE Id = :accountId];

        } catch(Exception exp) {
            return null;
        }
    }

    /**
     * @description run SOQL to return Contact information
     * @param accountId Account record Id
     * @return Contact object with required information. returns null on exception
     */    
    private Contact getContactInfoByAccountId(String accountId) {
        try{
            return [SELECT Id, Title, Name, Email, MobilePhone, Phone
                    FROM Contact 
                    WHERE AccountId = :accountId
                    ORDER BY CreatedDate DESC
                    LIMIT 1];
        } catch(Exception exp) {
            return null;
        }
    }

    /**
     * @description run SOQL to return List of Cases
     * @param accountId Account record Id
     * @return list of Case records with required information. returns null on exception
     */ 
    private List<Case> getCasesByAccountId(String accountId) {
        try{
            return [SELECT Id, CreatedDate
                    FROM Case
                    WHERE AccountId = :accountId
                        AND Status NOT IN ('Closed')
                    ORDER BY CreatedDate];
        } catch(Exception exp) {
            return null;
        }
    }
    
    /**
     * @description Inner class wrapper to keep Account, Contact and Case information
     */
    public class AccountInfoWrapper {
        public String accountName {get; set;}
        public String accountNumber {get; set;}
        public AccountAddress accountAddress {get; set;}
        public ContactInfo mainContact {get; set;}
        public CaseSummary caseSummary {get; set;}

        public AccountInfoWrapper(String accountName, String accountNumber, AccountAddress accountAddress,
                                    ContactInfo mainContact, CaseSummary caseSummary) {
            this.accountName = accountName;
            this.accountNumber = accountNumber;
            this.accountAddress = accountAddress;
            this.mainContact = mainContact;
            this.caseSummary = caseSummary;
        }
    }

    /**
     * @description Inner class to keep Account Address information
     */    
    public class AccountAddress {
        public String streetName {get; set;}
        public String city {get; set;}
        public String province {get; set;}
        public String postalCode {get; set;}
        public String country  {get; set;}

        public AccountAddress(String streetName, String city, String province, 
                                String postalCode, String country) {
            this.streetName = streetName;
            this.city = city;
            this.province = province;
            this.postalCode = postalCode;
            this.country = country;
        }
    }

    /**
     * @description Inner class to keep Contact informaton 
     */   
    public class ContactInfo {
        public String title {get; set;}
        public String name {get; set;}
        public String email {get; set;}
        public String mobile {get; set;}
        public String phone {get; set;}

        public ContactInfo(String title, String name, String email, String mobile, String phone) {
            this.title = title;
            this.name = name;
            this.email = email;
            this.mobile = mobile;
            this.phone = phone;
        }
    }

    /**
     * @description Inner class to keep Case summary information
     */ 
    public class CaseSummary {
        public Integer activeCaseCount {get; set;}
        public Datetime latestCaseCreatedDate {get; set;}

        public CaseSummary(Integer activeCaseCount, Datetime latestCaseCreatedDate) {
            this.activeCaseCount = activeCaseCount;
            this.latestCaseCreatedDate = latestCaseCreatedDate;
        }
    }
}
