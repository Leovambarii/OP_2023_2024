#!/bin/bash

BASE_URL="http://127.0.0.1:8000/api/product/"
ID=1

function test_index {
    echo -n "Testing GET request for retrieving all products ... "
    response=$(curl -s -X GET "$BASE_URL")
    # echo $response
    if [[ $response == *'"id"'* ]]; then
        echo "PASS"
    elif [[ $response == "[]" ]]; then
        echo "PASS (Empty list)"
    else
        echo "FAIL"
    fi
}

function test_show {
    echo -n "Testing GET request for retrieving a specific product ... "
    product_id="$1"
    response=$(curl -s "$BASE_URL$product_id")
    # echo $response
    if [[ $response == *'"id":'${product_id}''* ]]; then
        echo "PASS"
    else
        echo "FAIL"
    fi
}

function test_new {
    echo -n "Testing POST request for creating a new product ... "
    response=$(curl -s -X POST "$BASE_URL" \
        -H "Content-Type: application/json" \
        -d '{"name": "Test Product", "description": "Test description", "price": 100, "category": 1, "stock": 2}')
    # echo $response
    if [[ $response == *'"message":"Product created successfully"'* ]]; then
        echo "PASS"
    else
        echo "FAIL"
    fi
}

function test_edit {
    echo -n "Testing PUT request for updating an existing product ... "
    product_id="$1"
    response=$(curl -s -X PUT "$BASE_URL$product_id" \
        -H "Content-Type: application/json" \
        -d '{"name": "Updated Product", "price": 200}')
    # echo $response
    if [[ $response == *'"Updated Product"'*'"price":200'* ]]; then
        echo "PASS"
    else
        echo "FAIL"
    fi
}

function test_delete {
    echo -n "Testing DELETE request for deleting an existing product ... "
    product_id="$1"
    response=$(curl -s -X DELETE "$BASE_URL$product_id")
    # echo $response
    if [[ $response == *'"message":"Product deleted successfully"'* ]]; then
        echo "PASS"
    else
        echo "FAIL"
    fi
}

# Main function to run all tests
function main {
    cp symfony_project/var/data.db symfony_project/var/data_org.db
    sqlite3 symfony_project/var/data.db "
    DROP TABLE product;
    CREATE TABLE product (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name VARCHAR(255) NOT NULL,
        description VARCHAR(255) NOT NULL,
        price DOUBLE PRECISION NOT NULL,
        category INTEGER NOT NULL,
        stock INTEGER NOT NULL)
    "

    test_new
    test_index
    test_show $ID
    test_edit $ID
    test_delete $ID

    mv symfony_project/var/data_org.db symfony_project/var/data.db
}

main
