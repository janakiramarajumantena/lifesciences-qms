trigger DeviationTrigger on Deviation__c (after insert) {
    DeviationTriggerHandler.run();
}