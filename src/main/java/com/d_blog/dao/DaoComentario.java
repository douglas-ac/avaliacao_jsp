package com.d_blog.dao;

import com.d_blog.entidades.Comentario;
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

public class DaoComentario {
    private final static Connection con = Conexao.conectar();

    public static List<Comentario> getComentarios(int idpost, Perfil perfil){
        List<Comentario> comentarios = new ArrayList<Comentario>();

        String sql = "select * from comentario where idpost =  ? ";
        if(perfil == null || perfil != Perfil.MOD){
            sql += " and status_aprovacao = 1";
        }
        sql += " order by timestamp asc";
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, idpost);

            ResultSet rs = stm.executeQuery();
            while(rs.next()){
                Comentario c = new Comentario(rs.getInt("idcomentario"),
                        rs.getString("texto"),
                        rs.getBoolean("status_aprovacao"),
                        new Post(rs.getInt("idpost")),
                        DaoUsuario.consultarPorId(rs.getInt("idusuario")),
                        rs.getDate("timestamp"));
                comentarios.add(c);
            }
            return comentarios;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public static JSONObject cadastrar(Comentario comentario){
        JSONObject rst = new JSONObject();
        rst.put("rst", false);
        if(con != null){
            String sql = "insert into comentario(texto, status_aprovacao, idpost, idusuario) values(?, ?, ?, ?)";
            try {
                PreparedStatement stm = con.prepareStatement(sql);
                stm.setString(1, comentario.getTexto());
                stm.setBoolean(2, comentario.isStatus_aprovacao());
                stm.setInt(3, comentario.getPost().getId());
                stm.setInt(4, comentario.getUsuario().getId());

                stm.execute();
                rst.put("rst", true);
            } catch (SQLException e) {
                rst.put("msg", "Erro: " + e.getMessage());
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
            String sql = "delete from comentario where idcomentario = ?";
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

    public static JSONObject aprovar(int id){
        JSONObject rst = new JSONObject();
        rst.put("rst", false);
        if(con != null){
            String sql = "update comentario set status_aprovacao=1 where idcomentario = ?";
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
