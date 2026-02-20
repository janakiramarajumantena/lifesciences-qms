import { LightningElement, api, wire } from 'lwc';
import getCases from '@salesforce/apex/AccountService.getCases';

const columns = [
    {
        label: 'Case Number',  
        fieldName: 'recordUrl',
        type: 'url',
        typeAttributes: {
            label: { fieldName: 'CaseNumber' }
        }
    },
    { label: 'Subject', fieldName: 'Subject' },
    { label: 'Status', fieldName: 'Status' },
    { label: 'Priority', fieldName: 'Priority' }
];

export default class CaseList extends LightningElement {

    @api recordId;
    columns = columns;
    cases;

    @wire(getCases, { accountId: '$recordId' })
    wiredCases({ data }) {
        if (data) {
            this.cases = data.map(row => {
                return {
                    ...row,
                    recordUrl: '/' + row.Id
                };
            });
        }
    }
}
