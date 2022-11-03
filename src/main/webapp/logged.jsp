<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<div class="d-flex justify-content-end align-items-center">
    <span class="pe-2"><%out.write(""+session.getAttribute("login"));%></span>
    <div class="ms-2 vr me-2"></div>
    <form action="logged.jsp" method="POST">
        <button type="submit" class="btn btn-warning btn-sm">Sair</button>
    </form>
</div>

<%
    if(request.getMethod() == "POST" && request.getRequestURI().equals("/logged.jsp")){
        session.invalidate();
        response.sendRedirect("index.jsp");
    }
%>

</html>