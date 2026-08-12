PigPower SmartFarm Platform
Functional Requirements Specification
Module: Processing & Meat Production Management

Document ID: PSP-SRS-FR-PRO
Version: 1.0
Status: Draft
Parent Document: Software Requirements Specification
Chapter: 4 – Functional Requirements
Project: PigPower Lesotho – Community-Based Circular Pork Economy Platform

1. Module Overview

The Processing & Meat Production Management Module shall manage the transformation of pigs received from PigPower's farmer network into safe, traceable, standardized pork products.

The module shall provide digital coordination and traceability across:

LIVE PIGS
   ↓
PROCESSING RECEIVING
   ↓
PRE-PROCESSING
   ↓
SLAUGHTER
   ↓
CARCASS IDENTIFICATION
   ↓
CARCASS PROCESSING
   ↓
CUTTING
   ↓
VALUE-ADDED PROCESSING
   ↓
PACKAGING
   ↓
QUALITY CONTROL
   ↓
FINISHED PRODUCTS
   ↓
INVENTORY
   ↓
DISTRIBUTION

The module shall support both fresh pork production and value-added products, including:

Fresh pork
Pork cuts
Sausages
Bacon
Ham
Smoked pork
Minced pork
Other approved pork products

The system shall be designed so that PigPower can initially operate a relatively simple processing workflow and progressively introduce more sophisticated processing capabilities.

2. Business Purpose

PigPower's business model is not limited to selling live pigs.

The primary commercial objective is to increase value captured from each animal by transforming livestock into standardized, branded meat products.

For example:

Live Pig
   ↓
Carcass
   ↓
Primary Cuts
   ↓
Fresh Pork

or:

Live Pig
   ↓
Carcass
   ↓
Trim
   ↓
Sausage

or:

Live Pig
   ↓
Carcass
   ↓
Leg
   ↓
Curing
   ↓
Ham

The software must therefore allow PigPower to determine:

Which pigs went into which processing batch, what products were produced, how much was produced, where it is stored, and ultimately which customers received it?

3. Objectives

The module shall:

Register incoming livestock.
Verify incoming collection records.
Create processing batches.
Link pigs to processing batches.
Record slaughter/processing events.
Record carcass weights.
Track yield.
Manage carcass identification.
Manage cutting operations.
Manage value-added production.
Track ingredients and materials.
Track production quantities.
Manage product batches.
Support quality-control records.
Support food-safety traceability.
Manage packaging.
Generate product labels.
Transfer finished products to inventory.
Support product recall.
Provide processing analytics.
Calculate production yields.
Calculate processing costs.
Support production planning.
Integrate with sales and distribution.
4. Scope

The module shall cover:

Livestock receiving
Collection → Processing Facility
Primary processing
Pig → Carcass
Secondary processing
Carcass → Cuts
Value-added processing
Cuts / Trim → Sausage / Bacon / Ham / Smoked Products
Packaging
Processed Product → Packaged Product
Inventory transfer
Production → Finished Goods Inventory
5. User Roles
5.1 Processing Manager

Can:

Create production batches
Schedule processing
Assign processing activities
Monitor production
Approve production records
Review yields
5.2 Processing Operator

Can:

View assigned production tasks
Record processing events
Record quantities
Record weights
Record wastage
Update production status
5.3 Quality-Control Officer

Can:

Perform quality checks
Record inspection results
Place batches on hold
Release batches
Record non-conformances
5.4 Slaughter/Receiving Officer

Can:

Receive pigs
Verify quantities
Record weights
Confirm receiving
Record discrepancies
5.5 Inventory Manager

Can:

Receive finished products
Manage stock
Track product batches
Transfer inventory
5.6 Sales/Distribution Officer

Can:

View available finished products
Allocate products to orders
Create delivery requests
5.7 Management

Can view:

Production volumes
Product yields
Processing costs
Revenue potential
Production efficiency
Waste
Product profitability
6. Processing Facility
FR-PRO-001 — Register Processing Facility

The system shall maintain processing facility information.

Fields shall include:

Facility ID
Facility name
Location
Contact information
Operating status
Processing capacity
Approved product categories
Storage capacity
Cold-storage capacity
7. Processing Capacity

The system shall maintain configurable capacity information.

Example:

Daily processing capacity:
50 pigs

Current scheduled:
42 pigs

Remaining:
8 pigs

Capacity may be defined by:

Pigs/day
Liveweight/day
Carcass weight/day
Product capacity
Shift capacity
8. Livestock Receiving
FR-PRO-002 — Receive Livestock

When pigs arrive at the processing facility, the receiving officer shall record:

Trip ID
Collection ID
Farm
Farmer
Pig batch
Number received
Estimated weight
Actual weight where available
Arrival time
Receiving officer
Veterinary status
Receiving status
9. Receiving Reconciliation

The system shall compare:

Collection Quantity
        VS
Processing Receiving Quantity

Example:

Collected:
30 pigs

Received:
29 pigs

Variance:
1 pig

A discrepancy record shall be automatically generated.

10. Receiving Status
EXPECTED
ARRIVED
UNDER_INSPECTION
ACCEPTED
PARTIALLY_ACCEPTED
REJECTED
QUARANTINED
TRANSFERRED
11. Pre-Processing Verification

Before processing, the system shall support verification of required conditions.

Possible checks include:

Animal identity
Batch identity
Veterinary status
Required documentation
Withdrawal status
Receiving condition
Facility readiness

The system shall not replace professional veterinary or regulatory inspection.

12. Processing Batch
FR-PRO-003 — Create Processing Batch

The Processing Manager shall create a processing batch.

Example:

Processing Batch:
PB-2026-00023

Date:
20 August 2026

Source:
8 farms

Animals:
42 pigs

Estimated liveweight:
4,180 kg
13. Batch Traceability

Every processing batch shall maintain a relationship to its source livestock.

PB-2026-00023
      │
      ├── Collection COL-001
      │       └── Farm A
      │
      ├── Collection COL-002
      │       └── Farm B
      │
      └── Collection COL-003
              └── Farm C

This enables backward traceability.

14. Processing Batch Status
PLANNED
SCHEDULED
RECEIVED
INSPECTION
PROCESSING
CUTTING
VALUE_ADDED_PROCESSING
PACKAGING
QUALITY_CONTROL
RELEASED
COMPLETED
ON_HOLD
REJECTED
CANCELLED
15. Slaughter Processing Record
FR-PRO-004 — Record Primary Processing

The system shall record the primary processing event.

Information shall include:

Processing batch
Number processed
Start time
End time
Operator
Liveweight
Carcass weight
Processing status
16. Carcass Identification

Each carcass shall be traceable to its processing batch.

The system may assign:

Carcass ID:
CAR-2026-000045

The relationship shall be:

Farmer
 ↓
Pig Batch
 ↓
Collection
 ↓
Processing Batch
 ↓
Carcass
17. Carcass Weight
FR-PRO-005 — Record Carcass Weight

The system shall record carcass weight.

Example:

Liveweight:
102 kg

Carcass weight:
78 kg

Dressing percentage:
76.47%

The system shall calculate the dressing percentage automatically.

Dressing % =
Carcass Weight ÷ Liveweight × 100
18. Yield Management

The system shall calculate:

Liveweight
Carcass weight
Cutting yield
Product yield
Trim
By-products
Waste

Example:

Liveweight              100 kg
Carcass                  76 kg
Saleable cuts            63 kg
Processing products       8 kg
By-products               4 kg
Waste                     1 kg

The actual categories shall be configurable according to PigPower's operating procedures.

19. Cutting Management
FR-PRO-006 — Record Cutting Batch

The system shall support conversion of carcasses into cuts.

Potential products include:

Pork loin
Pork shoulder
Pork leg
Pork belly
Ribs
Chops
Mince
Trim

The exact product catalogue shall be configurable.

20. Cutting Yield

The system shall calculate:

Cutting Yield =
Saleable Cut Weight
÷
Carcass Weight
× 100

This will allow management to identify processing efficiency.

21. Value-Added Production

The system shall support production batches for:

Sausages
Pork trim
+
Ingredients
+
Casings
↓
Sausage
Bacon
Pork belly
↓
Curing
↓
Smoking / Processing
↓
Bacon
Ham
Pork leg
↓
Curing
↓
Processing
↓
Ham
Smoked products
Pork
↓
Curing
↓
Smoking
↓
Packaged Product
22. Product Recipe
FR-PRO-007 — Product Recipe Management

The system shall support configurable recipes.

A recipe may contain:

Product
Ingredients
Ingredient quantities
Processing steps
Expected yield
Packaging requirements

Example:

Product:
Pork Sausage

Batch size:
100 kg

Inputs:
Pork
Spices
Salt
Other approved ingredients
Casings

Expected output:
95 kg

The exact formulation shall be controlled by authorized personnel.

23. Bill of Materials

Each value-added product shall have a Bill of Materials (BOM).

Example:

SAUSAGE-001

Pork:
80 kg

Spices:
5 kg

Other ingredients:
10 kg

Casings:
5 kg

The system shall use BOM information for inventory consumption.

24. Ingredient Inventory Integration

When a production batch is completed, the system should automatically deduct consumed ingredients from inventory.

Ingredient Inventory
       ↓
Production Batch
       ↓
Consumption
       ↓
Updated Inventory
25. Production Batch
FR-PRO-008 — Create Value-Added Production Batch

Example:

Batch:
SUS-2026-0012

Product:
Pork Sausage

Input:
80 kg pork

Output:
76 kg sausage

Status:
QUALITY CONTROL
26. Production Yield

The system shall calculate:

Production Yield =
Finished Product Weight
÷
Raw Material Weight
× 100

This allows management to monitor product efficiency.

27. Packaging
FR-PRO-009 — Record Packaging

The system shall record:

Product
Product batch
Packaging type
Pack size
Number of packs
Total weight
Packaging date
Expiry/best-before date where applicable

Example:

Product:
Pork Sausage

Pack size:
500 g

Number of packs:
152

Total:
76 kg
28. Product Batch Number

Every finished product batch shall receive a unique batch number.

Example:

PS-2026-08-001

The batch number shall be linked to the production batch and source material.

29. QR Code Product Traceability

The system should generate a QR code for eligible products.

Scanning the QR code may provide controlled information such as:

Product:
PigPower Premium Pork Sausage

Batch:
PS-2026-08-001

Production Date:
20 August 2026

Best Before:
Configured date

Traceability:
PigPower production network

Sensitive internal information should not be publicly exposed.

30. Quality Control
FR-PRO-010 — Quality Inspection

The Quality-Control Officer shall be able to create inspection records.

Possible parameters:

Appearance
Odour
Packaging integrity
Weight
Temperature
Labelling
Product specification
Other approved QC parameters
31. Quality Status
PENDING
PASSED
FAILED
ON_HOLD
REQUIRES_RETEST
RELEASED

A product batch that fails required checks shall not automatically become available for sale.

32. Non-Conformance
FR-PRO-011 — Record Non-Conformance

The system shall record:

Batch
Product
Issue
Severity
Detection date
Detected by
Corrective action
Resolution
Approval
33. Product Hold

Authorized quality personnel shall be able to place a product batch on hold.

Example:

Batch:
PS-2026-08-001

Status:
ON HOLD

Reason:
Quality investigation

The system shall prevent normal sales allocation while the batch is on hold.

34. Product Release
FR-PRO-012 — Release Product Batch

Only authorized users shall be able to release a batch after required quality checks.

The release event shall be audited.

35. Finished Goods Inventory

Once a batch is released:

Production
   ↓
Quality Control
   ↓
Released
   ↓
Finished Goods Inventory

The inventory system shall receive:

Product
Batch
Quantity
Weight
Location
Production date
Expiry/best-before information where applicable
Status
36. Inventory Status
PRODUCED
IN_STORAGE
ALLOCATED
DISPATCHED
SOLD
RETURNED
ON_HOLD
RECALLED
DISPOSED
37. Cold Storage Integration

The module shall integrate with cold-storage operations.

The system should record:

Storage location
Product batch
Quantity
Entry time
Exit time
Temperature records where available
38. FIFO / FEFO

The system should support:

FIFO

First In, First Out.

FEFO

First Expired, First Out.

For perishable products, FEFO should be the preferred inventory allocation method, subject to PigPower's food-safety procedures.

39. Product Recall
FR-PRO-013 — Product Recall

The system shall support product recalls.

Management shall be able to identify:

Product Batch
      ↓
Production Batch
      ↓
Source Carcass
      ↓
Collection
      ↓
Farm

This enables targeted rather than unnecessarily broad recalls.

40. Forward Traceability

The system shall also support:

Processing Batch
      ↓
Product Batch
      ↓
Inventory
      ↓
Sales Order
      ↓
Customer

Therefore PigPower can answer both:

Where did this product come from?

and:

Where did products from this processing batch go?

41. Waste Management

The module shall record processing waste and by-products.

Potential categories:

Bones
Fat
Trim
Organic waste
Other processing by-products

The system should distinguish between:

SALEABLE
BY-PRODUCT
REUSABLE
WASTE
42. Circular Economy Integration

This module shall integrate with PigPower's circular-economy architecture.

For example:

Pig
 ↓
Meat Processing
 ↓
Pork Products
 ↓
Market

while processing waste can flow into:

Processing Waste
       ↓
Organic Waste Stream
       ↓
Biodigester
       ↓
Biogas
       +
Digestate

The system should therefore eventually allow the company to quantify:

Processing waste
Waste diverted to energy
Biogas production
Organic fertilizer production

This connects the processing module to the future Renewable Energy & Circular Economy Module.

43. Production Costing
FR-PRO-014 — Calculate Production Cost

The system should calculate production cost using configurable components:

Raw material
+
Ingredients
+
Labour
+
Energy
+
Packaging
+
Processing
+
Cold storage
+
Other overheads
=
Production Cost

This is essential for determining product profitability.

44. Product Unit Cost

The system shall calculate:

Unit Cost =
Total Production Cost
÷
Finished Product Quantity

Example:

Production cost:
M7,600

Output:
760 kg

Unit cost:
M10/kg
45. Product Margin

When sales pricing is available:

Gross Margin =
Selling Price
-
Unit Production Cost

Management should be able to compare margins across:

Fresh pork
Sausage
Bacon
Ham
Smoked products
46. Production Planning

The system shall allow management to plan production based on:

Available pigs
Carcass inventory
Customer orders
Product demand
Existing inventory
Processing capacity
Ingredients
Packaging availability

Example:

Customer demand:

Sausage:
500 kg

Bacon:
200 kg

Fresh pork:
800 kg

The system can then generate production requirements.

47. Production Scheduling

Production schedules shall contain:

Production date
Product
Batch
Required raw materials
Required quantity
Production line/workstation
Assigned operators
Expected output
Status
48. Production Status
PLANNED
SCHEDULED
MATERIALS_READY
IN_PROGRESS
PAUSED
COMPLETED
QC_PENDING
RELEASED
CANCELLED
49. Production Shortage

If required raw materials are unavailable, the system shall flag the production batch.

Example:

Production:
Sausage Batch 003

Required pork:
100 kg

Available:
80 kg

Shortage:
20 kg
50. Production Dashboard

Management dashboard:

TODAY'S PRODUCTION
------------------

Pigs processed:       42
Carcass output:     3,180 kg

Fresh pork:         1,400 kg
Sausage:              650 kg
Bacon:                420 kg
Ham:                  300 kg
Other products:       210 kg

Total finished:
2,980 kg
51. Processing Efficiency

The system shall calculate:

Throughput
Pigs processed/day
Processing yield
Finished output ÷ raw input
Capacity utilization
Actual production ÷ available capacity
Downtime
Scheduled production time
-
Actual operating time
52. Production Loss Analysis

The system shall identify differences between:

Expected Yield
vs
Actual Yield

Example:

Expected:
70%

Actual:
64%

Variance:
-6 percentage points

This should trigger investigation where configured thresholds are exceeded.

53. Equipment Integration

Future versions may integrate processing equipment.

Potential data sources include:

Scales
Temperature sensors
Cold-room sensors
Production counters
IoT equipment
Energy meters

The software architecture should therefore expose an integration layer rather than tightly coupling the application to a specific hardware vendor.

54. Energy Consumption

The system should eventually record energy consumed during processing.

Possible inputs:

Electricity
Solar energy
Biogas
Generator
Other energy sources

This enables:

Energy Cost per kg

and supports PigPower's circular-energy strategy.

55. Renewable Energy Integration

Future processing analytics should show:

Processing Energy Demand
          ↓
Solar Energy
+
Biogas Energy
+
Grid Energy

Management can therefore determine the percentage of processing energy supplied by renewable sources.

56. Product Catalogue

The system shall maintain a configurable product catalogue.

Example:

Category	Product
Fresh Pork	Pork Chops
Fresh Pork	Pork Shoulder
Fresh Pork	Pork Belly
Fresh Pork	Pork Loin
Processed	Sausage
Processed	Bacon
Processed	Ham
Smoked	Smoked Pork

Products should have:

Product ID
Product name
Category
Unit
Pack size
Recipe/BOM where applicable
Storage requirements
Status
57. Product Lifecycle
PRODUCT DESIGN
      ↓
RECIPE
      ↓
PRODUCTION
      ↓
QUALITY CONTROL
      ↓
RELEASE
      ↓
INVENTORY
      ↓
SALES
      ↓
DISTRIBUTION
58. Database Entities

The conceptual database shall include:

ProcessingFacility
ProcessingBatch
ProcessingEvent
Carcass
CarcassWeight
CuttingBatch
CuttingOutput
Product
ProductRecipe
RecipeIngredient
ProductionBatch
ProductionInput
ProductionOutput
PackagingRecord
ProductBatch
QualityInspection
QualityParameter
NonConformance
ProductHold
ProductRelease
ProductionWaste
ProcessingByProduct
ProcessingEquipment
ProcessingDowntime
ProductionCost
ProductionSchedule
ProcessingCapacity
ProductRecall
TraceabilityEvent
59. Core Relationships
COLLECTION
    │
    ▼
PROCESSING BATCH
    │
    ▼
CARCASS
    │
    ▼
CUTTING BATCH
    │
    ├───────────────┐
    ▼               ▼
FRESH CUTS      RAW MATERIAL
                    │
                    ▼
             VALUE-ADDED BATCH
                    │
          ┌─────────┼─────────┐
          ▼         ▼         ▼
       SAUSAGE     BACON      HAM
          │         │         │
          └─────────┼─────────┘
                    ▼
               PRODUCT BATCH
                    │
                    ▼
              QUALITY CONTROL
                    │
                    ▼
              FINISHED GOODS
60. End-to-End Traceability Architecture

The ultimate traceability chain shall be:

FARMER
   ↓
FARM
   ↓
PIG
   ↓
PIG BATCH
   ↓
PRODUCTION CYCLE
   ↓
COLLECTION
   ↓
TRANSPORT
   ↓
PROCESSING BATCH
   ↓
CARCASS
   ↓
CUTTING
   ↓
PRODUCTION BATCH
   ↓
PRODUCT BATCH
   ↓
PACKAGING
   ↓
INVENTORY
   ↓
SALES ORDER
   ↓
CUSTOMER

This should become one of PigPower's most important technology differentiators.

61. Business Rules
BR-PRO-001

Every processing batch must have an identifiable source.

BR-PRO-002

Livestock cannot enter processing without the required receiving and health-status checks.

BR-PRO-003

Every carcass must be associated with a processing batch.

BR-PRO-004

Every finished product batch must be traceable to its production inputs.

BR-PRO-005

Products on quality hold cannot be allocated for normal sale.

BR-PRO-006

Only authorized users may release products from quality hold.

BR-PRO-007

Production cannot consume inventory quantities that do not exist unless an authorized adjustment is recorded.

BR-PRO-008

Production outputs must be recorded before a production batch is closed.

BR-PRO-009

Finished product batches must have unique identifiers.

BR-PRO-010

Inventory generated from production must reference the originating product batch.

BR-PRO-011

A recalled product batch must be prevented from normal sale/distribution.

BR-PRO-012

Changes to completed production records must be auditable.

BR-PRO-013

Processing discrepancies must be recorded and investigated according to operational procedures.

BR-PRO-014

Production recipes/BOMs may only be modified by authorized users.

BR-PRO-015

The system shall retain traceability history for completed batches.

62. Key Performance Indicators

The module shall calculate:

KPI	Description
Pigs Processed/Day	Processing throughput
Liveweight Processed	Total input
Carcass Yield	Carcass efficiency
Cutting Yield	Saleable cut efficiency
Product Yield	Finished product efficiency
Capacity Utilization	Facility utilization
Processing Cost/kg	Unit economics
Energy Cost/kg	Energy efficiency
Waste %	Waste control
Product Rejection Rate	Quality
Production Downtime	Operational efficiency
Batch Completion Rate	Production reliability
Average Processing Time	Throughput
Product Gross Margin	Commercial performance
Recall Traceability Time	Food-safety capability
63. Acceptance Criteria

The module shall be considered functionally complete when:

Receiving
 Livestock can be received.
 Collection records can be reconciled.
 Receiving discrepancies can be recorded.
Processing
 Processing batches can be created.
 Carcasses can be registered.
 Carcass weights can be recorded.
 Processing events can be recorded.
Production
 Cuts can be recorded.
 Value-added production batches can be created.
 Recipes can be defined.
 Ingredients can be consumed from inventory.
 Production output can be recorded.
Quality
 Quality inspections can be recorded.
 Products can be placed on hold.
 Products can be released.
 Non-conformances can be recorded.
Traceability
 Finished products can be traced backwards.
 Processing batches can be traced to farms.
 Products can be traced forward to customers.
 Product batches have unique identifiers.
Inventory
 Finished products can enter inventory.
 Product batches can be tracked.
 Products can be allocated to sales.
 Recalled products can be identified.
Analytics
 Yield is calculated.
 Capacity utilization is calculated.
 Production cost can be calculated.
 Product margins can be calculated.
 Waste can be monitored.
64. MVP Recommendation

For the first working PigPower application, do not build the entire industrial processing system at once.

The MVP should implement:

1. Livestock Receiving
2. Processing Batch
3. Carcass Recording
4. Weight Recording
5. Basic Cutting
6. Product Catalogue
7. Production Batch
8. Product Batch
9. Quality Inspection
10. Product Release
11. Finished Goods Inventory
12. Basic Traceability
13. QR Code
14. Production Dashboard
15. Yield Calculation

Then expand into:

Phase 2
→ Recipes/BOM
→ Advanced value-added processing
→ Production costing
→ Waste management
→ Cold-chain integration
→ Recall management

Phase 3
→ IoT equipment
→ Energy monitoring
→ AI production forecasting
→ Predictive maintenance
→ Advanced optimization
65. Strategic Importance to PigPower

This module transforms PigPower from a pig aggregation company into a vertically integrated agri-food platform.

The economic model becomes:

                 FARMERS
                    │
                    ▼
              PIG PRODUCTION
                    │
                    ▼
               AGGREGATION
                    │
                    ▼
                PROCESSING
                    │
          ┌─────────┼─────────┐
          ▼         ▼         ▼
       FRESH      BACON     SAUSAGE
        PORK       HAM       SMOKED
          │         │         │
          └─────────┼─────────┘
                    ▼
              NATIONAL BRAND
                    │
                    ▼
               DISTRIBUTION
                    │
                    ▼
                 MARKET

And alongside it:

PROCESSING WASTE
       ↓
BIODIGESTER
       ↓
BIOGAS
       ↓
ENERGY
       ↓
PROCESSING FACILITY

with:

DIGESTATE
   ↓
ORGANIC FERTILIZER
   ↓
FARMERS

That is the core of the Community-Based Circular Pork Economy Platform.

Where we go next

We now have the major livestock-side modules through processing:

Chapter 4
│
├── Authentication
├── User Management
├── Farmer Management
├── Farm Management
├── Pig Management
├── Production Management
├── Veterinary Management
├── Feed Management
├── Collection & Logistics Management
└── Processing & Meat Production Management  ← CURRENT
