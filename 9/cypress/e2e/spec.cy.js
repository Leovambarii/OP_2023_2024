describe('Welcome page', () => {
  beforeEach(() => {
    cy.visit('http://localhost:3000/');
  });

  it('Display welcome page message', () => {
    cy.get('h1').first().should('be.visible').contains('Welcome to this shop!');
  });

  it('Navigate to different pages', () => {
    const links = ['/', '/products', '/cart', '/payments'];

    cy.get('ul').should('be.visible').find('li').should('have.length', 4);

    cy.get('ul li:nth-child(1) > a').should('have.attr', 'href', links[0]).click();
    cy.get('h1').first().should('be.visible').contains('Welcome to this shop!');

    cy.get('ul li:nth-child(2) > a').should('have.attr', 'href', links[1]).click();
    cy.get('h2').first().should('be.visible').contains('Available Products');
    cy.visit('http://localhost:3000/');

    cy.get('ul li:nth-child(3) > a').should('have.attr', 'href', links[2]).click();
    cy.get('h2').first().should('be.visible').contains('Shopping Cart');
    cy.visit('http://localhost:3000/');

    cy.get('ul li:nth-child(4) > a').should('have.attr', 'href', links[3]).click();
    cy.get('h2').first().should('be.visible').contains('Payment');
  });
});

describe('Products Page', () => {
  beforeEach(() => {
    cy.visit('http://localhost:3000/products');
  });

  it('Display available products message and table', () => {
    cy.get('h2').should('be.visible').contains('Available Products');
    cy.get('table').should('be.visible');
  });

  it('Add a product to the cart', () => {
    cy.contains('button', 'Add to Cart').first().click();
    cy.get('span').first().should('contain', ' (1 in cart)');
  });

  it('Check if remove button is present if product was not added to cart', () => {
    cy.contains('button', 'Remove One').should('not.exist');
  });

  it('Remove a product from the cart', () => {
    cy.contains('button', 'Add to Cart').first().click();
    cy.contains('button', 'Remove One').first().click();
    cy.get('span').should('not.exist');
  });

  it('Update cart quantity when adding and removing multiple same product', () => {
    cy.contains('button', 'Add to Cart').first().click();
    cy.contains('button', 'Add to Cart').first().click();
    cy.contains('button', 'Add to Cart').first().click();
    cy.get('span').first().should('contain', '3 in cart');
    cy.contains('button', 'Remove One').first().click();
    cy.contains('button', 'Remove One').first().click();
    cy.contains('button', 'Remove One').first().click();
    cy.get('span').should('not.exist');
  });

  it('Add different products multiple times and check quantity', () => {
    cy.get('button:contains("Add to Cart")').first().click();
    cy.get('button:contains("Add to Cart")').first().click();

    cy.get('button:contains("Add to Cart")').eq(1).click();

    cy.get('button:contains("Add to Cart")').eq(2).click();
    cy.get('button:contains("Add to Cart")').eq(2).click();
    cy.get('button:contains("Add to Cart")').eq(2).click();

    cy.get('span').first().should('contain', '2 in cart');
    cy.get('span').eq(1).should('contain', '1 in cart');
    cy.get('span').eq(2).should('contain', '3 in cart');

    cy.get('button:contains("Remove One")').first().click();
    cy.get('button:contains("Remove One")').eq(2).click();
    cy.get('button:contains("Remove One")').eq(2).click();

    cy.get('span').first().should('contain', '1 in cart');
    cy.get('span').eq(1).should('contain', '1 in cart');
    cy.get('span').eq(2).should('contain', '1 in cart');
  });

  it('Display correct first product information', () => {
    cy.get('td').first().should('contain', 'Table');
    cy.get('td').eq(1).should('contain', 'Made of wood.');
    cy.get('td').eq(2).should('contain', '350.99');
  });
});

describe('Cart Page', () => {
  it('Display cart message for empty cart', () => {
    cy.visit('http://localhost:3000/cart');
    cy.get('h2').should('be.visible').contains('Shopping Cart');
    cy.get('p').should('be.visible').contains('No products in the cart.');
  });

  it('Display cart products', () => {
    cy.visit('http://localhost:3000/products');
    cy.get('button:contains("Add to Cart")').first().click();
    cy.get('button:contains("Add to Cart")').eq(1).click();
    cy.get('button:contains("Add to Cart")').eq(2).click();

    cy.get('ul li:nth-child(3) > a').should('have.attr', 'href', '/cart').click();
    cy.get('h2').should('be.visible').contains('Shopping Cart');
    cy.get('tbody').find('tr').should('have.length', 3);
  });

  it('Add another same product in cart', () => {
    cy.visit('http://localhost:3000/products');
    cy.get('button:contains("Add to Cart")').first().click();

    cy.get('ul li:nth-child(3) > a').should('have.attr', 'href', '/cart').click();
    cy.get('tbody td:nth-child(4)').should('contain', '1');
    cy.contains('button', 'Add').first().click();
    cy.get('tbody td:nth-child(4)').should('contain', '2');
  });

  it('Remove products in cart', () => {
      cy.visit('http://localhost:3000/products');
      cy.get('button:contains("Add to Cart")').first().click();

      cy.get('ul li:nth-child(3) > a').should('have.attr', 'href', '/cart').click();
      cy.contains('button', 'Remove').first().click();
      cy.get('p').should('be.visible').contains('No products in the cart.');
    });

    it('Calculate total amount', () => {
      cy.visit('http://localhost:3000/products');
      cy.get('button:contains("Add to Cart")').first().click();
      cy.get('button:contains("Add to Cart")').eq(1).click();
      cy.get('button:contains("Add to Cart")').eq(1).click();
      cy.get('button:contains("Add to Cart")').eq(2).click();
      cy.get('button:contains("Add to Cart")').eq(2).click();

      cy.get('ul li:nth-child(3) > a').should('have.attr', 'href', '/cart').click();
      cy.get('h2').should('be.visible').contains('Shopping Cart');
      cy.get('tbody').find('tr').should('have.length', 3);

      let totalAmount = 0;
      cy.get('tbody tr').each(($row) => {
        const price = parseFloat($row.find('td:nth-child(3)').text().trim());
        const quantity = parseInt($row.find('td:nth-child(4)').text().trim());
        totalAmount += price * quantity;
      }).then(() => {
        cy.get('p').should('be.visible').contains('Total Amount: ' + totalAmount.toFixed(2));
      });
    });

    it('Check total amount change after removing a product', () => {
      cy.visit('http://localhost:3000/products');
      cy.get('button:contains("Add to Cart")').first().click();
      cy.get('button:contains("Add to Cart")').eq(1).click();
      cy.get('button:contains("Add to Cart")').eq(1).click();
      cy.get('button:contains("Add to Cart")').eq(2).click();
      cy.get('button:contains("Add to Cart")').eq(2).click();
      cy.get('ul li:nth-child(3) > a').should('have.attr', 'href', '/cart').click();
      cy.get('tbody').find('tr').should('have.length', 3);

      let totalAmountBefore;
      cy.get('p').invoke('text').then(text => {
        totalAmountBefore = parseFloat(text.trim().replace('Total Amount: ', '')).toFixed(2);
      });

      let totalAmountFirstProduct;
      cy.get('tbody tr').first().then($row => {
        const price = parseFloat($row.find('td:nth-child(3)').text().trim()).toFixed(2);
        const quantity = parseInt($row.find('td:nth-child(4)').text().trim());
        totalAmountFirstProduct = price * quantity;
      });

      cy.contains('button', 'Remove').first().click();
      cy.get('tbody').find('tr').should('have.length', 2);

      let totalAmountAfter;
      cy.get('p').invoke('text').then(text => {
        totalAmountAfter = parseFloat(text.trim().replace('Total Amount: ', '')).toFixed(2);
      });

      cy.wrap().should(() => {
        expect(totalAmountBefore).to.not.be.undefined;
        expect(totalAmountAfter).to.not.be.undefined;
        expect(totalAmountFirstProduct).to.not.be.undefined;
      }).then(() => {
        let diff = totalAmountBefore - totalAmountFirstProduct;
        expect(diff.toFixed(2)).to.equal(totalAmountAfter);
      });
    });
});

describe('Payments Page', () => {
  it('Display payment message with 0 total amount for empty cart', () => {
    cy.visit('http://localhost:3000/payments');
    cy.get('h2').should('be.visible').contains('Payment');
    cy.get('p').first().should('be.visible').contains('Total Amount: 0.00');
  });

  it('Payment with empty cart', () => {
    cy.visit('http://localhost:3000/payments');
    cy.contains('button', 'Make Payment').click();
    cy.get('[style="color: red;"]').should('be.visible').contains('There are no products in cart to pay for.');
  });

  it('Payment with empty and filled inputs', () => {
    cy.visit('http://localhost:3000/products');
    cy.get('button:contains("Add to Cart")').first().click();
    cy.get('button:contains("Add to Cart")').eq(1).click();
    cy.get('button:contains("Add to Cart")').eq(1).click();

    cy.get('ul li:nth-child(4) > a').should('have.attr', 'href', '/payments').click();
    cy.contains('button', 'Make Payment').click();
    cy.get('[style="color: red;"]').should('be.visible').contains('Please fill in all the fields.');

    cy.get('input[type="text"]').eq(0).type('1234 1234 1234');
    cy.contains('button', 'Make Payment').click();
    cy.get('[style="color: red;"]').should('be.visible').contains('Please fill in all the fields.');

    cy.get('input[type="text"]').eq(1).type('11/30');
    cy.contains('button', 'Make Payment').click();
    cy.get('[style="color: green;"]').should('be.visible').contains('Payment successful!');
  });

  it('Clear cart after payment', () => {
    cy.visit('http://localhost:3000/products');
    cy.get('button:contains("Add to Cart")').first().click();
    cy.get('button:contains("Add to Cart")').eq(1).click();
    cy.get('button:contains("Add to Cart")').eq(1).click();

    cy.get('ul li:nth-child(4) > a').should('have.attr', 'href', '/payments').click();
    cy.get('input[type="text"]').eq(0).type('1234 1234 1234');
    cy.get('input[type="text"]').eq(1).type('11/30');
    cy.contains('button', 'Make Payment').click();
    cy.get('[style="color: green;"]').should('be.visible').contains('Payment successful!');
    cy.get('p').first().should('be.visible').contains('Total Amount: 0.00');
    cy.get('p').eq(2).should('be.visible').contains('No products in the cart.');
  });

    it('Payment with empty cart', () => {
    cy.visit('http://localhost:3000/payments');
    cy.contains('button', 'Make Payment').click();
    cy.get('[style="color: red;"]').should('be.visible').contains('There are no products in cart to pay for.');
  });

  it('Payment with empty and filled inputs', () => {
    cy.visit('http://localhost:3000/products');
    cy.get('button:contains("Add to Cart")').first().click();

    cy.get('ul li:nth-child(4) > a').should('have.attr', 'href', '/payments').click();
    cy.contains('button', 'Make Payment').click();
    cy.get('[style="color: red;"]').should('be.visible').contains('Please fill in all the fields.');

    cy.get('input[type="text"]').eq(0).type('1234 1234 1234');
    cy.contains('button', 'Make Payment').click();
    cy.get('[style="color: red;"]').should('be.visible').contains('Please fill in all the fields.');

    cy.get('input[type="text"]').eq(1).type('11/30');
    cy.contains('button', 'Make Payment').click();
    cy.get('[style="color: green;"]').should('be.visible').contains('Payment successful!');
  });

  it('Payment with bad expiry date', () => {
    cy.visit('http://localhost:3000/products');
    cy.get('button:contains("Add to Cart")').first().click();

    cy.get('ul li:nth-child(4) > a').should('have.attr', 'href', '/payments').click();
    cy.get('input[type="text"]').eq(0).type('1234 1234 1234');
    cy.get('input[type="text"]').eq(1).type('11/23');
    cy.contains('button', 'Make Payment').click();
    cy.get('[style="color: red;"]').should('be.visible').contains('Failed to make payment! Make sure the card is valid.');
  });

  it('Payment with incorrect expiry date', () => {
    cy.visit('http://localhost:3000/products');
    cy.get('button:contains("Add to Cart")').first().click();

    cy.get('ul li:nth-child(4) > a').should('have.attr', 'href', '/payments').click();
    cy.get('input[type="text"]').eq(0).type('1234 1234 1234');
    cy.get('input[type="text"]').eq(1).type('11 2025');
    cy.contains('button', 'Make Payment').click();
    cy.get('[style="color: red;"]').should('be.visible').contains('Failed to make payment! Make sure the card is valid.');
  });
});