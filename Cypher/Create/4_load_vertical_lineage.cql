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