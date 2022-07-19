
<%@ page import="java.io.File" %>
<%@ page import="java.io.*"%>
<%@ page import="java.net.URLEncoder"%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<%
  String fileNameStr = request.getParameter("fileNameStr");
  String fileDir = request.getParameter("fileDir");

  //파일명 인코딩
  String UTF8FileName = new String(fileNameStr.getBytes("8859_1"), "UTF-8");

  //실제 파일

  //String savePath = "D:/project/workspace/sts-4.2.2.RELEASE/basicedu/src/main/webapp/upload/onlec";
  String savePath = "/home/basicedu/basicedu/upload/onlec";

  String filePath = savePath + "/" + fileNameStr;

  boolean MSIE = request.getHeader("user-agent").indexOf("MSIE") != -1;
  if(MSIE){
        // 브라우저가 IE일 경우 저장될 파일 이름
        // 공백이 '+'로 인코딩된것을 다시 공백으로 바꿔준다.
        fileNameStr = URLEncoder.encode(UTF8FileName, "UTF8").replaceAll("\\+", " ");
    }else{
        // 브라우저가 IE가 아닐 경우 저장될 파일 이름
        fileNameStr = new String(UTF8FileName.getBytes("UTF-8"), "8859_1");
    }
  try{

    out.clear();
    out = pageContext.pushBody();

    File file = new File(filePath);

    byte b[] = new byte[1024];

    response.reset();

    //response.setContentType("application/octet-stream");
    response.setHeader("Content-Type", "application/octet-stream;");
    response.setHeader("Content-Disposition", "attachment; filename=\"" + fileNameStr + "\";");

    FileInputStream fis = new FileInputStream(filePath);
    BufferedInputStream bis = new BufferedInputStream(fis);
    BufferedOutputStream bos = new BufferedOutputStream(response.getOutputStream());

    int numRead;

    while((numRead = bis.read(b,0,b.length)) != -1){
      bos.write(b,0,numRead);
    }
    bos.flush();
    bos.close();
    bis.close();

  }catch(Exception e){

    e.printStackTrace();

  }
%>



