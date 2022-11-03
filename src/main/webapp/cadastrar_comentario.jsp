<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.d_blog.dao.DaoComentario"%>
<%@page import="com.d_blog.entidades.Post"%>
<%@page import="com.d_blog.entidades.Usuario"%>
<%@page import="com.d_blog.entidades.Comentario"%>
<%@page import="com.d_blog.enums.Perfil"%>
<%@page import="org.json.simple.*"%>
<%@ page session="true" %>
<!DOCTYPE html>

<body >
<%
    int id_post = Integer.parseInt(request.getParameter("id_post"));
    if(session.getAttribute("perfil") == null){
        response.sendRedirect("post.jsp?id_post="+id_post);
    }

    String texto = request.getParameter("texto");
    int id_usuario = (Integer) session.getAttribute("id_usuario");
    boolean status_aprovacao = session.getAttribute("perfil").equals(Perfil.MOD.name());

    Usuario autor = new Usuario(id_usuario);
    Post post = new Post(id_post);
    Comentario novo = new Comentario(texto, status_aprovacao, post, autor);
    JSONObject rJson = DaoComentario.cadastrar(novo);

    if((Boolean)rJson.get("rst")){
       response.sendRedirect("post.jsp?id_post="+id_post);
   } else{
       out.write((String)rJson.get("msg"));
   }
   


%>
</body>
</html>