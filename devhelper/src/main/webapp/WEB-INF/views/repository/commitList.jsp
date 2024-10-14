<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
  html::-webkit-scrollbar{
    width: 10px;
  }
  html::-webkit-scrollbar-track { 
    background-color: transparent;
    border-radius: 5px;
  }
  html::-webkit-scrollbar-thumb { 
    background-color: skyblue;
    border-radius: 5px;
  }
  html::-webkit-scrollbar-button{
    display: none;
  }
  @font-face {
    font-family: 'GangwonEdu_OTFBoldA';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2201-2@1.0/GangwonEdu_OTFBoldA.woff') format('woff');
    font-weight: normal;
    font-style: normal;
  }
  body * {
    font-family: 'GangwonEdu_OTFBoldA';
    font-weight: normal;
  }
  .outer {
      position: relative;
      height: auto;
      margin: 10px;
      transition: .3s;
      background-color: transparent;
  }
  .commitList{
    min-height: 900px;
    width: 100%;
    backdrop-filter: blur(5px);
  }
  tbody tr td{
    text-align: center;
    font-size: 14px;
  }
  #commitContent{
    width: 100%;
    display: flex;
  }
  #cListTable, #commitDetail{
    width: 100%;
  }
  #commitDetail{
    border: 1px solid black;
  }
  #commitTitle{
    height: 30px;
    padding: auto;
  }
</style>
</head>
<body>
	<div class="outer">
    <div class="commitList">

      <div id="commitTitle">
        ${ repoName } Commits
      </div>

      <div id="commitContent">
        <table id="cListTable">
          <thead>
            <tr style="height: 50px;">
              <th style="width: 80px;">확정자</th>
              <th style="width: 80px;">메시지</th>
              <th style="width: 80px;">일자</th>
              <th style="width: 80px;">SHA</th>
            </tr>
          </thead>
          <tbody>
          
            <c:forEach var="c" items="${ commitList }">
              <tr style="height: 40px;">
                <td>${ c.comAuthor }</td>
                <td>${ c.comMessage }</td>
                <td>${ c.comDate }</td>
                <td>${ c.SHA }</td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>
    </div>

  </div>
</body>
</html>