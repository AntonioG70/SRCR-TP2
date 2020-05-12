package src.CSV_Parser;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.PrintWriter;
import java.io.IOException;

public class Parser{

    public static void removeAcc(String s){
       
        for(int i = 0; i < s.length(); i++){
            if(s.charAt(i) == 'á') {s.replace('á', 'a');}
            if(s.charAt(i) == 'à') {s.replace('à', 'a');}
            if(s.charAt(i) == 'é') {s.replace('é', 'e');}
            if(s.charAt(i) == 'è') {s.replace('è', 'e');}
            if(s.charAt(i) == 'í') {s.replace('í', 'i');}
            if(s.charAt(i) == 'ì') {s.replace('ì', 'i');}
            if(s.charAt(i) == 'ó') {s.replace('ó', 'o');}
            if(s.charAt(i) == 'ò') {s.replace('ò', 'o');}
            if(s.charAt(i) == 'ú') {s.replace('ú', 'u');}
            if(s.charAt(i) == 'ù') {s.replace('ù', 'u');}
            if(s.charAt(i) == ',') {s.replace(',', ' ');}
        } 
    }

     public static void main(String[] args) {

        String csvFile = "C:/Users/anton/Onedrive/Documentos/GitHub/SRCR-TP2/src/CSV_Parser/paragem_autocarros_oeiras.csv";
        BufferedReader br = null;
        String line = "";
        String cvsSplitBy = ";";
        int index = 10;

        try {
            FileWriter fileWriter = new FileWriter("C:/Users/anton/Onedrive/Documentos/GitHub/SRCR-TP2/src/base_de_conhecimento.pl");
            PrintWriter printWriter = new PrintWriter(fileWriter);
            br = new BufferedReader(new FileReader(csvFile));
            while ((line = br.readLine()) != null) {

                String[] info = line.split(cvsSplitBy);
                boolean inBounds = (index >= 0) && (index < info.length);
                
                for(int i = 0; i < info.length; i++){
                    removeAcc(info[i]);
                }

                if(info[1].equals("latitude")){
                    printWriter.printf("%% " + info[0].toLowerCase() + "," + info[1].toLowerCase() + "," + info[2].toLowerCase() + "," + info[3].toLowerCase() +"," + info[4].toLowerCase() + "," + info[5].toLowerCase() + "," +
                info[6].toLowerCase() + "," + info[7].toLowerCase() + "," + info[8].toLowerCase() + "," + info[9].toLowerCase() + "," + info[10].toLowerCase() + "\n");
                }

                printWriter.printf("paragem(" + info[0].toLowerCase() + "," + info[1].toLowerCase() + "," + info[2].toLowerCase() + "," + info[3].toLowerCase() +"," + info[4].toLowerCase() + "," + info[5].toLowerCase() + "," +
                info[6].toLowerCase() + "," + info[7].toLowerCase() + "," + info[8].toLowerCase() + "," + info[9].toLowerCase() + "," + info[10].toLowerCase() + ");\n");
                System.out.println("paragem(" + info[0] + "," + info[1] + "," + info[2] + "," + info[3] +"," + info[4] + "," + info[5] + "," +
                info[6] + "," + info[7] + "," + info[8] + "," + info[9] + "," + info[10] + ");\n");
                
               

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