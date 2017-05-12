/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Beans;

import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author Vash
 */
public class ServiceFeedback implements Convertable {
    private int spId;
    private int serviceid;
    private float rating;

    public ServiceFeedback() {
    }

    public ServiceFeedback(int spId, int serviceid, float rating) {
        this.spId = spId;
        this.serviceid = serviceid;
        this.rating = rating;
    }

    public void setSpId(int spId) {
        this.spId = spId;
    }

    public void setServiceid(int serviceid) {
        this.serviceid = serviceid;
    }

    public void setRating(float rating) {
        this.rating = rating;
    }

    public int getSpId() {
        return spId;
    }

    public int getServiceid() {
        return serviceid;
    }

    public float getRating() {
        return rating;
    }

    @Override
    public String toString() {
        return "ServiceFeedback{" + "spId=" + spId + ", serviceid=" + 
                serviceid + ", rating=" + rating + '}';
    }

    @Override
    public ArrayList<ServiceFeedback> toArrayList(ResultSet results) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    
    
}
