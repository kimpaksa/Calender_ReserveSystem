<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.kimpaksa.CalenderDraw.*" %>

<%!
	public class ReserveData {
		int num;
		String year;
		String month;
		String day;
		String beforeHour;
		String beforeMin;
		String afterHour;
		String afterMin;
		String name;

		public ReserveData(int num, String year, String month, String day, String beforeHour,
				String beforeMin, String afterHour, String afterMin, String name) {
			this.num = num;
			this.year = year;
			this.month = month;
			this.day = day;
			this.beforeHour = beforeHour;
			this.beforeMin = beforeMin;
			this.afterHour = afterHour;
			this.afterMin = afterMin;
			this.name = name;
		}
	}
%>

<%
	
	GregorianCalendar gc = new GregorianCalendar();
		
	CalenderExam AA = new CalenderExam(
		gc.get(Calendar.YEAR),			//Year
		(gc.get(Calendar.MONTH)+1),		//Month
		gc.get(Calendar.DATE)+1);		//Day
	
	
	ArrayList<ReserveData> arr = new ArrayList();
	
	// DB���� ���� Ŭ����	
	Connection conn = null;

	//���� �� ������ ���� ��ų Ŭ����	
	PreparedStatement pstmt = null;
	
	//���ǹ��� ���� ������� �ִ� Ŭ����
	ResultSet rs = null;
	
	try{
		//MySQL�� �ҷ��´�.
		Class.forName("com.mysql.jdbc.Driver");
		
		//DB���ؼ� ������ ���ڷ� �ѱ�� Ŀ�ؼ��� ��´�.
		conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/reserve_sys", "kimpaksa", "rla123");
		
		//Ŀ�ؼ� ��ü�� ���� �� �������� DB�� ��û
		pstmt = conn.prepareStatement("SELECT * FROM reserve_sys.reser_table");
		
		//��û ���ǹ� ���� �� ������� ��´�.
		rs = pstmt.executeQuery();
	
		while (rs.next()) {
			arr.add(new ReserveData(rs.getInt(1), rs.getString(2), 
					rs.getString(3), rs.getString(4), rs.getString(5), 
					rs.getString(6), rs.getString(7), rs.getString(8), rs.getString(9)  ));
		}
		
	} catch (Exception e) {
		e.printStackTrace();
		System.out.println(e.toString());
	} finally {
		if (rs != null)
			rs.close();
		if (pstmt != null)
			pstmt.close();
		if (conn != null)
			conn.close();
	}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01
 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>FXKIS SEC 9�� Lab�� ȸ�ǽ� ���� ����Ʈ</title>
<script type="text/javascript">
	function onInsert() {
		location.href="CalSet.jsp?actiontype=new";
	}
</script>
</head>
<body>
	<table border='1' width='980' height='550' cellpadding='0' cellspacing='0'>
		<%
			int oneDay = 0; //
			int f = 1; // 
			int endOfDay;

			//��, �� ����
			out.print(AA.year + "." + AA.month + " Calender" + "\n");

			out.print("<tr width='140' height='50' align='center' >\r\n");
			//���� ����
			for (int idx = 0; idx < AA.arr.size(); idx++) {
				if (idx == 0)	out.print("<td width='140' height='50' bgcolor='#FF9090' >" + AA.arr.get(idx) + "</td>\r\n");
				else if (idx == 6)	out.print("<td width='140' height='50' bgcolor='#7ED2FF' >" + AA.arr.get(idx) + "</td>\r\n");
				else out.print("<td width='140' height='50' >" + AA.arr.get(idx) + "</td>\r\n");
			}
			out.print("</tr>");

			//�ش� ���� 1���� ������������ �����Ѵ�.
			oneDay = AA.getOneDay(AA.month, AA.day, AA.total);
			endOfDay = AA.getDay(AA.month, AA.year);
			
			//�޷� �׸���
			for (int i = 0; i < 6; i++) {
				out.print("<tr width='140' height='100' valign='top' align='center' >\r\n");		
				/* ������ �Ͽ� ���ؼ� �׷��ش�. */
				for (int s = 0; s < 7; s++) {
					
					if (s == 0)			out.print("<td width='140' height='100' bgcolor='#FF9090'>\r\n");
					else if (s == 6)	out.print("<td width='140' height='50' bgcolor='#7ED2FF'>\r\n");
					else 				out.print("<td width='140' height='100'>\r\n");
					out.print("&nbsp;");
					//1���� ������������ ���ϱ�
					if (s == oneDay) {
						//������ 20���̶�� 20�� *ǥ�ø� ���ش�.
						if (f == AA.day - 1) {
							out.print("*");
						}
						out.print(f);
						
						//f������ ���ڿ� DB�� ����Ǿ� �ִ� ���ڰ� ��ġ �Ҷ�
						//DB������ ����Ѵ�.
						for(int cnt=0; cnt<arr.size(); cnt++) {
							if(arr.get(cnt).month.equals(Integer.toString(AA.month))) {
								if(arr.get(cnt).day.equals(Integer.toString(f)))
								{
									out.print("<BR>");
									out.print("<a href='CalView.jsp?num=" + arr.get(cnt).num + "'>");
									out.print(arr.get(cnt).beforeHour + ":" + arr.get(cnt).beforeMin + "~" + 
												arr.get(cnt).afterHour + ":" + arr.get(cnt).afterMin);
									out.print("</a>");
									out.print("<BR>" + arr.get(cnt).name);
									out.print("<BR>");
								}
							}
						}
						
						//�ݺ��۾� ���ϱ� ���� oneDay���� ����
						oneDay = -1;
						f++;
					} else if(f > 1 && f <= endOfDay) {
						//������ 20���̶�� 20�� *ǥ�ø� ���ش�.
						if (f == AA.day - 1) {
							out.print("*");
						}
						
						//���� �׸���.
						out.print(f);
						
						//f������ ���ڿ� DB�� ����Ǿ� �ִ� ���ڰ� ��ġ �Ҷ�
						//DB������ ����Ѵ�.
						for(int cnt=0; cnt<arr.size(); cnt++) {
							if(arr.get(cnt).month.equals(Integer.toString(AA.month))) {
								if(arr.get(cnt).day.equals(Integer.toString(f)))
								{
									out.print("<BR>");
									out.print("<a href='CalView.jsp?num=" + arr.get(cnt).num + "'>");
									out.print(arr.get(cnt).beforeHour + ":" + arr.get(cnt).beforeMin + "~" + 
												arr.get(cnt).afterHour + ":" + arr.get(cnt).afterMin);
									out.print("</a>");
									out.print("<BR>" + arr.get(cnt).name);
								}
							}
						}
						f++;
					}
					out.print("</td>");
					//�߰��߰��� 28 or 29 or 30 or 31 �ľ��Ѵ�. 
				}
				out.print("</tr>");
			}
		%>
	</table>
<input type="button" value="���" onclick="onInsert();" />
</body>
</html>

