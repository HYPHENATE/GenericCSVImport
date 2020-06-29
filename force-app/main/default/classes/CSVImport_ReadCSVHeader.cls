/**
 * @description     simple class that will read the header row of a provided CSV String
 * @author          daniel@hyphen8.com
 * @date            29/06/2020
 */
public with sharing class CSVImport_ReadCSVHeader {
    
    /**
     * @description     method to get the header row of a provided csv string and return them as a list of string
     * @param           string csvData
     * @return          List<WrapperObject>
     */
    public static List<CSVImport_ReadCSVHeader.WrapperObject> processHeaderCSV(String csvData){
        List<String> dataRows = csvData.replaceAll('\\r','').split('\n');
        List<String> headerRow = dataRows[0].split(',');
        List<String> firstRow = dataRows[1].split(',');
        integer i = 0;
        List<CSVImport_ReadCSVHeader.WrapperObject> returnWrapper = new List<CSVImport_ReadCSVHeader.WrapperObject>();
        for(String s:headerRow){
            CSVImport_ReadCSVHeader.WrapperObject wObject = new CSVImport_ReadCSVHeader.WrapperObject();
            wObject.headerRow = s;
            wObject.exampleValue = firstRow[i];
            i = i + 1;
            wObject.order = i;
            returnWrapper.add(wObject);
            
        }
        return returnWrapper;
    }


    public class WrapperObject {
        public string headerRow;
        public string exampleValue;
        public integer order;
    }
}