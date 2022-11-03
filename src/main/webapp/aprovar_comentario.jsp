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
    int id_comentario = Integer.parseInt(request.getParameter("id_comentario"));
    int id_post = Integer.parseInt(request.getParameter("id_post"));
    String perfil = (String) session.getAttribute("perfil");
    if(perfil != null && perfil.equals(Perfil.MOD.name())){
        DaoComentario.aprovar(id_comentario);
    }
    response.sendRedirect("post.jsp?id_post="+id_post);
    
   


%>
</body>
</html>