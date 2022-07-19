package site.shoppingBasket;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("ShoppingBasketService")
public class ShoppingBasketServiceImple implements ShoppingBasketService {
	static Logger log = LoggerFactory.getLogger(ShoppingBasketServiceImple.class);

	@Autowired
	ShoppingBasketMapper shoppingBasketMapper;

	@Override
	public int countShoppingBasket(ShoppingBasket shoppingBasket) {
		return shoppingBasketMapper.countShoppingBasket(shoppingBasket);
	}

	@Override
	public List<ShoppingBasket> findShoppingBasketList(ShoppingBasket shoppingBasket) {
		return shoppingBasketMapper.findShoppingBasketList(shoppingBasket);
	}

	@Override
	public void saveShoppingBasket(ShoppingBasket shoppingBasket) {
		shoppingBasketMapper.saveShoppingBasket(shoppingBasket);
	}

	@Override
	public void deleteShoppingBasket(ShoppingBasket shoppingBasket) {
		shoppingBasketMapper.deleteShoppingBasket(shoppingBasket);
	}

}
