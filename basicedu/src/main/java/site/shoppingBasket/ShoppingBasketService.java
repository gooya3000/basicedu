package site.shoppingBasket;

import java.util.List;

public interface ShoppingBasketService {

	public int countShoppingBasket(ShoppingBasket shoppingBasket);

	public List<ShoppingBasket> findShoppingBasketList(ShoppingBasket shoppingBasket);

	public void saveShoppingBasket(ShoppingBasket shoppingBasket);

	public void deleteShoppingBasket(ShoppingBasket shoppingBasket);
}
