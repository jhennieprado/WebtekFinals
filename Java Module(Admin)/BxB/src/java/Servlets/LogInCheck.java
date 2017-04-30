/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;
import java.sql.*;
/**
 *
 * @author Vash
 */
public class LogInCheck {
    
    private static Connection connection;
    private String userName;
    private String passWord;
    
    public LogInCheck(){
        
    }
    
    public LogInCheck(String userName, String password) throws Exception{
        this.userName = userName;
        this.passWord = password;
        LogInCheck.initializeDb();
    }
    
    
    private static void initializeDb() throws Exception{
        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/bxb?user=root&password";
        connection = DriverManager.getConnection(url);
        System.out.println("Connection to database established!");
    }
    
    public String getUserName(){
        return this.userName;
    }
    
    public String getPassWord(){
        return this.passWord;
    }
    
    public boolean isCredentialsValid() throws Exception{
       return isUserNameValid() && isPasswordValid();
    }    
    
    
    //Do we even need this? Why not just try connecting to the actual thingy with 
    //And if it turns out to be retarded then you are fucked 
    public boolean isUserNameValid(){
        try{
            String query = "SELECT first_name FROM actor WHERE first_name = ?";
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, getUserName());
            ResultSet results = statement.executeQuery();
            System.out.print(results.toString());
            if(results.next()){
                 statement.close();
                results.close();
                return true;
            }else{
                statement.close();
                results.close();
                
                return false;
            }
           
        }catch(SQLException exception){
            exception.printStackTrace();
            return false;
            
        }

    }
    
    public boolean isPasswordValid(){
        try{
            String query = "SELECT last_name FROM actor WHERE last_name = ?";
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, getPassWord());
            ResultSet results = statement.executeQuery();
            System.out.println(results.toString());
            if(results.next()){
                 statement.close();
                results.close();
                return true;
            }else{
                statement.close();
                results.close();
                
                return false;
            }
     }catch(SQLException exception){
            exception.printStackTrace();
            return false;
        }

    }
    
    public void closeConnection() throws Exception{
        connection.close();
    }
    
}
