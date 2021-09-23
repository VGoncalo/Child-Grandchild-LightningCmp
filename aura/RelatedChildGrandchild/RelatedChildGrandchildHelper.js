({
	getData : function(cmp) {
		var recId = cmp.get("v.recordId");
        var action = cmp.get("c.getRelatedRecords");
      	action.setParams({objID: recId});
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            if(cmp.isValid() && state === "SUCCESS") {
                cmp.set("v.child_records", response.getReturnValue());
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