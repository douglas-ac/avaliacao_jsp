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

    <title>D Blog - Novo Post</title>
</head>
<body class="vh-100 container-fluid p-0 overflow-auto bg-success bg-gradient">
    <%
        if(session.getAttribute("perfil") == null || !session.getAttribute("perfil").equals(Perfil.MOD.name())){
            response.sendRedirect("index.jsp");
        } 
        
        
    %>
    <jsp:include page='header.jsp'/>

    <div class='container-fluid mt-3'>
        <form id="post_form" class='container p-0 bg-light mb-5 border border-5 position-relative' action="cadastrar_post.jsp" Method="POST">
            <label class="form-label" for="titulo">Título</label>
            <input required class="form-control mb-3" type="text" name="titulo" id="titulo">
            <label class="form-label" for="texto">Texto</label>
            <textarea required class="form-control mb-3" name="texto" id="texto" rows="10"></textarea>
            <div class="d-flex justify-content-end mb-3">
                <button type="submit" class="btn btn-warning me-3">Salvar</button>
                <a href="index.jsp" type="button" class="btn btn-warning">Cancelar</a>
            </div>
        </form>
    </div>
</body>

<%
    if(request.getMethod() == "POST"){
         String titulo = request.getParameter("titulo");
         String texto = request.getParameter("texto");
         int id = (Integer) session.getAttribute("id_usuario");
         
         Usuario autor = new Usuario(id);
         Post novo = new Post(titulo, texto, autor);
         JSONObject rJson = DaoPost.cadastrar(novo);

         if((Boolean)rJson.get("rst")){
            response.sendRedirect("index.jsp");
        } else{
            out.write((String)rJson.get("msg"));
        }
        
    }

%>
</html>