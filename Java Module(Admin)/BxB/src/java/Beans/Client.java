/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Beans;
import java.sql.Date;
import java.sql.Timestamp;
/**
 *
 * @author Administrator
 */
public class Client {
    private int clientNo;
    private String firstName;
    private String lastName;
    private Date birthDate;
    private String email;
    private String usrName;
    private String passWord;
    private String contactno;
    private Timestamp accountCreated;

    public Client() {
        
    }
    
    
    public Client(int clientNo, String firstName, String lastName, Date birthDate, String email, String usrName, String passWord, String contactno, Timestamp accountCreated) {
        this.clientNo = clientNo;
        this.firstName = firstName;
        this.lastName = lastName;
        this.birthDate = birthDate;
        this.email = email;
        this.usrName = usrName;
        this.passWord = passWord;
        this.contactno = contactno;
        this.accountCreated = accountCreated;
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
        this.usrName = usrName;
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

    public String getUsrName() {
        return usrName;
    }

    public String getPassWord() {
        return passWord;
    }

    public String getContactno() {
        return contactno;
    }

    public Timestamp getAccountCreated() {
        return accountCreated;
    }

    @Override
    public String toString() {
        return "Client{" + "clientNo=" + clientNo + ", firstName=" +
                firstName + ", lastName=" + lastName + ", birthDate=" + 
                birthDate + ", email=" + email + ", usrName=" + usrName + ","
                + "passWord=" + passWord + ", contactno=" + contactno + ", "
                + "accountCreated=" + accountCreated + '}';
    }
    
    
    
    
    
}
