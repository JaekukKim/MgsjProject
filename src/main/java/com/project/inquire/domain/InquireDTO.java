package com.project.inquire.domain;

import java.util.Date;

public class InquireDTO {

	private int askNum;
	private int pno;
	private String userId;
	private String askTitle;
	private String askContent;
	private Date askRegDate;

	// 이너 조인
	private String categoryName;

	public int getAskNum() {
		return askNum;
	}

	public void setAskNum(int askNum) {
		this.askNum = askNum;
	}

	public int getPno() {
		return pno;
	}

	public void setPno(int pno) {
		this.pno = pno;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getAskTitle() {
		return askTitle;
	}

	public void setAskTitle(String askTitle) {
		this.askTitle = askTitle;
	}

	public String getAskContent() {
		return askContent;
	}

	public void setAskContent(String askContent) {
		this.askContent = askContent;
	}

	public Date getAskRegDate() {
		return askRegDate;
	}

	public void setAskRegDate(Date askRegDate) {
		this.askRegDate = askRegDate;
	}

	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	@Override
	public String toString() {
		return "InquireDTO [askNum=" + askNum + ", pno=" + pno + ", userId=" + userId + ", askTitle=" + askTitle + ", askContent=" + askContent
				+ ", askRegDate=" + askRegDate + ", categoryName=" + categoryName + "]";
	}

}
