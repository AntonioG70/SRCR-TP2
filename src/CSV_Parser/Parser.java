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

            printWriter.printf(":- dynamic aresta/2.\n:- dynamic paragem/10.\n");

            while ((line2 = br2.readLine()) != null) {

                String[] info = line2.split(cvsSplitBy);

                System.out.println("paragem" + "(" + info[0].toLowerCase() + "," + info[1].toLowerCase() + "," +  info[2].toLowerCase() + "," + info[3].toLowerCase() + "," + "'" +
                info[4].toLowerCase() + "'" + "," + info[5].toLowerCase() + "," + "'" + info[6].toLowerCase() + "'" + "," + info[7].toLowerCase() + "," + info[8].toLowerCase() + "," + "'" +
                info[9].toLowerCase() + "'" + "," + "'" + info[10].toLowerCase() + "'" + ").\n");
                printWriter.printf("paragem" + "(" + info[0].toLowerCase() + "," + info[1].toLowerCase() + "," +  info[2].toLowerCase() + "," +  "'" + info[3].toLowerCase() + "'" + "," + "'" +
                info[4].toLowerCase() + "'" + "," + "'" + info[5].toLowerCase() + "'" + "," + "'" + info[6].toLowerCase() + "'" + "," + info[7].toLowerCase() + "," + info[8].toLowerCase() + "," + "'" +
                info[9].toLowerCase() + "'" + "," + "'" + info[10].toLowerCase() + "'" + ").\n");
                
            }
            
            line = br.readLine();
            String[] info = line.split(cvsSplitBy);
            String ultima = info[0];
            String ultima1 = info[1];
            String ultima2 = info[2];
            String ultima3 = info[3];
            String ultima4 = info[4];
            String ultima5 = info[5];
            String ultima6 = info[6];
            String ultima7 = info[7];
            String ultima8 = info[8];
            String ultima9 = info[9];
            String ultima10 = info[10];
            String carreira = info[7];
            line2 = br.readLine();
            String[] info2 = line2.split(cvsSplitBy);
            p1 = info2[0];
            String p2 = info2[1];
            String p3 = info2[2];
            String p4 = info2[3];
            String p5 = info2[4];
            String p6 = info2[5];
            String p7 = info2[6];
            String p8 = info2[7];
            String p9 = info2[8];
            String p10 = info2[9];
            String p11 = info2[10];
            String carreira2 = info2[7];


            while ((line = br.readLine()) != null) {
                
                if(carreira.equals(carreira2)){

                    System.out.println("aresta" + "(" + "paragem" + "(" + ultima + "," + ultima1 + "," + ultima2 + "," + "'" + ultima3.toLowerCase() + "'" + ","
                     + "'" + ultima4.toLowerCase() + "'" + "," + "'" + ultima5.toLowerCase() + "'" + "," + "'" + ultima6.toLowerCase() + "'" + "," + ultima7 + ","
                      + ultima8 + "," + "'" + ultima9.toLowerCase() + "'" + "," + "'" + ultima10.toLowerCase() + "'" + ")" +"," + "paragem" + "(" + p1 + "," + p2 + "," + p3 + 
                      "," + "'" + p4.toLowerCase() + "'" + ","
                      + "'" + p5.toLowerCase() + "'" + "," + "'" + p6.toLowerCase() + "'" + "," + "'" + p7.toLowerCase() + "'" + "," + p8 + ","
                       + p9 + "," + "'" + p10.toLowerCase() + "'" + "," + "'" + p11.toLowerCase() + "'" + ");\n");
                    printWriter.printf("aresta" + "(" + "paragem" + "(" + ultima + "," + ultima1 + "," + ultima2 + "," + "'" + ultima3.toLowerCase() + "'" + ","
                    + "'" + ultima4.toLowerCase() + "'" + "," + "'" + ultima5.toLowerCase() + "'" + "," + "'" + ultima6.toLowerCase() + "'" + "," + ultima7 + ","
                     + ultima8 + "," + "'" + ultima9.toLowerCase() + "'" + "," + "'" + ultima10.toLowerCase() + "'" + ")" +"," + "paragem" + "(" + p1 + "," + p2 + "," + p3 + 
                     "," + "'" + p4.toLowerCase() + "'" + ","
                     + "'" + p5.toLowerCase() + "'" + "," + "'" + p6.toLowerCase() + "'" + "," + "'" + p7.toLowerCase() + "'" + "," + p8 + ","
                      + p9 + "," + "'" + p10.toLowerCase() + "'" + "," + "'" + p11.toLowerCase() + "'" + ")" + ").\n");
                    ultima = p1;
                    ultima1 = p2;
                    ultima2 = p3;
                    ultima3 = p4;
                    ultima4 = p5;
                    ultima5 = p6;
                    ultima6 = p7;
                    ultima7 = p8;
                    ultima8 = p9;
                    ultima9 = p10;
                    ultima10 = p11;
                    info = line.split(cvsSplitBy);
                    p1 = info[0];
                    p2 = info[1];
                    p3 = info[2];
                    p4 = info[3];
                    p5 = info[4];
                    p6 = info[5];
                    p7 = info[6];
                    p8 = info[7];
                    p9 = info[8];
                    p10 = info[9];
                    p11 = info[10];
                    carreira = carreira2;
                    carreira2 = info[7];
                }
                else{
                    ultima = p1;
                    ultima1 = p2;
                    ultima2 = p3;
                    ultima3 = p4;
                    ultima4 = p5;
                    ultima5 = p6;
                    ultima6 = p7;
                    ultima7 = p8;
                    ultima8 = p9;
                    ultima9 = p10;
                    ultima10 = p11;
                    info = line.split(cvsSplitBy);
                    p1 = info[0];
                    p2 = info[1];
                    p3 = info[2];
                    p4 = info[3];
                    p5 = info[4];
                    p6 = info[5];
                    p7 = info[6];
                    p8 = info[7];
                    p9 = info[8];
                    p10 = info[9];
                    p11 = info[10];
                    carreira = carreira2;
                    carreira2 = info[7];
                }
        }

        System.out.println("aresta" + "(" + "paragem" + "(" + ultima + "," + ultima1 + "," + ultima2 + "," + "'" + ultima3.toLowerCase() + "'" + ","
        + "'" + ultima4.toLowerCase() + "'" + "," + "'" + ultima5.toLowerCase() + "'" + "," + "'" + ultima6.toLowerCase() + "'" + "," + ultima7 + ","
         + ultima8 + "," + "'" + ultima9.toLowerCase() + "'" + "," + "'" + ultima10.toLowerCase() + "'" + ")" +"," + "paragem" + "(" + p1 + "," + p2 + "," + p3 + 
         "," + "'" + p4.toLowerCase() + "'" + ","
         + "'" + p5.toLowerCase() + "'" + "," + "'" + p6.toLowerCase() + "'" + "," + "'" + p7.toLowerCase() + "'" + "," + p8 + ","
          + p9 + "," + "'" + p10.toLowerCase() + "'" + "," + "'" + p11.toLowerCase() + "'" + ");\n");
       printWriter.printf("aresta" + "(" + "paragem" + "(" + ultima + "," + ultima1 + "," + ultima2 + "," + "'" + ultima3.toLowerCase() + "'" + ","
       + "'" + ultima4.toLowerCase() + "'" + "," + "'" + ultima5.toLowerCase() + "'" + "," + "'" + ultima6.toLowerCase() + "'" + "," + ultima7 + ","
        + ultima8 + "," + "'" + ultima9.toLowerCase() + "'" + "," + "'" + ultima10.toLowerCase() + "'" + ")" +"," + "paragem" + "(" + p1 + "," + p2 + "," + p3 + 
        "," + "'" + p4.toLowerCase() + "'" + ","
        + "'" + p5.toLowerCase() + "'" + "," + "'" + p6.toLowerCase() + "'" + "," + "'" + p7.toLowerCase() + "'" + "," + p8 + ","
         + p9 + "," + "'" + p10.toLowerCase() + "'" + "," + "'" + p11.toLowerCase() + "'" + ")" + ").\n");

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