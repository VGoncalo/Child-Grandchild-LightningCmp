({
	init : function(cmp, evt, hel) {
        cmp.set('v.columns', {label:'Child and Grandchild', fieldName: 'Name', type: 'text'});
		hel.getData(cmp);
    },
    
    getMoreRecords : function(cmp, evt){
        var recId = cmp.get("v.recordId");
        var current_records = cmp.get("v.child_records");
        
        var current_records_to_filter = [];
        for(const record in current_records){
            if(current_records[record].Name.includes('B-') ){
            	current_records_to_filter.push(current_records[record].Id);    
            }
        }
        
        var action = cmp.get("c.getMoreRelatedRecords");
        action.setParams({recAId: recId,
                          filter: current_records_to_filter
                         });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if(cmp.isValid() && state === "SUCCESS") {
                var newRecords = response.getReturnValue()
                for(const newrec in newRecords){
                    current_records.push(newRecords[newrec]);
                }
                cmp.set("v.child_records", current_records);
            }else if (state === "ERROR"){
                var errors = response.getError();
                console.error(errors)
            }else{
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);
    }

})