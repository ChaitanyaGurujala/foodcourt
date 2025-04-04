using {foodcourt101 as db} from '../db/data-model';

service Foodcourt101service {
    entity FoodList as projection on db.Products;
    entity CustomerList as projection on db.Customers;
     entity OrderList as projection on db.SalesOrders;
  @cds.redirection.target  entity OrderListItems as projection on db.SalesOrderItems;
    entity OpenOrders as projection on db.OrderItemsWithProductView;
}

