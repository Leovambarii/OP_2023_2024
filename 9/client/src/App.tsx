import './App.css';
import React from 'react';
import { BrowserRouter, Link, Route, Routes} from 'react-router-dom';
import NotFound from './components/NotFound';
import Welcome from './components/Welcome';
import Products from './components/Products';
import Payments from './components/Payments';
import CartComponent from "./components/CartComponent";
import { CartProvider } from './contexts/ContextCart';


function App() {
  return (
    <CartProvider>
      <div className="App">
        <div className="App-div">
          <BrowserRouter>
            <ul>
              <li><Link to="/">Home</Link></li>
              <li><Link to="/products">Products</Link></li>
              <li><Link to="/cart">Shopping Cart</Link></li>
              <li><Link to="/payments">Payments</Link></li>
            </ul>
            <Routes>
              <Route path="/" element={<Welcome />} />
              <Route path="/products" element={<Products />} />
              <Route path="/cart" element={<CartComponent />} />
              <Route path="/payments" element={<Payments />} />
              <Route path="*" element={<NotFound />} />
            </Routes>
          </BrowserRouter>
        </div>
      </div>
    </CartProvider>
  );
}

export default App;
