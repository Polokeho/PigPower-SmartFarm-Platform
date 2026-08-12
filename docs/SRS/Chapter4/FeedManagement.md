PigPower SmartFarm Platform
Functional Requirements Specification
Module: Feed Management

Document ID: PSP-SRS-FR-FEED
Version: 1.0
Status: Draft
Parent Document: Software Requirements Specification
Chapter: 4 – Functional Requirements
Project: PigPower Lesotho – Community-Based Circular Pork Economy Platform

1. Module Overview

The Feed Management Module shall manage the procurement, inventory, allocation, distribution, consumption and cost of animal feed across the PigPower farmer network.

The module shall provide visibility from:

Feed Supplier
      ↓
Procurement
      ↓
Central Inventory
      ↓
Regional/Farmer Allocation
      ↓
Farm Inventory
      ↓
Production Cycle
      ↓
Feed Consumption
      ↓
Growth
      ↓
FCR
      ↓
Production Cost
      ↓
Farmer Profitability

The module is therefore not simply an inventory system.

It is a core component of PigPower's production economics and supply-chain management system.

2. Business Purpose

Feed is expected to represent one of the largest variable costs in pig production.

Poor feed management can result in:

Feed shortages
Overstocking
Wastage
Price volatility
Poor feed conversion
Production delays
Increased mortality risk
Higher production costs
Reduced farmer profitability

PigPower therefore requires a centralized digital system capable of answering:

How much feed does the network have, where is it, who needs it, how much has been consumed, and what is its effect on production cost and performance?

3. Objectives

The module shall:

Maintain feed-product information.
Maintain feed suppliers.
Track feed procurement.
Track feed inventory.
Track feed batches/lots.
Track feed expiry where applicable.
Allocate feed to farmers.
Record feed deliveries.
Track farm-level feed inventory.
Record feed consumption.
Monitor feed wastage.
Calculate feed costs.
Calculate feed cost per pig.
Calculate feed cost per kilogram of liveweight.
Calculate FCR.
Forecast future feed requirements.
Generate feed shortage alerts.
Support centralized procurement.
Support farmer feed-credit models where applicable.
Integrate feed data with Production Management.
4. Feed Management Scope
                 FEED MANAGEMENT
                        │
        ┌───────────────┼────────────────┐
        │               │                │
     SUPPLIERS      PROCUREMENT       INVENTORY
        │               │                │
        └───────────────┼────────────────┘
                        ↓
                  FEED ALLOCATION
                        ↓
                 FARM DELIVERY
                        ↓
                 FARM INVENTORY
                        ↓
                FEED CONSUMPTION
                        ↓
             PRODUCTION PERFORMANCE
                        │
             ┌──────────┴──────────┐
             ↓                     ↓
            FCR               PRODUCTION COST
5. User Roles
5.1 Farmer

Can:

View allocated feed
View available feed
Confirm deliveries
Record feed consumption
Report shortages
Report damaged feed
View feed costs
View consumption history
5.2 Field Officer

Can:

View farmer feed requirements
Verify feed inventories
Record deliveries
Monitor consumption
Identify unusual consumption
Report shortages
Assist with stock verification
5.3 Procurement Officer

Can:

Create purchase requests
Create purchase orders
Manage suppliers
Record procurement
Track prices
Monitor supplier performance
5.4 Warehouse Manager

Can:

Receive feed
Manage stock
Record stock movements
Conduct stock counts
Manage feed batches
Record damaged/expired stock
5.5 Finance Officer

Can:

View feed costs
Approve purchases according to workflow
Monitor farmer feed balances
Reconcile feed transactions
5.6 Veterinary/Production Personnel

Can:

Define or approve appropriate feeding programs
Monitor feed-related production performance
Review feed efficiency
6. Feed Product Registry
FR-FEED-001 — Maintain Feed Product

The system shall maintain a registry of feed products.

Each feed product shall contain:

Feed ID
Product name
Feed category
Supplier
Manufacturer
Form
Unit of measure
Nutritional specification where applicable
Recommended production stage
Storage requirements
Active/inactive status

Examples:

Pig Starter
Pig Grower
Pig Finisher
Sow Feed
Boar Feed
Specialized Feed
7. Feed Categories

The system shall support configurable feed categories.

Initial categories may include:

STARTER
GROWER
FINISHER
BREEDER
SOW
BOAR
SPECIALIZED
OTHER

The final categories shall be configurable according to PigPower's production system.

8. Feed Production Stage
FR-FEED-002 — Associate Feed With Production Stage

A feed product may be associated with one or more production stages.

Example:

Starter
   ↓
Weaner

Grower
   ↓
Growing pig

Finisher
   ↓
Market preparation

The system shall not hard-code animal-age assumptions that may differ from PigPower's veterinary and nutrition protocols.

9. Feed Supplier Management
FR-FEED-003 — Maintain Feed Supplier

The system shall store:

Supplier ID
Supplier name
Contact information
Location
Products supplied
Pricing
Payment terms
Delivery terms
Supplier status
10. Supplier Performance
FR-FEED-004 — Monitor Supplier Performance

The system should calculate supplier performance indicators such as:

On-time delivery
Order fulfilment
Price consistency
Product quality issues
Rejected deliveries
Delivery lead time
11. Feed Procurement
FR-FEED-005 — Create Feed Purchase Request

Authorized users shall be able to create purchase requests.

The request shall include:

Feed product
Quantity
Required date
Requesting location
Reason
Estimated price
Requesting user
12. Purchase Order
FR-FEED-006 — Create Purchase Order

Authorized procurement users shall be able to create purchase orders.

The order shall contain:

PO number
Supplier
Feed products
Quantities
Unit prices
Total value
Delivery location
Expected delivery date
Payment terms
Status
13. Procurement Status
DRAFT
SUBMITTED
APPROVED
ORDERED
PARTIALLY_RECEIVED
RECEIVED
CANCELLED
CLOSED
14. Feed Receiving
FR-FEED-007 — Receive Feed

Warehouse personnel shall record feed received.

The receiving record shall include:

PO
Supplier
Product
Quantity
Unit
Batch/lot
Manufacturing date where available
Expiry date where applicable
Condition
Receiving date
Receiver
15. Feed Batch Tracking
FR-FEED-008 — Track Feed Batch

Each received feed batch should have a unique batch/lot reference.

Example:

Feed:
Pig Grower

Supplier:
Supplier A

Lot:
PG-260812-03

Quantity:
500 kg

Batch tracking will support:

Quality control
Recall management
Expiry management
Supplier traceability
16. Feed Quality Inspection
FR-FEED-009 — Record Quality Inspection

When required, receiving personnel shall record:

Packaging condition
Moisture concerns
Contamination
Pest damage
Visible spoilage
Quantity discrepancy
Rejection reason

Feed that fails defined quality criteria shall be placed into a restricted status.

17. Feed Inventory
FR-FEED-010 — Maintain Inventory

The system shall maintain feed inventory by:

Location
Product
Batch
Quantity
Unit
Status

Inventory statuses may include:

AVAILABLE
RESERVED
DAMAGED
QUARANTINED
EXPIRED
REJECTED
18. Inventory Locations

The system shall support multiple inventory locations.

Example:

Central Warehouse
      ↓
Maseru Depot
      ↓
District Storage
      ↓
Farmer Farm

The architecture shall support future regional warehouses.

19. Stock Movement
FR-FEED-011 — Record Stock Movement

The system shall record:

Source location
Destination location
Feed
Batch
Quantity
Date
User
Reason

Example:

Central Warehouse
      ↓
Farm FAR-0015

Pig Grower:
200 kg
20. Stock Transfer
FR-FEED-012 — Transfer Feed

Authorized users shall be able to transfer feed between inventory locations.

The system shall decrease stock at the source and increase stock at the destination only after the appropriate transaction state is reached.

21. Farm Feed Inventory
FR-FEED-013 — Maintain Farm Inventory

Each participating farm shall have a digital feed inventory.

The farmer shall be able to view:

Feed Available
Feed Reserved
Feed Consumed
Feed Remaining
Expected Days of Supply
22. Feed Allocation
FR-FEED-014 — Allocate Feed

Authorized users shall allocate feed to farmers or production cycles.

Allocation information shall include:

Farmer
Farm
Production cycle
Feed type
Quantity
Allocation date
Required date
Cost
Status
23. Feed Delivery
FR-FEED-015 — Record Delivery

The system shall record feed delivery to the farmer.

The delivery shall include:

Farmer
Farm
Product
Batch
Quantity
Delivery date
Driver/vehicle where applicable
Recipient
Proof of delivery
24. Digital Proof of Delivery

The mobile application should support digital confirmation through:

Farmer signature
PIN confirmation
QR scan
Photograph
GPS metadata where permitted

The selected mechanism should be determined during detailed system design.

25. Feed Consumption
FR-FEED-016 — Record Feed Consumption

Farmers or authorized users shall record feed consumed.

Record:

Date
Farm
Production cycle
Feed
Quantity
Unit
Person recording
26. Daily Feed Consumption

The system shall support daily feed records.

Example:

Farm:
FAR-0015

Date:
12 August

Grower feed:
18 kg

Finisher:
0 kg
27. Group Feed Consumption

The system should support consumption by batch where individual-level recording is impractical.

This is important because feed is frequently managed at group/batch level.

28. Feed Balance
FR-FEED-017 — Calculate Feed Balance

The system shall calculate:

Opening Stock
+
Received
+
Transfers In
-
Consumption
-
Transfers Out
-
Wastage
=
Closing Stock
29. Stock Reconciliation
FR-FEED-018 — Reconcile Physical and Digital Stock

Authorized users shall be able to perform stock counts.

The system shall calculate:

Physical Stock
-
System Stock
=
Stock Variance
30. Feed Wastage
FR-FEED-019 — Record Feed Wastage

Users shall be able to record wasted feed.

Reasons may include:

Spillage
Spoilage
Pest damage
Water contamination
Handling losses
Expiry
Other
31. Wastage Rate

The system shall calculate:

Feed Wastage Rate =
Wasted Feed
÷
Feed Issued
× 100

High wastage shall generate an alert where configured.

32. Low Stock Alert
FR-FEED-020 — Generate Low Stock Alert

The system shall calculate projected feed requirements and alert when inventory approaches minimum stock levels.

Example:

⚠ FEED ALERT

Farm: FAR-0023

Feed remaining:
95 kg

Expected consumption:
20 kg/day

Days remaining:
4.75 days

Recommended action:
Schedule delivery
33. Feed Shortage Forecast
FR-FEED-021 — Forecast Feed Shortage

The system shall estimate future feed shortages based on:

Current stock
Expected consumption
Active pigs
Production stage
Scheduled deliveries
Expected production cycles
34. Days of Feed Supply

The platform shall calculate:

Days of Supply =
Available Feed
÷
Average Daily Consumption

This shall be displayed to authorized users.

35. Feed Cost
FR-FEED-022 — Calculate Feed Cost

The system shall calculate feed expenditure.

Example:

500 kg × M6.50/kg
=
M3,250

The system shall support different purchase prices for different batches.

36. Weighted Average Cost

Where multiple feed batches have different purchase prices, the system should support weighted-average costing.

Example:

100 kg @ M6/kg
200 kg @ M7/kg

Total:
300 kg

Weighted cost:
M6.67/kg

The accounting methodology shall ultimately be aligned with PigPower's finance policies.

37. Feed Cost per Pig

The system shall calculate:

Total Feed Cost
÷
Number of Pigs
38. Feed Cost per kg Liveweight

The system shall calculate:

Total Feed Cost
÷
Liveweight Gain / Production Weight

This KPI shall integrate with Production Management.

39. Feed Conversion Ratio
FR-FEED-023 — Calculate FCR

The system shall provide the feed data required to calculate:

FCR =
Feed Consumed
÷
Liveweight Gain

Example:

Feed consumed = 240 kg
Weight gain = 100 kg

FCR = 2.4

The Production Management Module shall be responsible for the production-level performance interpretation.

40. Feed Efficiency

The system shall compare actual feed efficiency against configured targets.

Example:

Target FCR:
2.5

Actual:
2.9

Variance:
+0.4

Status:
BELOW TARGET
41. Feed Program
FR-FEED-024 — Create Feed Program

Authorized production/nutrition personnel shall create feeding programs.

The program may include:

Production stage
Feed type
Expected quantity
Feeding frequency
Start date
End date
Target performance
42. Production Integration

Feed Management shall integrate with Production Management.

Feed Program
      ↓
Feed Allocation
      ↓
Feed Consumption
      ↓
Weight Gain
      ↓
FCR
      ↓
Production Cost
      ↓
Profitability
43. Veterinary Integration

Feed information shall integrate with Veterinary Management where necessary.

Examples:

Special feeding requirements
Recovery diets
Restricted feed
Feed-related health events

Veterinary users shall not be required to manage commercial feed inventory unless explicitly authorized.

44. Feed Forecasting
FR-FEED-025 — Network Feed Forecast

The platform shall estimate future feed requirements across the PigPower network.

Forecast inputs may include:

Number of pigs
Production stages
Average daily consumption
Production-cycle schedules
Historical consumption
Planned farmer onboarding
45. Procurement Forecast

The system should convert projected demand into procurement requirements.

Example:

Expected requirement:
10,000 kg

Available:
3,000 kg

Committed:
2,000 kg

Projected shortage:
5,000 kg
46. Centralized Procurement Advantage

The system shall provide management with aggregate demand information.

Instead of:

Farmer A → buys 100 kg
Farmer B → buys 150 kg
Farmer C → buys 80 kg

PigPower can aggregate:

Network requirement:
10,000 kg

This may improve:

Negotiating power
Supplier pricing
Transport efficiency
Inventory planning
Feed availability
47. Feed Credit

A future version may support feed-credit arrangements.

Example:

PigPower supplies:
M5,000 feed

Farmer sells:
Pigs worth M15,000

Feed advance:
Deducted according to contract

The Feed Management Module should record the feed transaction, while the Finance/Settlement Module should manage the actual financial liability and deduction.

48. Feed Allocation Fairness

The system shall maintain allocation records so management can determine whether feed distribution is consistent with:

Number of pigs
Production stage
Production plan
Farmer agreement
Historical consumption

This helps prevent resource leakage and disputes.

49. Feed Theft / Loss Detection

The system should identify abnormal stock patterns.

For example:

Allocated:
500 kg

Expected consumption:
400 kg

Recorded consumption:
320 kg

Expected remaining:
100 kg

Reported remaining:
20 kg

Variance:
80 kg

The system shall flag this for investigation rather than automatically classify it as theft.

50. Feed Quality Monitoring

The system should support recording:

Product quality complaints
Batch issues
Rejected feed
Contamination reports
Supplier complaints
Animal performance anomalies associated with a feed batch

This could eventually enable batch-level feed-performance analysis.

51. Feed Batch Traceability

The system shall preserve the relationship:

Supplier
 ↓
Purchase Order
 ↓
Feed Batch
 ↓
Warehouse
 ↓
Farmer
 ↓
Production Cycle
 ↓
Pigs

This becomes particularly valuable if a feed quality problem is identified.

52. Feed Recall
FR-FEED-026 — Support Feed Recall

Authorized users shall be able to identify all farms that received a particular feed batch.

Example:

Problematic Batch:
PG-260812-03

Distributed to:
Farm 01
Farm 04
Farm 11
Farm 18

The system shall support notification and quarantine of affected feed inventory.

53. Inventory Expiry
FR-FEED-027 — Monitor Expiry

Where feed has an expiry date, the system shall generate advance warnings.

Example:

Feed batch:
FG-0045

Expires:
30 September

Stock:
420 kg

Action:
Prioritize consumption / review
54. First-In-First-Out

The system should support configurable stock rotation policies such as:

FIFO

or, where appropriate:

FEFO
First Expired, First Out

For products with expiry dates, FEFO may be preferable.

55. Feed Inventory Dashboard
FR-FEED-028 — Warehouse Dashboard

The warehouse dashboard shall display:

TOTAL FEED STOCK
-----------------
Starter       2,500 kg
Grower        4,800 kg
Finisher      3,200 kg

Total:       10,500 kg

Low-stock items:       2
Expiring batches:      1
Pending deliveries:    3
56. Farmer Feed Dashboard

The farmer dashboard shall display:

MY FEED

Available:
185 kg

Reserved:
50 kg

Expected consumption:
18 kg/day

Days of supply:
10.3

Next delivery:
18 August

Current feed cost:
M1,202
57. Management Feed Dashboard

Management shall be able to view:

Total feed stock
Feed value
Feed consumption
Feed requirements
Feed shortages
Feed wastage
Cost/kg
Supplier pricing
Farmer allocations
Production-cycle requirements
58. Feed Cost Analytics

The platform shall provide:

Feed Cost
   ↓
Production Cycle
   ↓
Farm
   ↓
District
   ↓
Network

Management should be able to identify where feed costs are highest.

59. Feed Price Monitoring

The system should track historical feed prices.

Example:

Month	Grower Feed M/kg
Jan	6.20
Feb	6.35
Mar	6.50
Apr	6.80

This information can support procurement planning and financial forecasting.

60. Feed Inflation Alert

The system should identify significant price changes.

Example:

Feed price:
M6.50/kg

New supplier quotation:
M7.30/kg

Increase:
12.3%

⚠ Procurement review required
61. Feed Demand by District

Management shall be able to view demand geographically.

Example:

Maseru       4,500 kg
Mafeteng     2,800 kg
Leribe       3,200 kg
Berea        1,900 kg
Mokhotlong     700 kg

This shall support logistics planning.

62. Offline Functionality

The mobile application shall allow farmers and field officers to record feed information without internet access.

Offline records may include:

Feed receipt
Feed consumption
Feed wastage
Feed stock count
Delivery confirmation

Records shall synchronize when connectivity becomes available.

63. Synchronization

The system shall support:

PENDING
SYNCING
SYNCED
FAILED
CONFLICT

Synchronization conflicts shall be logged and resolved according to defined rules.

64. Notifications

The module shall support alerts for:

Low stock
Feed shortage
Upcoming delivery
Delayed delivery
Expiring feed
Feed-quality issue
High consumption
High wastage
Unusual feed variance
Price increase
65. Business Rules
BR-FEED-001

Every feed inventory transaction shall identify a product.

BR-FEED-002

Inventory quantities shall never become negative through normal system transactions.

BR-FEED-003

Every feed movement shall have a source and destination where applicable.

BR-FEED-004

Feed received into inventory must have a receiving transaction.

BR-FEED-005

Feed batch information shall be retained where supplied by the supplier.

BR-FEED-006

Expired or quarantined feed shall not be allocated through normal workflows.

BR-FEED-007

Feed allocations shall be traceable to a farmer or production cycle.

BR-FEED-008

Consumption records shall not directly modify historical transactions.

BR-FEED-009

Corrections to feed transactions shall be audited.

BR-FEED-010

Physical stock adjustments require authorization.

BR-FEED-011

Feed wastage shall be recorded separately from normal consumption.

BR-FEED-012

Feed forecasts shall be distinguishable from confirmed procurement orders.

BR-FEED-013

FCR calculations require valid consumption and weight-gain data.

BR-FEED-014

Feed-credit balances shall be managed by the financial subsystem.

BR-FEED-015

Feed recalls shall identify affected inventory locations and farmers where possible.

66. Database Entities

The conceptual Feed Management database shall contain:

FeedProduct
FeedCategory
FeedSupplier
FeedPurchaseRequest
FeedPurchaseOrder
FeedPurchaseOrderItem
FeedReceipt
FeedBatch
FeedInventory
FeedInventoryTransaction
FeedAllocation
FeedDelivery
FeedConsumption
FeedWastage
FeedStockCount
FeedProgram
FeedForecast
FeedPriceHistory
FeedQualityInspection
FeedRecall
FeedAlert
67. Conceptual Database Relationship
SUPPLIER
   │
   ▼
PURCHASE ORDER
   │
   ▼
FEED RECEIPT
   │
   ▼
FEED BATCH
   │
   ▼
WAREHOUSE INVENTORY
   │
   ▼
ALLOCATION
   │
   ▼
FARM INVENTORY
   │
   ▼
PRODUCTION CYCLE
   │
   ▼
FEED CONSUMPTION
   │
   ├───────────────┐
   ▼               ▼
FEED COST         FCR
   │               │
   └───────┬───────┘
           ▼
     PRODUCTION COST
           │
           ▼
        PROFITABILITY
68. Integration With Production Management

The relationship between the two modules is critical.

Production Management
        │
        │ Required feed
        ▼
Feed Management
        │
        │ Feed allocated
        ▼
Farmer
        │
        │ Consumption
        ▼
Feed Management
        │
        │ Actual consumption
        ▼
Production Management
        │
        ├── Weight gain
        ├── ADG
        ├── FCR
        └── Production cost

This creates a feedback loop.

69. Integration With Farmer Management

Feed records shall be associated with farmer accounts.

This allows PigPower to calculate:

Feed supplied
Feed consumed
Feed cost
Feed wastage
Feed efficiency
Outstanding feed-credit balance where applicable
70. Integration With Farm Management

Each feed transaction shall be associated with a farm where applicable.

This allows comparison between farms.

Example:

Farm A
FCR = 2.4

Farm B
FCR = 3.1

PigPower can investigate why performance differs.

71. Integration With Procurement

The system should eventually support:

Forecast demand
       ↓
Calculate shortage
       ↓
Generate purchase requirement
       ↓
Procurement
       ↓
Supplier
       ↓
Warehouse

This moves PigPower toward data-driven centralized procurement.

72. Integration With Finance

Feed expenditure shall flow into the financial model.

Feed Purchase
      ↓
Inventory
      ↓
Farmer Allocation
      ↓
Production Cost
      ↓
Farmer Settlement

This will eventually allow the platform to calculate true unit economics.

73. Feed Cost as a Core Unit-Economics Metric

PigPower management should ultimately be able to calculate:

Revenue per pig
-
Piglet cost
-
Feed cost
-
Veterinary cost
-
Transport
-
Other production costs
=
Farmer production margin

This is one of the most important outputs of the entire platform.

74. Feed Forecasting and AI Roadmap

AI should be introduced progressively.

Phase 1 — Rule-based
Current stock
÷
Daily consumption
=
Days of supply
Phase 2 — Statistical

Use historical:

Pig population
Production stages
Seasonal consumption
Farmer behaviour

to improve forecasts.

Phase 3 — Machine Learning

Predict:

Feed demand
Feed shortages
Consumption anomalies
Expected FCR
Feed-price trends
Phase 4 — Optimization

The platform could eventually recommend:

Which feed should be purchased, how much, from which supplier, and when?

This would turn PigPower into a digital agricultural supply-chain optimization platform.

75. Feed Security

Feed security is strategically important for PigPower.

The platform should monitor:

Feed Supply
     +
Feed Inventory
     +
Production Demand
     =
Feed Security

Management should be alerted before shortages affect production.

76. Key Feed KPIs
KPI	Purpose
Feed Cost/kg	Procurement efficiency
Feed Cost/pig	Unit economics
Feed Cost/kg liveweight	Production economics
FCR	Biological efficiency
Feed Wastage Rate	Operational efficiency
Days of Feed Supply	Supply security
Stock Variance	Inventory control
Supplier On-Time Delivery	Supply reliability
Feed Price Variance	Procurement monitoring
Feed Forecast Accuracy	Planning
Feed Availability Rate	Farmer support
Consumption Variance	Production monitoring
77. Acceptance Criteria

The module shall be considered functionally complete when:

Product Management
 Feed products can be created.
 Feed categories can be configured.
 Feed products can be associated with production stages.
Procurement
 Purchase requests can be created.
 Purchase orders can be created.
 Feed receipts can be recorded.
 Supplier information can be maintained.
Inventory
 Feed inventory can be tracked.
 Feed batches can be tracked.
 Stock transfers can be recorded.
 Stock counts can be performed.
 Stock variances can be identified.
Farmer Distribution
 Feed can be allocated.
 Deliveries can be recorded.
 Farmers can confirm deliveries.
 Farm-level stock can be tracked.
Consumption
 Feed consumption can be recorded.
 Feed wastage can be recorded.
 Feed balances can be calculated.
Analytics
 Feed costs can be calculated.
 Feed cost per pig can be calculated.
 Feed cost per kg can be calculated.
 FCR data can be calculated.
 Feed demand can be forecast.
Alerts
 Low-stock alerts work.
 Shortage forecasts work.
 Expiry alerts work.
 Abnormal consumption alerts work.
Integration
 Production Management receives feed-consumption information.
 Farmer records are linked.
 Farm records are linked.
 Procurement information is integrated.
 Financial records can receive feed-cost information.
Offline
 Feed consumption can be recorded offline.
 Delivery records can be captured offline.
 Records synchronize when connectivity returns.
78. MVP Scope

For the first PigPower MVP, I recommend implementing only:

Phase 1
Feed Product Registry
Supplier Registry
Feed Inventory
Feed Batch Tracking
Feed Allocation
Feed Delivery
Farm Feed Inventory
Feed Consumption
Feed Wastage
Feed Cost
Low Stock Alerts
Days of Feed Supply
Basic FCR
Production Integration
Offline Data Capture
Synchronization
Phase 2

Add:

Purchase Orders
Supplier performance
Feed forecasting
Price monitoring
Digital proof of delivery
Stock optimization
Feed-credit integration
Phase 3

Add:

AI demand forecasting
Feed-price forecasting
Automated procurement recommendations
Advanced anomaly detection
Supplier optimization
79. Strategic Importance

Feed Management creates one of the most important data loops in the PigPower platform:

                FARMER
                   │
                   ▼
              PIGS / BATCH
                   │
                   ▼
             PRODUCTION
                   │
                   ▼
            FEED REQUIREMENT
                   │
                   ▼
              PROCUREMENT
                   │
                   ▼
                FEED
                   │
                   ▼
              CONSUMPTION
                   │
                   ▼
              WEIGHT GAIN
                   │
          ┌────────┴────────┐
          ▼                 ▼
         FCR          PRODUCTION COST
          │                 │
          └────────┬────────┘
                   ▼
              PROFITABILITY
                   │
                   ▼
             FARMER INCOME

This is strategically important because PigPower's competitive advantage should not simply be that it supplies farmers with piglets and feed.

The platform should know:

What inputs each farmer received → how those inputs were used → what production they generated → what that production cost → what the farmer earned → and what PigPower ultimately earned.

That is the foundation for the data-driven contract-farming model we are designing.