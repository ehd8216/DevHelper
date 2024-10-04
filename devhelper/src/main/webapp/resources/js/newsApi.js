document.addEventListener('DOMContentLoaded', function() {
            const query = '연예'; // 원하는 검색어
            const url = `http://localhost:8234/FinalProject/api/news?query=${encodeURIComponent(query)}`; // 백엔드 엔드포인트

            fetch(url)
                .then(response => response.json())
                .then(data => {
					console.log(data);
                    const articles = data.items; // 응답 데이터에서 articles 추출
                    const container = document.getElementById('news-container');

                    articles.forEach(article => {
                        const articleElement = document.createElement('div');
                        articleElement.innerHTML = `
                            <h2>${article.title}</h2>
                            <img src="${article.thumbnail}" alt="${article.title}" style="width:100%; height:auto;">
                            <p>${article.description}</p>
                            <a href="${article.link}" target="_blank">Read more</a>
                        `;
                        container.appendChild(articleElement);
                    });
                })
                .catch(error => {
                    console.error('Error fetching data:', error);
                });
        });