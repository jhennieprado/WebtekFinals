/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets.DbManipulators;

import Beans.Appointment;
import Beans.Client;
import Beans.Service;
import Beans.ServiceProvider;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 *
 * @author Vash
 */
public class TableInsert {
        private static Connection connection;
    
    public TableInsert() throws ClassNotFoundException, SQLException{
        TableInsert.initializeDb();
    }
    
    private static void initializeDb() throws ClassNotFoundException, SQLException{
        Class.forName("com.mysql.jdbc.Driver");
        String url="jdbc:mysql://localhost:3306/bxbfin?user=root&password";
        connection = DriverManager.getConnection(url);
        System.out.println("Connected to the bxb database");
    }
    
   
    public void insertIntoSp(ServiceProvider actor, String update) throws SQLException{
        System.out.println("Waht is this" + update);
        PreparedStatement statement = connection.prepareStatement(update);
        statement.setString(1, actor.getFirstName());
        statement.setString(2, actor.getLastName());
        statement.setString(3, actor.getEmail());
        statement.setString(4,actor.getContactNo());
        statement.setInt(8,actor.getTotalRating());
        statement.setString(5, actor.getUserName());
        statement.setString(6, actor.getPassword());
        statement.setString(7, actor.getStatus());
        statement.setObject(9,actor.getProfpic());
        statement.executeUpdate();
        statement.close();
    }
    
    
    public void insertIntoService(Service service, String update) throws SQLException{
        PreparedStatement statement = connection.prepareStatement(update);
        statement.setString(1,service.getServiceName());
        statement.setFloat(2,service.getServiceAmount());
        statement.setString(3,service.getDescription());
        statement.setString(4,service.getCategory());
        statement.executeUpdate();
        statement.close();
    }
    
    public void insertIntoAppointment(Appointment appointment, String update) throws SQLException{
        PreparedStatement statement = connection.prepareStatement(update);
        statement.setInt(1,appointment.getSpSchedId());
        statement.setTimestamp(2,appointment.getDatereq());
        statement.setInt(3,appointment.getClientno());
        statement.setInt(4,appointment.getServiceId());
        statement.setString(5,appointment.getStatus());
        statement.executeUpdate();
        statement.close();
   
    }
    
    public void insertIntoMessages() throws SQLException{
        
    }
    
    public void insertIntoClient(Client client,String update) throws SQLException{
        //Eyy include the photos
        PreparedStatement statement = connection.prepareStatement(update);
        statement.setString(1,client.getFirstName());
        statement.setString(2,client.getLastName());
        statement.setDate(3,client.getBirthDate());
        statement.setString(4,client.getEmail());
        statement.setString(5,client.getUserName());
        statement.setString(6,client.getPassWord());
        statement.setString(7,client.getContactno());
        statement.setString(8,client.getAddress());
        statement.setTimestamp(9,client.getAccountCreated());
        statement.setString(10,client.getStatus());
        statement.setObject(11,client.getProfpic());
        statement.executeUpdate();
        statement.close();
        
        
    }
   
   public void closeConnection() throws SQLException{
       connection.close();
       System.out.print("Connection to database closed!");
   }
}
