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