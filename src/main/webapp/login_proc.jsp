<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ page errorPage = "error.jsp" %>
<%@ page import = "user.UserDO" %>
<%@ page import = "user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	
	UserDO userDO = new UserDO();
	userDO.setId(id);
	userDO.setPassword(password);
	
	UserDAO userDAO = new UserDAO();
	UserDO user = userDAO.getUser(userDO);
	
	if(user != null){
		session.setAttribute("IdKey", id);
		response.sendRedirect("getBoardList.jsp");
		//out.println("<script>alert('로그인 성공')</script>");
	}else{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인 실패.')");
		script.println("history.back()");
		script.println("</script>");
	}
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>