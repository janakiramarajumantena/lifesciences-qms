import { LightningElement, api, wire } from 'lwc';
import getContacts from '@salesforce/apex/AccountService.getContacts';

const columns = [
    {
        label: 'Name',
        fieldName: 'recordUrl',
        type: 'url',
        typeAttributes: {
            label: { fieldName: 'Name' }
        }
    },
    { label: 'Title', fieldName: 'Title' },
    { label: 'Email', fieldName: 'Email', type: 'email' },
    { label: 'Phone', fieldName: 'Phone', type: 'phone' },
];

export default class ContactsList extends LightningElement {
    @api recordId; // Account Id
    contacts;
    columns = columns;

    @wire(getContacts, { accountId: '$recordId' })
    wiredContacts({ data, error }) {
        if (data) {
            this.contacts = data.map(row => {
                return {
                    ...row,
                    recordUrl: '/' + row.Id
                };
            });
        }
    }
}