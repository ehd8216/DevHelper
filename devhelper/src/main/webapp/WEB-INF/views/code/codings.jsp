<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

                <!DOCTYPE html>
                <html>

                <head>
                    <meta charset="UTF-8">
                    <title>Insert title here</title>
                    <style>
                        .category-header {
                            cursor: pointer;
                            background-color: #f0f0f0;
                            padding: 10px;
                            border: 1px solid #ccc;
                            margin: 5px 0;
                            border-radius: 10px;
                        }

                        .problem-items {
                            padding-left: 20px;
                            height: 0;
                            overflow: hidden;
                            transition: height 1s ease;
                        }

                        .cfBoundaries {
                            display: flex;
                            justify-content: space-between;
                        }

                        .user-list {
                            width: 20%;
                        }

                        .user {
                            background-color: #fff;
                            border: 1px solid #ccc;
                            border-radius: 8px;
                            padding: 15px;
                            margin: 10px 0;
                            display: flex;
                            align-items: center;
                            justify-content: space-between;
                        }

                        .user p {
                            margin: 0;
                            font-size: 18px;
                        }

                        .medal {
                            margin-right: 10px;
                            font-size: 20px;
                        }

                        .problem-list {
                            width: 40%;
                        }

                        .contest-list {
                            width: 35%;
                        }

                        .titles {
                            font-size: 30px;
                            margin: 10px auto;
                        }

                        .contest {
                            display: flex;
                            flex-direction: column;
                            border: 3px solid #d1f3fd;
                            border-radius: 10px;
                            margin: 20px auto;
                            padding: 8px;
                            font-size: 18px;
                            background-color: transparent;
                        }

                        .con_top {
                            display: flex;
                            justify-content: space-between;
                            margin-bottom: 5px;
                        }

                        .con_bot {
                            text-align: center;
                        }
                    </style>
                </head>

                <body>

                    <jsp:include page="../common/menubar.jsp" />

                    <div class="outer">

                        <div class="cfBoundaries">

                            <div class="user-list">
                                <div class="titles">👍 유저 Top 100</div>
                                <c:set var="rank" value="1" />
                                <c:forEach var="user" items="${codeforcesUsers}">
                                    <div class="user">
                                        <p>
                                            <span class="medal">
                                                <c:choose>
                                                    <c:when test="${rank == 1}">
                                                        🥇
                                                    </c:when>
                                                    <c:when test="${rank == 2}">
                                                        🥈
                                                    </c:when>
                                                    <c:when test="${rank == 3}">
                                                        🥉
                                                    </c:when>
                                                    <c:otherwise>
                                                        👍
                                                    </c:otherwise>
                                                </c:choose>
                                            </span>
                                            ${rank} <span style="font-size: 24px;">${user.handle}</span> (${user.rank})
                                        </p>
                                    </div>
                                    <c:set var="rank" value="${rank + 1}" />
                                </c:forEach>
                            </div>

                            <div class="problem-list">
                                <div class="titles">🔥 문제 목록</div>
                                <c:forEach var="tag" items="${tags}">
                                    <div class="problem-category">
                                        <h3 class="category-header" style="font-size: 25px;">${tag}</h3>
                                        <div class="problem-items">
                                            <c:set var="problemIndex" value="1" />
                                            <c:forEach var="problem" items="${problems}">
                                                <c:if test="${fn:contains(problem.tags, tag)}">
                                                    <div class="problem">
                                                        <p style="font-size: 20px; margin-bottom: 4px;">
                                                            ${problemIndex}번
                                                            (🔥${problem.rating}) : <a
                                                                href="https://codeforces.com/problemset/problem/${problem.contestId}/${problem.index}"
                                                                target="_blank">${problem.name}</a></p>
                                                    </div>
                                                    <c:set var="problemIndex" value="${problemIndex + 1}" />
                                                </c:if>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>

                            <div class="contest-list">
                                <div class="titles">🏆 대회 목록 </div>
                                <c:forEach var="contest" items="${contests}">
                                    <div class="contest">
                                        <div class="con_top">
                                            <div>대회명 : ${contest.name}</div>
                                            <div>시작 시간:
                                                <fmt:formatDate value="${contest.startTime}" pattern="MM-dd HH:mm" />
                                            </div>
                                        </div>
                                        <div class="con_bot"><a href="https://codeforces.com/contestRegistration/2030"
                                                target="_blank">참여하기!</a></div>
                                    </div>
                                </c:forEach>
                            </div>

                        </div>

                    </div>

                    <script>
                        document.querySelectorAll('.category-header').forEach(header => {
                            header.addEventListener('click', () => {
                                const items = header.nextElementSibling;
                                if (items.style.height === '0px' || items.style.height === '') {
                                    items.style.height = items.scrollHeight + 'px';
                                } else {
                                    items.style.height = '0';
                                }
                            });
                        });
                    </script>

                </body>

                </html>