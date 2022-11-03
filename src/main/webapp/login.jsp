<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.d_blog.dao.DaoUsuario"%>
<%@page import="com.d_blog.entidades.Usuario"%>
<%@page import="org.json.simple.*"%>
<!DOCTYPE html>
<div class="d-flex justify-content-end align-items-center">
    <form class="d-flex justify-content-end align-items-center" action='login.jsp' method='POST'>
        <div class='d-flex justify-content-between me-3'>
            <label class="d-flex align-items-center me-1" for='login'>Login</label>
            <input type='text' class='form-control-sm' id='login' name='login'  required>
        </div>
        <div class='d-flex justify-content-between me-3'>
            <label class="d-flex align-items-center me-1" for='senha'>Senha</label>
            <input type='password' class='form-control-sm' id='senha' name='senha'  required>
        </div>
        <button type="submit" class="btn btn-sm btn-warning">Entrar</button>
    </form>

    <div class="ms-2 vr me-2"></div>

    <a class="btn btn-warning btn-sm" href="cadastro_usuario.jsp">Cadatrar</a>
</div>


<%
    if(request.getMethod() == "POST"){
        String login = request.getParameter("login");
        String senha = request.getParameter("senha");

        JSONObject rJson = DaoUsuario.logar(login, senha);
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