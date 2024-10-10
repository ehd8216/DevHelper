<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
  .outer {
      position: relative;
      width: 98vw;
      height: auto;
      border-radius: 10px;
      margin: 10px auto;
      overflow: hidden;
      padding: 5px;
      display: flex;
      flex-direction: column;
      transition: .3s;
      background-color: transparent;
  }

  /* .outer::before {
      content: "";
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background-image: url(resources/image/Designer5.jpeg);
      background-size: cover;
      background-attachment: fixed;
      opacity: 0.2;
      z-index: -1; 
  }*/
  .commitList{
    min-height: 900px;
    width: 80%;
    margin: auto;
    backdrop-filter: blur(5px);
  }
  tbody tr td{
    text-align: center;
  }
  #commitContent{
    width: 100%;
    display: flex;
  }
  #cListTable, #commitDetail{
    width: 50%;
  }
  #commitDetail{
    border: 1px solid black;
  }
</style>
</head>
<body>
	<div class="outer">
    <div class="commitList">

      <div id="commitBtn">
        <button>commit</button>
      </div>

      <div id="commitContent">

        <table id="cListTable">
          <thead>
            <tr style="height: 50px;">
              <th style="width: 100px;">확정자</th>
              <th style="width: 200px;">메시지</th>
              <th style="width: 200px;">일자</th>
              <th style="width: 400px;">SHA</th>
            </tr>
          </thead>
          <tbody>
          
            <c:forEach var="c" items="${ commitList }">
              <tr style="height: 30px;">
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