package com.d_blog.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexao {
    public static Connection conectar(){
        Connection con = null;
        String url = "jdbc:mysql://localhost/d_blog";
        String user = "root";
        String password = "0000";

        try{
//            Class.forName("org.mysql.Driver");
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e){
            throw new RuntimeException();
        }

        try{
            con = DriverManager.getConnection(url, user, password);
        } catch (SQLException e){
            throw new RuntimeException();
        }
        return con;
    }
}
