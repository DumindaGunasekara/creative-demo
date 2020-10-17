public with sharing class AccountController {

    @AuraEnabled(cacheable=true)
    public static AccountService.AccountWrapper getAccountInformation(String accountId){
        
        return null;
    }
}
