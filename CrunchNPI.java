import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

import org.apache.commons.validator.routines.checkdigit.LuhnCheckDigit;


public class CrunchNPI
{
    public static void main(String[] args)
    {
        LuhnCheckDigit luhn = new LuhnCheckDigit();

        //Input file which needs to be parsed
        String fileToParse = "/npi/npidata.csv";
        BufferedReader fileReader = null;

        //Delimiter used in CSV file
        final String DELIMITER = ",";
        try
        {
            String line = "";
            //Create the file reader
            fileReader = new BufferedReader(new FileReader(fileToParse));

            int lineCount = 0;
            //Read the file line by line
            while ((line = fileReader.readLine()) != null)
            {
                // the first row contains header information
                if (lineCount > 0) {
                    String[] fields = line.split(DELIMITER);
                    String npi = "80840" + slice_range(fields[0], 1, fields[0].length() - 1);
                    luhn.isValid(npi);
                }
                lineCount++;
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        finally
        {
            try {
                fileReader.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    public static String slice_start(String s, int startIndex) {
        if (startIndex < 0) startIndex = s.length() + startIndex;
        return s.substring(startIndex);
    }

    public static String slice_end(String s, int endIndex) {
        if (endIndex < 0) endIndex = s.length() + endIndex;
        return s.substring(0, endIndex);
    }

    public static String slice_range(String s, int startIndex, int endIndex) {
        if (startIndex < 0) startIndex = s.length() + startIndex;
        if (endIndex < 0) endIndex = s.length() + endIndex;
        return s.substring(startIndex, endIndex);
    }
}