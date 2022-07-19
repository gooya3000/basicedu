package site.mypage.product;

import java.util.List;

import site.util.Param;

public interface ProductService {

	public int countProduct(Param param);

	public List<Product> findProductList(Param param);

	public Product findProduct(Product product);

	public void saveProduct(Product product);

	public void modifyProduct(Product product);

	public void modifyProductQuantityByOrder(Product product);

	public void deleteProduct(Product product);
}
