import React, { useEffect, useState } from 'react';
import { Product } from '../interfaces/Product';
import { useCart } from '../contexts/ContextCart';
import Api from '../api/Api';

const Products: React.FC = () => {
  const [products, setProducts] = useState<Product[]>([]);
  const { cart, addProductToCart, removeProductFromCart } = useCart();

  useEffect(() => {
    const fetchProducts = async () => {
      try {
        const response = await Api.get('/products');
        const data = response.data;
        const convertedProducts: Product[] = data.map((item: any) => ({
          id: item.ID,
          name: item.name,
          description: item.description,
          price: item.price,
          quantity: 0
        }));
        setProducts(convertedProducts);
      } catch (error) {
        console.error('Error fetching products:', error);
      }
    };

    fetchProducts();
  }, []);

  const isInCart = (productId: number) => {
    return cart.some((product: Product) => product.id === productId);
  };

  const getQuantity = (productId: number) => {
    const productInCart = cart.find((product: Product) => product.id === productId);
    return productInCart ? productInCart.quantity : 0;
  };

  return (
    <div>
      <h2>Available Products</h2>
      <table>
        <thead>
          <tr>
            <th>Name</th>
            <th>Description</th>
            <th>Price</th>
            <th></th>
          </tr>
        </thead>
        <tbody>
          {products.map((product: Product) => (
            <tr key={product.id}>
              <td>{product.name}</td>
              <td>{product.description}</td>
              <td>{product.price}</td>
              {isInCart(product.id) ? (
                <>
                  <td><button onClick={() => addProductToCart(product)}>Add to Cart</button></td>
                  <td><button onClick={() => removeProductFromCart(product.id)}>Remove One</button></td>
                  <td><span>{` (${getQuantity(product.id)} in cart)`}</span></td>
                </>
              ) : (
                <td><button onClick={() => addProductToCart(product)}>Add to Cart</button></td>
              )}
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};

export default Products;
