#!/bin/bash

PRODUCT_URL="http://localhost:8000/product"
HEADER="Content-Type: application/json"
ID=1

echo "Testing GET request for retrieving all products..."
curl -X GET -s -o /dev/null -w "Response Code: %{response_code}\n" $PRODUCT_URL/
echo ""

echo "Testing GET request for retrieving a specific product..."
curl -X GET -s -o /dev/null -w "Response Code: %{response_code}\n" $PRODUCT_URL/$ID
echo ""

echo "Testing POST request for creating a new product..."
curl -X POST \
    -H $HEADER \
    -d '{"name": "New Product Test", "description": "Testing POST!", "category": 1, "price": 150, "stock": 50}' \
    -s -o /dev/null -w "Response Code: %{response_code}\n" $PRODUCT_URL
echo ""

echo "Testing PUT request for updating an existing product..."
curl -X PUT \
    -H "Content-Type: application/json" \
    -d '{"name": "Updated Product", "description": "Updated description", "category": 2, "price": 15, "stock": 1}' \
    -s -o /dev/null -w "Response Code: %{response_code}\n" $PRODUCT_URL/1
echo ""

echo "Testing DELETE request for deleting an existing product..."
curl -X DELETE -s -o /dev/null -w "Response Code: %{response_code}\n" $PRODUCT_URL/1
echo ""
