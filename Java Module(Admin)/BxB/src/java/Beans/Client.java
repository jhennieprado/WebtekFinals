/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Beans;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
/**
 *
 * @author Administrator
 */
public class Client implements Convertable {
    private int clientNo;
    private String firstName;
    private String lastName;
    private Date birthDate;
    private String email;
    private String userName;
    private String passWord;
    private String contactno;
    private String address; 
    private String status;
    private Timestamp accountCreated;
    private Object profpic;

    public Client() {
        
    }

    public Client(String firstName, String lastName, Date birthDate, 
            String email, String usrName, String passWord, String contactno, String address, 
            Timestamp accountCreated,String status) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.birthDate = birthDate;
        this.email = email;
        this.userName = usrName;
        this.passWord = passWord;
        this.contactno = contactno;
        this.address = address;
        this.status = status;
        this.accountCreated = accountCreated;
        this.profpic = null;
    }

    public Client(int clientNo,String firstName, String lastName, Date birthDate, 
        String email, String usrName, String passWord, String contactno, String address, 
        Timestamp accountCreated,String status) {
        this.clientNo = clientNo;
        this.firstName = firstName;
        this.lastName = lastName;
        this.birthDate = birthDate;
        this.email = email;
        this.userName = usrName;
        this.passWord = passWord;
        this.contactno = contactno;
        this.address = address;
        this.status = status;
        this.accountCreated = accountCreated;
        this.profpic = null;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Object getProfpic() {
        return profpic;
    }

    public void setProfpic(Object profpic) {
        this.profpic = profpic;
    }

    public void setStatus(String status) {
        this.status = status;
    }   
    

    public void setClientNo(int clientNo) {
        this.clientNo = clientNo;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public void setBirthDate(Date birthDate) {
        this.birthDate = birthDate;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setUsrName(String usrName) {
        this.userName = usrName;
    }

    public void setPassWord(String passWord) {
        this.passWord = passWord;
    }

    public void setContactno(String contactno) {
        this.contactno = contactno;
    }

    public void setAccountCreated(Timestamp accountCreated) {
        this.accountCreated = accountCreated;
    }

    
    public int getClientNo() {
        return clientNo;
    }

    public String getFirstName() {
        return firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public Date getBirthDate() {
        return birthDate;
    }

    public String getEmail() {
        return email;
    }

    public String getUserName() {
        return userName;
    }

    public String getPassWord() {
        return passWord;
    }

    public String getContactno() {
        return contactno;
    }

    public String getStatus() {
        return status;
    }

    
    public Timestamp getAccountCreated() {
        return accountCreated;
    }

    @Override
    public String toString() {
        return "Client{" + "clientNo=" + clientNo + ", firstName=" +
                firstName + ", lastName=" + lastName + ", birthDate=" + 
                birthDate + ", email=" + email + ", usrName=" + userName + ","
                + "passWord=" + passWord + ", contactno=" + contactno + ", "
                + "accountCreated=" + accountCreated + '}';
    }

    @Override
    public ArrayList<Client> toArrayList(ResultSet results) {
        ArrayList<Client> list = new ArrayList<> ();
        try {                     
            while(results.next()){
                //Remember to include the blob next time PICTURES
                int custId = results.getInt(1);
                String first_Name = results.getString(2);
                String last_Name = results.getString(3);
                Date date = results.getDate(4);
                String mail = results.getString(5);
                String userName = results.getString(6);
                String password = results.getString(7);
                String contactNum = results.getString(8);
                String addres = results.getString(9);
                Timestamp stamp = results.getTimestamp(10);
                String stat = results.getString(11);
                
                Client client = new Client(custId,first_Name,last_Name,date,mail,
                        userName,password,contactNum,addres,stamp,stat);
                
                list.add(client);
            }
        } catch (SQLException ex) {
            Logger.getLogger(Client.class.getName()).log(Level.SEVERE, null, ex);
        }
        System.out.println("\nThe size " + list.size());
        return list;
    }
    
    
    
    
    
}
