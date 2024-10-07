package com.kh.dh.repository.model.vo;

import java.time.LocalDateTime;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;


@NoArgsConstructor
@Setter
@Getter
@ToString
public class Issues {
    // 이슈 번호
    private int number;

    // 이슈 제목
    private String title;

    // 이슈 설명
    private String description;

    // 작성자
    private String user;

    // 이슈 상태 (예: OPEN, CLOSED)
    private String state;

    // 생성 날짜
    private LocalDateTime createdAt;

    // 업데이트 날짜
    private LocalDateTime updatedAt;
}
