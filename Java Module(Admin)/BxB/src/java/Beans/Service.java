/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Beans;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Vash
 */

public class Service implements Convertable {
    private int serviceId;
    private String serviceName;
    private float serviceAmount;
    private String description;
    private String category;

    public Service() {
        
    }

    
    
    
    public Service(int serviceId, String serviceName, float serviceAmount, String description, String category) {
        this.serviceId = serviceId;
        this.serviceName = serviceName;
        this.serviceAmount = serviceAmount;
        this.description = description;
        this.category = category;
    }

    public Service(String serviceName, float serviceAmount, String description, String category){
        this.serviceId = 0;
        this.serviceName = serviceName;
        this.serviceAmount = serviceAmount;
        this.description = description;
        this.category = category;
    }
    public int getServiceId() {
        return serviceId;
    }

    public String getServiceName() {
        return serviceName;
    }

    public float getServiceAmount() {
        return serviceAmount;
    }

    public String getDescription() {
        return description;
    }

    public String getCategory() {
        return category;
    }

    @Override
    public String toString() {
        return "Services{" + "serviceId=" + serviceId + ", serviceName=" + 
                serviceName + ", serviceAmount=" + serviceAmount + ", description=" 
                + description + ", category=" + category + '}';
    }

    @Override
    public ArrayList<Service> toArrayList(ResultSet results) {
        ArrayList<Service> list = new ArrayList<> ();
        
        try {
            while(results.next()){
                int servId = results.getInt(1);
                String servName = results.getString(2);
                float fee = results.getFloat(3);
                String desc = results.getString(4);
                String cat =  results.getString(5);
                
                Service service = new Service(servId,servName,fee,desc,cat);
                
                list.add(service);
                
            }
        } catch (SQLException ex) {
            Logger.getLogger(Service.class.getName()).log(Level.SEVERE, null, ex);
            ex.printStackTrace(); //remember to remove these stack traces.
        }
        
        return list;
    }
    
    
    
    
}
