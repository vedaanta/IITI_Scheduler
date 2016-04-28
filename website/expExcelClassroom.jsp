<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@page import=" org.apache.poi.hssf.usermodel.*,org.apache.poi.hssf.util.*,org.apache.poi.hssf.util.cell.*"%> 
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<% 
String bat[]=request.getParameterValues("bat");
String time[]=request.getParameterValues("time");
String data[]=request.getParameterValues("data");
String sem[] = request.getParameterValues("sem");
String year[] = request.getParameterValues("year");
String md[] = request.getParameterValues("md");
String cto[] = request.getParameterValues("cto");
int k,datcnt,timcnt;
out.print("Hello!");
try{ 
HSSFWorkbook hwb=new HSSFWorkbook(); 
k=0;
datcnt = 0;
timcnt = 0;
out.print("Hello!");
%>
<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost/mydb" user="root"  password=";"/>


     <sql:query dataSource="${snapshot}" var="result">
		SELECT * from batch
	</sql:query>
	
	<c:forEach var="ovrow" items="${result.rows}">
	<c:out value="Entered!" />
	<c:set var="bid" value="${ovrow.batch_name}" />

<%
String bid = (String)pageContext.getAttribute("bid");
HSSFSheet sheet = hwb.createSheet(bid); 
sheet.setDefaultColumnWidth(10); 
sheet.addMergedRegion(new CellRangeAddress(0,0,0,10));
HSSFCellStyle cs = sheet.getWorkbook().createCellStyle();
HSSFCellStyle csh = sheet.getWorkbook().createCellStyle();
HSSFCellStyle tabs = sheet.getWorkbook().createCellStyle();
cs.setAlignment(HSSFCellStyle.ALIGN_CENTER);
HSSFFont bfont = sheet.getWorkbook().createFont();
bfont.setBold(true);
cs.setFont(bfont);
csh.setFont(bfont);
csh.setWrapText(true);
csh.setBorderBottom(HSSFCellStyle.BORDER_THIN);
csh.setBorderLeft(HSSFCellStyle.BORDER_THIN);
csh.setBorderRight(HSSFCellStyle.BORDER_THIN);
csh.setBorderTop(HSSFCellStyle.BORDER_THIN);
tabs.setBorderBottom(HSSFCellStyle.BORDER_THIN);
tabs.setBorderLeft(HSSFCellStyle.BORDER_THIN);
tabs.setBorderRight(HSSFCellStyle.BORDER_THIN);
tabs.setBorderTop(HSSFCellStyle.BORDER_THIN);
tabs.setWrapText(true);
HSSFRow rowhead1 = sheet.createRow((short)0);
HSSFCell cell = rowhead1.createCell((short) 0);
cell.setCellValue("Indian Institute of Technology");
cell.setCellStyle(cs); 
sheet.addMergedRegion(new CellRangeAddress(1,1,0,10));
HSSFRow rowhead2 = sheet.createRow((short)1);
HSSFCell cell2 = rowhead2.createCell((short) 0);
cell2.setCellValue(year[0]+" "+sem[0]+" Semester: Class Time Table for "+bat[k]);
cell2.setCellStyle(cs); 
HSSFRow rowhead= sheet.createRow((short)3);
rowhead.createCell((short) 0).setCellValue("Day/Time"); 
rowhead.getCell((short) 0).setCellStyle(csh);
k++;
for(int cnt=1;cnt<=10;cnt++){
	rowhead.createCell((short) cnt).setCellValue(time[timcnt+(cnt-1)]);
	rowhead.getCell((short) cnt).setCellStyle(csh);
} 
timcnt += 10;
for(int jk =4;jk<=8;jk++){
	
	HSSFRow row= sheet.createRow((short)jk);
	row.setHeight((short)1000);
for(int i=datcnt;i<(datcnt+11);i++){ 
row.createCell((short) (i%11)).setCellValue(data[i]);
row.getCell((short) (i%11)).setCellStyle(tabs);
out.print(data[i]);
}
datcnt += 11; 
}
HSSFRow row2 = sheet.createRow((short)9);
sheet.addMergedRegion(new CellRangeAddress(9,9,0,4));
row2.createCell((short)0).setCellValue("Made by: "+md[0]);
HSSFRow row3 = sheet.createRow((short)11);
row3.createCell((short)0).setCellValue("Copy to: ");
for(int kid=1;kid<=cto.length;kid++){
	sheet.createRow((short)(11+kid)).createCell((short)0).setCellValue(""+kid);
	sheet.getRow((short)(11+kid)).createCell((short)1).setCellValue(""+cto[kid-1]);
}
%> 
	</c:forEach>
	
<%
out.println("Your excel file has been generated!"); 
ByteArrayOutputStream outByteStream = new ByteArrayOutputStream();
hwb.write(outByteStream);
byte[] outArray = outByteStream.toByteArray();
response.setContentType("applications/ms-excel");
response.setContentLength(outArray.length);
response.setHeader("Expires:","0");
response.setHeader("Content-Disposition","attachment; filename=ClassroomTimeTable.xls");
OutputStream outStream = response.getOutputStream();
outStream.write(outArray);
outStream.flush();
} catch( Exception ex ) { 
out.println("Error: "+ex); 
} 
%>