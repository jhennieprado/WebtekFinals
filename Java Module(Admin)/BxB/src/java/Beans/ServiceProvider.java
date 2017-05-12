/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Beans;

import Servlets.ConvertResultSetServlet;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Vash
 */
public class ServiceProvider implements Convertable {
    private int spId;
    private String firstName;
    private String lastName;
    private String email;
    private String contactNo;
    private int totalRating;
    private String userName;
    private String password;
    private String status;
    private Object profpic;
    
    public ServiceProvider(){
        this.spId = 1;
        this.firstName = "awef";
        this.lastName = "awef";
        this.email = "awef";
        this.contactNo = "123";
        this.totalRating = 0;
        this.userName ="awef";
        this.password ="awef";
        this.status = "awef";
        this.profpic = null;
    }

    public ServiceProvider(int spId, String firstName, String lastName, String email, 
            String contactNo, String userName, String password, String status, int totalRating) {
        this.spId = spId;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.contactNo = contactNo;
        this.totalRating = totalRating;
        this.userName = userName;
        this.password = password;
        this.status = status;
        this.profpic = null;
    }
    
    public ServiceProvider(String firstName, String lastName, String email, 
        String contactNo, String userName, String password, String status, int totalRating) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.contactNo = contactNo;
        this.totalRating = totalRating;
        this.userName = userName;
        this.password = password;
        this.status = status;
        this.profpic = null;
    }
    
    public ServiceProvider(String firstName, String lastName, String email, 
        String contactNo, String userName, String password, String status, int totalRating
        ,Object profPic) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.contactNo = contactNo;
        this.totalRating = totalRating;
        this.userName = userName;
        this.password = password;
        this.status = status;
        this.profpic = profPic;
    }
    
    
    public ServiceProvider(int spId, String firstName, String lastName, String email, 
            String contactNo, String userName, String password, String status, int totalRating, Object profPic) {
        this.spId = spId;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.contactNo = contactNo;
        this.totalRating = totalRating;
        this.userName = userName;
        this.password = password;
        this.status = status;
        this.profpic = profPic;
    }

    public void setSpId(int spId) {
        this.spId = spId;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setContactNo(String contactNo) {
        this.contactNo = contactNo;
    }

    public void setTotalRating(int totalRating) {
        this.totalRating = totalRating;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public void setProfpic(Object profpic) {
        this.profpic = profpic;
    }

    
    
    public int getSpId() {
        return spId;
    }

    public String getFirstName() {
        return firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public String getEmail() {
        return email;
    }

    public String getContactNo() {
        return contactNo;
    }

    public int getTotalRating() {
        return totalRating;
    }

    public String getUserName() {
        return userName;
    }

    public String getPassword() {
        return password;
    }

    public String getStatus() {
        return status;
    }

    public Object getProfpic() {
        return profpic;
    }

    @Override
    public ArrayList<ServiceProvider> toArrayList(ResultSet validSp) {
                /**
         * This is repeated code. You better refactor this as a method 
         * since you can reuse this to full effect
         * Remember to use the picture thingy.
        */
            ArrayList<ServiceProvider> list = new ArrayList<> ();

            try{
                while(validSp.next()){
                    int spid = validSp.getInt(1) ;
                    String first_name  = validSp.getString(2);
                    String last_name = validSp.getString(3); 
                    String mail = validSp.getString(4);
                    String contact = validSp.getString(5);
                    int rating = validSp.getInt(9);
                    String user = validSp.getString(6);
                    String passWord = validSp.getString(7);
                    String accepted = validSp.getString(8);

                    ServiceProvider sp = new ServiceProvider(spid,first_name,last_name,
                            mail,contact,user,passWord,accepted,rating);
                    list.add(sp);
                }
            } catch (SQLException ex) {
                Logger.getLogger(ConvertResultSetServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            return list;
    }

    
    
           
}
