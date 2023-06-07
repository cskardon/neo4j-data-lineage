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