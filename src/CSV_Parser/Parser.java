package src.CSV_Parser;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.PrintWriter;
import java.io.IOException;

public class Parser{

     public static void main(String[] args) {

        String csvFile = "C:/Users/anton/Onedrive/Documentos/GitHub/SRCR-TP2/src/CSV_Parser/lista_adjacencias_paragens.csv";
        BufferedReader br = null;
        BufferedReader br2 = null;
        String line = "";
        String line2 = "";
        String cvsSplitBy = ";";
        String p1 = "";

        try {
            FileWriter fileWriter = new FileWriter("C:/Users/anton/Onedrive/Documentos/GitHub/SRCR-TP2/src/base_de_conhecimento.pl");
            PrintWriter printWriter = new PrintWriter(fileWriter);
            br2 = new BufferedReader(new FileReader(csvFile));
            br = new BufferedReader(new FileReader(csvFile));
            br.readLine();
            br2.readLine();


            while ((line2 = br2.readLine()) != null) {

                String[] info = line2.split(cvsSplitBy);

                System.out.println("paragem" + "(" + info[0].toLowerCase() + "," + info[1].toLowerCase() + "," +  info[2].toLowerCase() + "," + info[3].toLowerCase() + "," + "'" +
                info[4].toLowerCase() + "'" + "," + info[5].toLowerCase() + "," + info[6].toLowerCase() + "," + info[7].toLowerCase() + "," + info[8].toLowerCase() + "," + "'" +
                info[9].toLowerCase() + "'" + "," + "'" + info[10].toLowerCase() + "'" + ").\n");
                printWriter.printf("paragem" + "(" + info[0].toLowerCase() + "," + info[1].toLowerCase() + "," +  info[2].toLowerCase() + "," + info[3].toLowerCase() + "," + "'" +
                info[4].toLowerCase() + "'" + "," + info[5].toLowerCase() + "," + info[6].toLowerCase() + "," + info[7].toLowerCase() + "," + info[8].toLowerCase() + "," + "'" +
                info[9].toLowerCase() + "'" + "," + "'" + info[10].toLowerCase() + "'" + ").\n");
                
            }
            
            line = br.readLine();
            String[] info = line.split(cvsSplitBy);
            String ultima = info[0];
            String carreira = info[7];
            line2 = br.readLine();
            String[] info2 = line2.split(cvsSplitBy);
            p1 = info2[0];
            String carreira2 = info2[7];


            while ((line = br.readLine()) != null) {
                
                if(carreira.equals(carreira2)){

                    System.out.println("aresta" + "(" + ultima + "," + p1 + ");\n");
                    printWriter.printf("aresta" + "(" + ultima + "," + p1 + ").\n");
                    ultima = p1;
                    info = line.split(cvsSplitBy);
                    p1 = info[0];
                    carreira = carreira2;
                    carreira2 = info[7];
                }
                else{
                    ultima = p1;
                    info = line.split(cvsSplitBy);
                    p1 = info[0];
                    carreira = carreira2;
                    carreira2 = info[7];
                }
        }

        System.out.println("aresta" + "(" + ultima + "," + p1 + ");\n");
        printWriter.printf("aresta" + "(" + ultima + "," + p1 + ").\n");

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
            if (br2 != null) {
                try {
                    br2.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }



    }
}