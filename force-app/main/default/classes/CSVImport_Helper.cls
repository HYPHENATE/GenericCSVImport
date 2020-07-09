/**
 * @description     helper class library for the CSV Import Tool
 * @author          daniel@hyphen8.com  
 * @date            09/07/2020
 * 
 */
public with sharing class CSVImport_Helper {
    
    /**
     * @description     method that confirms if an object exists
     * @param           string objectName
     * @return          boolean
     */
    public static boolean isObjectExist(String objectName){
        for (Schema.SObjectType sObjectType : Schema.getGlobalDescribe().values() ) {
           String sobjName = String.valueOf(sObjectType);
           if (sobjName.contains(objectName) ) {
               return true;
           }
        }
        return false;
    }

    /**
    * @description  getSObjectFieldType - Will take in a field name and return the type of field selected
    * @param        string SOQLField - confirms the SOQL API Name of the field
    * @param        SObjectType objectType - confirms what objecttype we are working with
    * @return       DisplayType - confirmed what or how we are going to display the field
    */
    public static DisplayType getSObjectFieldType(SObjectType objectType, string sOQLField) {        
        DisplayType fieldType = null;
        if(objectType.getDescribe().fields.getMap().containsKey(sOQLField)) {
            fieldType = objectType.getDescribe().fields.getMap().get(sOQLField).getDescribe().getType();    
        }
        return fieldType;
    }
}
