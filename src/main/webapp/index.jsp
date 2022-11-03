<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.d_blog.dao.DaoPost"%>
<%@page import="com.d_blog.entidades.Post"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.d_blog.enums.Perfil"%>
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

    <title>D Blog - Home</title>
</head>
<body class="vh-100 container-fluid p-0 overflow-auto bg-success bg-gradient">
    <jsp:include page='header.jsp'/>

    <%
        String campo_busca = request.getParameter("campo_busca");
        Integer quantidade = null;
        if(campo_busca != null){
            quantidade = null;
        }
        List<Post> posts = DaoPost.getPosts(quantidade, campo_busca);
    %>
    <div class='container-fluid mt-3'>
        <div class='container d-flex justify-content-between align-items-center p-0 mb-2'>
            <form class="d-flex">
                <input type="text" class="form-control me-2" placeholder="Título" name="campo_busca" required>
                <button type="buttom" class="btn btn-warning">Buscar</button>
            </form>
            <span class="text-white font-thicker"><%out.write((campo_busca != null) ? posts.size()+" resultado(s) encontrado(s)" : "");%></span>

        <%
            if(session.getAttribute("perfil") != null && session.getAttribute("perfil").equals(Perfil.MOD.name())){
                out.write("    <a type='button' class='btn btn-warning' href='cadastrar_post.jsp'>Novo Post</a>");
            }
        %>

        </div>

        <%
        
        for(Post p: posts){ %>
            <div class='container p-0 bg-light mb-5 border border-5 rounded-2'>
                <div class='d-flex align-items-center justify-content-between m-0 bg-color-main text-white ps-3 pe-3'>
                    <h3><%out.write(p.getTitulo());%></h3>
                    <span><%out.write(p.getUsuario().getNome()+", "+p.getTimestamp());%></span>
                </div>
                <div class='pt-3 pb-3 ps-5 pe-5'>
                    <p class='m-0'><%out.write(p.getIntroTexto());%></p>
                </div>
                 <div class='container d-flex justify-content-end'>
                     <a class='text-color-main me-2' href=<%out.write("'post.jsp?id_post="+p.getId()+"'");%>>Continuar Lendo>></a>
            <%if(session.getAttribute("perfil") != null && session.getAttribute("perfil").equals(Perfil.MOD.name())){%>
                         <a class='text-color-main me-2' href=<%out.write("'editar_post.jsp?id_post="+p.getId()+"'");%>>Editar</a>
                         <a onclick="return confirm('Confirmar exclusão do post?')" class='text-color-main me-2' href=<%out.write("'excluir_post.jsp?id_post="+p.getId()+"'");%>>Excluir</a>
            <%}%>
                 </div>
            </div>
        <%}%>

    </div>

    <div class='container-fluid h-50'>
    </div>

</body>
</html>