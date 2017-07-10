/**
 * Created by vitor on 20-06-2017.
 */
import java.io.*;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.concurrent.locks.*;

class Servidor extends Thread{

    Ball b;
    
    Servidor(Ball b){
      this.b = b; 
    }
    
    public void run(){

        try {
            ServerSocket server_Socket = new ServerSocket(8421); //cria socket e da bind na porta 4444
            Socket client_Socket = server_Socket.accept(); // aceita a coneção que vem do cliente e fica à espera até
                                                           // receber esse pedido de coneção
            PrintWriter out = new PrintWriter(client_Socket.getOutputStream(), true);
            BufferedReader in = new BufferedReader(new InputStreamReader(client_Socket.getInputStream()));

            String s = in.readLine();               
            System.out.println(s);
            while(true) {                
                s = in.readLine(); 
                if(s == null) break;
                if(s.equals("save point")) b.setPoint();
                else if(s.equals("go to point")) b.setGotoPoint(true);
                else{
                  String[] split = s.split(" ");
                  if(split[0].equals("f")) b.setVD(Float.parseFloat(split[1]),0);
                  else if(split[0].equals("r")) b.setVD(0,Float.parseFloat(split[1]));
                  else if(split[0].equals("0")) b.setVD(0,0);
                }
                out.println("OK");
                out.flush();
            }
            server_Socket.close();
        }catch(Exception e){
            e.printStackTrace();
        }
    }
}