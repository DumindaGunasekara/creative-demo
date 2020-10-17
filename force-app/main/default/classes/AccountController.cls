/**
 *  @description this class repects to the current users sharing.
 *      This is the interface for the LWC or Aura web component
 */
public with sharing class AccountController {

    /**
     * @description this is the interface method to get Account, Contact and Case information 
     *      to LWC or Aura web components
     * @param current record's account id from the URL
     * @return AccountInfoWrapper wrapper with encapsulated data
     */
    @AuraEnabled(cacheable=true)
    public static AccountService.AccountInfoWrapper getAccountInformation(String accountId){
        AccountService service = new AccountService();
        return service.getAccountInformation(accountId);
    }
}
