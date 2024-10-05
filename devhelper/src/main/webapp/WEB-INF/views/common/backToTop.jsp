<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
 <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
 <!-- jQuery CDN -->
 <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

 <style>
	/* Back to Top button styling */
	#back-to-top {
      position: fixed;
      bottom: 40px;
      right: 40px;
      font-size: 18px;
      padding: 10px 20px;
      background-color: #000;
      color: #fff;
      border: none;
      cursor: pointer;
      border-radius: 5px;
    }

    #back-to-top:hover { background-color: #555;}

 </style>
</head>
<body>
<button id="back-to-top"><span class="material-symbols-outlined">arrow_upward</span></button>
<script>
	  $('#back-to-top').click(function () {
          $('html, body').animate({ scrollTop: 0 }, 'slow');
          return false;
        });
</script>
</body>
</html>