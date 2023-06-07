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
