@RestResource(urlMapping='/qms/deviations/*')
global with sharing class DeviationRestService {
    @HttpGet
    global static List<SObject> getDeviations() {
        RestRequest req = RestContext.request;
        String uri = req.requestURI;
        List<String> parts = uri.split('/');
        List<SObject> result = new List<SObject>();
        
		if (parts.size() == 3) {        // URL - services/apexrest/qms/deviations
            result = getAllDeviations();
            return result;
        }
        else if (parts.size() == 4) {   // URL - services/apexrest/qms/deviations/a01xxxx
            result = getDeviationById(parts[3]);
            return result;
        }
        else if (parts.size() == 5 && parts[4] == 'capas') { // URL - services/apexrest/qms/deviations/a01xxxx/capas
            result = getCAPAsByDeviationId(parts[3]);
            return result;
        }
        return result;   
    }
    @HttpPost
    global static String createDeviation() {
        RestRequest req = RestContext.request;
        String body = req.requestBody.toString();

        Deviation__c dev = (Deviation__c) JSON.deserialize(body, Deviation__c.class);
        insert dev;

        return 'Created Deviation with Id: ' + dev.Id;
    }
    private static List<SObject> getAllDeviations() {
        return [SELECT Id, Name, Status__c, Category__c, Severity__c, Due_Date__c, CAPA_Required__c FROM Deviation__c LIMIT 50];
    }
    private static List<SObject> getDeviationById(String id) {
        return [SELECT Id, Name, Status__c, Category__c, Severity__c, Due_Date__c, CAPA_Required__c FROM Deviation__c WHERE Id = :id];
    }
    private static List<SObject> getCAPAsByDeviationId(String id) {
        return [SELECT Id, Name, Status__c, Severity__c, Due_Date__c FROM CAPA__c WHERE DeviationId__c = :id];
    }
}