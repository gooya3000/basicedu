package site.mypage.product;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

public class Product {

	int productNo;
	String productName;
	String contentsFileName;
	int quantity;
	int price;
	String imgFileName;
	String sellerId;
	String sellerName;
	Date registerDate;
	String deleteAt;

	MultipartFile  contentsFile;
	MultipartFile  imgFile;

	public int getProductNo() {
		return productNo;
	}
	public void setProductNo(int productNo) {
		this.productNo = productNo;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public String getContentsFileName() {
		return contentsFileName;
	}
	public void setContentsFileName(String contentsFileName) {
		this.contentsFileName = contentsFileName;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getImgFileName() {
		return imgFileName;
	}
	public void setImgFileName(String imgFileName) {
		this.imgFileName = imgFileName;
	}
	public String getSellerId() {
		return sellerId;
	}
	public void setSellerId(String sellerId) {
		this.sellerId = sellerId;
	}
	public String getSellerName() {
		return sellerName;
	}
	public void setSellerName(String sellerName) {
		this.sellerName = sellerName;
	}
	public Date getRegisterDate() {
		return registerDate;
	}
	public void setRegisterDate(Date registerDate) {
		this.registerDate = registerDate;
	}
	public String getDeleteAt() {
		return deleteAt;
	}
	public void setDeleteAt(String deleteAt) {
		this.deleteAt = deleteAt;
	}
	public MultipartFile getContentsFile() {
		return contentsFile;
	}
	public void setContentsFile(MultipartFile contentsFile) {
		this.contentsFile = contentsFile;
	}
	public MultipartFile getImgFile() {
		return imgFile;
	}
	public void setImgFile(MultipartFile imgFile) {
		this.imgFile = imgFile;
	}
}
