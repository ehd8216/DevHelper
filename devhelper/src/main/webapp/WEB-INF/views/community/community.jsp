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
                                    margin-bottom: 20px;
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


                                    & .swiper-slide {
                                        display: flex;
                                        flex-direction: column;
                                        justify-content: center;
                                        align-items: center;
                                        text-align: center;
                                        height: 40px;
                                        padding: 0 10px;
                                        gap: 3px;
                                    }

                                    & .swiper-slide a {
                                        text-decoration: none;
                                        color: #4A90E2;
                                        font-size: 20px;
                                    }

                                    & .swiper-slide p {
                                        margin: 0;
                                        color: #666;
                                        font-size: 12px;
                                    }
                                }

                                .swiper-container2 {
                                    width: 100%;
                                    height: 450px;
                                    overflow: hidden;
                                    margin-left: .5%;

                                    & .swiper-slide {
                                        display: flex;
                                        gap: 20px;
                                    }

                                    & .swiper-thumbnail {
                                        width: 40%;
                                        height: 90%;
                                        position: relative;
                                        border: 1px solid gainsboro;
                                        overflow: hidden;
                                        border-radius: 10px;

                                        & pre {
                                            overflow: auto;
                                            width: 100%;
                                            height: 100%;
                                            padding: 0;
                                            margin: 0;
                                            scrollbar-width: none;
                                            -ms-overflow-style: none;
                                        }

                                        & .language-js {
                                            width: 100%;
                                            height: 100%;
                                            display: block;
                                        }
                                    }

                                }

                                .swiper-thumbnail pre::-webkit-scrollbar {
                                    display: none;
                                }

                                @keyframes blink {

                                    0%,
                                    100% {
                                        opacity: 0.5;
                                    }

                                    50% {
                                        opacity: 1;
                                        font-weight: bolder;
                                    }
                                }

                                .dot {
                                    font-size: 34px;
                                    animation: blink 1.5s linear infinite;
                                }

                                .dot:nth-child(1) {
                                    animation-delay: 0s;
                                }

                                .dot:nth-child(2) {
                                    animation-delay: 0.3s;
                                }

                                .dot:nth-child(3) {
                                    animation-delay: 0.6s;
                                }

                                .swiper-inners {
                                    display: flex;
                                    flex-direction: column;
                                    gap: 30px;
                                    width: 58%;
                                    height: 95%;
                                }

                                .swiper-title {
                                    font-size: 20px;
                                    line-height: 20px;
                                    display: flex;
                                    gap: 20px;
                                }

                                .helpCall {
                                    font-size: 15px;
                                    color: red;
                                    border: 1px solid red;
                                    height: 18px;
                                    border-radius: 10px;
                                    width: 40px;
                                    text-align: center;
                                    background-color: white;
                                    cursor: pointer;
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

                                <script>
                                    $(function () {

                                        $.ajax({
                                            url: 'viewCount.bo',
                                            method: 'GET',
                                            success: (result) => {
                                                toastr.success("조회수별 구조요청 수신완료");
                                            }
                                        });

                                        $.ajax({
                                            url: 'viewRandom.bo',
                                            method: 'GET',
                                            success: (result) => {
                                                toastr.success("랜덤 구조요청 수신완료");
                                            }
                                        });

                                    });
                                </script>

                                <div class="box-section">

                                    <div class="swiper-container2">

                                        <div style="color: #DAA520; font-size: 25px;">
                                            구조 요청중<span class="dot">.</span>
                                            <span class="dot">.</span>
                                            <span class="dot">.</span>
                                        </div>

                                        <div class="swiper-wrapper">
                                            <c:forEach var="b" items="${list}">
                                                <div class="swiper-slide">
                                                    <div class="swiper-thumbnail">
                                                        <pre>
                                                                <code class="language-js"><c:forEach var="chunk" items="${codeMap[b.boardNo]}"><c:out value="${chunk.chunkContent}" escapeXml="true" /></c:forEach></code>
                                                            </pre>
                                                    </div>
                                                    <div class="swiper-inners">
                                                        <div class="swiper-title">📌${empty b.boardTitle ? "제목 없음" :
                                                            b.boardTitle}<div class="helpCall" data-bNo="${b.boardNo}">
                                                                Help!
                                                            </div>
                                                        </div>
                                                        <div class="swiper-content">${empty b.boardContent ? "본문 없음" :
                                                            b.boardContent}</div>
                                                    </div>
                                                </div>
                                            </c:forEach>

                                        </div>

                                    </div>

                                    <br><br><br>

                                    <div class="swiper-container2">

                                        <div style="color: #DAA520; font-size: 25px; float: right; margin-right: 1%;">
                                            구조 요청중<span class="dot">.</span>
                                            <span class="dot">.</span>
                                            <span class="dot">.</span>
                                        </div>

                                        <div class="swiper-wrapper">
                                            <c:forEach var="b" items="${list2}">
                                                <div class="swiper-slide">
                                                    <div class="swiper-inners">
                                                        <div class="swiper-title">📌${empty b.boardTitle ? "제목 없음" :
                                                            b.boardTitle}<div class="helpCall" data-bNo="${b.boardNo}">
                                                                Help!
                                                            </div>
                                                        </div>
                                                        <div class="swiper-content">${empty b.boardContent ? "본문 없음" :
                                                            b.boardContent}</div>
                                                    </div>
                                                    <div class="swiper-thumbnail">
                                                        <pre>
                                                                <code class="language-js"><c:forEach var="chunk" items="${codeMap2[b.boardNo]}"><c:out value="${chunk.chunkContent}" escapeXml="true" /></c:forEach></code>
                                                            </pre>
                                                    </div>
                                                </div>
                                            </c:forEach>

                                        </div>

                                    </div>

                                    <br><br><br>

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

                                var swiper = new Swiper('.swiper-container2', {
                                    direction: 'horizontal',
                                    slidesPerView: 1,
                                    spaceBetween: 0,
                                    loop: true,
                                    autoplay: {
                                        delay: 12000,
                                        disableOnInteraction: true,
                                    },
                                    keyboard: true,
                                });

                                $(document).on('click', '.helpCall', function () {
                                    const bNo = $(this).data("bno");
                                    location.href = "detail.bo?bNo=" + bNo;
                                });
                            </script>
                            <!-- 
                            <script src="https://cdnjs.cloudflare.com/ajax/libs/ace/1.4.12/ace.js"></script>
                            <div id="editor" style="height: 300px; width: 100%;"></div>
                            <script>
                                // Ace Editor 초기화
                                const editor = ace.edit("editor");
                                editor.setTheme("ace/theme/monokai");
                                editor.session.setMode("ace/mode/javascript");
                            </script>

                            <script>
                                const socket = new WebSocket('ws://localhost:8234/dh/collab'); // yourContextPath는 실제 경로로 변경

                                socket.onopen = function () {
                                    console.log("WebSocket 연결됨");
                                };

                                socket.onmessage = function (event) {
                                    const data = JSON.parse(event.data);
                                    if (data.type === 'codeUpdate') {
                                        editor.setValue(data.code); // 코드 에디터에 업데이트
                                    }
                                };

                                function sendCodeUpdate(code) {
                                    socket.send(JSON.stringify({ type: 'codeUpdate', code }));
                                }

                                // 코드 에디터에서 변화가 생겼을 때 호출
                                editor.on('change', () => {
                                    const code = editor.getValue();
                                    sendCodeUpdate(code);
                                });
                            </script> -->

                        </body>

                        </html>