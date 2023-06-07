// Usage: 
// unzip the zip file it contains cypher scripts.
// run the scripts in the right order from 1 to 7

// Queries to show in the Neo4j browser:

// Show infrasrtucture and servers Via the dependency structurs
MATCH p=(srv:Server {ip : "192.168.35.13"})-[:DEPENDS_ON*]-()
RETURN p 
LIMIT 100;

// Which applications/servers are accessible in DMZ?
MATCH p=(dmz:NetworkSegment {name:'DMZ'})<-[:NETWORK_ACCESS]-()
RETURN p

// Tables, Columns and Foreign keys
MATCH p=(t:Table)<-[:OWNED_BY|:BELONGS_TO]-()
RETURN p

// Datamodel plus DataDomain and RuleCheck
MATCH (t:Table)<-[r:OWNED_BY|:BELONGS_TO]-(x)
OPTIONAL MATCH (x)-[rr]-(y)
RETURN t,x,y,r,rr

// Show table access rights per user
MATCH (n:User)-->(rg)-[a]->(t:Table) 
RETURN 
   n.name AS username, 
   COLLECT(type(a)) AS rights,
   t.name AS tablename
ORDER BY username

// Vertical Lineage
// Show the glosary elements and their representations in the DB Schema's
// The app layer is left out for this query, TIP when clicking on schema you will get the applications also
MATCH 
   (glossary:Glossary)-[r1:GLOSSARY_ELEMENT_FOR]->(concept)
   ,(concept)-[r2:CONCEPT_FOR]->(logical)
   ,(logical)-[r3:LOGICAL_ATTRIBUTE_FOR]->(attribute)
   ,(attribute)-[r4:GENERATES]->(column)
   ,(column)-[r5:OWNED_BY]->(table)
   ,(table)-[r6:STORED_IN]-(schema)
RETURN glossary,concept,logical,attribute,column,table,schema,r1,r2,r3,r4,r5,r6

// Horizontal lineage; show the business horizontal lineage
MATCH (cn:Glossary)-[r:SENDS_CDE|:RECEIVES_CDE]-(b) 
RETURN cn,b,r

// the technical horizontal linage for Customer Name
MATCH 
   (n:Process {name :"Customer Name Change Listener"})
   , p=(n)-[:SENDS|:RECEIVES *1..4]-()
RETURN p

// Changing attribute affects reports...
