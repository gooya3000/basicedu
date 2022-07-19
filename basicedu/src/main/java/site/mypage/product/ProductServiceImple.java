package site.mypage.product;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import site.util.Param;

@Service("ProductService")
public class ProductServiceImple implements ProductService {

	static Logger log = LoggerFactory.getLogger(ProductServiceImple.class);

	@Autowired
	ProductMapper productMapper;

	@Override
	public int countProduct(Param param) {
		return productMapper.countProduct(param);
	}

	@Override
	public List<Product> findProductList(Param param) {
		return productMapper.findProductList(param);
	}

	@Override
	public Product findProduct(Product product) {
		return productMapper.findProduct(product);
	}

	@Override
	public void saveProduct(Product product) {
		productMapper.saveProduct(product);
	}

	@Override
	public void modifyProduct(Product product) {
		productMapper.modifyProduct(product);
	}

	@Override
	public void modifyProductQuantityByOrder(Product product) {
		productMapper.modifyProductQuantityByOrder(product);
	}

	@Override
	public void deleteProduct(Product product) {
		productMapper.deleteProduct(product);
	}
}
