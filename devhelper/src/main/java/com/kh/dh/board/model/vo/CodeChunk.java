package com.kh.dh.board.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@Getter
@Setter
@ToString
public class CodeChunk {

	private int codeId;
	private int boardNo;
	private String chunkContent;
	private int chunkOrder;
	
	public CodeChunk(String chunk, int chunkOrder) {     
        this.chunkContent = chunk;     
        this.chunkOrder = chunkOrder; 
	}
}
