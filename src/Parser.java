import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.PrintWriter;
import java.io.IOException;

public class Parser{

     public static void main(String[] args) {

        String csvFile = "paragem_autocarros_oeiras_processado_4.csv";
        BufferedReader br = null;
        String line = "";
        String cvsSplitBy = ";";
        //int i = 0;

        try {
            FileWriter fileWriter = new FileWriter("base.pl");
            PrintWriter printWriter = new PrintWriter(fileWriter);
            br = new BufferedReader(new FileReader(csvFile));
            while ((line = br.readLine()) != null) {

                String[] info = line.split(cvsSplitBy);
                //printWriter.printf(country[0]);
                System.out.println("paragem(" + info[0] + "," + info[1] + "," + info[2] + ")");
               //i++;

            }
        printWriter.close();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (br != null) {
                try {
                    br.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }



    }
}