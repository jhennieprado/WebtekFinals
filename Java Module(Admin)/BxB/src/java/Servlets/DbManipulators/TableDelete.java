/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets.DbManipulators;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Vash
 * 
 * You're not supposed to delete shit in your database
 * 
 * //Turn this into a deactivator
 */
public class TableDelete {
    private static Connection connect;
    
    public TableDelete(){
       TableDelete.initializeDb();
    }
    
    private static void initializeDb(){
        try {
            Class.forName("com.mysql.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/bxbfin?user=root&password";
            connect = DriverManager.getConnection(url);
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(TableDelete.class.getName()).log(Level.SEVERE, null, ex);
        }
        
    }
    
    public void deleteRow(String query, String id){       
        try {
            PreparedStatement statement = connect.prepareStatement(query);
            statement.setInt(1,Integer.parseInt(id));
            statement.executeUpdate();
        } catch (SQLException ex){
            Logger.getLogger(TableDelete.class.getName()).log(Level.SEVERE, null, ex);
        }
        
                
    }   
    
    public void closeConnection(){
        try {
            connect.close();
        }catch (SQLException ex) {
            Logger.getLogger(TableDelete.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
}
