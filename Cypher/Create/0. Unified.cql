//
// Create DataCenters
//
CREATE (dc1:DataCenter {name : 'Atown East'})
CREATE (dc2:DataCenter {name : 'The Village'}) 

//
// create network segment DMZ - Office Lan
//
CREATE (dmz:NetworkSegment {name :'DMZ' ,capacity:1000})
CREATE (olan:NetworkSegment {name :'Office LAN' ,capacity:10000})

//
// create Applications 
// 
CREATE (crm1:Application { ip:'192.168.32.1', host:'CRM-APPLICATION', type: 'APPLICATION', system: 'CRM'}) 
CREATE (erp1:Application { ip:'192.168.33.1', host:'ERP-APPLICATION', type: 'APPLICATION', system: 'ERP'}) 
CREATE (datawarehouse1:Application { ip:'192.168.34.1', host:'DATA-WAREHOUSE', type: 'DATABASE',system: 'DW'}) 

//
// office lan
//
// Create internal websites
//
CREATE (Intranet1:Intranet {ip:'192.168.35.2',host:'events.acme.net',type: "APPLICATION",system: "INTRANET"}) 
CREATE (Intranet2:Intranet {ip:'192.168.35.3',host:'intranet.acme.net',type: "APPLICATION",system: "INTRANET"}) 
CREATE (Intranet3:Intranet {ip:'192.168.35.4',host:'humanresources.acme.net',type: "APPLICATION",system: "INTRANET"}) 

CREATE (olan)<-[:NETWORK_ACCESS {athroughput:100 ,pthroughput:700  }]-(Intranet1)
CREATE (olan)<-[:NETWORK_ACCESS {athroughput:800 ,pthroughput:1200 }]-(Intranet2)
CREATE (olan)<-[:NETWORK_ACCESS {athroughput:50  ,pthroughput:150}]-(Intranet3)


// Create Database VM 1
CREATE (customerdatabase1:VirtualMachine {ip:'192.168.35.7', host:'CUSTOMER-DB-1',type: "DATABASE SERVER", system: "VIRTUAL MACHINE"}) 

CREATE (olan)<-[:NETWORK_ACCESS {athroughput:200 ,pthroughput:250}]-(customerdatabase1)


// Create Database VM 2
CREATE (customerdatabase2:VirtualMachine {ip:'192.168.35.8', host:'CUSTOMER-DB-2',type: "DATABASE SERVER",system: "VIRTUAL MACHINE"}) 

CREATE (olan)<-[:NETWORK_ACCESS {athroughput:100 ,pthroughput:200}]-(customerdatabase2)


// Create Database VM 3
CREATE (databasevm3:VirtualMachine {ip:'192.168.35.9',host:'ERP-DB',type: "DATABASE SERVER",system: "VIRTUAL MACHINE"}) 

CREATE (olan)<-[:NETWORK_ACCESS {athroughput:800 ,pthroughput:900}]-(databasevm3)

// Create Database VM 4
CREATE (dwdatabase:VirtualMachine {ip:'192.168.35.10',host:'DW-DATABASE',type: "DATABASE SERVER",system: "VIRTUAL MACHINE"}) 

CREATE (olan)<-[:NETWORK_ACCESS {athroughput:400 ,pthroughput:600}]-(dwdatabase)


// Create Hardware 1
CREATE (hardware1:Server {ip:'192.168.35.11',host:'HARDWARE-SERVER-1',type: "HARDWARE SERVER", system: "PHYSICAL INFRASTRUCTURE"}) 

CREATE (olan)<-[:NETWORK_ACCESS {athroughput:100 ,pthroughput:150}]-(hardware1)


// Create Hardware 2
CREATE (hardware2:Server {ip:'192.168.35.12',host:'HARDWARE-SERVER-2',type: "HARDWARE SERVER",system: "PHYSICAL INFRASTRUCTURE"}) 

CREATE (olan)<-[:NETWORK_ACCESS {athroughput:100 ,pthroughput:160}]-(hardware2)

// Create Hardware 3
CREATE (hardware3:Server {ip:'192.168.35.13',host:'HARDWARE-SERVER-3',type: "HARDWARE SERVER",system: "PHYSICAL INFRASTRUCTURE"}) 

CREATE (olan)<-[:NETWORK_ACCESS {athroughput:200 ,pthroughput:330}]-(hardware3)

// Create SAN 1
CREATE (san1:Storage {ip:'192.168.35.14',host:'SAN1',type: "STORAGE AREA NETWORK",system: "PHYSICAL INFRASTRUCTURE"}) 

CREATE (olan)<-[:NETWORK_ACCESS {athroughput:900 ,pthroughput:1100}]-(san1)

// Create SAN 2

CREATE (san2:Storage {ip:'192.168.35.44',host:'SAN2',type: "STORAGE AREA NETWORK",system: "PHYSICAL INFRASTRUCTURE"}) 

CREATE (olan)<-[:NETWORK_ACCESS {athroughput:800, pthroughput:700}]-(san2)


// Create CRM_SCHEMA
CREATE (crmschema:DBSchema {name:"CRM"})
// Create ERP_SCHEMA
CREATE (erpschema:DBSchema {name:"ERP"})
// Create DW_SCHEMA
CREATE (dwschema:DBSchema {name:"DW"})

// DMZ applications
// Create Public Website 1
CREATE (Internet1:Internet {ip:'10.10.35.1',host:'global.acme.com',type: "APPLICATION",system: "INTERNET"}) 

CREATE (dmz)<-[:NETWORK_ACCESS {athroughput:25 ,pthroughput:125}]-(Internet1)

// Create Public Website 2
CREATE (Internet2:Internet {ip:'10.10.35.2',host:'support.acme.com',type: "APPLICATION",system: "INTERNET"}) 

CREATE (dmz)<-[:NETWORK_ACCESS {athroughput:20 ,pthroughput:300}]-(Internet2)

// Create Public Website 3
CREATE (Internet3:Internet {ip:'10.10.35.3',host:'shop.acme.com',type: "APPLICATION",system: "INTERNET"}) 

CREATE (dmz)<-[:NETWORK_ACCESS {athroughput:220 ,pthroughput:454}]-(Internet3)

// Create Public Website 4
CREATE (Internet4:Internet {ip:'10.10.35.4',host:'training.acme.com',type: "APPLICATION",system: "INTERNET"}) 

CREATE (dmz)<-[:NETWORK_ACCESS {athroughput:55 ,pthroughput:130}]-(Internet4)

// Create Public Website 5
CREATE (Internet5:Internet {ip:'10.10.35.1',host:'partners.acme.com',type: "APPLICATION",system: "INTERNET"}) 

CREATE (dmz)<-[:NETWORK_ACCESS {athroughput:35 ,pthroughput:128}]-(Internet5)

// Create Webserver VM 1
CREATE (webservervm1:VirtualMachine {ip:'10.10.35.5',host:'WEBSERVER-1',type: "WEB SERVER",system: "VIRTUAL MACHINE"}) 

CREATE (dmz)<-[:NETWORK_ACCESS {athroughput:89 ,pthroughput:100}]-(webservervm1)

// Create Webserver VM 2
CREATE (webservervm2:VirtualMachine {ip:'10.10.35.6',host:'WEBSERVER-2',type: "WEB SERVER",system: "VIRTUAL MACHINE"}) 

CREATE (dmz)<-[:NETWORK_ACCESS {athroughput:67 ,pthroughput:95}]-(webservervm2)

// Connect the server's with the datacentre, note that the SAN 'service' is running in both data centers
CREATE (san1)-[:LOCATED_IN]->(dc1)
CREATE (san2)-[:LOCATED_IN]->(dc2)

CREATE (hardware1)-[:LOCATED_IN]->(dc1)
CREATE (hardware2)-[:LOCATED_IN]->(dc2)
CREATE (hardware3)-[:LOCATED_IN]->(dc2)

// Connect CRM to CRM_SCHEMA 
CREATE (crm1)-[:DEPENDS_ON]->(crmschema) 

// Connect CRM_SCHEMA to Database VM 1
CREATE (crmschema)-[:DEPENDS_ON]->(customerdatabase1) 


// Connect Public Websites 1-3 to Database VM 1
CREATE  (Internet1)-[:DEPENDS_ON]->(customerdatabase1),(Internet2)-[:DEPENDS_ON]->(customerdatabase1),(Internet3)-[:DEPENDS_ON]->(customerdatabase1) 

// Connect Database VM 1 to Hardware 1
CREATE  (customerdatabase1)-[:DEPENDS_ON]->(hardware1) 

// Connect Hardware 1 to SAN 1
CREATE  (hardware1)-[:DEPENDS_ON]->(san1) 

// Connect Public Websites 1-3 to Webserver VM 1
CREATE  (webservervm1)<-[:DEPENDS_ON]-(Internet1),(webservervm1)<-[:DEPENDS_ON]-(Internet2),(webservervm1)<-[:DEPENDS_ON]-(Internet3) 

// Connect Internal Websites 1-3 to Webserver VM 1
CREATE  (webservervm1)<-[:DEPENDS_ON]-(Intranet1),(webservervm1)<-[:DEPENDS_ON]-(Intranet2),(webservervm1)<-[:DEPENDS_ON]-(Intranet3) 

// Connect Webserver VM 1 to Hardware 2
CREATE  (webservervm1)-[:DEPENDS_ON]->(hardware2) 

// Connect Hardware 2 to SAN 1
CREATE  (hardware2)-[:DEPENDS_ON]->(san2) 

// Connect Webserver VM 2 to Hardware 2
CREATE  (webservervm2)-[:DEPENDS_ON]->(hardware2) 

// Connect Public Websites 4-6 to Webserver VM 2
CREATE  (webservervm2)<-[:DEPENDS_ON]-(Internet4),(webservervm2)<-[:DEPENDS_ON]-(Internet5) 

// Connect Database VM 2 to Hardware 2
CREATE  (hardware2)<-[:DEPENDS_ON]-(customerdatabase2) 

// Connect Public Websites 4-5 to Database VM 2
CREATE  (Internet4)-[:DEPENDS_ON]->(customerdatabase2),(Internet5)-[:DEPENDS_ON]->(customerdatabase2) 

// Connect Hardware 3 to SAN 1
CREATE  (hardware3)-[:DEPENDS_ON]->(san1) 

// Connect Database VM 3 to Hardware 3
CREATE  (hardware3)<-[:DEPENDS_ON]-(databasevm3) 

// Connect ERP 1 to ERP_SCHEMA
CREATE  (erp1)-[:DEPENDS_ON]->(erpschema) 

// Connect ERP_SCHEMA to Database VM 3
CREATE  (erpschema)-[:DEPENDS_ON]->(databasevm3) 

// Connect Database VM 4 to Hardware 3
CREATE  (hardware3)<-[:DEPENDS_ON]-(dwdatabase) 

// Connect Data Warehouse 1 to DW_SCHEMA
CREATE  (datawarehouse1)-[:DEPENDS_ON]->(dwschema) 

// Connect DW_SCHEMA to Database VM 4
CREATE  (dwschema)-[:DEPENDS_ON]->(dwdatabase) 
;


////////////////////////////////////////////////////////////

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

//////////////////////////////////////////

//
// Load Entitlements
//
MATCH (cust:Table {name:'CRM.Account'})
MATCH (addr:Table {name:'CRM.Address'})

MATCH (order:Table {name:'CRM.Order'})
MATCH (ordl:Table {name:'CRM.Orderline'})
MATCH (prd:Table {name:'CRM.Product'})

MATCH (party:Table {name:'ERP.Party'})

MATCH (eaddr:Table {name:'ERP.Address'})

MATCH (ord:Table {name:'ERP.Order'})

MATCH (eordl:Table {name:'ERP.Orderline'})

MATCH (eprd:Table {name:'ERP.Product'})

MATCH (catalog:Table {name : 'DWH.ProductCatalog'})


//
// Entitlements user 1,2,3,4
// Groups: Sales (u1,u2), Report (u2,u3), BackOffice (u2,u4)
// Role: Admin (u3)
//
CREATE (u1:User {name:'User1'})

CREATE (u2:User {name:'User2'})

CREATE (u3:User {name:'User3'})

CREATE (u4:User {name:'User4'})

CREATE (salesgroup:Group {name:'Group Sales'})

CREATE (reportgroup:Group {name: 'Group Report'})

CREATE (backofficegroup:Group {name: 'Group BackOffice'})

CREATE (adminrole:Role {name: 'Role Admin'})

CREATE (u1)-[:MEMBER]->(salesgroup)
CREATE (u2)-[:MEMBER]->(salesgroup)

CREATE (u2)-[:MEMBER]->(reportgroup)
CREATE (u3)-[:MEMBER]->(reportgroup)

CREATE (u3)-[:CAN_ASSUME]->(adminrole)

CREATE (u4)-[:MEMBER]->(backofficegroup)

//
// CRUD rights every right has an own relationship which is easier to query
// sales has focus on crm, backoffice has focus on erp
//
CREATE (salesgroup)-[:CREATE]->(cust)
CREATE (salesgroup)-[:CREATE]->(addr)
CREATE (salesgroup)-[:CREATE]->(order)
CREATE (salesgroup)-[:CREATE]->(ordl)
CREATE (salesgroup)-[:READ]->(cust)
CREATE (salesgroup)-[:READ]->(addr)
CREATE (salesgroup)-[:READ]->(order)
CREATE (salesgroup)-[:READ]->(ordl)
CREATE (salesgroup)-[:READ]->(prd)
CREATE (salesgroup)-[:UPDATE]->(cust)
CREATE (salesgroup)-[:UPDATE]->(addr)
CREATE (salesgroup)-[:UPDATE]->(order)
CREATE (salesgroup)-[:UPDATE]->(ordl)
CREATE (salesgroup)-[:READ]->(catalog)

CREATE (reportgroup)-[:READ]->(cust)
CREATE (reportgroup)-[:READ]->(addr)
CREATE (reportgroup)-[:READ]->(order)
CREATE (reportgroup)-[:READ]->(ordl)
CREATE (reportgroup)-[:READ]->(prd)
CREATE (reportgroup)-[:READ]->(catalog)



CREATE (reportgroup)-[:READ]->(party)
CREATE (reportgroup)-[:READ]->(eaddr)
CREATE (reportgroup)-[:READ]->(ord)
CREATE (reportgroup)-[:READ]->(eordl)
CREATE (reportgroup)-[:READ]->(eprd)

CREATE (backofficegroup)-[:READ]->(cust)
CREATE (backofficegroup)-[:READ]->(addr)
CREATE (backofficegroup)-[:READ]->(order)
CREATE (backofficegroup)-[:READ]->(ordl)
CREATE (backofficegroup)-[:READ]->(prd)
CREATE (backofficegroup)-[:READ]->(catalog)

CREATE (backofficegroup)-[:READ]->(party)
CREATE (backofficegroup)-[:READ]->(eaddr)
CREATE (backofficegroup)-[:READ]->(ord)
CREATE (backofficegroup)-[:READ]->(eordl)
CREATE (backofficegroup)-[:READ]->(eprd)

CREATE (backofficegroup)-[:CREATE]->(party)
CREATE (backofficegroup)-[:CREATE]->(eaddr)
CREATE (backofficegroup)-[:UPDATE]->(eaddr)
CREATE (backofficegroup)-[:UPDATE]->(ord)
CREATE (backofficegroup)-[:UPDATE]->(eordl)
CREATE (backofficegroup)-[:UPDATE]->(eprd)





CREATE (adminrole)-[:CREATE]->(cust)
CREATE (adminrole)-[:CREATE]->(addr)
CREATE (adminrole)-[:CREATE]->(order)
CREATE (adminrole)-[:CREATE]->(ordl)
CREATE (adminrole)-[:CREATE]->(prd)
CREATE (adminrole)-[:CREATE]->(catalog)


CREATE (adminrole)-[:READ]->(cust)
CREATE (adminrole)-[:READ]->(addr)
CREATE (adminrole)-[:READ]->(order)
CREATE (adminrole)-[:READ]->(ordl)
CREATE (adminrole)-[:READ]->(prd)
CREATE (adminrole)-[:READ]->(catalog)

CREATE (adminrole)-[:UPDATE]->(cust)
CREATE (adminrole)-[:UPDATE]->(addr)
CREATE (adminrole)-[:UPDATE]->(order)
CREATE (adminrole)-[:UPDATE]->(ordl)
CREATE (adminrole)-[:UPDATE]->(prd)
CREATE (adminrole)-[:UPDATE]->(catalog)

CREATE (adminrole)-[:DELETE]->(cust)
CREATE (adminrole)-[:DELETE]->(addr)
CREATE (adminrole)-[:DELETE]->(order)
CREATE (adminrole)-[:DELETE]->(ordl)
CREATE (adminrole)-[:DELETE]->(catalog)
CREATE (adminrole)-[:DELETE]->(prd)

CREATE (adminrole)-[:CREATE]->(party)
CREATE (adminrole)-[:CREATE]->(eaddr)
CREATE (adminrole)-[:CREATE]->(ord)
CREATE (adminrole)-[:CREATE]->(eordl)
CREATE (adminrole)-[:CREATE]->(eprd)


CREATE (adminrole)-[:READ]->(party)
CREATE (adminrole)-[:READ]->(eaddr)
CREATE (adminrole)-[:READ]->(ord)
CREATE (adminrole)-[:READ]->(eordl)
CREATE (adminrole)-[:READ]->(eprd)


CREATE (adminrole)-[:UPDATE]->(party)
CREATE (adminrole)-[:UPDATE]->(eaddr)
CREATE (adminrole)-[:UPDATE]->(ord)
CREATE (adminrole)-[:UPDATE]->(eordl)
CREATE (adminrole)-[:UPDATE]->(eprd)


CREATE (adminrole)-[:DELETE]->(party)
CREATE (adminrole)-[:DELETE]->(eaddr)
CREATE (adminrole)-[:DELETE]->(ord)
CREATE (adminrole)-[:DELETE]->(eordl)
CREATE (adminrole)-[:DELETE]->(eprd)



;




///////////////////////////
//4
///////////////////////////
//
// Load Vertical Lineage example
//
// Customer name --> party.name, 
//
// First get the already existing physical elements
//
MATCH (accName:Column {name: 'CRM.Account.Name'})

MATCH (prdName:Column {name: 'CRM.Product.Name'})

MATCH (prdSalesPrice:Column {name: 'CRM.Product.SalesPrice'})

MATCH (partyFName:Column {name: 'ERP.Party.FirstName'})

MATCH (partyLName:Column {name: 'ERP.Party.LastName'})

MATCH (eprdName:Column {name: 'ERP.Product.Name'})

MATCH (eprdPrice:Column {name: 'ERP.Product.Price'})

MATCH (eprdCost:Column {name: 'ERP.Product.Cost'})

MATCH (adrLine1:Column {name:'CRM.Address.line1'})

MATCH (adrLine2:Column {name:'CRM.Address.line2'})

MATCH (adrZip:Column {name:'CRM.Address.ZipCode'})

MATCH (adrCity:Column {name:'CRM.Address.City'})

MATCH (adrCountry:Column {name:'CRM.Address.Country'})

MATCH (eadrLine1:Column {name:'ERP.Address.line1'})

MATCH (eadrLine2:Column {name:'ERP.Address.line2'})

MATCH (eadrZip:Column {name:'ERP.Address.ZipCode'})

MATCH (eadrCity:Column {name:'ERP.Address.City'})

MATCH (eadrCountry:Column {name:'ERP.Address.Country'})

MATCH (rcAddress:RuleCheck {name : "Address Rule" })

MATCH (rcOrderPrice:RuleCheck {name:"OrderPrice"})

MATCH (eadrZip:Column {name:'ERP.Address.ZipCode'})

MATCH (rcMargin:RuleCheck {name:"Margin Check"})

MATCH (rcAddress:RuleCheck {name : "Address Rule" })


// Glossary

CREATE (glCustName:Glossary {name: "Customer Name"})

CREATE (glEmpName:Glossary {name: "Employee Name"})

CREATE (glProdName:Glossary {name: "Product Name"})

CREATE (glProdCost:Glossary {name: "Product Cost"})

CREATE (glProdPrice:Glossary {name: "Product Price"})

CREATE (glAddress:Glossary {name: "Address"})


// Concept

CREATE (cCustName:Concept {name:"Customer.Customer Name"})

CREATE (cEmpName:Concept {name:"Employee.Employee Name"})

CREATE (cProdName:Concept {name:"Product.Product Name"})

CREATE (cAccountName:Concept {name:"Account.Name"})

CREATE (cProdCost:Concept {name:"Product.Product Cost"})

CREATE (cProdPrice:Concept {name:"Product.Product Price"})

CREATE (cAddLine1:Concept {name:"Address.Line1"})

CREATE (cAddLine2:Concept {name:"Address.Line2"})

CREATE (cAddCountry:Concept {name:"Address.Country"})

CREATE (cAddZip:Concept {name:"Address.ZipCode"})

CREATE (cAddCity:Concept {name:"Address.City"})


// relate concept to glossary

CREATE (glCustName)-[:GLOSSARY_ELEMENT_FOR]->(cCustName)

CREATE (glEmpName)-[:GLOSSARY_ELEMENT_FOR]->(cEmpName)

CREATE (glProdName)-[:GLOSSARY_ELEMENT_FOR]->(cProdName)

CREATE (glCustName)-[:GLOSSARY_ELEMENT_FOR]->(cAccountName)

CREATE (glProdCost)-[:GLOSSARY_ELEMENT_FOR]->(cProdCost)

CREATE (glProdPrice)-[:GLOSSARY_ELEMENT_FOR]->(cProdPrice)


CREATE (glAddress)-[:GLOSSARY_ELEMENT_FOR]->(cAddCountry)

CREATE (glAddress)-[:GLOSSARY_ELEMENT_FOR]->(cAddZip)

CREATE (glAddress)-[:GLOSSARY_ELEMENT_FOR]->(cAddCity)

CREATE (glAddress)-[:GLOSSARY_ELEMENT_FOR]->(cAddLine1)

CREATE (glAddress)-[:GLOSSARY_ELEMENT_FOR]->(cAddLine2)



// Logical
CREATE (lPartyFName:Logical {name:"Party.Party First Name"})

CREATE (lPartyLName:Logical {name:"Party.Party Last Name"})

CREATE (lAccountName:Logical {name:"Account.Account Name"})

CREATE (lProdName:Logical {name:"Product.Product Name"})

CREATE (lProdCost:Logical {name:"Product.Product Cost"})

CREATE (lProdPrice:Logical {name:"Product.Product Price"})

CREATE (lAddLine1:Logical {name:"Address.Line1"})

CREATE (lAddLine2:Logical {name:"Address.Line2"})

CREATE (lAddCountry:Logical {name:"Address.Country"})

CREATE (lAddZip:Logical {name:"Address.ZipCode"})

CREATE (lAddCity:Logical {name:"Address.City"})




// relate Concept to Logical

CREATE (cCustName)-[:CONCEPT_FOR]->(lPartyFName)
CREATE (cCustName)-[:CONCEPT_FOR]->(lPartyLName)

CREATE (cEmpName)-[:CONCEPT_FOR]->(lPartyFName)
CREATE (cEmpName)-[:CONCEPT_FOR]->(lPartyLName)

CREATE (cAccountName)-[:CONCEPT_FOR]->(lAccountName)

CREATE (cProdName)-[:CONCEPT_FOR]->(lProdName)
CREATE (cProdCost)-[:CONCEPT_FOR]->(lProdCost)
CREATE (cProdPrice)-[:CONCEPT_FOR]->(lProdPrice)

CREATE (cAddLine1)-[:CONCEPT_FOR]->(lAddLine1)

CREATE (cAddLine2)-[:CONCEPT_FOR]->(lAddLine2)

CREATE (cAddCountry)-[:CONCEPT_FOR]->(lAddCountry)

CREATE (cAddZip)-[:CONCEPT_FOR]->(lAddZip)

CREATE (cAddCity)-[:CONCEPT_FOR]->(lAddCity)


// Entity

CREATE (entParty:Entity {name: "PARTY"})
CREATE (entAccount:Entity {name: "ACCOUNT"})
CREATE (entProduct:Entity {name: "PRODUCT"})
CREATE (entAddress:Entity {name: "ADDRESS"})


// Attribute

CREATE (attFirstName:Attribute {name: "PARTY.PARTY_FIRST_NAME"})

CREATE (attLastName:Attribute {name: "PARTY.PARTY_LAST_NAME"})

CREATE (attAccountName:Attribute {name: "ACCOUNT.NAME"})

CREATE (attProductName:Attribute {name: "PRODUCT.NAME"})

CREATE (attProductCost:Attribute {name: "PRODUCT.COST"})

CREATE (attProductPrice:Attribute {name: "PRODUCT.PRICE"})


CREATE (attAdrLine1:Attribute {name:'Address.line1'})

CREATE (attAdrLine2:Attribute {name:'Address.line2'})

CREATE (attAdrZip:Attribute {name:'Address.ZipCode'})

CREATE (attAdrCity:Attribute {name:'Address.City'})

CREATE (attAdrCountry:Attribute {name:'Address.Country'})



// Relate Attribute to Entity

CREATE (entParty)-[:HAS_ATTRIBUTE]->(attFirstName)

CREATE (entParty)-[:HAS_ATTRIBUTE]->(attLastName)

CREATE (entAccount)-[:HAS_ATTRIBUTE]->(attAccountName)

CREATE (entProduct)-[:HAS_ATTRIBUTE]->(attProductName)

CREATE (entProduct)-[:HAS_ATTRIBUTE]->(attProductCost)

CREATE (entProduct)-[:HAS_ATTRIBUTE]->(attProductPrice)

CREATE (entAddress)-[:HAS_ATTRIBUTE]->(attAdrLine1)

CREATE (entAddress)-[:HAS_ATTRIBUTE]->(attAdrLine2)

CREATE (entAddress)-[:HAS_ATTRIBUTE]->(attAdrZip)

CREATE (entAddress)-[:HAS_ATTRIBUTE]->(attAdrCity)

CREATE (entAddress)-[:HAS_ATTRIBUTE]->(attAdrCountry)



// Relate attribute to Logical

CREATE (lPartyFName)-[:LOGICAL_ATTRIBUTE_FOR]->(attFirstName)

CREATE (lPartyLName)-[:LOGICAL_ATTRIBUTE_FOR]->(attLastName)

CREATE (lAccountName)-[:LOGICAL_ATTRIBUTE_FOR]->(attAccountName)

CREATE (lProdName)-[:LOGICAL_ATTRIBUTE_FOR]->(attProductName)

CREATE (lProdCost)-[:LOGICAL_ATTRIBUTE_FOR]->(attProductCost)

CREATE (lProdPrice)-[:LOGICAL_ATTRIBUTE_FOR]->(attProductPrice)


CREATE (lAddLine1)-[:LOGICAL_ATTRIBUTE_FOR]->(attAdrLine1)

CREATE (lAddLine2)-[:LOGICAL_ATTRIBUTE_FOR]->(attAdrLine2)

CREATE (lAddCountry)-[:LOGICAL_ATTRIBUTE_FOR]->(attAdrCountry)

CREATE (lAddZip)-[:LOGICAL_ATTRIBUTE_FOR]->(attAdrZip)

CREATE (lAddCity)-[:LOGICAL_ATTRIBUTE_FOR]->(attAdrCity)


// Relate the Attribute to the physical model in DB (ERP schema)

CREATE (attFirstName)-[:GENERATES]->(partyFName)

CREATE (attLastName)-[:GENERATES]->(partyLName)

CREATE (attAccountName)-[:GENERATES]->(accName)

CREATE (attProductName)-[:GENERATES]->(prdName)

CREATE (attProductName)-[:GENERATES]->(eprdName)

CREATE (attProductPrice)-[:GENERATES]->(prdSalesPrice)

CREATE (attProductPrice)-[:GENERATES]->(eprdPrice)

CREATE (attProductCost)-[:GENERATES]->(eprdCost)


CREATE (attAdrLine1)-[:GENERATES]->(adrLine1)

CREATE (attAdrLine2)-[:GENERATES]->(adrLine2)

CREATE (attAdrCountry)-[:GENERATES]->(adrCountry)

CREATE (attAdrZip)-[:GENERATES]->(adrZip)

CREATE (attAdrCity)-[:GENERATES]->(adrCity)

CREATE (attAdrLine1)-[:GENERATES]->(eadrLine1)

CREATE (attAdrLine2)-[:GENERATES]->(eadrLine2)

CREATE (attAdrCountry)-[:GENERATES]->(eadrCountry)

CREATE (attAdrZip)-[:GENERATES]->(eadrZip)

CREATE (attAdrCity)-[:GENERATES]->(eadrCity)

//
// business rule
// Adress Check
CREATE (bsrAddress:BusinessRule {name:'Address Rule'})

// Zip Check
CREATE (bsrZipCode:BusinessRule {name:'Zip Code Rule'})

// Price Check // margin rule
//
CREATE (bsrMargin:BusinessRule {name:'Margin Rule'})

CREATE (bsrAddress)-[:DEFINED_ON]->(glAddress)

CREATE (bsrZipCode)-[:DEFINED_ON]->(glAddress)

CREATE (bsrMargin)-[:DEFINED_ON]->(glProdCost)

CREATE (bsrMargin)-[:DEFINED_ON]->(glProdPrice)

CREATE (rcMargin)-[:IMPLEMENTS]->(bsrMargin)

CREATE (rcAddress)-[:IMPLEMENTS]->(bsrAddress)

;

//////////////////////////////////
//5//
////////////////////////////////

// create the Governance Role Nodes
// They are linked to the database, and glossary element
// so match those first
//
//
MATCH (crmdb:VirtualMachine {ip:'192.168.35.7', host:'CUSTOMER-DB-1',type: "DATABASE SERVER", system: "VIRTUAL MACHINE"}) 

// Create Database VM 3
MATCH (erpdb:VirtualMachine {ip:'192.168.35.9',host:'ERP-DB',type: "DATABASE SERVER",system: "VIRTUAL MACHINE"}) 

// glosary nodes
MATCH (glCustName:Glossary {name:'Customer Name'})

MATCH (glEmpName:Glossary {name:'Employee Name'})

MATCH (glProdName:Glossary {name:'Product Name'})

MATCH (glProdCost:Glossary {name:'Product Cost'})

MATCH (glProdPrice:Glossary {name:'Product Price'})

MATCH (salesgroup:Group {name:'Group Sales'})

MATCH (reportgroup:Group {name:'Group Report'})

MATCH (backofficegroup:Group {name:'Group BackOffice'})

MATCH (adminrole:Role {name:'Role Admin'})


MATCH (rcAddress:RuleCheck {name : "Address Rule" })

MATCH (rcMargin:RuleCheck {name:"Margin Check"})

MATCH (eadrZip:Column {name:'ERP.Address.ZipCode'})

MATCH (eprdCost:Column {name: 'ERP.Product.Cost'})


// Labels are used for the DataGovernance roles
//DGSponsoe, DGBusinessOwner, DGBusinessSteward, DGSystemOwner, DGDBA
//
// DGSponsor
//
CREATE (sponsor1:DGSponsor {name:'User10', function :'Vice President Sales'})
CREATE (sponsor2:DGSponsor {name:'User11', function :'Vice President Logistics'})

CREATE (sponsor1)-[:MEMBER]->(salesgroup)
CREATE (sponsor1)-[:MEMBER]->(reportgroup)

CREATE (sponsor2)-[:MEMBER]->(reportgroup)
CREATE (sponsor2)-[:MEMBER]->(backofficegroup)

//
// DG Business Owner
//
CREATE (bowner1:DGBusinessOwner {name:'User20', function : 'Sales Manager'})
CREATE (bowner2:DGBusinessOwner {name:'User21', function : 'ERP Business Manager'})
CREATE (bowner3:DGBusinessOwner {name:'User22', function : 'HR Manager'})

CREATE (bowner1)-[:MEMBER]->(salesgroup)
CREATE (bowner1)-[:MEMBER]->(reportgroup)

CREATE (bowner2)-[:MEMBER]->(reportgroup)
CREATE (bowner2)-[:MEMBER]->(backofficegroup)

CREATE (bowner3)-[:MEMBER]->(reportgroup)



CREATE (bowner1)-[:DEFINES]->(glCustName)

CREATE (bowner3)-[:DEFINES]->(glEmpName)

CREATE (bowner2)-[:DEFINES]->(glProdName)

CREATE (bowner2)-[:DEFINES]->(glProdCost)

CREATE (bowner2)-[:DEFINES]->(glProdPrice)


CREATE (bowner1)-[:ACCOUNTABLE_TO]->(sponsor1)
CREATE (bowner2)-[:ACCOUNTABLE_TO]->(sponsor2)
//
// BusinessSteward
//
CREATE (steward1:DGBusinessSteward {name:'User30', function : 'Information Analyst'})
CREATE (steward2:DGBusinessSteward {name:'User31', function : 'Information Analyst'})

CREATE (steward1)-[:REPORTS_TO]->(bowner1)
CREATE (steward2)-[:REPORTS_TO]->(bowner2)


CREATE (steward1)-[:DQ_RESPONSIBLE]->(glCustName)

CREATE (steward1)-[:DQ_RESPONSIBLE]->(glEmpName)

CREATE (steward2)-[:DQ_RESPONSIBLE]->(glProdName)

CREATE (steward2)-[:DQ_RESPONSIBLE]->(glProdCost)

CREATE (steward2)-[:DQ_RESPONSIBLE]->(glProdPrice)

CREATE (steward1)-[:MEMBER]->(salesgroup)
CREATE (steward1)-[:MEMBER]->(reportgroup)

CREATE (steward2)-[:MEMBER]->(reportgroup)
CREATE (steward2)-[:MEMBER]->(backofficegroup)



//
// System Ownewr
//
CREATE (sysowner:DGSystemOwner {name:'User40', function : 'Systems Administration Manager'})
CREATE (sysowner)-[:REPORTS_TO]->(bowner1)
CREATE (sysowner)-[:REPORTS_TO]->(bowner2)

CREATE (crmdb)-[:HAS_OWNER]->(sysowner)
CREATE (erpdb)-[:HAS_OWNER]->(sysowner)

CREATE (sysowner)-[:MEMBER]->(salesgroup)
CREATE (sysowner)-[:MEMBER]->(reportgroup)
CREATE (sysowner)-[:MEMBER]->(backofficegroup)


//
// DBA
//
CREATE (dba1:DGDBA {name:'User50', function : 'MS SQL Database Administrator'})

CREATE (dba2:DGDBA {name:'User51', function : 'Oracle Database Administrator'})

CREATE (dba1)-[:ADMINISTERS]->(crmdb)

CREATE (dba2)-[:ADMINISTERS]->(erpdb)

CREATE (dba1)-[:CAN_ASSUME]->(adminrole)

CREATE (dba2)-[:CAN_ASSUME]->(adminrole)

CREATE (dba1)-[:REPORTS_TO]->(sysowner)

CREATE (dba2)-[:REPORTS_TO]->(sysowner)


//
// Data Quality
//

CREATE (dqiMargin:DataQualityIssue {issuenr:1234,type:"SEVERE",desc:"Invalid cost price"})

CREATE (dqiMargin)-[:VIOLATES]->(rcMargin)

CREATE (eprdCost)-[:ISSUE_CREATED]->(dqiMargin)
;

///////////////////////////////
//6
///////////////////////////////

//
// Data Movement "Horizondal" Lineage
//
//
// CRM
MATCH (crm1:Application { ip:'192.168.32.1', host:'CRM-APPLICATION', type: 'APPLICATION', system: 'CRM'}) 

// ERP
MATCH (erp1:Application { ip:'192.168.33.1', host:'ERP-APPLICATION', type: 'APPLICATION', system: 'ERP'}) 

// DWHe 
MATCH (dwh1:Application { ip:'192.168.34.1', host:'DATA-WAREHOUSE', type: 'DATABASE',system: 'DW'}) 



// glosarry name
MATCH (glCustName:Glossary {name: "Customer Name"})

MATCH (accName:Column {name: 'CRM.Account.Name'})

MATCH (partyFName:Column {name: 'ERP.Party.FirstName'})

MATCH (partyLName:Column {name: 'ERP.Party.LastName'})

MATCH (glProdCost:Glossary {name:'Product Cost'})

MATCH (glProdPrice:Glossary {name:'Product Price'})

MATCH (erpPrice:Column {name: 'ERP.Product.Price'})

MATCH (eprCost:Column {name: 'ERP.Product.Cost'})

MATCH (dwhCost:Column {name :'DWH.ProductCatalog.Cost'})

MATCH (dwhPrice:Column {name :'DWH.ProductCatalog.Price'})

MATCH (prdSalesPrice:Column {name: 'CRM.Product.SalesPrice'})


//
// Create reports and link them to DWH
//
CREATE (repProfitLoss:Report {name:'Profit and Loss'} )

CREATE (repPostCalc:Report {name:'Post Calcualtion'} )

CREATE (repFinPlanning3m: Report {name:'Financial Planning 3 months'})

CREATE (repFinPlanning6m: Report {name:'Financial Planning 6 months'})

CREATE (repEmpOverview: Report {name: 'Employee overview'})


CREATE (dwh1)-[:PROVIDES_DATA]->(repProfitLoss)

CREATE (dwh1)-[:PROVIDES_DATA]->(repPostCalc)

CREATE (dwh1)-[:PROVIDES_DATA]->(repFinPlanning3m)

CREATE (dwh1)-[:PROVIDES_DATA]->(repFinPlanning6m)

CREATE (dwh1)-[:PROVIDES_DATA]->(repEmpOverview)


//
// Business View (with Logical Link)
//
// The "CRITICAL_DATA_ELEMENT" is abreviated as CDE. 
// The relation will have it in the type 
// 
CREATE (erp1)-[:SENDS_CDE]->(glCustName)-[:RECEIVES_CDE]->(crm1)

//
// ProductCost and ProducPrice is send from erp to crm and dwh
// and from dwh to report a,b,c,
// 
CREATE (erp1)-[:SENDS_CDE]->(glProdCost)-[:RECEIVES_CDE]->(dwh1)

CREATE (erp1)-[:SENDS_CDE]->(glProdPrice)-[:RECEIVES_CDE]->(dwh1)

CREATE (erp1)-[:SENDS_CDE]->(glProdPrice)-[:RECEIVES_CDE]->(crm1)

CREATE (dwh1)-[:SENDS_CDE]->(glProdCost)

CREATE (dwh1)-[:SENDS_CDE]->(glProdPrice)

CREATE (glProdCost)-[:RECEIVES_CDE]->(repProfitLoss)

CREATE (glProdCost)-[:RECEIVES_CDE]->(repPostCalc)

CREATE (glProdCost)-[:RECEIVES_CDE]->(repFinPlanning3m)

CREATE (glProdCost)-[:RECEIVES_CDE]->(repFinPlanning6m)

CREATE (glProdPrice)-[:RECEIVES_CDE]->(repProfitLoss)

CREATE (glProdPrice)-[:RECEIVES_CDE]->(repPostCalc)

CREATE (glProdPrice)-[:RECEIVES_CDE]->(repFinPlanning3m)

CREATE (glProdPrice)-[:RECEIVES_CDE]->(repFinPlanning6m)



//
// Technical View
//
// Customer Name integration process
// Process X: React on changes in ERP PARTY FIRST NAME and PARTY LAST NAME 
//            SENDS CHANGED DATA TO PROCESS Y
// Process Y: Receives Party Name Change and sends the Change to the CRM system in the required format
//
// *** Mayby changing the relation names
//

CREATE (processX:Process {name: 'Customer Name Change Listener'})

CREATE (processY:Process {name: 'Maintain CRM Account Name'})

CREATE (processPC:Process {name: "Product Change Listener"} )

CREATE (processPCdwh:Process {name: "Recieve and process product Cost and Price"} )

CREATE (processPCcrm:Process {name: "Recieve and process product Price"} )

CREATE (erp1)-[:SENDS]->(erpPrice)

CREATE (erp1)-[:SENDS]->(eprCost)

CREATE (erpPrice)-[:RECEIVES]->(processPC)

CREATE (eprCost)-[:RECEIVES]->(processPC)

CREATE (processPC)-[:SENDS]->(erpPrice)

CREATE (processPC)-[:SENDS]->(eprCost)

CREATE (erpPrice)-[:RECEIVES]->(processPCcrm)

CREATE (erpPrice)-[:RECEIVES]->(processPCdwh)

CREATE (eprCost)-[:RECEIVES]->(processPCdwh)

CREATE (processPCcrm)-[:SENDS]->(prdSalesPrice)

CREATE (prdSalesPrice)-[:RECEIVES]->(crm1)


CREATE (processPCdwh)-[:SENDS]->(dwhCost)

CREATE (processPCdwh)-[:SENDS]->(dwhPrice)

CREATE (dwhCost)-[:RECEIVES]->(dwh1)

CREATE (dwhPrice)-[:RECEIVES]->(dwh1)

CREATE (erp1)-[:SENDS]->(partyFName)

CREATE (erp1)-[:SENDS]->(partyLName)

CREATE (partyFName)-[:RECEIVES]->(processX)

CREATE (partyLName)-[:RECEIVES]->(processX)

CREATE (processX)-[:SENDS]->(partyFName)

CREATE (processX)-[:SENDS]->(partyLName)

CREATE (partyFName)-[:RECEIVES]->(processY)

CREATE (partyLName)-[:RECEIVES]->(processY)

CREATE (processY)-[:SENDS]->(accName)

CREATE (accName)-[:RECEIVES]->(crm1)

;

//////////////////////////////////
//7
//////////////////////////////////

// loading user which are application owners reporting to business owners
MATCH (salesgroup:Group {name:'Group Sales'})

MATCH (reportgroup:Group {name: 'Group Report'})

MATCH (backofficegroup:Group {name: 'Group BackOffice'})

// CRM
MATCH (crm1:Application { ip:'192.168.32.1', host:'CRM-APPLICATION', type: 'APPLICATION', system: 'CRM'}) 

// ERP
MATCH (erp1:Application { ip:'192.168.33.1', host:'ERP-APPLICATION', type: 'APPLICATION', system: 'ERP'}) 

// DWHe 
MATCH (dwh1:Application { ip:'192.168.34.1', host:'DATA-WAREHOUSE', type: 'DATABASE',system: 'DW'}) 

MATCH (erpbo:DGBusinessOwner {name:"User21"})

MATCH (dwbo:DGBusinessOwner {name:"User22"})

MATCH (crmbo:DGBusinessOwner {name:"User20"})

// user 140 application owner of ERP
CREATE (u40:User {name:"User140"}) 

// user 130 application owner of dwh application
CREATE (u30:User {name:"User130"})

// user 110 application owner of CRM application
CREATE (u10:User {name:"User110"})


CREATE (u40)<-[:APPLICATION_OWNER]-(erp1)

CREATE (u40)<-[:MEMBER]-(backofficegroup)


CREATE (u30)<-[:APPLICATION_OWNER]-(dwh1)

CREATE (u30)<-[:MEMBER]-(reportgroup)


CREATE (u10)<-[:APPLICATION_OWNER]-(crm1)

CREATE (u10)-[:MEMBER]->(salesgroup)


// REPORTS_TO business owners

CREATE (u40)-[:REPORTS_TO]->(erpbo)

CREATE (u30)-[:REPORTS_TO]->(dwbo)

CREATE (u10)-[:REPORTS_TO]->(crmbo)


;