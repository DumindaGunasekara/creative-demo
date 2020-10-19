import { api, LightningElement, track, wire } from 'lwc';

import getAccountInfo from '@salesforce/apex/AccountController.getAccountInformation';

export default class AccountDetail extends LightningElement {

    @api recordId;
    @track accountData;
    @track error;

    @wire(getAccountInfo, {accountId: '$recordId'})
    wiredAccount({error, data}) {
        if(data) {
            this.accountData = data;
            this.error = undefined;
        } else if(error) {
            this.accountData = undefined;
            this.error = error;
        }
    }
}