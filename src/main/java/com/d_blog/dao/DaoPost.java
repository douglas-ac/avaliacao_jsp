package com.d_blog.dao;

import com.d_blog.entidades.Post;
import com.d_blog.entidades.Usuario;
import com.d_blog.enums.Perfil;
import com.d_blog.utils.Conexao;
import org.json.simple.JSONObject;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DaoPost {
    private final static Connection con = Conexao.conectar();

    public static List<Post> getPosts(Integer quantidade, String titulo){
        List<Post> posts = new ArrayList<Post>();
        if(quantidade == null){
            quantidade = 1000;
        }
        if(titulo == null){
            titulo = "%";
        } else {
            titulo = "%"+titulo+"%";
        }
        String sql = "select * from post where titulo like ? order by timestamp desc limit ?";
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, titulo);
            stm.setInt(2, quantidade);

            ResultSet rs = stm.executeQuery();
            while(rs.next()){
                Usuario usuario = DaoUsuario.consultarPorId(rs.getInt("idusuario"));
                Post p = new Post(rs.getInt("idpost"),
                        rs.getString("titulo"),
                        rs.getString("texto"),
                        usuario,
                        rs.getDate("timestamp"));
                posts.add(p);
            }
            return posts;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public static Post consultarPorTitulo(String titulo){
        String sql = "select * from post where titulo = ?";
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, titulo);
            return consultar(stm);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public static Post consultarPorId(int id){
        String sql = "select * from post where idpost = ?";
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, id);
            return consultar(stm);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public static Post consultar(PreparedStatement stm){
        Post post = null;
        try {
            ResultSet rs = stm.executeQuery();
            while(rs.next()){
                Usuario usuario = DaoUsuario.consultarPorId(rs.getInt("idusuario"));
                Post p = new Post(rs.getInt("idpost"),
                        rs.getString("titulo"),
                        rs.getString("texto"),
                        usuario,
                        rs.getDate("timestamp"));
                post = p;
            }
        } catch (SQLException e) {
            return post;
        }
        return post;
    }

    public static JSONObject cadastrar(Post post){
        JSONObject rst = new JSONObject();
        rst.put("rst", false);
        if(con != null){
            if(consultarPorTitulo(post.getTitulo()) == null){
                String sql = "insert into post(titulo, texto, idusuario) values(?, ?, ?)";
                try {
                    PreparedStatement stm = con.prepareStatement(sql);
                    stm.setString(1, post.getTitulo());
                    stm.setString(2, post.getTexto());
                    stm.setInt(3, post.getUsuario().getId());

                    stm.execute();
                    rst.put("rst", true);
                } catch (SQLException e) {
                    rst.put("msg", "Erro: " + e.getMessage());
                }
            } else{
                rst.put("msg", "Título já cadastrado");
            }
        } else{
            rst.put("msg", "Falha na conexão com o Banco de Dados");
        }
        return rst;
    }

    public static JSONObject alterar(Post post){
        JSONObject rst = new JSONObject();
        rst.put("rst", false);
        if(con != null){
            Post tmp = consultarPorTitulo(post.getTitulo());
            if(tmp == null || tmp.getId()==post.getId()){
                String sql = "update post set titulo=?, texto=?, idusuario=?, timestamp=now() where idpost = ?";
                try {
                    PreparedStatement stm = con.prepareStatement(sql);
                    stm.setString(1, post.getTitulo());
                    stm.setString(2, post.getTexto());
                    stm.setInt(3, post.getUsuario().getId());
                    stm.setInt(4, post.getId());

                    stm.execute();
                    rst.put("rst", true);
                } catch (SQLException e) {
                    rst.put("msg", "Erro: " + e.getMessage());
                }
            } else{
                rst.put("msg", "Título já cadastrado");
            }
        } else{
            rst.put("msg", "Falha na conexão com o Banco de Dados");
        }
        return rst;
    }


    public static JSONObject excluir(int id){
        JSONObject rst = new JSONObject();
        rst.put("rst", false);
        if(con != null){
            String sql = "delete from post where idpost = ?";
            try {
                PreparedStatement stm = con.prepareStatement(sql);
                stm.setInt(1, id);
                stm.execute();
            } catch (SQLException e) {
                rst.put("msg", "Erro: " + e.getMessage());
            }
            rst.put("rst", true);
        } else{
            rst.put("msg", "Falha na conexão com o Banco de Dados");
        }
        return rst;
    }
}
