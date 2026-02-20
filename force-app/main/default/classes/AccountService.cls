public with sharing class AccountService {
 
	public class AccountSummaryWrapper {
        @AuraEnabled public Id accountId;
        @AuraEnabled public String accountName;
        @AuraEnabled public String industry;
        @AuraEnabled public Decimal annualRevenue;
        @AuraEnabled public Integer totalOpportunities;
        @AuraEnabled public Decimal totalPipelineAmount;
    }

    @AuraEnabled(cacheable=true)
    public static AccountSummaryWrapper getAccountSummary(Id accountId) {

        Account acc = [
            SELECT Id, Name, Industry, AnnualRevenue,
                   (SELECT Id, Amount FROM Opportunities)
            FROM Account
            WHERE Id = :accountId
            LIMIT 1
        ];

        AccountSummaryWrapper wrapper = new AccountSummaryWrapper();
        wrapper.accountId = acc.Id;
        wrapper.accountName = acc.Name;
        wrapper.industry = acc.Industry;
        wrapper.annualRevenue = acc.AnnualRevenue;

        wrapper.totalOpportunities = acc.Opportunities.size();

        Decimal totalAmount = 0;
        for (Opportunity opp : acc.Opportunities) {
            if (opp.Amount != null) {
                totalAmount += opp.Amount;
            }
        }

        wrapper.totalPipelineAmount = totalAmount;

        return wrapper;
    }

    @AuraEnabled(cacheable=true)
    public static List<Case> getCases(Id accountId){

        return [
            SELECT Id, CaseNumber, Subject, Status, Priority
            FROM Case
            WHERE AccountId = :accountId
        ];
    }

    @AuraEnabled(cacheable=true)
	public static List<Contact> getContacts(Id accountId){
        return [
            SELECT Id, Name, Email, Phone, Title
            FROM Contact
            WHERE AccountId = :accountId
            ORDER BY CreatedDate DESC
            LIMIT 50
        ];
	}
    
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getOpportunities(Id accountId){
        return [
            SELECT Id, Name, StageName, Amount, CloseDate
            FROM Opportunity
            WHERE AccountId = :accountId
            ORDER BY CloseDate DESC
            LIMIT 50
        ];
    }
}