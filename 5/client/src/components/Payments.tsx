import React, { useState } from 'react';
import { Payment } from '../interfaces/Payment';
import { useCart } from "../contexts/ContextCart";
import CartComponent from "./CartComponent";

const Payments: React.FC = () => {
  const initialPaymentState: Payment = {
    cardNumber: '',
    expiryDate: '',
    amount: 0,
  };
  const [payment, setPayment] = useState<Payment>(initialPaymentState);
  const [response, setResponse] = useState<string>('');
  const { cartTotalAmount, clearCart } = useCart();

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target;
    const parsedValue = name === 'amount' ? parseFloat(value) : value;
    setPayment(prevPayment => ({
      ...prevPayment,
      [name]: parsedValue,
    }));
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();

    if (cartTotalAmount === 0) {
      setResponse("There are no products in cart to pay for.");
      return;
    }

    if (!payment.cardNumber || !payment.expiryDate) {
      setResponse("Please fill in all the fields.");
      return;
    }

    payment.amount = cartTotalAmount.toFixed(2);

    const response = await fetch('http://localhost:8080/payment', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(payment),
    });
    if (response.ok) {
      clearCart();
      setResponse(`Payment successful!`);
    } else {
      setResponse(`Failed to make payment! Make sure the card is valid.`);
    }
  };

  return (
    <div>
      <h2>Payment</h2>
      <form onSubmit={handleSubmit}>
        <div className="input-container">
          <label htmlFor="cardNumber">Card Number:</label>
          <input
            type="text"
            id="cardNumber"
            name="cardNumber"
            placeholder={"1234 1234 1234 1234"}
            value={payment.cardNumber}
            onChange={handleChange}
          />
          <label htmlFor="expiryDate">Expiry Date:</label>
          <input
            type="text"
            id="expiryDate"
            name="expiryDate"
            placeholder={"MM/YY"}
            value={payment.expiryDate}
            onChange={handleChange}
          />
        </div>
        <div>
          <p>Total Amount: {cartTotalAmount.toFixed(2)}</p>
        </div>
        <div className="payment-bttn-div">
          <button type="submit">Make Payment</button>
        </div>
      </form>
      {response && <p style={{color: response.includes('successful') ? 'green' : 'red'}}>{response}</p>}
      <CartComponent/>
    </div>
  );
};

export default Payments;
