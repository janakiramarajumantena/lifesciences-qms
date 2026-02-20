import { LightningElement, api, wire } from 'lwc';
import getAccountSummary from '@salesforce/apex/AccountService.getAccountSummary';

export default class AccountSummary extends LightningElement {

    @api recordId;
    summary;
    error;

    @wire(getAccountSummary, { accountId: '$recordId' })
    wiredSummary({ error, data }) {
        if (data) {
            this.summary = data;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.summary = undefined;
        }
    }
}
