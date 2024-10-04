<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/boxicons/2.1.0/css/boxicons.min.css" integrity="sha512-pVCM5+SN2+qwj36KonHToF2p1oIvoU3bsqxphdOIWMYmgr4ZqD3t5DjKvvetKhXGc/ZG5REYTT6ltKfExEei/Q==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/MaterialDesign-Webfont/5.3.45/css/materialdesignicons.css" integrity="sha256-NAxhqDvtY0l4xn+YVa6WjAcmd94NNfttjNsDmNatFVc=" crossorigin="anonymous" />
<style>
  .repoList{
    border: 1px solid black;
    margin: auto;
    width: 80%;
  }
  .repoTable{
    border: 1px solid gray;
    margin: auto;
    width: 100%;
  }
  #repoHead{
    height: 50px;
    font-size: 24px;
  }
  #repoBody{
    text-align: center;
  }
  #repoBody tr{
    height: 70px;
    cursor: pointer;
  }
  #repoBody tr:hover{
    background-color: rgba(155, 155, 155, 0.3)
  }  
  
</style>
</head>
<body>
  <jsp:include page="../common/menubar.jsp" />
  <div class="outer">
      <div class="repoList">
        <table border="1" class="repoTable">
          <thead id="repoHead">
            <tr>
              <th>아이콘</th>
              <th>이름</th>
              <th>공개범위</th>
              <th>기타</th>
            </tr>
          </thead>
          <tbody id="repoBody">
            <tr>
              <td>사진</td>
              <td>TestRe</td>
              <td>private</td>
              <td>
                <button>초대</button>
                <button>삭제</button>
              </td>
            </tr>
            <tr>
              <td>사진</td>
              <td>TestRe</td>
              <td>private</td>
              <td>
                <button>초대</button>
                <button>삭제</button>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
  </div>

  <script>
    $(function(){
      $("#repoBody tr").click(function(){
        location.href="repoDetail.re";
      })
    })

  </script>

</body>
</html>