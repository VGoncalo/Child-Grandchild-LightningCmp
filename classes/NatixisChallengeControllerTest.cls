@isTest
private class NatixisChallengeControllerTest {
	
    @testSetup static void setup(){
    	Object_A__c a_record = new Object_A__c();
    	insert a_record;
        Object_B__c b_record_1 = new Object_B__c(Object_A__c=a_record.id);
        insert b_record_1;
        Object_C__c c_record_1 = new Object_C__c(Object_B__c=b_record_1.id);
        insert c_record_1;
        Object_C__c c_record_2 = new Object_C__c(Object_B__c=b_record_1.id);
        insert c_record_2;
    }
    
    static testMethod void testingController(){
        List<Object_A__c> a_record = [select id from Object_A__c];        
        List<Object> ChildAndGrandchilds = NatixisChallengeController.getRelatedRecords(a_record[0].id);
        List<Object_B__c> b_records_lst = [select id from Object_B__c where Object_A__c =: a_record[0].id];
        system.assertEquals(1, b_records_lst.size());
        List<String> str_lst = new List<String>();
        List<Object> moreChildAndGrandchilds = NatixisChallengeController.getMoreRelatedRecords(a_record[0].id, str_lst);
        
        system.assertEquals(3, ChildAndGrandchilds.size());
    }
}