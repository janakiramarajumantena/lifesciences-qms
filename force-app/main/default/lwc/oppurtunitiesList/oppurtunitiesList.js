import { LightningElement, api, wire } from 'lwc';
import getOpportunities from '@salesforce/apex/AccountService.getOpportunities';

const columns = [
    { 
        label: 'Opportunity Name',
        fieldName: 'recordUrl',
        type: 'url',
        typeAttributes: {
            label: { fieldName: 'Name' }
        }
    },
    { label: 'Stage', fieldName: 'StageName' },
    { label: 'Amount', fieldName: 'Amount', type: 'currency' },
    { label: 'Close Date', fieldName: 'CloseDate', type: 'date' },
];
export default class OppurtunitiesList extends LightningElement {
    @api recordId; // Account Id
    opportunities;
    columns = columns;

    @wire(getOpportunities, { accountId: '$recordId' })
    wiredContacts({ data, error }) {
        if (data) {
            this.opportunities = data.map(row => {
                return {
                    ...row,
                    recordUrl: '/' + row.Id
                };
            });
        }
    }
}