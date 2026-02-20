public with sharing class DeviationTriggerHandler {
    public static void run() {
        if(Trigger.isAfter && Trigger.isInsert) {
            afterInsert(Trigger.new);
        }
    }
    
    public static void afterInsert(List<Deviation__c> deviations) {
        List<CAPA__c> capaList = new List<CAPA__c>();
        for (Deviation__c dev: deviations) {
            if (dev.CAPA_Required__c) {
                CAPA__c newCapa = new CAPA__c(
                    DeviationId__c = dev.Id,
                    Due_Date__c = dev.Due_Date__c,
                    Severity__c = dev.Severity__c,
                    Status__c = 'Open'
                );
                capaList.add(newCapa);
            }
        }
        if (!capaList.isEmpty()) {
            insert capaList;
        }
    }
}
