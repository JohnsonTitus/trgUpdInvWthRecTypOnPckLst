trigger trgRecTypeUpd on Invoice__c (before insert) {

    //create a map of Record that maps Name to Id
    Map<String,RecordType> mapRecordtype = new Map<String,RecordType>();
    for(RecordType r : [select DeveloperName, id from RecordType where sObjectType = Invoice__c]){
        mapRecordtype.put(r.DeveloperName, r);
    }
    
    //get the corresponding Record id in the map based on the picklist value selected
    for(Invoice__c inv : Trigger.new){
        if(mapRecordtype.containsKey(inv.Industry__c)){
            inv.RecordType = mapRecordtype.get(inv.Industry__c).Id;
        }
    }

}