<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.d_blog.dao.DaoPost"%>
<%@page import="com.d_blog.dao.DaoComentario"%>
<%@page import="com.d_blog.entidades.Post"%>
<%@page import="com.d_blog.entidades.Comentario"%>
<%@page import="com.d_blog.enums.Perfil"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
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

    <title>D Blog - Post</title>
</head>
<body class="vh-100 container-fluid p-0 overflow-auto bg-success bg-gradient">
    <jsp:include page='header.jsp'/>

    <div class='container-fluid mt-3'>
        <%
        int id_post = Integer.parseInt(request.getParameter("id_post"));
        String perfil = (String) session.getAttribute("perfil");
        Post post = DaoPost.consultarPorId(id_post);
        %>
        <div class='container p-0 bg-light mb-5 border border-5 position-relative'>
            <div class='d-flex align-items-center justify-content-between m-0 bg-color-main text-white ps-3 pe-3'>
                <h3><%out.write(post.getTitulo());%></h3>
                <span><%out.write(post.getUsuario().getNome()+", "+post.getTimestamp());%></span>
            </div>
            <div class='pt-3 pb-3 ps-5 pe-5'>
                <p class='m-0'><%out.write(post.getTexto());%></p>
            </div>
            <a class='position-absolute bottom-0 end-0 text-color-main me-2' href='index.jsp'>Voltar</a>
        </div>
    </div>

    <div class='container-fluid mt-3'>
        <div class='container p-0 bg-light mb-5 border border-5'>
            <div class='d-flex align-items-center justify-content-between mb-3 bg-color-main text-white ps-3 pe-3'>
                <h4>Comentários</h4>
                <span>99+</span>
            </div>
            <div class="ps-3 pe-3 pt-2 pb-2">
                <%if(perfil != null){%>
                <form class="mb-3" action=<%out.write("'cadastrar_comentario.jsp?id_post="+id_post+"'");%> method="POST">
                    <textarea class="form-control mb-3" name="texto" id="texto" rows="3"></textarea>
                    <div class="d-flex justify-content-end">
                        <button type="submit" class="btn btn-warning">Enviar</button>
                    </div>
                </form>
                <%}%>
                <%
                    List<Comentario> comentarios = DaoComentario.getComentarios(id_post, perfil == null ? null : Perfil.valueOf(perfil));
                    for(Comentario c: comentarios){
                %>
                <!-- <div class='d-flex align-items-center justify-content-start mb-3 bg-color-main text-white ps-3 pe-3 ms-5 me-5'> -->
                <div class='row mb-3 bg-color-main text-white ps-3 pe-3 ms-5 me-5'>
                    <div class="col-2 d-flex flex-column align-items-center">
                        <h6><%out.write(c.getUsuario().getLogin());%></h6>
                        <span><%out.write(""+c.getTimestamp());%></span>
                    </div>
                    <div class='col-10 pt-3 pb-3 ps-5 pe-5'>
                        <p class='m-0'><%out.write(c.getTexto());%></p>
                    </div>
                </div>
                <%}%>
            </div>
        </div>
    </div>

    <div class='container-fluid h-50'>
    </div>


</body>
</html>