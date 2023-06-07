# Data Lineage - Demo Script

This will guide you through the Data Lineage demo. 

## Intended Audience
* Developers
* Stakeholders

## Database information

* Current version: `5.9.0`
* APOC: *true*
* GDS: *false*
* Bloom: *false*

## Glossary

* ERP - Enterprise Resource Planning
* CRM - Customer Relationship Management
* CDE - Critical Data Element

# Setup the database

1. Create the server instance (use [Neo4j Desktop](https://neo4j.com/download-center/), or a free [Aura](https://neo4j.com/cloud/platform/aura-graph-database) instance.)
2. (Neo4j Desktop) Install [APOC](https://neo4j.com/docs/apoc/current/)
3. (Neo4j Desktop) Start the server
4. Load the data
   
   Either
   - Execute the Cypher in the `Cypher\Create` folder (in order `1`->`7`)
   
   Or
   - Load the dump file into a `data-lineage` database

> ### How do I load the dump file??
>
> 1. Locate the file
> 2. Execute the following (nb. on Windows do *not* add a trailing `\` character in the `--from-path` parameter)
> ```
> .\bin\neo4j-admin.bat database load --from-path="D:\temp\datalineage" data-lineage --overwrite-destination=true
> ```
> 3. Open up Neo4j Browser and execute the following:
> ```cypher
> :use system;
> CREATE DATABASE `data-lineage`;
> START DATABASE `data-lineage`;
> :use data-lineage;
>```
> If you get an error message saying: "Database "data-lineage" is unavailable, its status is "unknown"." it is just a timing issue, just try the last statement (`:use data-lineage`) again and it'll work.

# Exploring the data

We're going to look at some queries to see what our data looks like.

First, let's look at the model as a whole:

```cypher
CALL db.schema.visualisation()
```

<img width="800" alt="Data Model - Data Lineage" src="https://raw.githubusercontent.com/cskardon/neo4j-data-lineage/main/Assets/Images/schema.svg">

## Nodes

Stuff about the nodes will go here.

### Application

The `Application` node represents an Application in our system, this could be a Data Warehouse, CRM or ERP in this data set.
In a real-world system, this could represent your customer facing website, phone app or maybe internal only applications.

## 

## Relationships

Perhaps unsurprisingly, relationship stuff will go here!

### RECEIVES_CDE

This indicates that a `Report` or `Application` recieves a CDE from a `Glossary` 


# Queries

This is a set of example queries (there are more in the [Queries](https://raw.githubusercontent.com/cskardon/neo4j-data-lineage/main/Cypher/Queries/ExampleQueries.cql) file *nb* they will have less documentation).

## Find an Application by host name:

Let's focus on one specific `Application`:

```cypher
MATCH (a:Application {host:'DATA-WAREHOUSE'}) 
RETURN a; 
```

## Find all Reports that an Application provides data for:

Our `Application` (the 'Data Warehouse') provides data to `Reports`. If we want to get a list of those reports we can run:

```cypher
MATCH (:Application {host:'DATA-WAREHOUSE'}) -[:PROVIDES_DATA]-> (r:Report) 
RETURN r;
```

> *Cypher Note* - we don't supply an identifier for the `Application` as we don't need to return it, 
> we're only interested in the `Report`s that the `Application` `PROVIDES_DATA` for.

Reports get data from other sources as well, for example, CDEs that come from `Glossary` repositories.

We're now asking our data "_Which reports use the Data Warehouse `Application` as a source, and which `Glossary`'s do they get their CDEs from?_".

```cypher
MATCH (:Application {host:'DATA-WAREHOUSE'})-[:PROVIDES_DATA]->(r:Report)<-[:RECEIVES_CDE]-(g:Glossary)  
RETURN r, g;
```

Of course, we're not limited to seeing that data in a Node/Relationship way - we can also view it in a tabular format.

```cypher
MATCH (:Application {host:'DATA-WAREHOUSE'})-[:PROVIDES_DATA]->(r:Report)<-[:RECEIVES_CDE]-(g:Glossary)
RETURN r.name,g.name 
ORDER BY r.name;
```

With this, we'll get some duplicate responses, so it will make more sense to do something like this:

```cypher
MATCH (:Application {host:'DATA-WAREHOUSE'})-[:PROVIDES_DATA]->(r:Report)<-[:RECEIVES_CDE]-(g:Glossary)
WITH r.name AS report, COLLECT(DISTINCT g.name) AS glossaries
RETURN report, glossaries 
ORDER BY report;
```

## What are the connections to an `Application`?

Imagine we want to do some maintainence on an `Application`, and whilst we know what `Report`s we'd be disrupting, is there anything else?

```cypher
MATCH (app:Application {host:'DATA-WAREHOUSE'})-[how]-(connected) 
RETURN app, how, connected;
```

The relationship definition is `-[how]-` which we can break apart - the `[how]` bit is saying we want _any_ relationship with the `Application`, we've not put a direction on the relationship either (`>` or `<`) so we don't mind which way around the connection is, and lastly, we're only looking one 'hop' away from the `Application` - i.e. directly connected.

We haven't defined any labels for the `(connected)` node, which means we don't mind what the 

But what if we wanted to look _further_ afield??

```cypher
MATCH (app:Application {host:'DATA-WAREHOUSE'})-[how*1..2]-(connected) 
RETURN app, how, connected;
```

By adding the `*1..2` to the end of our relationship definition - we are now looking for both direct connections and connections **two** hops out.

## How are applications connected??

We can check things like how `Applications` (or anything else) are connected by using the path functions, the `shortestPath`, will return to us the quickest way to get between two nodes (in this case `Application`s):

```cypher
MATCH 
   (erp:Application{host:'ERP-APPLICATION'}),
   (crm:Application{host:'CRM-APPLICATION'}),
   p = shortestPath( (erp)-[*1..5]-(crm) )
RETURN p;
```

Which gives us:

<img width="400" alt="Shortest Path between ERP and CRM Applications" src="https://raw.githubusercontent.com/cskardon/neo4j-data-lineage/main/Assets/Images/shortestPath-Result.svg">

The path returned only has 2 hops, but we can see we've asked for `[1..5]`. By using `shortestPath` we only get the shortest route between nodes. There will be lots of ways to get between the two applications, as we can see if we execute:

```cypher
MATCH 
   (erp:Application{host:'ERP-APPLICATION'}),
   (crm:Application{host:'CRM-APPLICATION'}),
   p = (erp)-[*1..5]-(crm)
RETURN p;
```

Where we get:

<img width="800" alt="All the Paths between ERP and CRM Applications" src="https://raw.githubusercontent.com/cskardon/neo4j-data-lineage/main/Assets/Images/shortestPath-NotShortest-Result.svg">

Which if we run:

```cypher
MATCH 
   (erp:Application{host:'ERP-APPLICATION'}),
   (crm:Application{host:'CRM-APPLICATION'}),
   p = (erp)-[*1..5]-(crm)
RETURN COUNT(p);
```

Gives us **103** ways to get between the two `Application`s!
 
But how can we find all connections between 2 applications, but ignore the extra 'loops', so just the shortest ways?

```cypher
MATCH 
   (erp:Application{host:'ERP-APPLICATION'}),
   (crm:Application{host:'CRM-APPLICATION'}),
   p = allShortestPaths( (erp)-[*1..5]-(crm) )
RETURN p;
```

<img width="400" alt="All the Shortest Paths between ERP and CRM Applications" src="https://raw.githubusercontent.com/cskardon/neo4j-data-lineage/main/Assets/Images/allShortestPath-Result.svg">

Returning the `COUNT(p)` instead of just `p` gives us only **3** paths this time, much more manageable.

## Aggregating

Looking at nodes and relationsihps and in particular the paths therein can be super useful, but sometimes we also want to do things like find out which of our `Application`s is the source for the most 'things'


```cypher
MATCH (app:Application)
OPTIONAL MATCH (app)-[pd:PROVIDES_DATA]->()
RETURN app.host AS host, count(pd) AS count
ORDER BY count DESC;
```

In our limited dataset we can see that the `DATA-WAREHOUSE` acts as a source for 5 'things', the other apps don't act as a source. But what types of 'thing' is the `DATA-WAREHOUSE` providing data for?

```cypher
MATCH (app:Application)
OPTIONAL MATCH (app)-[pd:PROVIDES_DATA]->(other)
RETURN app.host AS host, labels(other) AS Labels,  count(pd) AS count
ORDER BY count DESC;
```

By adding the `labels(other)` return statement, we can see that the `DATA-WAREHOUSE` is a source only for `Report`s.

---

# Advanced Exploration


- Data governance: Business Glossary and its stakeholders

We're going to use one of the `Path` methods from APOC now - specifically the [`expandPath`](https://neo4j.com/docs/apoc/current/overview/apoc.path/apoc.path.expandConfig/) method. This allows us to expand all the paths (to a set depth) from a start point, so we can use this to see who are the stakeholders (i.e. who has a vested interest about a particular `Glossary` - for example if it stopped responding)

```cypher
MATCH (g:Glossary {name:'Product Price'})
WITH g
CALL apoc.path.expandConfig(g, {
         maxLevel:5, 
         labelFilter:'-Glossary', 
         relationshipFilter:'DEFINES|GLOSSARY_ELEMENT_FOR|MEMBER|DQ_RESPONSIBLE', 
         uniqueness:'RELATIONSHIP_GLOBAL', 
         filterStartNode:false
      }) YIELD path
RETURN path;
```

## Where are the `Glossary` items used?


```cypher
// Full paths
MATCH (g:Glossary{name:'Product Price'}) -[*1]-> (c:Concept) -[*1]-> (l:Logical)
WITH g,collect(l) AS logicalCol
CALL apoc.path.expandConfig(logicalCol,{maxLevel:-1,labelFilter:'/Application|-DGBusinessSteward|DGBusinessOwner|Glossary',uniqueness:'RELATIONSHIP_GLOBAL'}) YIELD path
RETURN path;
```

// Tabular result
```cypher
MATCH (g:Glossary{name:'Product Price'}) -[*1]-> (c:Concept) -[*1]-> (l:Logical)
WITH g,collect(l) AS logicalCol
CALL apoc.path.expandConfig(logicalCol,{maxLevel:-1,labelFilter:'/Application|-DGBusinessSteward|DGBusinessOwner|Glossary',uniqueness:'RELATIONSHIP_GLOBAL'}) YIELD path
UNWIND nodes(path) AS aNode
```

```cypher
// RETURN aNode
MATCH (aNode) -[:GENERATES]-> (col:Column) -[*1]-> (tbl:Table) -[*1]-> (s:DBSchema) -[*1]- (app:Application)
RETURN DISTINCT aNode.name AS AttributeName, col.name AS ColumnName, tbl.name AS TableName, s.name AS SchemaName, app.host AS AppHost
ORDER BY AttributeName, ColumnName, TableName, SchemaName, AppHost;
```