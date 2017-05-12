/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets.DbManipulators;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import Beans.*;
import java.sql.PreparedStatement;
/**
 *
 * @author Vash
 */
public class TableUpdate {
    private static Connection connection;
    public TableUpdate() {
        initializeDb();
    }
    
    //Redundant code. Put in superclass
    private void initializeDb(){
        try {
            Class.forName("com.mysql.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/bxbfin?user=root&password";
            connection = DriverManager.getConnection(url);
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(TableUpdate.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public void updateServiceProvider(ServiceProvider sp){
        try {
            int spId = sp.getSpId();
            
            //remember to include the pictures for this huehuehuehueheu.
            //Think about the implementation of this carefully
            //You're basically changing all of the stuff here
            //And it also all depends if you can actually udpate all of this
            //Try to talk with the DB dudes about the final implementation of
            
            String query = "UPDATE serviceproviders SET "
                    + "first_name = ?, last_name = ?, email = ?"
                    + ", contactno = ?, username = ?, password = ?, accepted = ? "
                    + ", totalrating = ? WHERE spid = ? ";
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1,sp.getFirstName());
            statement.setString(2,sp.getLastName());
            statement.setString(3,sp.getEmail());
            statement.setString(4,sp.getContactNo());
            statement.setInt(8,sp.getTotalRating());
            statement.setString(5,sp.getUserName());
            statement.setString(6,sp.getPassword());
            statement.setString(7,sp.getStatus());
            statement.setInt(9,sp.getSpId());
            System.out.println(statement.toString());
            statement.executeUpdate();
        } catch (SQLException exception) {
            Logger.getLogger(TableUpdate.class.getName()).log(Level.SEVERE, null, exception);
        }
        
        
    }
    
    public void updateClient(Client client){
        try{
            int clientno = client.getClientNo();
            
            //Include the picture here
            final String query = "UPDATE client SET first_name = ?, last_name = ?,"
                    + " birthdate = ?, email = ?, username = ?, password = ?, "
                    + " contactNo = ?, address = ?, accountcreated = ?, accepted = ?"
                    + " WHERE clientno = ?";
            
            //Remember to include also the pictures here
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1,client.getFirstName());
            statement.setString(2,client.getLastName());
            statement.setDate(3,client.getBirthDate());
            statement.setString(4,client.getEmail());
            statement.setString(5,client.getUserName());
            statement.setString(6,client.getPassWord());
            statement.setString(7,client.getContactno());
            statement.setString(8, client.getAddress());
            statement.setTimestamp(9, client.getAccountCreated());
            statement.setInt(10,client.getClientNo());
            
            statement.executeUpdate();
           
            
            
        }catch(SQLException exception){
            Logger.getLogger(TableUpdate.class.getName()).log(Level.SEVERE, null, exception);
        }
    }
    
    public void updateAppointment(Appointment appointment){
        try{
            int id = appointment.getAppointmentno();
            
            String query = "UPDATE appointment SET sp_schedid = ?, daterequest = ?, "
                    + "clientno = ?, serviceid = ?, status = ? WHERE appointmentno = ?  ";
            
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setInt(1,appointment.getSpSchedId());
            statement.setTimestamp(2,appointment.getDatereq());
            statement.setInt(3,appointment.getClientno());
            statement.setInt(4,appointment.getServiceId());
            statement.setString(5,appointment.getStatus());
            statement.setInt(6,appointment.getAppointmentno());            
            statement.executeUpdate();            
        }catch(SQLException exception){
            Logger.getLogger(TableUpdate.class.getName()).log(Level.SEVERE, null, exception);          
        }
    }
    
    public void updateMessages(Messages message){
        try{
            String id = message.getMessageId();
            
            String query = "UPDATE messages SET reciever = ?, sender = ?, mdesc = ?"
                    + " WHERE messageid = ?";
            
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setInt(1,message.getReceiver());
            statement.setInt(2,message.getSender());
            statement.setString(3,message.getMdesc());
            statement.setString(4,message.getMessageId());
            
            statement.executeQuery();
            
        }catch(SQLException exception){
            
        }
    }
    
    public void closeConnection(){
        try {
            connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(TableUpdate.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

        
    
    
    
    
}
