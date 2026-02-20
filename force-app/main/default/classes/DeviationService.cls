public with sharing class DeviationService {

    @AuraEnabled(cacheable=true)
    public static List<Deviation__c> getOpenDeviations() {
        return [
            SELECT Id, Name, Status__c
            FROM Deviation__c
            WHERE Status__c = 'Open'
            ORDER BY CreatedDate DESC
            LIMIT 50
        ];
    }
    
    @AuraEnabled(cacheable=true)
    public static Map<String, Integer> getDeviationStats() {
        Map<String, Integer> stats = new Map<String, Integer>();

        stats.put('Total', [SELECT COUNT() FROM Deviation__c]);
        stats.put('Open', [SELECT COUNT() FROM Deviation__c WHERE Status__c = 'Open']);
        stats.put('Closed', [SELECT COUNT() FROM Deviation__c WHERE Status__c = 'Closed']);

        return stats;
    }
}