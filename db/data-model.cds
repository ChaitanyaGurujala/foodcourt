using{managed, cuid} from '@sap/cds/common';

namespace foodcourt101;


type AmountT: Decimal(10,2);
type CurrencyT: String(3);
type FoodTypeT: String(2);
type EmailAddress: String(100) @assert.format:'email';

type OrderStatusT : String(15) enum {
    InProgress;  
    Completed;   
    Cancelled;    
}

type OrdertypeT : String(15) enum {
    DineIn;
    Takeout;
}



entity Products: cuid, managed {
    name: String(30) @mandatory;
    description: String(60) @mandatory;
    unitPrice: AmountT;
    currency: CurrencyT;
    foodType: FoodTypeT;
    salesItems: Association to many SalesOrderItems on salesItems.product=$self;

}

entity Customers: cuid, managed {
    name: String(30)@mandatory;
    phoneNumber: String(10)@mandatory;
    email:EmailAddress;
}

entity SalesOrders: cuid, managed {
    orderNumber: String(15) @readonly; // Auto-generated order number
    customer: Association to one Customers;
    totalAmount: AmountT;
    currency: CurrencyT;
    status: OrderStatusT @default: 'InProgress';
    Ordertype: OrdertypeT;
    items: Composition of many SalesOrderItems on items.salesOrder = $self;
}

entity SalesOrderItems: cuid, managed {
    salesOrder: Association to one SalesOrders;
    product: Association to one Products;
    quantity: Integer @assert.range:[1,null];
    unitPrice: AmountT;
}

entity OrderCounters {
    date: Date @key;
    lastNumber: Integer;
}



entity OrderItemsWithProductView as select from SalesOrderItems {
    key ID,
    salesOrder.orderNumber as orderNumber,
    quantity,
    unitPrice,
    product.name as productName,
    product.description as productDescription
}





