public class NatixisChallengeController {
	
    public class A_RelatedRecords{
        @AuraEnabled public List<Object_B__c> related_B {get;set;}
        @AuraEnabled public List<Object_C__c> related_C {get;set;}
    }
    
    @AuraEnabled
    public static List<Object> getRelatedRecords(Id objID){
        A_RelatedRecords a_related_records = new A_RelatedRecords();
        List<Object> records = new List<Object>();
        
        List<Object_B__c> child_records = [select id, Name from Object_B__c where Object_A__c =: objID limit 1];
        a_related_records.related_B = child_records;
        
        List<Object_C__c> grandchild_records = [select id, Name from Object_C__c where Object_B__c IN :child_records];
        a_related_records.related_C = grandchild_records;   
        
        for(Object b : a_related_records.related_B){
            records.add(b);
        }
        for(Object c : a_related_records.related_C){
            records.add(c);
        }
        system.debug(records);
        return records;
    }
    
    @AuraEnabled
    public static List<Object> getMoreRelatedRecords(Id recAId, List<String> filter){
        A_RelatedRecords a_related_records = new A_RelatedRecords();
        List<Object> moreRecords = new List<Object>();
        List<Object_B__c> newBrecord = new List<Object_B__c>();
        List<Object_C__c> newCrecord = new List<Object_C__c>();
        
        for(Object_B__c b : [select Id, Name, Object_A__c from Object_B__c where Object_A__c = :recAId and Id != :filter limit 1]){
            if(b.Object_A__c == recAId){
                newBrecord.add(b);
            }
        }
        a_related_records.related_B = newBrecord;
        for(Object b : a_related_records.related_B){
            moreRecords.add(b);
        }
		
        for(Object_C__c c : [select Id, Name from Object_C__c where Object_B__c =:newBrecord]){
            newCrecord.add(c);
        }
        a_related_records.related_C = newCrecord;
        for(Object c : a_related_records.related_C){
            moreRecords.add(c);
        }
        
        return moreRecords;
    }
}