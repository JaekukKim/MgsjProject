package com.project.product.domain;

public class CartDTO {
	
	private int cartNum;
	private int pno;
	private String userId;
	private int productCnt;

	private int totalCnt;
	private String productName;
	private int productPrice;
	private String storedFileName;
	
	public int getCartNum() {
		return cartNum;
	}

	public void setCartNum(int cartNum) {
		this.cartNum = cartNum;
	}

	public int getPno() {
		return pno;
	}

	public void setPno(int pno) {
		this.pno = pno;
	}

	public int getTotalCnt() {
		return totalCnt;
	}

	public void setTotalCnt(int totalCnt) {
		this.totalCnt = totalCnt;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public int getProductCnt() {
		return productCnt;
	}

	public void setProductCnt(int productCnt) {
		this.productCnt = productCnt;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public int getProductPrice() {
		return productPrice;
	}

	public void setProductPrice(int productPrice) {
		this.productPrice = productPrice;
	}

	public String getStoredFileName() {
		return storedFileName;
	}

	public void setStoredFileName(String storedFileName) {
		this.storedFileName = storedFileName;
	}

	@Override
	public String toString() {
		return "CartDTO [cartNum=" + cartNum + ", pno=" + pno + ", userId=" + userId + ", productCnt=" + productCnt
				+ ", totalCnt=" + totalCnt + ", productName=" + productName + ", productPrice=" + productPrice
				+ ", storedFileName=" + storedFileName + "]";
	}

	
}
