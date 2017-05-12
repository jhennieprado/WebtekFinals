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
public class Messages implements Convertable {
    private final String messageId;
    private final int receiver;
    private final int sender;
    private final String mdesc;

    public Messages(String messageId, int receiver, int sender, String mdesc) {
        this.messageId = messageId;
        this.receiver = receiver;
        this.sender = sender;
        this.mdesc = mdesc;
    }

    public String getMessageId() {
        return messageId;
    }

    public int getReceiver() {
        return receiver;
    }

    public int getSender() {
        return sender;
    }

    public String getMdesc() {
        return mdesc;
    }

    @Override
    public String toString() {
        return "Messages{" + "messageId=" + messageId + ", receiver=" +
                receiver + ", sender=" + sender + ", mdesc=" + mdesc + '}';
    }

    @Override
    public ArrayList<Messages> toArrayList(ResultSet results) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    
    
    
}