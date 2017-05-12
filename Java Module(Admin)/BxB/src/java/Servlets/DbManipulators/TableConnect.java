/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets.DbManipulators;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Vash
 */
public class TableConnect {
    
    private static Connection connection;
    
    public TableConnect() throws ClassNotFoundException, SQLException{
        TableConnect.initializeDb();
    }
    
    private static void initializeDb() throws ClassNotFoundException, SQLException{
        Class.forName("com.mysql.jdbc.Driver");
        String url="jdbc:mysql://localhost:3306/bxbfin?user=root&password";
        connection = DriverManager.getConnection(url);
        System.out.println("Connected to the sakila database");
    }
    
   public ResultSet queryFromDatabase(String query) throws SQLException{
       PreparedStatement statement = connection.prepareStatement(query);
       ResultSet result = statement.executeQuery();
       return result;
   }
   
   public Connection getConnection(){
       return connection;
       //Find out if this is ok;
   }
   
   public void closeConnection() throws SQLException{
       connection.close();
       System.out.print("Connection to database closed!");
   }
   
    
    
}
