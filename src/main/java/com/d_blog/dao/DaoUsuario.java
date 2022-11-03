package com.d_blog.dao;

import com.d_blog.entidades.Usuario;
import com.d_blog.enums.Perfil;
import com.d_blog.utils.Conexao;
import org.json.simple.JSONObject;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DaoUsuario {
    private final static Connection con = Conexao.conectar();

    public static JSONObject logar(String login, String senha){
        JSONObject rst = new JSONObject();
        rst.put("rst", false);
        Usuario usuario = consultarPorLogin(login);

        if(usuario == null){
            rst.put("msg", "Login inexistente");
            return rst;
        }

        if(usuario.getSenha().equals(senha)){
            rst.put("rst", true);
            rst.put("usuario", usuario);
        } else{
            rst.put("msg", "Senha incorreta");
        }
        return rst;
    }
    public static Usuario consultarPorLogin(String login){
        String sql = "select * from usuario where login = ?";
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, login);
            return consultar(stm);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public static Usuario consultarPorId(int id){
        String sql = "select * from usuario where idusuario = ?";
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, id);
            return consultar(stm);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public static Usuario consultar(PreparedStatement stm){
        Usuario usuario = null;
        try {
            ResultSet rs = stm.executeQuery();
            while(rs.next()){
                Usuario u = new Usuario(rs.getInt("idusuario"),
                        rs.getString("nome"),
                        rs.getString("login"),
                        rs.getString("senha"),
                        Perfil.valueOf(rs.getString("perfil")));
                usuario = u;
            }
        } catch (SQLException e) {
            return usuario;
        }
        return usuario;
    }

    public static JSONObject cadastrar(Usuario usuario){
        JSONObject rst = new JSONObject();
        rst.put("rst", false);
        if(con != null){
            if(consultarPorLogin(usuario.getLogin()) == null){
                String sql = "insert into usuario(nome, login, senha) values(?, ?, ?)";
                try {
                    PreparedStatement stm = con.prepareStatement(sql);
                    stm.setString(1, usuario.getNome());
                    stm.setString(2, usuario.getLogin());
                    stm.setString(3, usuario.getSenha());

                    stm.execute();
                    Usuario novo = consultarPorLogin(usuario.getLogin());
                    rst.put("rst", true);
                    rst.put("usuario", novo);
                } catch (SQLException e) {
                    rst.put("msg", "Erro: " + e.getMessage());
                }
            } else{
                rst.put("msg", "Login já cadastrado");
            }
        } else{
            rst.put("msg", "Falha na conexão com o Banco de Dados");
        }
        return rst;
    }
}
