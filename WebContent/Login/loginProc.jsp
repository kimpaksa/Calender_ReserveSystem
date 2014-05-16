<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
    <%
    	/*한글 형태로 값을 넘길때 깨진다. 그걸 방지해주기 위해 request.setCharacterEncoding() 함수를 사용하면 해소가 된다.*/
    	request.setCharacterEncoding("euc-kr");
    	/* textbox에 입력한 정보를 취득하는 방법은 getParameter()함수를 사용하면 된다. */
    	String id = (String)request.getParameter("id");
    	String pass = (String)request.getParameter("pass");
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%=id %>
<%=pass %>
</body>
</html>