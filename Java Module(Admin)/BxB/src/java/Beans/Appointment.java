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
public class Appointment {
    private int appointmentno;
    private double amount;
    private Date datereq;
    private Date dateOfService;
    private Date dateFinished;
    private String status;
    private int clientno;
    private int spId;
    private int serviceid;

    public Appointment() {
   
    }

    
    public Appointment(int appointmentno, double amount, Date datereq, Date dateOfService, Date dateFinished, String status, int clientno, int spId, int serviceid) {
        this.appointmentno = appointmentno;
        this.amount = amount;
        this.datereq = datereq;
        this.dateOfService = dateOfService;
        this.dateFinished = dateFinished;
        this.status = status;
        this.clientno = clientno;
        this.spId = spId;
        this.serviceid = serviceid;
    }

    public void setAppointmentno(int appointmentno) {
        this.appointmentno = appointmentno;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public void setDatereq(Date datereq) {
        this.datereq = datereq;
    }

    public void setDateOfService(Date dateOfService) {
        this.dateOfService = dateOfService;
    }

    public void setDateFinished(Date dateFinished) {
        this.dateFinished = dateFinished;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public void setClientno(int clientno) {
        this.clientno = clientno;
    }

    public void setSpId(int spId) {
        this.spId = spId;
    }

    public void setServiceid(int serviceid) {
        this.serviceid = serviceid;
    }
    
    

    public int getAppointmentno() {
        return appointmentno;
    }

    public double getAmount() {
        return amount;
    }

    public Date getDatereq() {
        return datereq;
    }

    public Date getDateOfService() {
        return dateOfService;
    }

    public Date getDateFinished() {
        return dateFinished;
    }

    public String getStatus() {
        return status;
    }

    public int getClientno() {
        return clientno;
    }

    public int getSpId() {
        return spId;
    }

    public int getServiceid() {
        return serviceid;
    }

    @Override
    public String toString() {
        return "Appointment{" + "appointmentno=" + appointmentno + ", "
                + "amount=" + amount + ", datereq=" + datereq + ", "
                + "dateOfService=" + dateOfService + ", dateFinished=" + 
                dateFinished + ", status=" + status + ", clientno=" + clientno 
                + ", spId=" + spId + ", serviceid=" + serviceid + '}';
    }
    
    
    
    
    
}
