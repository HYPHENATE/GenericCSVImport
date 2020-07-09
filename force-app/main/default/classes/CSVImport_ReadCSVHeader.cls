/**
 * @description     simple class that will read the header row of a provided CSV String
 * @author          daniel@hyphen8.com
 * @date            29/06/2020
 */
public with sharing class CSVImport_ReadCSVHeader {

    /**
     * @description     method to create the template file Headers
     */
    @InvocableMethod(label='Generate Headers')
    public static void sendEmail(List<ProcessMappingFile> requests) {
        ProcessMappingFile pmf = requests[0];
        ContentVersion cv = [SELECT Id, VersionData, FileExtension, Title FROM ContentVersion WHERE FirstPublishLocationId =: pmf.templateId LIMIT 1];
        string csvData = cv.VersionData.toString();
        List<CSVImport_ReadCSVHeader.WrapperObject> headers = processHeaderCSV(csvData);
        List<CSV_Template_File_Header__c> insertHeaderList = new List<CSV_Template_File_Header__c>();
        for(CSVImport_ReadCSVHeader.WrapperObject csvHeader:headers){
            CSV_Template_File_Header__c ctfh = new CSV_Template_File_Header__c();
            ctfh.Column_title__c = csvHeader.headerRow;
            ctfh.Order__c = csvHeader.order;
            ctfh.CSV_Import_Template__c = pmf.templateId;
            insertHeaderList.add(ctfh);
        }
        database.insert(insertHeaderList);
    }


    /**
     * @description     class to support the invocable method processing
     */
    public class ProcessMappingFile {
        @InvocableVariable(label='Template Record Id' ) 
        public Id templateId;                  
    }
    
    /**
     * @description     method to get the header row of a provided csv string and return them as a list of string
     * @param           string csvData
     * @return          List<WrapperObject>
     */
    public static List<CSVImport_ReadCSVHeader.WrapperObject> processHeaderCSV(String csvData){
        List<String> dataRows = csvData.replaceAll('\\r','').split('\n');
        List<String> headerRow = dataRows[0].split(',');
        integer i = 0;
        List<CSVImport_ReadCSVHeader.WrapperObject> returnWrapper = new List<CSVImport_ReadCSVHeader.WrapperObject>();
        for(String s:headerRow){
            CSVImport_ReadCSVHeader.WrapperObject wObject = new CSVImport_ReadCSVHeader.WrapperObject();
            wObject.headerRow = s;
            i = i + 1;
            wObject.order = i;
            returnWrapper.add(wObject);
            
        }
        return returnWrapper;
    }


    public class WrapperObject {
        public string headerRow;
        public integer order;
    }
}