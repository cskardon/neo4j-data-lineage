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




