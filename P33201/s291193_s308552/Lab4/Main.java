package org.example;

import java.io.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import com.jcraft.jsch.*;

public class Main {

    static String password_database = "maybenex1ime";

    static String password_ssh = "BflF!5827";

    static String host = "helios.cs.ifmo.ru";

    public static void listFolderStructure(String username, String password,
                                           String host, int port, String command) throws Exception {

        Session session = null;
        ChannelExec channel = null;

        try {
            session = new JSch().getSession(username, host, port);
            session.setPassword(password);
            session.setConfig("StrictHostKeyChecking", "no");
            session.connect();

            channel = (ChannelExec) session.openChannel("exec");
            channel.setCommand(command);
            ByteArrayOutputStream responseStream = new ByteArrayOutputStream();
            channel.setOutputStream(responseStream);
            channel.connect();

            while (channel.isConnected()) {
                Thread.sleep(100);
            }

            String responseString = responseStream.toString();
            System.out.println(responseString);
        } finally {

        }
        ;
    }

    static DataOutputStream dataOutputStream;

    static {
        try {
            dataOutputStream = new DataOutputStream(new FileOutputStream("src/main/resources/insert.sql"));
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
    }

    public static void saveToFile(ArrayList arrayList){
        try{
            for(Object object: arrayList){
                dataOutputStream.writeBytes(object + "\n");
            }
        } catch (IOException e){
            e.printStackTrace();
        }
    }

    public static String[] tables = {
            "attribute","player","sponsor","goal","league","stadium","coach","referee","club","match",
            "player_club", "club_league", "club_match", "match_league", "match_goal","match_referee",
            "match_stadium", "player_goal", "play_MOTM", "sponsor_club"
    };

    public static int[] num_columns = {
            7,9,4,3,3,4,3,4,6,4,2,2,2,2,2,2,2,2,2,2
    };

    public static Map<Integer,String[]> columns_map = new HashMap<>();

    public static Map<String, Object[]> data_map = new HashMap<>();
    static int limit = 15;

    public static Integer[] generate_random_numbers(int max, int min){
        Integer[] result = new Integer[limit];
        for(int i=0; i<limit;++i) {
            result[i] = (int) Math.floor(Math.random() * (max - min + 1) + min);
        }
        return result;
    }

    public static String[] generate_content(){
        String[] result = new String[15];
        for(int i=0; i<limit;++i){
            result[i] = data_map.get("name1")[i]+ "_SALVAGE";
        }
        return result;
    }

    public static void set_up(){
        columns_map.put(0, new String[]{"attack", "defense","dribble", "pass","speed","power","stamina"});
        columns_map.put(1, new String[]{"full_name", "height","weight","position","nationality","shirt_number","birthday","image","id_attribute"});
        columns_map.put(2, new String[]{"name", "birthday","id_transport"});
        columns_map.put(3, new String[]{"content", "time","place"});
        columns_map.put(4, new String[]{"salvage_id", "part_id"});
        columns_map.put(5, new String[]{"person_id", "salvage_id"});
        data_map.put("model0",new String[]{
                "XL-1","XL-2","Xl-3","XL-4","XL-5","CM-1","CM-2","CM-3","CM-4","CM-5","HJ-1","HJ-2",
                "HJ-3","HJ-4","HJ-5"
        });
        data_map.put("tonnage0",generate_random_numbers(50,200));
        data_map.put("name2", new String[]{
                "Tommy","Johnny","Polly","Arthur","Ada","Shelby","Dustin","Rose","Grace","Michael",
                "Raphina","Frank","Werner","Mark","Halland"
        });
        data_map.put("weight1",generate_random_numbers(150,300));
        data_map.put("name1",new String[]{
                "Left Wing","Right Wing","Head","Upper Back","Lower Back","Tail","Upper Tail","Funnel",
                "Steam","Propeller","Hull","Anchor","Bow","Forward","Deck"
        });
        data_map.put("id_transport2",generate_random_numbers(1,1000));
        data_map.put("birthday2",new String[]{
                "2021-10-03","2021-10-02","2021-10-04","2021-10-05","2021-10-06","2021-10-08",
                "2021-10-07","2021-10-01","2001-10-08","2001-10-03","2000-10-08","1999-09-08",
                "1999-09-08","1999-09-09","1999-08-10"
        });
        data_map.put("content3",generate_content());
        data_map.put("time3", new String[]{
                "2021-10-03 10:00:01","2021-10-02 11:01:00","2021-10-04 10:01:08","2021-10-05 11:05:08","2021-10-06 12:01:03","2021-10-08 10:08:00",
                "2021-10-03 18:00:01","2021-10-02 08:01:00","2021-10-04 10:00:07","2021-10-05 15:08:06","2021-10-06 17:06:07","2021-10-08 19:05:00",
                "2021-10-03 14:00:01","2021-10-02 00:01:00","2021-10-04 00:00:08","2021-10-05 16:30:06","2021-10-06 17:30:07","2021-10-08 19:35:00",
        });
        data_map.put("place3", new String[]{
           "Neva River","Black River","Fontanka River","Moyka River","Griboedov Canal",
                "Kryukov Canal","Karpovka River","Smolenka River","Zimnyaya Kanavka","Swan Canal",
                "Okhta River","Finnish Bay","Hay Bay","Neva Bay","Nhevskaya Bay"
        });
        data_map.put("salvage_id4", generate_random_numbers(1,1000));
        data_map.put("part_id4",generate_random_numbers(1,1000));
        data_map.put("person_id5",generate_random_numbers(1,1000));
        data_map.put("salvage_id5",generate_random_numbers(1,1000));
    }
    public static void generateQuery(int index){
        ArrayList<String> list = new ArrayList<>();
        String queryBuilder ;
        for(int i=0; i<1000;++i){
            queryBuilder = "INSERT INTO " + tables[index] + " (";
            for(int j=0; j<num_columns[index];++j) {
                queryBuilder += columns_map.get(index)[j];
                if(j != num_columns[index]-1) queryBuilder += ", ";
            }
            queryBuilder += ") VALUES (";
            for(int j=0; j<num_columns[index];++j){
                String name = columns_map.get(index)[j];
                Object data = data_map.get(name+index)[new Random().nextInt(15)];
                if(data.getClass() == String.class) queryBuilder += "'" + data + "'";
                else queryBuilder += data;
                if(j != num_columns[index]-1) queryBuilder += ",";
            }
            queryBuilder += ");";
            list.add(queryBuilder);
        }
        saveToFile(list);
    }

    public static void main(String[] args) throws Exception {
        //listFolderStructure("s291193",password_ssh,host,2222,"psql -h pg -d studs");
        set_up();
        generateQuery(1);
    }
}