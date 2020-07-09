trigger ImportTemplateObjectTrigger on CSV_Import_Template_Object__c (before insert, before update) {

    for(CSV_Import_Template_Object__c cito:trigger.new){
        boolean objectExists = CSVImport_Helper.isObjectExist(cito.Object_API_Name__c);
        if(!objectExists){
            cito.addError('The Object name provided does not existing please check and try again, this must be the developer API Name.');
        }
    }
    
}