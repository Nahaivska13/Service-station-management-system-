# Katalizator - Car Service Station Database

## Overview
"Katalizator" is a relational database system designed for a car service station.  
The system helps to **manage clients, track service orders, monitor spare parts inventory, and assign tasks to employees**.  
This project demonstrates skills in **database design, SQL, data analytics**.

---

## Key Features
- **Order Management:** Tracks the full lifecycle of a service order from client request to completion.  
- **Inventory & Supplier Tracking:** Manages stock levels and supplier information for spare parts.  
- **Service & Labor Integration:** Links services to qualified workers and calculates costs.  
- **Data Analysis & Reporting:** Includes complex SQL queries for business insights such as top services, employee performance, and stock status.

---

## Database Architecture
The database consists of **6 core tables**, designed for normalization and data integrity:

| Table       | Description |
|------------|-------------|
| clients     | Stores client personal information and vehicle details |
| workers     | Tracks employee data, positions, and experience |
| services    | Catalog of maintenance and repair services |
| parts       | Inventory of spare parts linked to suppliers |
| suppliers   | Information about external partners for parts |
| orders      | Links clients, workers, services, and parts in a central table |

**EER Diagram:** `schema/EER diagram.png`  
**Optional Use Case Diagram:** `docs/Use Case diagram.png`  

---

## Technical Highlights
- **Data Modeling:** Entity-Relationship Diagram (ERD) visualizes relationships between tables.  
- **Normalization:** Applied **3NF** to reduce redundancy and prevent update anomalies.  
- **SQL Implementation:**  
  - Queries with **JOINs, UNIONs, GROUP BY, HAVING**  
  - Relational algebra operations: Selection, Projection, Cartesian Product, Division  
  - Dynamic reporting using **CASE/IF expressions**  
- **Data Handling:** Sample data provided for demonstration  
- **Access Control:** User roles and permissions defined (GRANT/REVOKE)

---

## Tech Stack
- **Database Engine:** MySQL  
- **Query Language:** SQL  
- **Design Tools:** MySQL Workbench (EER Diagramming)  
- **Development Tools:** VS Code, Git/GitHub  

---



