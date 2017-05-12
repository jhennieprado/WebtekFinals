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
public interface Convertable {
    
    public ArrayList<? extends Object> toArrayList(ResultSet results);
}
