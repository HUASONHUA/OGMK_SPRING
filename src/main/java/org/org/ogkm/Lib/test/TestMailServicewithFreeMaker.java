package org.org.ogkm.Lib.test;

import org.org.ogkm.Lib.service.MailService;

import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Administrator
 */
public class TestMailServicewithFreeMaker {

    public static void main(String[] args) {
        try {
            Map<String, Object> map = new HashMap<>();
            map.put("title", "OGKMMUSIC");
            String ipAddress = java.net.InetAddress.getLocalHost().getHostAddress();
            map.put("host", ipAddress);
            String rtn = MailService.processTemplateWithMap("welcome.ftl", map);
            System.out.println("rtn = \n" + rtn);
        } catch (Exception ex) {
            Logger.getLogger(TestMailServicewithFreeMaker.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
