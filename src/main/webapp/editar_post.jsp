<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.d_blog.dao.DaoPost"%>
<%@page import="com.d_blog.entidades.Post"%>
<%@page import="com.d_blog.entidades.Usuario"%>
<%@page import="com.d_blog.enums.Perfil"%>
<%@page import="org.json.simple.*"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- CSS only -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
    <link rel="stylesheet" href="./styles/styles.css" type="text/css">

    <title>D Blog - Editar Post</title>
</head>
<body class="vh-100 container-fluid p-0 overflow-auto bg-success bg-gradient">
    <%
        if(session.getAttribute("perfil") == null || !session.getAttribute("perfil").equals(Perfil.MOD.name())){
            response.sendRedirect("index.jsp");
        }
        Post post = new Post();
        if(request.getMethod() == "GET"){ 
            Integer id_post = Integer.parseInt(request.getParameter("id_post"));
            post = DaoPost.consultarPorId(id_post);
        
        
    %>
    <jsp:include page='header.jsp'/>

    <div class='container-fluid mt-3'>
        <form id="post_form" class='container p-0 bg-light mb-5 border border-5 position-relative' action="editar_post.jsp" Method="POST">
            <label class="form-label" for="id_post">ID do Post</label>
            <input readonly value="<%out.write(""+post.getId());%>" required class="form-control mb-3" type="text" name="id_post" id="id_post">

            <label class="form-label" for="id_usuario">Autor</label>
            <input readonly value="<%out.write(""+post.getUsuario().getLogin());%>" required class="form-control mb-3" type="text" name="id_usuario" id="id_usuario">

            <label class="form-label" for="titulo">Título</label>
            <input value="<%out.write(post.getTitulo());%>" required class="form-control mb-3" type="text" name="titulo" id="titulo">

            <label class="form-label" for="texto">Texto</label>
            <textarea required class="form-control mb-3" name="texto" id="texto" rows="10"><%out.write(""+post.getTexto());%></textarea>

            <div class="d-flex justify-content-end mb-3">
                <button type="submit" class="btn btn-warning me-3">Salvar</button>
                <a href="index.jsp" type="button" class="btn btn-warning">Cancelar</a>
            </div>
        </form>
    </div>
    <% } %>
</body>

<%
    if(request.getMethod() == "POST"){
         String titulo = request.getParameter("titulo");
         String texto = request.getParameter("texto");
         int id_usuario = (Integer) session.getAttribute("id_usuario");
         int id_p = Integer.parseInt(request.getParameter("id_post"));  
         
         Usuario autor = new Usuario(id_usuario);
         post = new Post(id_p, titulo, texto, autor, null);
         JSONObject rJson = DaoPost.alterar(post);

         if((Boolean)rJson.get("rst")){
            response.sendRedirect("index.jsp");
        } else{
            out.write((String)rJson.get("msg"));
        }
        
    }

%>
</html>