import React, {createContext, ReactNode, useContext, useState, useEffect} from 'react';
import { Product } from "../interfaces/Product";

const CartContext = createContext<any>(null);

export const useCart = () => {
  return useContext(CartContext);
};

interface CartProviderProps {
  children: ReactNode;
}

export const CartProvider = ({ children }: CartProviderProps) => {
  const [cart, setCart] = useState<Product[]>([]);
  const [cartTotalAmount, setCartTotalAmount] = useState<number>(0);

  useEffect(() => {
    const totalAmount = cart.reduce((total, item) => total + item.price * item.quantity, 0);
    setCartTotalAmount(totalAmount);
  }, [cart]);

  const addProductToCart = (product: Product) => {
    const existingProductIndex = cart.findIndex((item) => item.id === product.id);

    if (existingProductIndex !== -1) {
      const updatedCart = cart.map((item, index) =>
        index === existingProductIndex ? { ...item, quantity: item.quantity + 1 } : item
      );
      setCart(updatedCart);
    } else {
      setCart([...cart, { ...product, quantity: 1 }]);
    }
  };

  const removeProductFromCart = (productId: number) => {
    const existingProductIndex = cart.findIndex(
      (item) => item.id === productId
    );

    if (existingProductIndex !== -1) {
      const updatedCart = cart.map((item, index) => {
        if (index === existingProductIndex) {
          return {
            ...item,
            quantity: item.quantity > 1 ? item.quantity - 1 : 0,
          };
        }
        return item;
      }).filter(item => item.quantity > 0);

      setCart(updatedCart);
    }
  };

  const clearCart = () => {
    setCart([]);
  };

  return (
    <CartContext.Provider value={{ cart, cartTotalAmount, addProductToCart, removeProductFromCart, clearCart }}>
      {children}
    </CartContext.Provider>
  );
};
