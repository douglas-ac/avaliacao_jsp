<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.d_blog.dao.DaoUsuario"%>
<%@page import="com.d_blog.entidades.Usuario"%>
<%@page import="org.json.simple.*"%>

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


    <title>D Blog - Criar conta</title>
</head>

<body class="container-fluid d-flex justify-content-center align-items-center vh-100 vw-100">

    <%
        if(session.getAttribute("login") != null){
            response.sendRedirect("login.jsp");
        }
    %>

    <form class="container-fluid d-flex flex-column justify-content-center w-50 h-75 bg-success" action="cadastro_usuario.jsp" method="POST">
            <div class="text-center d-flex justify-content-center"><h1 class="display-5 text-white">D Blog</h1></div>
            <div class="form-floating mb-3">
                <input type="text" class="form-control" id="nome" name="nome" placeholder="nome" required>
                <label for="nome">Nome</label>
            </div>
            <div class="form-floating mb-3">
                <input type="text" class="form-control" id="login" name="login" placeholder="name@example.com" required>
                <label for="login">Login</label>
            </div>
            <div class="form-floating mb-3">
                <input type="password" class="form-control" id="senha" name="senha" placeholder="Senha" required>
                <label for="senha">Senha</label>
            </div>
            <div class="d-inline-flex justify-content-end">
                <button type="submit" class="btn btn-warning btn-lg me-3">Criar Conta</button>
                <a href="index.jsp" type="button" class="btn btn-warning btn-lg">Cancelar</a>
            </div>
    </form>
</body>
<%
    if(request.getMethod() == "POST"){
        String nome = request.getParameter("nome");
        String login = request.getParameter("login");
        String senha = request.getParameter("senha");

        Usuario u = new Usuario(nome, login, senha);

        JSONObject rJson = DaoUsuario.cadastrar(u);

        if((Boolean)rJson.get("rst")){
            Usuario usuario = (Usuario) rJson.get("usuario");
            session.setAttribute("id_usuario", usuario.getId());
            session.setAttribute("login", usuario.getLogin());
            session.setAttribute("perfil", usuario.getPerfil().name());
        } else{
            out.write((String)rJson.get("msg"));
        }
        response.sendRedirect("index.jsp");

    }
%>

</html>