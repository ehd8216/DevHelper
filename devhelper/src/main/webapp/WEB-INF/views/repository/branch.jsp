<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
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
  .branchContent{
    min-height: 500px;
    width: 100%;
    backdrop-filter: blur(1px);
 }
  #branchTitle{
    height: 30px;
    text-align: center;
    font-size: 24px;
    font-weight: 700;
  }
  .branchList{
    margin-top: 20px;
    text-align: center;
  }
  .bTable{
    margin: auto;
  }
  thead{
    font-size: 20px;
  }
  #bTr td button{
    border: none;
    background-color: transparent;
    cursor: pointer;
    border-radius: 5px;
  }
  #bTr td button:hover{
    background-color: #cccccc;
  }
  #bTr td button svg{
    margin-top: 4px;
  }
</style>
</head>
<body>
    <div class="outer">
       <div class="branchContent">
         <div id="branchTitle">
           ${ repoName } Branch
         </div>
         
         <div class="branchList">
			  <table class="bTable">
			    <thead>
			      <tr>
			        <th style="width: 200px;">Branch</th>
			        <th style="width: 200px;">Recent Update</th>
			        <th style="width: 200px;">delete</th>
			      </tr>
			    </thead>
			    <tbody>
			      <c:forEach var="b" items="${ bList }">
		            <tr id="bTr" style="height: 40px;">
		              <td>${ b.branchName }</td>
		              <td>${ b.updateDate }</td>
		              <td><button onclick="deleteBranch('${b.branchName}')"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" width="16" height="16">
                      <path d="M11 1.75V3h2.25a.75.75 0 0 1 0 1.5H2.75a.75.75 0 0 1 0-1.5H5V1.75C5 .784 5.784 0 6.75 0h2.5C10.216 0 11 .784 11 1.75ZM4.496 6.675l.66 6.6a.25.25 0 0 0 .249.225h5.19a.25.25 0 0 0 .249-.225l.66-6.6a.75.75 0 0 1 1.492.149l-.66 6.6A1.748 1.748 0 0 1 10.595 15h-5.19a1.75 1.75 0 0 1-1.741-1.575l-.66-6.6a.75.75 0 1 1 1.492-.15ZM6.5 1.75V3h3V1.75a.25.25 0 0 0-.25-.25h-2.5a.25.25 0 0 0-.25.25Z"></path>
                      </svg></button>
                  </td>
		            </tr>
		          </c:forEach>
			    </tbody>
			  </table>
			</div>
         
       </div>
    </div>

          <script>
            function deleteBranch(branchName){
              location.href="deleteBranch.re?branchName=" + branchName;
            }
          </script>
</body>
</html>