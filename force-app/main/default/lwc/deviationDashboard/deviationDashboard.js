import { LightningElement, wire } from 'lwc';
import getOpenDeviations from '@salesforce/apex/DeviationService.getOpenDeviations';
import getDeviationStats from '@salesforce/apex/DeviationService.getDeviationStats';

const COLUMNS = [
    { label: 'Deviation Number', fieldName: 'Name' },
    { label: 'Status', fieldName: 'Status__c' }
];

export default class DeviationDashboard extends LightningElement {

    columns = COLUMNS;
    deviations;
    error;

    stats = {};

    @wire(getDeviationStats)
    wiredStats({ error, data }) {
        if (data) {
            this.stats = data;
        } else if (error) {
            console.error(error);
        }
    }

    @wire(getOpenDeviations)
    wiredDeviations({ data, error }) {
        if (data) {
            this.deviations = data;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.deviations = undefined;
        }
    }
}
