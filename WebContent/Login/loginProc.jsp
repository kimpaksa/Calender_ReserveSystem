<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
    <%
    	/*�ѱ� ���·� ���� �ѱ涧 ������. �װ� �������ֱ� ���� request.setCharacterEncoding() �Լ��� ����ϸ� �ؼҰ� �ȴ�.*/
    	request.setCharacterEncoding("euc-kr");
    	/* textbox�� �Է��� ������ ����ϴ� ����� getParameter()�Լ��� ����ϸ� �ȴ�. */
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