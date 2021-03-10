There is one last operation we need to look at before our new model is complete. Our last operation is to query our top 10 customers by the number of sales orders. In our current model we first need to do a group by on each customer and sum for sales orders in our customer container, then sort in descending order and take the top 10 results. Even though customers and sales orders sit in the same container, this is not something you can currently do.

The solution here is to denormalize and create a new property in the customer document, 'salesOrderCount'. This will allow us to now write a query like this one below to get this data.

    :::image type="content" source="../media/sales-order-count.png" alt-text="sales order count by customer":::

Next we now need a way where every time a customer creates a new sales order and a new sales order is inserted into our customer container, we update the customer document and increment the salesOrderCount property by one. To do this we need a transaction. Azure Cosmos DB supports transactions when the data sits within the same logical partition. Since the customer and sales order all reside in the same logical partition we can take advantage of this and put the insert of the new sales order and update of the customer document within a transaction. There are two choices for implementing transactions in Azure Cosmos DB, stored procedures or using a feature called Transactional Batch available in both .NET or Java SDKs.

    :::image type="content" source="../media/sales-order-customer-transaction.png" alt-text="sales order and customer transaction":::
