PigPower SmartFarm Platform
Functional Requirements Specification
Module: Inventory & Warehouse Management

Document ID: PSP-SRS-FR-IWM
Version: 1.0
Status: Draft
Parent Document: Software Requirements Specification
Chapter: 4 – Functional Requirements
Project: PigPower Lesotho – Community-Based Circular Pork Economy Platform

1. Module Overview

The Inventory & Warehouse Management Module shall provide centralized management of all physical inventory used, produced, stored, transferred, consumed, or distributed throughout the PigPower ecosystem.

The module shall provide visibility from:

Procurement → Receiving → Storage → Allocation → Consumption/Production → Transfer → Sale/Distribution → Adjustment

The system shall support inventory across multiple locations, including:

Central warehouse
Feed storage facilities
Veterinary stores
Processing facility
Cold rooms
Finished-goods warehouses
Regional distribution points
Farmer-associated stock locations

The objective is to ensure that PigPower always knows:

What stock exists, where it is located, how much is available, what condition it is in, when it expires, what it is allocated to, and how it entered or left the inventory system.

2. Business Purpose

Inventory represents a significant portion of PigPower's operating capital.

Poor inventory management could result in:

Feed shortages
Feed spoilage
Expired veterinary products
Product losses
Excess inventory
Theft
Stock discrepancies
Production interruptions
Cold-chain losses
Unnecessary procurement
Cash-flow problems

The system shall therefore transform inventory management from manual stocktaking into a digitally controlled, traceable inventory system.

3. Inventory Categories

The system shall support configurable inventory categories.

3.1 Livestock Inputs

Examples:

Piglets
Breeding stock
Replacement stock

These should not be treated identically to ordinary warehouse stock because livestock has biological attributes and belongs primarily to the Pig Management module.

3.2 Feed

Examples:

Starter feed
Grower feed
Finisher feed
Sow feed
Maize
Soybean meal
Mineral supplements
Premixes
3.3 Veterinary Supplies

Examples:

Vaccines
Medicines
Disinfectants
Syringes
Gloves
Veterinary consumables

Veterinary inventory shall include additional controls for:

Batch number
Expiry date
Storage requirements
3.4 Processing Inputs

Examples:

Salt
Spices
Casings
Curing ingredients
Smoking materials
Approved food-processing ingredients
3.5 Packaging

Examples:

Vacuum bags
Plastic packaging
Labels
Boxes
Trays
QR labels
3.6 Finished Products

Examples:

Pork chops
Pork shoulder
Pork belly
Sausages
Bacon
Ham
Smoked pork
3.7 Cleaning & Sanitation

Examples:

Detergents
Sanitizers
Protective materials
Cleaning equipment
3.8 Maintenance Inventory

Examples:

Electrical components
Fuses
Cables
Bearings
Pumps
Filters
Spare parts
3.9 Circular Economy Products

Potential future categories:

Organic fertilizer
Compost
Digestate
Biogas-related consumables
4. Inventory Locations
FR-IWM-001 — Manage Inventory Locations

The system shall support multiple inventory locations.

Example:

PigPower Central Warehouse
│
├── Feed Store
├── Veterinary Store
├── Packaging Store
├── Maintenance Store
└── General Store

Processing Facility
│
├── Raw Material Store
├── Production Area
├── Cold Room 1
├── Cold Room 2
└── Finished Goods Store

Each location shall have a unique identifier.

5. Warehouse Structure

The system should support hierarchical warehouse locations.

Example:

Warehouse
   ↓
Zone
   ↓
Aisle
   ↓
Rack
   ↓
Shelf
   ↓
Bin

Example:

WH01
 └── Feed Zone
      └── Rack A
           └── Shelf 02
                └── Bin 05

This will allow future barcode/QR-based warehouse operations.

6. Inventory Item
FR-IWM-002 — Create Inventory Item

Each inventory item shall have a unique item record.

Fields should include:

Item ID
SKU
Item name
Category
Description
Unit of measure
Product type
Supplier
Reorder level
Maximum stock level
Minimum stock level
Storage requirements
Expiry tracking requirement
Batch tracking requirement
Serial-number tracking requirement
Active/inactive status
7. SKU Management

The system shall generate or support unique Stock Keeping Units.

Example:

FEED-GRW-025

Meaning:

FEED
GROWER
25 KG

A consistent SKU strategy should be adopted across the organization.

8. Units of Measurement

The system shall support configurable units.

Examples:

kg
g
litres
ml
units
bags
boxes
packs
bottles
tonnes

The system shall support conversions where required.

Example:

1 tonne = 1,000 kg
9. Stock Receipt
FR-IWM-003 — Receive Inventory

When inventory arrives, authorized personnel shall record:

Purchase order
Supplier
Delivery reference
Item
Quantity
Unit
Batch number
Expiry date
Receiving date
Storage location
Receiving officer
Condition
Supporting documents
10. Goods Received Note

The system shall generate a digital Goods Received Note (GRN).

Example:

GRN:
GRN-2026-00421

Supplier:
ABC Feed Suppliers

Item:
Grower Feed

Quantity:
100 × 25 kg

Total:
2,500 kg

Received:
12 August 2026

Status:
ACCEPTED
11. Receiving Inspection

Inventory may require inspection before becoming available.

Statuses:

RECEIVED
UNDER_INSPECTION
ACCEPTED
PARTIALLY_ACCEPTED
REJECTED
QUARANTINED

Rejected stock shall not be included in available inventory.

12. Batch Tracking
FR-IWM-004 — Track Inventory Batches

The system shall support batch-level inventory tracking.

Example:

Item:
Grower Feed

Batch:
GF-0826-001

Quantity:
2,500 kg

Expiry:
February 2027

Batch tracking shall be mandatory for configurable categories such as:

Veterinary products
Feed
Food ingredients
Finished pork products
13. Expiry Management

The system shall monitor expiry dates.

The system should generate alerts for:

90 days before expiry
60 days before expiry
30 days before expiry
7 days before expiry

The exact alert thresholds shall be configurable.

14. FEFO

For perishable inventory, the system shall support:

First Expired, First Out (FEFO).

Example:

Batch A → expires September
Batch B → expires December

The system should recommend:

Use Batch A first.
15. FIFO

For inventory where expiry is not the primary consideration, the system may support:

First In, First Out (FIFO).

The inventory policy shall determine whether FIFO or FEFO applies to each inventory category.

16. Stock Issue
FR-IWM-005 — Issue Inventory

Authorized users shall issue inventory to:

Farmers
Farms
Veterinary teams
Processing
Production
Maintenance
Distribution
Other authorized departments

The issue transaction shall record:

Item
Quantity
Source location
Destination
Recipient
Purpose
Date
Issued by
Batch number
17. Feed Allocation

Feed inventory shall integrate with Feed Management.

Example:

Central Feed Store
       ↓
Allocation
       ↓
Farmer F-001
       ↓
Farm F-001
       ↓
Pig Batch PB-004

This enables PigPower to calculate:

How much feed was issued to each farm and production cycle?

18. Veterinary Inventory Integration

Veterinary supplies shall integrate with Veterinary Management.

Example:

Veterinary Store
      ↓
Medicine Issue
      ↓
Farm
      ↓
Pig Batch
      ↓
Treatment Record

This provides both stock and veterinary traceability.

19. Production Consumption

The Processing & Meat Production Module shall consume inventory through the inventory system.

Example:

Ingredient Inventory
       ↓
Production Batch
       ↓
Consumption Transaction
       ↓
Updated Inventory
20. Inventory Transfer
FR-IWM-006 — Transfer Inventory

Authorized users shall transfer stock between locations.

Example:

Central Warehouse
       ↓
Transfer
       ↓
Maseru Processing Facility

Transfer statuses:

REQUESTED
APPROVED
IN_TRANSIT
RECEIVED
CANCELLED
21. Inter-Warehouse Transfer

The system shall support transfers between:

Central warehouse
Regional warehouses
Processing facility
Cold rooms
Distribution points

Each transfer shall retain an audit trail.

22. Stock Reservation
FR-IWM-007 — Reserve Inventory

Inventory may be reserved for:

Production orders
Customer orders
Farmer allocations
Veterinary campaigns
Scheduled deliveries

Example:

Available:
1,000 kg

Reserved:
600 kg

Free:
400 kg

The system shall distinguish:

Physical Stock from Available Stock.

23. Inventory States

The system shall distinguish:

ON_HAND
AVAILABLE
RESERVED
ALLOCATED
IN_TRANSIT
QUARANTINED
DAMAGED
EXPIRED
RECALLED
DISPOSED
24. Stock Adjustment
FR-IWM-008 — Adjust Inventory

Authorized users may make inventory adjustments when justified.

Reasons may include:

Physical count variance
Damage
Spoilage
Expiry
Theft investigation
Measurement correction
Data-entry error

Every adjustment must include:

Reason
Quantity
Previous quantity
New quantity
User
Date
Approval where required
25. Stocktake
FR-IWM-009 — Conduct Stocktake

The system shall support physical inventory counts.

Stocktake types:

Full Stocktake

All inventory.

Cycle Count

Selected inventory categories or locations.

Spot Check

Specific items.

26. Stocktake Reconciliation

The system shall compare:

System Quantity
        VS
Physical Quantity

Example:

System:
500 kg

Physical:
480 kg

Variance:
-20 kg

The system shall record the variance and require authorization before adjustment where configured.

27. Inventory Valuation

The system should support inventory valuation.

Potential valuation methods:

Weighted average cost
FIFO

The chosen accounting methodology should be configurable in accordance with PigPower's accounting policies.

28. Purchase Cost

Each stock receipt shall record its acquisition cost where applicable.

Example:

Grower Feed

Quantity:
2,500 kg

Purchase price:
M8/kg

Inventory value:
M20,000
29. Inventory Cost Tracking

The system should track:

Purchase Cost
+
Transport
+
Applicable Handling Cost
=
Landed Inventory Cost

This is particularly important for feed because feed is likely to be one of PigPower's largest production costs.

30. Reorder Management
FR-IWM-010 — Reorder Alerts

The system shall monitor minimum stock levels.

Example:

Item:
Grower Feed

Minimum:
1,000 kg

Current:
850 kg

Status:
REORDER REQUIRED
31. Reorder Point

The system may calculate reorder points based on:

Average consumption
Supplier lead time
Safety stock
Seasonal demand

Conceptually:

Reorder Point =
Average Daily Usage × Lead Time
+
Safety Stock
32. Safety Stock

The system shall support configurable safety-stock levels.

This is particularly important for:

Feed
Veterinary supplies
Packaging
Processing ingredients
33. Inventory Forecasting

Future versions shall support AI-assisted forecasting.

Example:

Historical Feed Consumption
+
Number of Active Pigs
+
Production Cycles
+
Seasonality
+
Expected Farmer Growth
=
Forecast Feed Demand

This will integrate directly with the future AI Production Forecasting Module.

34. Cold-Chain Inventory
FR-IWM-011 — Cold Storage Management

The system shall support cold-storage inventory.

Each cold-storage location may have:

Temperature range
Capacity
Current occupancy
Product batches
Entry date
Exit date
35. Temperature Monitoring

Future IoT integration shall allow:

Temperature Sensor
       ↓
API / IoT Gateway
       ↓
PigPower Platform
       ↓
Cold Room Dashboard

The system can generate alerts if temperatures move outside configured thresholds.

36. Cold-Chain Alert

Example:

COLD ROOM CR-02

Temperature:
9.2°C

Configured range:
0–5°C

STATUS:
TEMPERATURE ALERT

The system shall record the event for investigation.

37. Finished Product Integration

When the Processing Module releases a product:

Production
   ↓
QC Approval
   ↓
Finished Product
   ↓
Inventory Receipt

The system shall automatically create or update the relevant inventory quantity.

38. Sales Integration

When a customer order is confirmed:

Finished Inventory
       ↓
Stock Reservation
       ↓
Order Fulfillment
       ↓
Stock Issue
       ↓
Delivery

This will later integrate with Sales & Order Management.

39. Product Returns
FR-IWM-012 — Process Returns

The system shall support returned inventory.

Return reasons may include:

Damaged product
Incorrect delivery
Customer rejection
Quality concern
Administrative error

Returned food products shall be placed into an appropriate status such as:

QUARANTINED

until authorized disposition is determined.

40. Product Recall Integration

If a product batch is recalled:

Product Recall
       ↓
Identify Batch
       ↓
Locate Inventory
       ↓
Block Stock
       ↓
Identify Dispatched Quantity

This connects directly to the Processing & Meat Production Management Module.

41. Warehouse Dashboard

The Warehouse Manager should see:

WAREHOUSE DASHBOARD
────────────────────────

Total Inventory Value
M XXX,XXX

Items:
1,245

Low Stock:
18

Expiring Soon:
12

Quarantined:
4

Stock Transfers:
7

Pending Receipts:
5
42. Inventory Dashboard by Category

Example:

Category	Quantity	Status
Feed	12,500 kg	Normal
Veterinary	1,240 units	Normal
Packaging	8,500 units	Low
Ingredients	2,100 kg	Normal
Finished Pork	1,850 kg	Normal
Maintenance	420 items	Normal
43. Farmer Stock Visibility

Where PigPower provides inputs to farmers, the platform shall maintain farmer-level allocation records.

Example:

FARMER: F-001

Feed allocated:
1,200 kg

Feed consumed/issued:
900 kg

Balance:
300 kg

This should integrate with Farm Management and Feed Management.

44. Inventory Accountability

Every inventory movement shall create a transaction.

Conceptually:

INVENTORY TRANSACTION

Transaction ID
Item
Batch
Quantity
Unit
Source
Destination
Transaction Type
User
Date/Time
Reference

Transaction types:

RECEIPT
ISSUE
TRANSFER
RESERVATION
RELEASE
ADJUSTMENT
RETURN
DISPOSAL
PRODUCTION_CONSUMPTION
PRODUCTION_OUTPUT
45. Inventory Ledger

The system shall maintain a permanent inventory transaction ledger.

Example:

Date	Transaction	Qty	Balance
01 Aug	Opening	2,000 kg	2,000
03 Aug	Receipt	+1,000 kg	3,000
05 Aug	Farmer Issue	-500 kg	2,500
07 Aug	Production	-300 kg	2,200
10 Aug	Adjustment	-20 kg	2,180

This ledger is critical for auditability.

46. Barcode & QR Integration

The system shall support barcode and QR scanning.

Potential applications:

Warehouse receiving
SCAN
 ↓
Identify Item
 ↓
Enter Quantity
 ↓
Confirm Receipt
Stock issue
SCAN
 ↓
Identify Batch
 ↓
Enter Quantity
 ↓
Confirm Issue
Finished products
SCAN PRODUCT QR
 ↓
Retrieve Product Batch
 ↓
Traceability Information
47. Offline Capability

Because PigPower will operate in rural areas, inventory operations should support offline-first functionality where practical.

For example:

Warehouse App
      ↓
No Internet
      ↓
Record Stock Movement
      ↓
Local Database
      ↓
Internet Restored
      ↓
Synchronize
      ↓
Central Server

This requirement is especially important for remote farmer input distribution.

48. Synchronization

Each transaction should have a unique identifier so that offline transactions can safely synchronize with the central system.

The architecture should prevent duplicate transactions during synchronization.

49. Inventory Security

Permissions shall be role-based.

For example:

Action	Warehouse Clerk	Warehouse Manager	Admin
View Stock	✓	✓	✓
Receive Stock	✓	✓	✓
Issue Stock	✓	✓	✓
Transfer Stock	Limited	✓	✓
Adjust Stock	No	✓	✓
Delete Transactions	No	No	No
Approve Adjustment	No	✓	✓

Inventory transactions should generally be reversed or corrected rather than deleted.

50. Audit Trail

The system shall record:

User
Date
Time
Action
Previous value
New value
Reason
Device where available

Example:

User:
Warehouse Manager

Action:
Stock Adjustment

Item:
Grower Feed

Previous:
500 kg

New:
480 kg

Reason:
Physical stock variance

Timestamp:
2026-08-12 10:42
51. Inventory Notifications

The system should generate notifications for:

Low stock
Critical stock
Expiring stock
Expired stock
Stock discrepancy
Pending receipt
Pending transfer
Cold-room temperature issue
Recall
Quarantine
Excess stock
52. Procurement Integration

The inventory system shall eventually integrate with Procurement.

The workflow shall be:

Low Stock
   ↓
Reorder Alert
   ↓
Purchase Request
   ↓
Purchase Order
   ↓
Supplier
   ↓
Goods Received
   ↓
Inventory

This reduces unnecessary emergency procurement.

53. Inventory Analytics

Management reports shall include:

Stock turnover
Inventory Turnover =
Cost of Goods Sold
÷
Average Inventory
Days of inventory
Average Inventory
÷
Average Daily Consumption
Stock variance
Physical Stock
-
System Stock
Inventory value

Total stock value by:

Warehouse
Category
Product
Farmer allocation
Processing facility
54. Dead Stock

The system should identify slow-moving and inactive inventory.

Example:

Item:
Packaging Type X

Last movement:
180 days ago

Status:
SLOW MOVING

Management can then determine whether to:

Reallocate
Discount
Return
Consume
Dispose
55. Inventory Loss

The system shall track losses caused by:

Spoilage
Expiry
Damage
Theft
Processing loss
Storage loss

This will help management identify where value is leaking from the business.

56. Circular Economy Integration

Inventory management shall eventually track circular products.

Example:

Pig Waste
   ↓
Biodigester
   ↓
Digestate
   ↓
Organic Fertilizer
   ↓
Inventory
   ↓
Farmers

The system could therefore track:

Fertilizer produced
Fertilizer stored
Fertilizer distributed
Farmer receiving fertilizer
Fertilizer utilization

This creates a digital material-flow record across the circular economy.

57. Renewable Energy Inventory

The future system may also track physical energy-system consumables such as:

Solar components
Batteries
Inverter spare parts
Biogas equipment
Filters
Pumps
Maintenance components

However, actual energy generation should remain under the Renewable Energy Management Module rather than this inventory module.

58. Database Entities

The conceptual database should include:

InventoryItem
InventoryCategory
InventoryLocation
Warehouse
WarehouseZone
StorageBin
InventoryBatch
InventoryBalance
InventoryTransaction
GoodsReceivedNote
GoodsReceivedItem
StockIssue
StockIssueItem
StockTransfer
StockTransferItem
StockReservation
StockAdjustment
Stocktake
StocktakeItem
Supplier
PurchaseOrder
InventoryValuation
ReorderRule
StockAlert
ExpiryRecord
ColdStorageLocation
TemperatureRecord
ProductReturn
InventoryDisposal
InventoryAllocation
59. Core Database Relationship

The basic relationship should be:

INVENTORY ITEM
      │
      ▼
INVENTORY BATCH
      │
      ▼
INVENTORY LOCATION
      │
      ▼
INVENTORY BALANCE
      │
      ▼
INVENTORY TRANSACTIONS

The transaction ledger then becomes the source of truth for stock movement.

60. Key Business Rules
BR-IWM-001

Every inventory item must have a unique identifier.

BR-IWM-002

Every stock movement must create an inventory transaction.

BR-IWM-003

Inventory transactions must not be silently deleted.

BR-IWM-004

Batch-controlled items must retain batch numbers.

BR-IWM-005

Expiry-controlled items must retain expiry information.

BR-IWM-006

Expired stock must not be available for normal allocation.

BR-IWM-007

Quarantined stock must not be available for normal use or sale.

BR-IWM-008

Inventory cannot be issued beyond available stock unless an authorized exception exists.

BR-IWM-009

Stock adjustments require a reason.

BR-IWM-010

Inventory transfers must record both source and destination.

BR-IWM-011

Finished products must reference their production batch.

BR-IWM-012

Inventory allocated to production must be reflected in inventory balances.

BR-IWM-013

Inventory allocated to customer orders must be distinguishable from free stock.

BR-IWM-014

The system shall maintain an auditable inventory history.

BR-IWM-015

Access to inventory operations shall be controlled using role-based permissions.

61. Key Performance Indicators

The module shall provide:

KPI	Purpose
Inventory Value	Working capital monitoring
Stock Turnover	Inventory efficiency
Days of Inventory	Liquidity planning
Stockout Rate	Supply reliability
Expiry Loss	Waste reduction
Stock Variance	Inventory accuracy
Warehouse Utilization	Capacity management
Order Fulfillment Rate	Service quality
Inventory Accuracy	Data reliability
Slow-Moving Stock	Capital efficiency
Feed Stock Days	Production continuity
Product Loss Rate	Food-loss monitoring
Inventory Holding Cost	Financial efficiency
62. Acceptance Criteria

The module shall be considered functionally complete when:

Item Management
 Inventory items can be created.
 SKUs can be assigned.
 Categories can be assigned.
 Units of measurement can be configured.
Warehousing
 Warehouses can be created.
 Storage locations can be created.
 Inventory can be assigned to locations.
Receiving
 Stock can be received.
 GRNs can be created.
 Batch numbers can be recorded.
 Expiry dates can be recorded.
Stock Movement
 Stock can be issued.
 Stock can be transferred.
 Stock can be reserved.
 Stock can be returned.
 Stock can be adjusted.
Control
 Stocktakes can be conducted.
 Variances can be identified.
 Expiry alerts can be generated.
 Low-stock alerts can be generated.
Processing Integration
 Production can consume inventory.
 Production can generate finished inventory.
 Product batches remain traceable.
Traceability
 Inventory transactions can be traced.
 Batch-level traceability works.
 QR/barcode scanning can identify inventory.
Reporting
 Inventory value can be reported.
 Stock levels can be reported.
 Stock movements can be reported.
 Inventory losses can be reported.
63. MVP Scope

For the first version of the PigPower application, I recommend not implementing every warehouse feature immediately.

The MVP should contain:

1. Inventory Item Management
2. Categories
3. Warehouses
4. Storage Locations
5. Stock Receiving
6. Stock Issue
7. Stock Transfer
8. Batch Tracking
9. Expiry Tracking
10. Stock Balance
11. Inventory Ledger
12. Stock Adjustment
13. Basic Stocktake
14. Low-Stock Alerts
15. Finished Product Inventory
16. QR/Barcode Support
17. Basic Inventory Dashboard
18. Role-Based Access
19. Audit Trail

Then Phase 2 can introduce:

Advanced:
→ Purchase Orders
→ Inventory Forecasting
→ FEFO automation
→ Cold-room IoT
→ Temperature alerts
→ Advanced costing
→ AI demand forecasting
→ Automated procurement
→ Advanced warehouse optimization
64. Integration with the Overall PigPower Platform

Inventory should not operate as an isolated module.

The architecture should look like:

                         ┌─────────────────┐
                         │ USER MANAGEMENT │
                         └────────┬────────┘
                                  │
                                  ▼
┌──────────┐       ┌────────────────────────┐
│ FARMERS  │──────▶│                        │
└──────────┘       │                        │
                   │     INVENTORY          │
┌──────────┐       │     MANAGEMENT         │
│   FEED   │──────▶│                        │
└──────────┘       │                        │
                   └───────┬───────┬────────┘
┌──────────┐               │       │
│VETERINARY│───────────────┘       │
└──────────┘                       │
                                   │
┌──────────────┐                   ▼
│  PROCESSING  │──────────────▶ FINISHED
└──────────────┘                PRODUCTS
                                   │
                                   ▼
                              ┌──────────┐
                              │  SALES   │
                              └────┬─────┘
                                   │
                                   ▼
                              DISTRIBUTION

This makes Inventory Management the material-flow backbone of PigPower's digital platform.

65. Strategic Design Decision

There is one important software-engineering principle I recommend we establish now:

Inventory should use an immutable transaction ledger rather than simply storing a single editable "quantity" field.

In other words, instead of relying on:

Feed = 10,000 kg

we maintain:

Opening balance       +10,000
Farmer allocation      -1,000
Farmer allocation        -800
New purchase           +5,000
Production consumption -2,000
Stock adjustment         -100
                       -------
Current balance       11,100 kg

The application can still display:

Current stock: 11,100 kg

but the underlying transactions remain auditable.

This design will become extremely valuable when we later implement financial accounting, farmer settlements, procurement, traceability, fraud controls, offline synchronization and analytics.
