package site.mypage.product;

import java.util.List;

import site.util.Param;

public interface ProductMapper {

	int countProduct(Param param);

	List<Product> findProductList(Param param);

	Product findProduct(Product product);

	void saveProduct(Product product);

	void modifyProduct(Product product);

	void modifyProductQuantityByOrder(Product product);

	void deleteProduct(Product product);
}
