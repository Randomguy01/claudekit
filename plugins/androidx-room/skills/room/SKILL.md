---
name: 
descripton: 
---

# Room Database

The Room persistence library is an abstraction layer over SQLite. Benefits of Room:
- Compile-time verification of SQL queries
- Annotations to minimize boilerplate code
- Database migration paths

**We recommend that you use Room instead of using the SQLite APIs directly.**

# Installation

To install or verify installation of Room follow the (installtion reference)[refrences/install.md]

# Primary Components

Three primary components:
- (Database)[api/annotations/database.md]: Holds the database and serves as the main access point for the underlying database connection
- (Entities)[api/annotations/entity.md]: Represent tables
- (Data Access Objects (DAOs))[api/annotations/dao.md]: Interface to query, update, insert, and delete data

# Entities

For creating and modifying entities follow the [entity reference](references/entity.md)
