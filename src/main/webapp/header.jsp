<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<nav class="text-white bg-success container-fluid d-flex align-items-center row pt-2 pb-2 m-0 sticky-top">
    <div class="col-2"><h1><a href="index.jsp">D Blog</a></h1></div>
    <div class="col-10">
        <%
        if(session.getAttribute("login") == null){
            %><jsp:include page='login.jsp'/><%  
        } else{
            %><jsp:include page='logged.jsp'/><%
        }
        %>
    </div>
</nav>


</html>