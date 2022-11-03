<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.d_blog.dao.DaoPost"%>
<%@page import="com.d_blog.entidades.Post"%>
<%@page import="com.d_blog.entidades.Usuario"%>
<%@page import="com.d_blog.enums.Perfil"%>
<%@page import="org.json.simple.*"%>
<%@ page session="true" %>
<!DOCTYPE html>

<body >
<%
    if(session.getAttribute("perfil") == null || !session.getAttribute("perfil").equals(Perfil.MOD.name())){
        response.sendRedirect("index.jsp");
    } 

    int id_post = Integer.parseInt(request.getParameter("id_post"));
    DaoPost.excluir(id_post);
    response.sendRedirect("index.jsp");

%>
</body>
</html>