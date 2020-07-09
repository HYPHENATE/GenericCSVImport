trigger ImportTemplateFieldTrigger on CSV_Import_Template_Object_Field__c (before insert, before update) {

    for(CSV_Import_Template_Object_Field__c citobf:trigger.new){
        try {
            SObjectType objectType = Schema.getGlobalDescribe().get(citobf.Object_API_Name__c);
            system.debug(objectType);
            DisplayType displayType = CSVImport_Helper.getSObjectFieldType(objectType, citobf.Field_API_Name__c);
            system.debug(displayType);
            citobf.Field_Type__c = string.valueof(displayType);
        } catch (Exception e){
            system.debug(e.getMessage());
        }
    }
}