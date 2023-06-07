//
// loading data model 
//

MATCH (crmdb:DBSchema {name:'CRM'})

MATCH (erpdb:DBSchema {name:'ERP'})

MATCH (dwdb:DBSchema {name:"DW"})

//
// DW tables
//

CREATE (catalog:Table {name : 'DWH.ProductCatalog'})

CREATE (catalog)-[:STORED_IN]->(dwdb)

CREATE (dwhID:Column {name :'DWH.ProductCatalog.ID'})

CREATE (dwhName:Column {name :'DWH.ProductCatalog.Name'})

CREATE (dwhCost:Column {name :'DWH.ProductCatalog.Cost'})

CREATE (dwhPrice:Column {name :'DWH.ProductCatalog.Price'})

CREATE (dwhID)-[:OWNED_BY]->(catalog)

CREATE (dwhName)-[:OWNED_BY]->(catalog)

CREATE (dwhCost)-[:OWNED_BY]->(catalog)

CREATE (dwhPrice)-[:OWNED_BY]->(catalog)



//
// Tables modelled CRM : Account (and when there is more time:, Address, Order, OrderLine, Product)
// Tables modelled ERP : Party, (and when there is more time:, Addres, SalesOrder, SalesOrderLine, Product)
//

CREATE (cust:Table {name:'CRM.Account'})

CREATE (cust)-[:STORED_IN]->(crmdb)

CREATE (addr:Table {name:'CRM.Address'})

CREATE (addr)-[:STORED_IN]->(crmdb)

CREATE (order:Table {name:'CRM.Order'})

CREATE (order)-[:STORED_IN]->(crmdb)

CREATE (ordl:Table {name:'CRM.Orderline'})

CREATE (ordl)-[:STORED_IN]->(crmdb)

CREATE (prd:Table {name:'CRM.Product'})

CREATE (prd)-[:STORED_IN]->(crmdb)

CREATE (party:Table {name:'ERP.Party'})

CREATE (party)-[:STORED_IN]->(erpdb)

CREATE (eaddr:Table {name:'ERP.Address'})

CREATE (eaddr)-[:STORED_IN]->(erpdb)

CREATE (ord:Table {name:'ERP.Order'})

CREATE (ord)-[:STORED_IN]->(erpdb)

CREATE (eordl:Table {name:'ERP.Orderline'})

CREATE (eordl)-[:STORED_IN]->(erpdb)

CREATE (eprd:Table {name:'ERP.Product'})

CREATE (eprd)-[:STORED_IN]->(erpdb)


//
// CRM Customer Table (Account)
//

CREATE (accID:Column {name: 'CRM.Account.ID'})

CREATE (accID)-[:OWNED_BY]->(cust)

CREATE (accName:Column {name: 'CRM.Account.Name'})

CREATE (accName)-[:OWNED_BY]->(cust)

CREATE (accWebSite:Column {name: 'CRM.Account.WebsSite'})

CREATE (accWebSite)-[:OWNED_BY]->(cust)

CREATE (accDUNS:Column {name: 'CRM.Account.DUNS'})

CREATE (accDUNS)-[:OWNED_BY]->(cust)

CREATE (accVis:Column {name: 'CRM.Account.VisitAddressID'})

CREATE (accVis)-[:BELONGS_TO]->(cust)

//
// CRM Product table columns
//
CREATE (prdID:Column {name: 'CRM.Product.ID'})

CREATE (prdID)-[:OWNED_BY]->(prd)

CREATE (prdName:Column {name: 'CRM.Product.Name'})

CREATE (prdName)-[:OWNED_BY]->(prd)

CREATE (prdSalesPrice:Column {name: 'CRM.Product.SalesPrice'})

CREATE (prdSalesPrice)-[:OWNED_BY]->(prd)

//
// CRM Address columns
//
CREATE (adrID:Column {name:'CRM.Address.ID'})

CREATE (adrID)-[:OWNED_BY]->(addr)


CREATE (adrLine1:Column {name:'CRM.Address.line1'})

CREATE (adrLine1)-[:OWNED_BY]->(addr)

CREATE (adrLine2:Column {name:'CRM.Address.line2'})

CREATE (adrLine2)-[:OWNED_BY]->(addr)

CREATE (adrZip:Column {name:'CRM.Address.ZipCode'})

CREATE (adrZip)-[:OWNED_BY]->(addr)

CREATE (adrCity:Column {name:'CRM.Address.City'})

CREATE (adrCity)-[:OWNED_BY]->(addr)

CREATE (adrCountry:Column {name:'CRM.Address.Country'})

CREATE (adrCountry)-[:OWNED_BY]->(addr)


// customer -> address
CREATE (accVis)-[:FK_TO]->(adrID)

//
// CRM Order columns
//
CREATE (ordID:Column {name:'CRM.Order.ID', type:'number'})
CREATE (ordID)-[:OWNED_BY]->(order)

CREATE (ordDate:Column {name:'CRM.Order.OrderDate', type:'date'})
CREATE (ordDate)-[:OWNED_BY]->(order)

CREATE (ordTotal:Column {name:'CRM.Order.OrderTotal', type:'number'})
CREATE (ordTotal)-[:OWNED_BY]->(order)

CREATE (ordDisc:Column {name:'CRM.Order.OrderDiscount', type:'number'})
CREATE (ordDisc)-[:OWNED_BY]->(order)

CREATE (ordBillingAdr:Column {name:'CRM.Order.BillingAddressID', type:'number'})
CREATE (ordBillingAdr)-[:BELONGS_TO]->(order)

CREATE (ordCust:Column {name:'CRM.Order.AccountID', type:'number'})
CREATE (ordCust)-[:BELONGS_TO]->(order)

// order -> billing address
CREATE (ordBillingAdr)-[:BELONGS_TO]->(adrID)

// order - customer
CREATE (ordCust)-[:FK_TO]->(accID)

//
// CRM Order Line Columns
//
CREATE (ordlOrdID:Column {name:'CRM.OrderLine.OrderID', type:'long'})
CREATE (ordlOrdID)-[:BELONGS_TO]->(ordl)

CREATE (ordlLinePos:Column {name:'CRM.OrderLine.LinePos', type:'int'})
CREATE (ordlLinePos)-[:OWNED_BY]->(ordl)

CREATE (ordlLineAmt:Column {name:'CRM.OrderLine.Amount', type:'number'})
CREATE (ordlLineAmt)-[:OWNED_BY]->(ordl)

CREATE (ordlPrdID:Column {name:'CRM.OrderLine.ProductID', type:'number'})
CREATE (ordlPrdID)-[:BELONGS_TO]->(ordl)

CREATE (ordlQty:Column {name:'CRM.orderLine.Quantity', type:'number'})
CREATE (ordlQty)-[:OWNED_BY]->(ordl)
// 
// order line -> order 
//
CREATE (ordlOrdID)-[:FK_TO]->(ordID)
// order line -> product
CREATE (ordlPrdID)-[:FK_TO]->(prdID)

//
// ERP Party Table 
//

CREATE (partyID:Column {name: 'ERP.Party.ID'})

CREATE (partyID)-[:OWNED_BY]->(party)

CREATE (partyFName:Column {name: 'ERP.Party.FirstName'})

CREATE (partyFName)-[:OWNED_BY]->(party)

CREATE (partyLName:Column {name: 'ERP.Party.LastName'})

CREATE (partyLName)-[:OWNED_BY]->(party)

CREATE (partyWebSite:Column {name: 'ERP.Party.website'})

CREATE (partyWebSite)-[:OWNED_BY]->(party)

CREATE (partyDUNS:Column {name: 'ERP.Party.DUNS'})

CREATE (partyDUNS)-[:OWNED_BY]->(party)

CREATE (partyCC:Column {name: 'ERP.Party.CreditCheck'})

CREATE (partyCC)-[:OWNED_BY]->(party)

CREATE (partyVis:Column {name: 'ERP.Party.VisitAddressID'})

CREATE (partyVis)-[:BELONGS_TO]->(party)

//
// ERP Product table columns
//
CREATE (eprdID:Column {name: 'ERP.Product.ID'})

CREATE (eprdID)-[:OWNED_BY]->(eprd)

CREATE (eprdName:Column {name: 'ERP.Product.Name'})

CREATE (eprdName)-[:OWNED_BY]->(eprd)

CREATE (eprdSalesPrice:Column {name: 'ERP.Product.Price'})

CREATE (eprdSalesPrice)-[:OWNED_BY]->(eprd)

CREATE (eprdCost:Column {name: 'ERP.Product.Cost'})

CREATE (eprdCost)-[:OWNED_BY]->(eprd)

//
// ERP Address columns
//
CREATE (eadrID:Column {name:'ERP.Address.ID'})

CREATE (eadrID)-[:OWNED_BY]->(eaddr)


CREATE (eadrLine1:Column {name:'ERP.Address.line1'})

CREATE (eadrLine1)-[:OWNED_BY]->(eaddr)

CREATE (eadrLine2:Column {name:'ERP.Address.line2'})

CREATE (eadrLine2)-[:OWNED_BY]->(eaddr)

CREATE (eadrZip:Column {name:'ERP.Address.ZipCode'})

CREATE (eadrZip)-[:OWNED_BY]->(eaddr)

CREATE (eadrCity:Column {name:'ERP.Address.City'})

CREATE (eadrCity)-[:OWNED_BY]->(eaddr)

CREATE (eadrCountry:Column {name:'ERP.Address.Country'})

CREATE (eadrCountry)-[:OWNED_BY]->(eaddr)

//
// Party Visit Address -> address
//
CREATE (partyVis)-[:FK_TO]->(eadrID)


//
// ERP Order columns
//
CREATE (eordID:Column {name:'ERP.SalesOrder.ID', type:'long'})
CREATE (eordID)-[:OWNED_BY]->(ord)

CREATE (eordDate:Column {name:'ERP.SalesOrder.OrderDate', type:'date'})
CREATE (eordDate)-[:OWNED_BY]->(ord)

CREATE (eordTotal:Column {name:'ERP.SalesOrder.OrderTotal', type:'number'})
CREATE (eordTotal)-[:OWNED_BY]->(ord)

CREATE (eordDeliveryDate:Column {name:'ERP.SalesOrder.DeliveryDate', type:'date'})
CREATE (eordDeliveryDate)-[:OWNED_BY]->(ord)

CREATE (eordBillingAdr:Column {name:'ERP.SalesOrder.BillingAddressID', type:'number'})
CREATE (eordBillingAdr)-[:BELONGS_TO]->(ord)

CREATE (eordDevliveryAdr:Column {name:'ERP.SalesOrder.DeliveryAddressID', type:'number'})
CREATE (eordDevliveryAdr)-[:BELONGS_TO]->(ord)

CREATE (eordCust:Column {name:'ERP.SalesOrder.PartyID', type:'number'})
CREATE (eordCust)-[:BELONGS_TO]->(ord)

//
// Order -> Party
//
CREATE (eordCust)-[:FK_TO]->(partyID)
//
// Order Billing Address - Address
//
CREATE (eordBillingAdr)-[:FK_TO]->(eadrID)
//
// Order Delivery Address - Address
//
CREATE (eordDevliveryAdr)-[:FK_TO]->(eadrID)


//
// ERP Order Line Columns
//
CREATE (eordlOrdID:Column {name:'ERP.OrderLine.OrderID', type:'long'})
CREATE (eordlOrdID)-[:BELONGS_TO]->(eordl)

CREATE (eordlLinePos:Column {name:'ERP.OrderLine.LinePos', type:'int'})
CREATE (eordlLinePos)-[:OWNED_BY]->(eordl)

CREATE (eordlLineAmt:Column {name:'ERP.OrderLine.Amount', type:'number'})
CREATE (eordlLineAmt)-[:OWNED_BY]->(eordl)

CREATE (eordlPrdID:Column {name:'ERP.OrderLine.ProductID', type:'number'})
CREATE (eordlPrdID)-[:BELONGS_TO]->(eordl)

CREATE (eordlQty:Column {name:'ERP.orderLine.Quantity', type:'number'})
CREATE (eordlQty)-[:OWNED_BY]->(eordl)
//
// Order line -> order
//
CREATE (eordlOrdID)-[:FK_TO]->(eordID)
//
// Order Line -> PRODUCT
//
CREATE (eordlPrdID)-[:FK_TO]->(eprdID)

//
// DataDomain
// and
// 
// RuleCheck (will be linked to BusinessRule later 
//
CREATE (ddOid:DataDomain {name: 'OID', type:'long'})

CREATE (ddOid)-[:DOMAIN_FOR]->(accID)

CREATE (ddOid)-[:DOMAIN_FOR]->(prdID)

CREATE (ddOid)-[:DOMAIN_FOR]->(adrID)

CREATE (ddOid)-[:DOMAIN_FOR]->(ordID)

CREATE (ddOid)-[:DOMAIN_FOR]->(ordlOrdID)

CREATE (ddOid)-[:DOMAIN_FOR]->(partyID)

CREATE (ddOid)-[:DOMAIN_FOR]->(eprdID)

CREATE (ddOid)-[:DOMAIN_FOR]->(eadrID)

CREATE (ddOid)-[:DOMAIN_FOR]->(eordID)

CREATE (ddOid)-[:DOMAIN_FOR]->(eordlOrdID)

CREATE (rcAddress:RuleCheck {name : "Address Rule" })

CREATE (rcAddress)-[:CHECKS]->(eadrLine1)

CREATE (rcAddress)-[:CHECKS]->(eadrLine2)

CREATE (rcAddress)-[:CHECKS]->(eadrZip)

CREATE (rcAddress)-[:CHECKS]->(eadrCity)

CREATE (rcAddress)-[:CHECKS]->(eadrCountry)

CREATE (rcAddress)-[:CHECKS]->(adrLine1)

CREATE (rcAddress)-[:CHECKS]->(adrLine2)

CREATE (rcAddress)-[:CHECKS]->(adrZip)

CREATE (rcAddress)-[:CHECKS]->(adrCity)

CREATE (rcAddress)-[:CHECKS]->(adrCountry)

CREATE (rcOrderPrice:RuleCheck {name:"OrderPrice"})

CREATE (rcOrderPrice)-[:CHECKS]->(ordTotal)

CREATE (rcOrderPrice)-[:CHECKS]->(ordDisc)

CREATE (rcOrderPrice)-[:CHECKS]->(ordlQty)

CREATE (rcOrderPrice)-[:CHECKS]->(ordlLineAmt)

CREATE (rcOrderPrice)-[:CHECKS]->(prdSalesPrice)

CREATE (rcMargin:RuleCheck {name:"Margin Check"})

CREATE (rcMargin)-[:CHECKS]->(eprdSalesPrice)

CREATE (rcMargin)-[:CHECKS]->(eprdCost)

CREATE (rcMargin)-[:CHECKS]->(prdSalesPrice)



;

