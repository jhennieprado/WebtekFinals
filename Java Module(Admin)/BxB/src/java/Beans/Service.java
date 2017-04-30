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

public class Service {
    private int serviceId;
    private String serviceName;
    private float serviceAmount;
    private String description;
    private String category;

    public Service(int serviceId, String serviceName, float serviceAmount, String description, String category) {
        this.serviceId = serviceId;
        this.serviceName = serviceName;
        this.serviceAmount = serviceAmount;
        this.description = description;
        this.category = category;
    }

    public void setServiceId(int serviceId) {
        this.serviceId = serviceId;
    }

    public void setServiceName(String serviceName) {
        this.serviceName = serviceName;
    }

    public void setServiceAmount(float serviceAmount) {
        this.serviceAmount = serviceAmount;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setCategory(String category) {
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
    
    
    
    
}
