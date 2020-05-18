Now that the CRUD actions have been added to the web API, it's time to test them.

1. Send an invalid HTTP POST request to the web API:

    ```bash
    curl -i -k \
        -H "Content-Type: application/json" \
        -d "{\"name\":\"Plush Squirrel\",\"price\":0.00}" \
        https://localhost:5001/products
    ```

    In the preceding command:

    * `-i` displays the HTTP response headers.
    * `-d` implies an HTTP POST operation and defines the request body.
    * `-H` indicates that the request body is in JSON format. The header's value overrides the default content type of `application/x-www-form-urlencoded`.

    The command returns an HTTP 400 status code because the controller's `[ApiController]` attribute triggers Model validation on the request body. MVC's Model binder attempts to convert the request's `-d` JSON to a `Product` object. Model validation fails because the request's `Price` value is less than the minimum value of 0.01.

    The following text represents the response:

    ```text
    HTTP/1.1 400 Bad Request
    Date: Mon, 18 May 2020 21:04:05 GMT
    Content-Type: application/problem+json; charset=utf-8
    Server: Kestrel
    Transfer-Encoding: chunked

    {
      "type": "https://tools.ietf.org/html/rfc7231#section-6.5.1",
      "title": "One or more validation errors occurred.",
      "status": 400,
      "traceId": "|34d8eb25-4f589a8a1ec12a3f.",
      "errors": {
        "Price": [
          "The field Price must be between 0.01 and 7.922816251426434E+28."
        ]
      }
    }
    ```

1. Send a valid HTTP POST request to the web API:

    ```bash
    curl -i -k \
        -H "Content-Type: application/json" \
        -d "{\"name\":\"Plush Squirrel\",\"price\":12.99}" \
        https://localhost:5001/products
    ```

    The following text represents the response:

    ```text
    HTTP/1.1 201 Created
    Date: Mon, 18 May 2020 21:07:17 GMT
    Content-Type: application/json; charset=utf-8
    Server: Kestrel
    Transfer-Encoding: chunked
    Location: https://localhost:5001/products/3

    {"id":3,"name":"Plush Squirrel","price":12.99}
    ```

    Successful creation of the product results in:

    * An HTTP 201 status code
    * A `Location` response header with a URL to retrieve the newly created product
    * A JSON representation of the newly created product

1. Send an HTTP GET request to the web API:

    ```bash
    curl -k -s https://localhost:5001/products/3 | jq
    ```

    The following output is displayed, proving that the new product was persisted to the in-memory database:

    ```json
    {
      "id": 3,
      "name": "Plush Squirrel",
      "price": 12.99
    }
    ```

1. Send an HTTP PUT request to the web API:

    ```bash
    curl -i -k \
        -X PUT \
        -H "Content-Type: application/json" \
        -d "{\"id\":2,\"name\":\"Knotted Rope\",\"price\":14.99}" \
        https://localhost:5001/products/2
    ```

    The preceding command changes the price from 12.99 to 14.99. The retailer has decided to increase the price of the Knotted Rope product.

    The following text represents the response:

    ```text
    HTTP/1.1 204 No Content
    Date: Mon, 18 May 2020 21:08:48 GMT
    Server: Kestrel
    ```

1. Send an HTTP DELETE request to the web API:

    ```bash
    curl -i -k -X DELETE https://localhost:5001/products/1
    ```

    The preceding command deletes the product from the in-memory database. The supplier for the Squeaky Bone product has filed for bankruptcy. The product can no longer be ordered and the retailer has no inventory remaining.

    The following text represents the response:

    ```text
    HTTP/1.1 204 No Content
    Date: Mon, 18 May 2020 21:09:29 GMT
    Server: Kestrel
    ```

1. Send an HTTP GET request to the web API:

    ```bash
    curl -k -s https://localhost:5001/products | jq
    ```

    The updated inventory is displayed:

    ```json
    [
      {
        "id": 2,
        "name": "Knotted Rope",
        "price": 14.99
      },
      {
        "id": 3,
        "name": "Plush Squirrel",
        "price": 12.99
      }
    ]
    ```
