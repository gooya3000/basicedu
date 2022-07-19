package site.shoppingBasket;

import java.util.List;

public interface ShoppingBasketMapper {

	int countShoppingBasket(ShoppingBasket shoppingBasket);

	List<ShoppingBasket> findShoppingBasketList(ShoppingBasket shoppingBasket);

	void saveShoppingBasket(ShoppingBasket shoppingBasket);

	void deleteShoppingBasket(ShoppingBasket shoppingBasket);
}
