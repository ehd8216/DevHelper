<%@ page import="org.json.simple.JSONArray" %>
    <%@ page import="org.json.simple.JSONObject" %>
        <%@ page import="org.json.simple.parser.JSONParser" %>
            <%@ page import="org.json.simple.parser.ParseException" %>
                <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
                    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

                        <!DOCTYPE html>
                        <html>

                        <head>
                            <meta charset="UTF-8">
                            <title>DevHelper</title>
                            <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
                            <style>
                                .news-section {
                                    display: flex;
                                    gap: 10px;
                                    align-items: center;
                                    position: relative;
                                    height: 40px;
                                    border-radius: 6px;
                                    padding: 5px;
                                    box-shadow: 0 4px 10px rgba(61, 60, 60, 0.1);
                                }

                                form {
                                    display: flex;
                                    width: auto;
                                    height: 20px;
                                    gap: 10px;
                                    margin-left: 2%;
                                }

                                .swiper-container {
                                    width: 100%;
                                    height: 40px;
                                    overflow: hidden;
                                }

                                .swiper {
                                    width: 100%;
                                    height: 100%;
                                }

                                .swiper-slide {
                                    display: flex;
                                    flex-direction: column;
                                    justify-content: center;
                                    align-items: center;
                                    text-align: center;
                                    height: 40px;
                                    padding: 0 10px;
                                    gap: 3px;
                                }

                                .swiper-slide a {
                                    text-decoration: none;
                                    color: #4A90E2;
                                    font-size: 20px;
                                }

                                .swiper-slide p {
                                    margin: 0;
                                    color: #666;
                                    font-size: 12px;
                                }

                                .topic-box-left {
                                    width: 99%;
                                    height: auto;
                                    display: flex;
                                    gap: 1%;
                                    margin: 2% auto;

                                    & .img-box {
                                        width: 40%;
                                        height: auto;
                                        overflow: hidden;
                                        border-radius: 10px;

                                        & img {
                                            width: 100%;
                                            height: 100%;
                                            object-fit: cover;
                                            transition: .4s;

                                            &:hover {
                                                cursor: pointer;
                                                transform: scale(1.03);
                                            }
                                        }
                                    }
                                }

                                .topic-box-right {
                                    width: 99%;
                                    height: auto;
                                    display: flex;
                                    gap: 1%;
                                    margin: 2% auto;
                                    justify-content: flex-end;

                                    & .img-box {
                                        width: 40%;
                                        height: auto;
                                        overflow: hidden;
                                        border-radius: 10px;

                                        & img {
                                            width: 100%;
                                            height: 100%;
                                            object-fit: cover;
                                            transition: .4s;

                                            &:hover {
                                                cursor: pointer;
                                                transform: scale(1.03);
                                            }
                                        }
                                    }
                                }
                            </style>
                        </head>

                        <body>
                            <jsp:include page="../common/menubar.jsp" />

                            <div class="outer">

                                <div class="news-section">

                                    <form action="searchNews" method="get">
                                        <input type="text" name="query" value="" placeholder="검색어를 입력하세요." />
                                        <input type="submit" value="검색" />
                                    </form>

                                    <div class="swiper-container">

                                        <div class="swiper-wrapper">

                                            <c:forEach var="item" items="${items}">
                                                <div class="swiper-slide">
                                                    <a href="${item.link}" target="_blank">${item.title}</a>
                                                    <p>${item.description}</p>
                                                </div>
                                            </c:forEach>

                                        </div>

                                    </div>

                                </div>

                                <div class="topic-box-left">
                                    <div class="img-box">
                                        <img src="resources/image/Designer2.jpeg">
                                    </div>

                                    <div class="description-box">
                                        <p>
                                            이거는~ 어쩌구~
                                            저쩌구~~
                                        </p>
                                    </div>
                                </div>

                                <div class="topic-box-right">
                                    <div class="description-box">
                                        <p>
                                            이거는~ 어쩌구~
                                            저쩌구~~
                                        </p>
                                    </div>

                                    <div class="img-box">
                                        <img src="resources/image/Designer5.jpeg">
                                    </div>
                                </div>

                            </div>

                            <script>
                                var swiper = new Swiper('.swiper-container', {
                                    direction: 'vertical',
                                    slidesPerView: 1,
                                    spaceBetween: 10,
                                    loop: true,
                                    autoplay: {
                                        delay: 5000,
                                        disableOnInteraction: false,
                                    },
                                    mousewheel: true,
                                    keyboard: true,
                                });
                            </script>

                        </body>

                        </html>