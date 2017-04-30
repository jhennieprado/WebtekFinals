/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Beans;

/**
 *
 * @author Vash
 */
public class ServiceProvider {
    private final int spId;
    private final String firstName;
    private final String lastName;
    private final String email;
    private final int contactNo;
    private final float totalRating;
    private final String userName;
    private final String password;
    private final String status;
    private final Object profpic;
    
    public ServiceProvider(){
        this.spId = 1;
        this.firstName = "awef";
        this.lastName = "awef";
        this.email = "awef";
        this.contactNo = 123;
        this.totalRating = (float) 5.0123;
        this.userName ="awef";
        this.password ="awef";
        this.status = "awef";
        this.profpic = null;
    }

    public ServiceProvider(int spId, String firstName, String lastName, String email, int contactNo, float totalRating, String userName, String password, String status) {
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
    
    
    public ServiceProvider(int spId, String firstName, String lastName, String email, int contactNo, float totalRating, String userName, String password, String status, Object profpic) {
        this.spId = spId;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.contactNo = contactNo;
        this.totalRating = totalRating;
        this.userName = userName;
        this.password = password;
        this.status = status;
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

    public int getContactNo() {
        return contactNo;
    }

    public float getTotalRating() {
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

    
    
           
}
