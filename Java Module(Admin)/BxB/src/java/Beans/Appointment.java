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
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
public class Appointment implements Convertable {
    private int appointmentno;
    private int spSchedId;
    private Timestamp datereq;
    private int clientno;
    private int serviceId;
    private String status;
    private int spId;
    private int rating;
    private float amount;
    

    public Appointment() {
   
    }

    public Appointment(int appointmentno, int spSchedId, Timestamp datereq, int clientno, int serviceId, String status, int spId, int rating, float amount) {
        this.appointmentno = appointmentno;
        this.spSchedId = spSchedId;
        this.datereq = datereq;
        this.clientno = clientno;
        this.serviceId = serviceId;
        this.status = status;
        this.spId = spId;
        this.rating = rating;
        this.amount = amount;
    }

    public Appointment(int spSchedId, Timestamp datereq, int clientno,int serviceId, String status, int spId, int rating, float amount) {
        this.spSchedId = spSchedId;
        this.datereq = datereq;
        this.clientno = clientno;
        this.serviceId = serviceId;
        this.status = status;
        this.spId = spId;
        this.rating = rating;
        this.amount = amount;
    }

    public void setSpId(int spId) {
        this.spId = spId;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public void setAmount(float amount) {
        this.amount = amount;
    }

    
    
    public void setServiceId(int serviceId) {
        this.serviceId = serviceId;
    }
    
    
    
    public void setSpSchedId(int spSchedId) {
        this.spSchedId = spSchedId;
    }

    public void setDatereq(Timestamp datereq) {
        this.datereq = datereq;
    }

    public void setClientno(int clientno) {
        this.clientno = clientno;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getAppointmentno() {
        return appointmentno;
    }

    public int getSpSchedId() {
        return spSchedId;
    }

    public Timestamp getDatereq() {
        return datereq;
    }

    public int getClientno() {
        return clientno;
    }

    public String getStatus() {
        return status;
    }

    public int getServiceId() {
        return serviceId;
    }

    public int getSpId() {
        return spId;
    }

    public int getRating() {
        return rating;
    }

    public float getAmount() {
        return amount;
    }
    
    
    

    @Override
    public String toString() {
        return "Appointment{" + "appointmentno=" + appointmentno + ", spSchedId=" + spSchedId + ", datereq=" + datereq + ", clientno=" + clientno + ", status=" + status + '}';
    }

    
 

    @Override
    public ArrayList<Appointment> toArrayList(ResultSet results){
        ArrayList<Appointment> list = new ArrayList<> ();
        try {           
            while(results.next()){
                int appointmentNo = results.getInt(1);
                int schedId = results.getInt(2);
                Timestamp dateReq = results.getTimestamp(3);
                int clientNo = results.getInt(4);
                int servId = results.getInt(5);
                String stat = results.getString(6);
                int rate = results.getInt(7);
                int spID = results.getInt(8);
                float price = results.getFloat(9);
                Appointment appointment = new Appointment(appointmentNo,schedId,dateReq,clientNo
                    ,servId,stat,rate,spID,price);
                
                list.add(appointment);               
            }
           
        } catch (SQLException ex) {
            Logger.getLogger(Appointment.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    
    
    
    
}
