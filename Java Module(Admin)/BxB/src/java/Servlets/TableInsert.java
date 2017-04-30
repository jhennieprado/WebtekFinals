/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Beans.Service;
import Beans.ServiceProvider;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Vash
 */
public class TableInsert {
        private static Connection connection;
    
    protected TableInsert() throws ClassNotFoundException, SQLException{
        TableInsert.initializeDb();
    }
    
    private static void initializeDb() throws ClassNotFoundException, SQLException{
        Class.forName("com.mysql.jdbc.Driver");
        String url="jdbc:mysql://localhost:3306/bxb?user=root&password";
        connection = DriverManager.getConnection(url);
        System.out.println("Connected to the bxb database");
    }
    
   
    protected void insertIntoSp(ServiceProvider actor, String update) throws SQLException{
        System.out.println("Waht is this" + update);
        PreparedStatement statement = connection.prepareStatement(update);
        statement.setInt(1, actor.getSpId());
        statement.setString(2, actor.getFirstName());
        statement.setString(3, actor.getLastName());
        statement.setString(4, actor.getEmail());
        statement.setInt(5,actor.getContactNo());
        statement.setFloat(6,actor.getTotalRating());
        statement.setString(7, actor.getUserName());
        statement.setString(8, actor.getPassword());
        statement.setString(9, actor.getStatus());
        statement.setObject(10,actor.getProfpic());
        statement.executeUpdate();
        statement.close();
    }
    
    
    protected void insertIntoService(Service service, String update) throws SQLException{
        PreparedStatement statement = connection.prepareStatement(update);
        statement.setInt(1,service.getServiceId());
        statement.setString(2,service.getServiceName());
        statement.setFloat(3,service.getServiceAmount());
        statement.setString(4,service.getDescription());
        statement.setString(5,service.getCategory());
        statement.executeUpdate();
        statement.close();
    }
    
   
   protected void closeConnection() throws SQLException{
       connection.close();
       System.out.print("Connection to database closed!");
   }
}
