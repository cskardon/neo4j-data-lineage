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