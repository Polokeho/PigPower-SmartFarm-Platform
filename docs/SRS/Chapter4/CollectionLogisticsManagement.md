PigPower SmartFarm Platform
Functional Requirements Specification
Module: Collection & Logistics Management

Document ID: PSP-SRS-FR-LOG
Version: 1.0
Status: Draft
Parent Document: Software Requirements Specification
Chapter: 4 – Functional Requirements
Project: PigPower Lesotho – Community-Based Circular Pork Economy Platform

1. Module Overview

The Collection & Logistics Management Module shall manage the physical movement of pigs, feed, veterinary supplies, equipment, and other approved materials between PigPower's distributed farms, collection points, warehouses, processing facilities, and markets.

The module shall provide visibility across the livestock supply chain:

FARM
 │
 │ Production-ready pigs
 ▼
COLLECTION REQUEST
 │
 ▼
ROUTE PLANNING
 │
 ▼
VEHICLE + DRIVER ASSIGNMENT
 │
 ▼
FARM COLLECTION
 │
 ▼
COLLECTION / HOLDING POINT
 │
 ▼
PROCESSING FACILITY
 │
 ▼
PROCESSING
 │
 ▼
DISTRIBUTION
 │
 ▼
CUSTOMER / MARKET

The module must maintain a strong relationship between:

farmer → farm → pig batch → collection → transport → processing → market.

This traceability is fundamental to PigPower's commercial model.

2. Business Purpose

PigPower will operate a distributed production network.

As the number of participating farmers increases, manually coordinating collections becomes increasingly inefficient.

The system therefore needs to answer:

Which pigs are ready for collection, where are they located, when should they be collected, which vehicle and driver should perform the collection, where are they going, and what happened during the journey?

The module shall help PigPower minimize:

Empty vehicle trips
Transport costs
Delayed collections
Animal welfare incidents
Route inefficiencies
Vehicle downtime
Processing-facility shortages
Processing-facility overloading
Lost or incorrect livestock records
Delivery disputes
3. Objectives

The module shall:

Create collection requests.
Identify pigs ready for collection.
Schedule collections.
Group collections geographically.
Create optimized routes.
Assign vehicles.
Assign drivers.
Track vehicle availability.
Record livestock loading.
Record transport events.
Confirm arrival at collection/processing locations.
Track transport status.
Record livestock quantities.
Record discrepancies.
Support route planning.
Support proof of collection.
Support proof of delivery.
Monitor transport costs.
Track vehicle utilization.
Support cold-chain logistics for processed products.
Integrate collection with production.
Integrate collection with processing.
Provide logistics analytics.
4. Scope

The module shall initially cover:

Inbound logistics
Farmer → Collection Point → Processing Facility
Internal logistics
Warehouse → Farm
Processing Facility → Distribution Centre
Outbound logistics
Processing Facility → Distributor → Retailer / Customer
Future logistics
Processing Facility → Regional Market → Export Market
5. User Roles
5.1 Farmer

Can:

Request collection
View scheduled collection
View estimated collection date
Confirm collection
Confirm quantity collected
Report collection problems
View collection history
5.2 Field Officer

Can:

Create collection requests
Verify pigs ready for collection
Coordinate farmers
Confirm farm readiness
Monitor collection
Record discrepancies
5.3 Logistics Coordinator

Can:

Schedule collections
Create routes
Assign vehicles
Assign drivers
Monitor active trips
Reschedule collections
View logistics KPIs
5.4 Driver

Can:

View assigned route
Navigate to farms
Confirm arrival
Record loading
Record departure
Record incidents
Confirm delivery
5.5 Processing Manager

Can:

View incoming collections
Confirm receiving capacity
Accept or reject incoming loads according to defined procedures
Confirm arrival
Record receiving quantities
Report discrepancies
5.6 Warehouse Manager

Can:

Manage warehouse deliveries
Confirm material receipts
Manage internal logistics
5.7 Fleet Manager

Can:

Register vehicles
Monitor vehicle availability
Track maintenance status
Monitor mileage
Manage vehicle capacity
5.8 Management

Can view:

Logistics performance
Transport costs
Collection volumes
Vehicle utilization
Route performance
Farmer collection performance
Processing supply forecasts
6. Collection Request
FR-LOG-001 — Create Collection Request

The system shall allow an authorized user to create a collection request.

The request shall contain:

Collection ID
Farmer ID
Farm ID
Production cycle
Pig batch
Number of pigs
Estimated weight
Requested collection date
Priority
Destination
Status

Example:

Collection:
COL-000152

Farmer:
FAR-0017

Farm:
FARM-0017

Pigs:
18

Estimated weight:
1,620 kg

Destination:
PigPower Processing Facility

Requested date:
20 August
7. Collection Eligibility

The system shall identify whether pigs are eligible for collection based on configured production rules.

Possible criteria include:

Target market weight
Production-cycle status
Veterinary clearance
Health status
Withdrawal periods
Farmer contract requirements
Processing demand

The system shall not independently make veterinary decisions.

Where health clearance is required, it must rely on the Veterinary Management Module.

8. Collection Status

Collection requests shall support:

DRAFT
REQUESTED
VERIFIED
APPROVED
SCHEDULED
ASSIGNED
IN_PROGRESS
COLLECTED
IN_TRANSIT
DELIVERED
RECEIVED
COMPLETED
CANCELLED
FAILED
9. Collection Verification
FR-LOG-002 — Verify Collection

A Field Officer or authorized user shall verify that the animals are ready for collection.

Verification may include:

Number of pigs
Estimated weight
Health status
Veterinary clearance
Farmer readiness
Farm accessibility
10. Collection Scheduling
FR-LOG-003 — Schedule Collection

The logistics coordinator shall be able to schedule collections.

The system shall consider:

Requested collection date
Farm location
Number of pigs
Estimated weight
Vehicle availability
Vehicle capacity
Driver availability
Processing capacity
Route distance
Priority
Animal welfare considerations
11. Geographic Clustering
FR-LOG-004 — Group Nearby Collections

The system should allow nearby farms to be grouped into a collection route.

Example:

Route R-001

Farm A
   ↓
Farm B
   ↓
Farm C
   ↓
Processing Facility

This reduces unnecessary travel.

12. Route Planning
FR-LOG-005 — Create Route

The system shall create a route containing:

Route ID
Date
Vehicle
Driver
Collection points
Destination
Estimated distance
Estimated duration
Planned sequence
Status
13. Route Optimization

The system should support optimization based on:

Distance
+
Vehicle capacity
+
Farm locations
+
Collection windows
+
Processing capacity
+
Animal welfare
=
Optimal route

Advanced optimization may be implemented in later versions.

14. Vehicle Management
FR-LOG-006 — Register Vehicle

The system shall maintain:

Vehicle ID
Registration number
Vehicle type
Capacity
Owner
Status
Insurance status
Inspection status
Maintenance status
15. Vehicle Status
AVAILABLE
ASSIGNED
IN_TRANSIT
MAINTENANCE
OUT_OF_SERVICE
RESERVED
16. Vehicle Capacity

The system shall prevent assignment of loads that exceed configured vehicle capacity.

Capacity may be represented by:

Number of pigs
Weight
Volume
Other operational constraints

The system shall support configurable limits.

17. Driver Management
FR-LOG-007 — Maintain Driver

Driver records shall contain:

Driver ID
Name
Contact details
License information
Assigned vehicle
Employment/contract status
Availability
Training status

Sensitive information shall be protected through appropriate access controls.

18. Driver Assignment
FR-LOG-008 — Assign Driver

The logistics coordinator shall assign a driver to a route.

The system shall verify that:

Driver is available
Driver is authorized
Vehicle is available
Required route conditions are satisfied
19. Trip Creation
FR-LOG-009 — Create Trip

A route becomes a trip when operational execution begins.

Trip information shall include:

Trip ID
Route ID
Vehicle
Driver
Date
Start location
Destination
Collection points
Expected distance
Expected duration
Status
20. Farm Arrival
FR-LOG-010 — Record Arrival

The driver shall confirm arrival at the farm.

The mobile application should record:

Arrival time
Farm
GPS coordinates where enabled
Driver
Vehicle
Collection ID
21. Digital Check-In

The system should support digital farm check-in using:

GPS
QR code
Farmer confirmation
PIN
Manual confirmation

The final mechanism shall be selected during technical design.

22. Pig Loading
FR-LOG-011 — Record Loading

The system shall record:

Number of pigs loaded
Pig batch
Estimated/actual weight where available
Time loaded
Farmer confirmation
Driver confirmation
23. Pig Identification

The system should support identification through:

Pig batch ID
Individual animal ID where applicable
QR code
RFID in future versions

For the MVP, batch-level tracking may be more cost-effective than RFID.

24. Collection Confirmation

After loading, the farmer shall confirm the collection.

Example:

Collection COL-000152

Expected:
18 pigs

Collected:
18 pigs

Farmer:
Confirmed ✓

Driver:
Confirmed ✓
25. Collection Discrepancy
FR-LOG-012 — Record Discrepancy

The system shall allow discrepancies to be recorded.

Examples:

Expected:
18 pigs

Actual:
17 pigs

Variance:
1 pig

Reasons may include:

Pig unavailable
Health issue
Mortality
Farmer error
Recording error
Other
26. Departure
FR-LOG-013 — Record Departure

The driver shall record:

Departure time
Location
Load quantity
Destination
Trip status

The system shall transition the trip to:

IN_TRANSIT
27. Transport Monitoring

The system shall track the status of active trips.

Example:

TRIP-0045

Status:
IN TRANSIT

Origin:
Mafeteng

Destination:
Maseru Processing Facility

Pigs:
32

Driver:
Assigned

Departure:
08:15
28. GPS Tracking

GPS tracking shall be designed as an optional capability.

The MVP should not require continuous GPS tracking if this creates excessive:

Data usage
Battery consumption
Development complexity
Privacy concerns

Instead, the initial application may record GPS at important events:

Arrival
Loading
Departure
Delivery

Continuous tracking can be introduced later.

29. Offline Logistics

Because PigPower will operate in rural Lesotho, the driver application shall support offline operation.

The driver shall be able to record:

Arrival
Loading
Collection
Departure
Incident
Delivery

Data shall synchronize when connectivity becomes available.

30. Transport Incident
FR-LOG-014 — Record Incident

Drivers shall be able to report:

Vehicle breakdown
Accident
Road blockage
Severe weather
Animal welfare concern
Delayed collection
Missing documentation
Other incident
31. Incident Severity
LOW
MEDIUM
HIGH
CRITICAL

Critical incidents shall trigger immediate notifications to authorized logistics personnel.

32. Delivery to Processing Facility
FR-LOG-015 — Confirm Processing Arrival

The processing facility shall confirm arrival.

The receiving record shall contain:

Trip ID
Collection ID
Arrival time
Number received
Weight received
Condition
Receiving officer
Discrepancy
33. Receiving Reconciliation

The system shall compare:

Collected
vs
Received

Example:

Collected:
32 pigs

Received:
31 pigs

Variance:
1 pig

The discrepancy shall be flagged for investigation.

34. Processing Capacity Integration

Collection scheduling shall consider processing capacity.

Example:

Processing capacity:
50 pigs/day

Scheduled:
45 pigs

Available capacity:
5 pigs

The system should prevent excessive scheduled collections unless an authorized override is provided.

35. Processing Schedule

The logistics system shall integrate with the Processing Management Module.

Production Ready
       ↓
Collection Request
       ↓
Processing Slot
       ↓
Route
       ↓
Collection
       ↓
Processing Facility
36. Collection Forecast

The system shall forecast upcoming collection demand using:

Pigs approaching target weight
Production cycles
Farmer production schedules
Processing capacity
Historical collection data
37. Collection Calendar

Management shall have access to a calendar showing:

MONDAY
8 farms
42 pigs

TUESDAY
11 farms
63 pigs

WEDNESDAY
6 farms
37 pigs

This will enable proactive logistics planning.

38. Logistics Cost
FR-LOG-016 — Calculate Trip Cost

The system should calculate transport costs using configurable parameters.

Possible inputs:

Distance
Fuel consumption
Fuel price
Driver cost
Vehicle operating cost
Maintenance cost
Tolls/fees
Other expenses
39. Cost per Pig

The platform shall calculate:

Transport Cost
÷
Number of Pigs Transported

Example:

Trip cost:
M1,500

Pigs:
30

Cost/pig:
M50
40. Cost per Kilogram

Where weights are available:

Transport Cost
÷
Total Liveweight
=
Transport Cost/kg

This becomes an important unit-economics metric.

41. Vehicle Utilization

The system shall calculate:

Vehicle Utilization =
Actual Load
÷
Vehicle Capacity
× 100

Low utilization should be highlighted because it can significantly increase transport cost per pig.

42. Empty Return Trips

The system should identify routes where vehicles return without useful cargo.

Example:

Outbound:
100% utilized

Return:
0%

Potential optimization:
Collect feed/materials on return journey

This creates an opportunity for two-way logistics.

43. Backhaul Optimization

PigPower should eventually use the same logistics network for:

Farm → Processing

and:

Processing/Warehouse → Farm

For example:

Vehicle
 ↓
Deliver feed to farms
 ↓
Collect market-ready pigs
 ↓
Return to processing facility

This can significantly improve vehicle utilization.

44. Multi-Commodity Logistics

The architecture should allow future transport of:

Feed
Piglets
Veterinary supplies
Equipment
Pigs
Fertilizer
Processed pork products

However, the system shall enforce operational rules preventing incompatible cargo combinations.

45. Cold-Chain Logistics

For processed pork products, the platform shall eventually support cold-chain distribution.

The system should track:

Product
Quantity
Vehicle
Delivery route
Departure
Arrival
Temperature records where supported
46. Temperature Monitoring

Future versions may integrate IoT temperature sensors.

Cold Storage
     ↓
Temperature Sensor
     ↓
Mobile / Gateway
     ↓
PigPower Platform
     ↓
Temperature Alert

This is particularly important for value-added meat products.

47. Cold-Chain Alert

Example:

⚠ COLD CHAIN ALERT

Vehicle:
TRK-004

Temperature:
10.2°C

Configured threshold:
[system-defined]

Action:
Investigate

Thresholds must be configured according to PigPower's food-safety procedures and applicable regulations.

48. Proof of Delivery

For processed products, delivery confirmation shall include:

Customer
Order
Product
Quantity
Delivery time
Recipient
Signature/PIN
Delivery status
49. Delivery Discrepancy

The system shall record:

Expected:
100 kg

Delivered:
96 kg

Variance:
4 kg

Reasons shall be recorded.

50. Route Performance

The system shall compare planned versus actual:

Distance
Duration
Number of stops
Fuel usage
Collection quantity
Delivery quantity
51. Route Deviation

Where GPS tracking is available, the system may identify significant route deviations.

The system should flag deviations rather than automatically accuse the driver of misconduct.

Possible explanations:

Road closure
Weather
Emergency
Traffic
Customer request
52. Collection Priority

Collections shall support configurable priority levels:

NORMAL
HIGH
URGENT
CRITICAL

Priority may be influenced by:

Animal welfare
Processing schedule
Farmer contract
Market order
Disease-control requirements
53. Failed Collection
FR-LOG-017 — Record Failed Collection

A collection may fail because:

Farmer unavailable
Pigs unavailable
Vehicle breakdown
Road inaccessible
Veterinary restriction
Weather
Capacity issue
Other

The system shall record the reason and allow rescheduling.

54. Rescheduling
FR-LOG-018 — Reschedule Collection

Authorized users shall be able to reschedule failed or cancelled collections.

The system shall preserve the original scheduling history.

55. Collection Notifications

The system shall notify farmers of:

Collection request received
Collection approved
Collection date
Estimated arrival
Driver assigned
Collection completed
Collection rescheduled
56. Driver Notifications

Drivers shall receive:

Route assignment
Collection list
Farm addresses
Collection quantities
Special instructions
Schedule changes
Incident notifications
57. Processing Facility Notifications

Processing management shall receive:

Expected incoming pigs
Estimated arrival time
Number of pigs
Estimated weight
Origin farms
Veterinary status where appropriate
58. Collection Dashboard

Management dashboard:

TODAY'S COLLECTIONS
-------------------

Scheduled:       12
Completed:        7
In Progress:      3
Delayed:          1
Failed:           1

Pigs scheduled:  86
Pigs collected:  51
59. Logistics Dashboard

The logistics coordinator dashboard shall display:

ACTIVE TRIPS
AVAILABLE VEHICLES
DRIVERS AVAILABLE
PENDING COLLECTIONS
DELAYED COLLECTIONS
PROCESSING CAPACITY
TRANSPORT COST
60. Farmer Dashboard

The farmer shall see:

NEXT COLLECTION
----------------

Date:
20 August

Estimated arrival:
09:30

Pigs:
18

Status:
SCHEDULED

Driver:
Assigned
61. Database Entities

The conceptual database shall contain:

CollectionRequest
CollectionItem
CollectionSchedule
CollectionRoute
RouteStop
Trip
Vehicle
VehicleMaintenance
Driver
DriverAssignment
CollectionEvent
PigLoad
TransportIncident
Delivery
DeliveryItem
DeliveryConfirmation
RouteCost
FuelTransaction
ProcessingReceipt
CollectionDiscrepancy
LogisticsNotification
ColdChainRecord
62. Key Relationships
FARMER
   │
   ▼
FARM
   │
   ▼
PRODUCTION CYCLE
   │
   ▼
PIG BATCH
   │
   ▼
COLLECTION REQUEST
   │
   ▼
COLLECTION SCHEDULE
   │
   ▼
ROUTE
   │
   ├──── VEHICLE
   │
   └──── DRIVER
          │
          ▼
         TRIP
          │
          ▼
      ROUTE STOPS
          │
          ▼
       COLLECTION
          │
          ▼
PROCESSING FACILITY
          │
          ▼
      PROCESSING
          │
          ▼
      DISTRIBUTION
63. Traceability Chain

This is one of the most important requirements in the entire PigPower system.

The platform should ultimately be able to trace:

Farmer
  ↓
Farm
  ↓
Production Cycle
  ↓
Pig Batch
  ↓
Collection
  ↓
Vehicle
  ↓
Driver
  ↓
Processing Facility
  ↓
Processing Batch
  ↓
Pork Product
  ↓
Customer

This creates the foundation for farm-to-market traceability.

64. QR Code Integration

Each collection may have a unique QR code.

Example:

COL-2026-000152

Scanning the QR code could display:

Collection:
COL-2026-000152

Farmer:
FAR-0017

Farm:
FARM-0017

Pigs:
18

Destination:
Processing Facility

Status:
IN TRANSIT

The QR code should not expose sensitive farmer information to unauthorized users.

65. Offline Architecture

The mobile logistics application shall use local storage to temporarily store operational records.

Example:

Driver App
    ↓
Local Database
    ↓
Offline Collection
    ↓
Network Available
    ↓
Sync Engine
    ↓
Backend API
    ↓
Central Database

This is particularly important for rural Lesotho.

66. Synchronization Rules

The system shall support:

PENDING
SYNCING
SYNCED
FAILED
CONFLICT

Each synchronized transaction should have a unique identifier to prevent duplicate submissions.

67. Security

The module shall enforce role-based permissions.

For example:

Function	Farmer	Driver	Logistics	Processing
Request collection	✓		✓	
Schedule collection			✓	
Assign vehicle			✓	
View route		✓	✓	
Record loading		✓	✓	
Confirm collection	✓	✓	✓	
Confirm receiving				✓
Modify vehicle			✓	
View all routes			✓	✓
68. Audit Trail

The system shall record changes to:

Collection schedules
Routes
Vehicle assignments
Driver assignments
Quantities
Delivery records
Discrepancies
Trip status

Example:

Collection:
COL-000152

Original:
18 pigs

Changed to:
17 pigs

Changed by:
Field Officer

Date:
20 August 2026

Reason:
One pig failed veterinary clearance
69. Business Rules
BR-LOG-001

A collection request must be associated with a valid farmer and farm.

BR-LOG-002

A collection should be associated with a production cycle or pig batch.

BR-LOG-003

Pigs requiring veterinary clearance shall not be transported until the required status is confirmed.

BR-LOG-004

A vehicle cannot be assigned to conflicting active trips.

BR-LOG-005

A driver cannot be assigned to overlapping trips.

BR-LOG-006

A route shall not exceed configured vehicle capacity.

BR-LOG-007

Collection quantities shall be recorded at the point of loading.

BR-LOG-008

Receiving quantities shall be recorded independently of collection quantities.

BR-LOG-009

Differences between collected and received quantities shall generate a discrepancy record.

BR-LOG-010

Cancelled collections shall retain their historical records.

BR-LOG-011

Failed collections must contain a reason.

BR-LOG-012

Changes to completed trips require authorization.

BR-LOG-013

Transport incidents must be auditable.

BR-LOG-014

A processing facility may reject or defer a scheduled collection if capacity constraints require it, subject to defined operational procedures.

BR-LOG-015

GPS information shall only be collected where enabled and permitted by PigPower's privacy policies.

70. Key Logistics KPIs

The system shall calculate:

KPI	Purpose
Collection Completion Rate	Reliability
On-Time Collection Rate	Service quality
Average Collection Delay	Operational efficiency
Transport Cost/Pig	Unit economics
Transport Cost/kg	Cost efficiency
Vehicle Utilization	Fleet efficiency
Average Route Distance	Logistics planning
Empty Return Rate	Route optimization
Fuel Cost/km	Fleet efficiency
Collection Failure Rate	Reliability
Collection Discrepancy Rate	Control
Average Loading Time	Operational efficiency
Average Trip Duration	Fleet planning
Processing Arrival Accuracy	Coordination
Cost per Collection	Logistics economics
71. Strategic Logistics KPI

One of the most important KPIs should be:

Logistics Cost per Kilogram of Pork Produced

Ultimately:

Transport Costs
+
Collection Costs
+
Distribution Costs
--------------------------------
Total Pork Output (kg)

This metric should feed directly into PigPower's overall unit economics.

72. Integration With Feed Management

Collection logistics should work in both directions.

Outbound to farms
Warehouse
 ↓
Feed
 ↓
Farm
Inbound to processing
Farm
 ↓
Pigs
 ↓
Processing

The same logistics network can therefore support both.

This is important because PigPower can potentially reduce logistics costs through backhaul optimization.

73. Integration With Veterinary Management

Before collection:

Pig
 ↓
Health Assessment
 ↓
Veterinary Clearance
 ↓
Collection Eligibility

The Logistics Module should read veterinary status rather than independently determine animal health.

74. Integration With Production Management

Production Management determines:

Which pigs are approaching market readiness?

Logistics Management determines:

How do we physically move them?

Therefore:

Production
    ↓
Ready for Market
    ↓
Collection Request
    ↓
Logistics
75. Integration With Processing Management

Processing Management determines:

How many pigs can we process?

Logistics determines:

How many pigs can we deliver and when?

The two modules should therefore exchange:

Capacity
Schedule
Expected arrivals
Quantities
Weight
Processing slots
76. Integration With Sales

Sales orders should eventually generate distribution requirements.

Customer Order
      ↓
Required Pork
      ↓
Processing
      ↓
Finished Product
      ↓
Delivery Route
      ↓
Customer

This creates a complete order-to-delivery chain.

77. Logistics Data Architecture

At the conceptual level:

                    FARMER
                       │
                       ▼
                      FARM
                       │
                       ▼
                 PIG PRODUCTION
                       │
                       ▼
              COLLECTION REQUEST
                       │
                       ▼
               COLLECTION PLAN
                       │
            ┌──────────┴──────────┐
            ▼                     ▼
         VEHICLE                DRIVER
            │                     │
            └──────────┬──────────┘
                       ▼
                      TRIP
                       │
                       ▼
                    ROUTE
                       │
              ┌────────┼────────┐
              ▼        ▼        ▼
            FARM A   FARM B   FARM C
              │        │        │
              └────────┼────────┘
                       ▼
                 PROCESSING
                       │
                       ▼
                  PRODUCTS
                       │
                       ▼
                  DISTRIBUTION
78. MVP Scope

For the first PigPower MVP, I recommend implementing:

Phase 1
Collection Request
Collection Scheduling
Farmer Collection Status
Vehicle Registry
Driver Registry
Route Creation
Driver Assignment
Collection Confirmation
Loading Record
Processing Arrival
Collection Discrepancy
Trip Status
Basic GPS event capture
Offline operation
Synchronization
Basic transport-cost calculation
Notifications
Phase 2

Add:

Route optimization
Fuel management
Vehicle maintenance
Advanced fleet analytics
Backhaul optimization
Cold-chain management
Customer delivery management
Phase 3

Add:

AI route optimization
Predictive collection forecasting
Dynamic scheduling
IoT vehicle tracking
IoT temperature monitoring
Advanced logistics optimization
79. Acceptance Criteria

The module shall be considered functionally complete when:

Collection
 A collection request can be created.
 Collection eligibility can be verified.
 Collections can be scheduled.
 Collections can be cancelled/rescheduled.
 Farmers can view collection schedules.
Fleet
 Vehicles can be registered.
 Vehicle capacity can be configured.
 Drivers can be registered.
 Drivers can be assigned to routes.
 Vehicle availability can be monitored.
Route
 Routes can be created.
 Farms can be added as route stops.
 Routes can be assigned to vehicles.
 Routes can be assigned to drivers.
Collection
 Drivers can check in at farms.
 Pig quantities can be recorded.
 Farmers can confirm collection.
 Loading can be recorded.
 Discrepancies can be recorded.
Transport
 Trips can be started.
 Trips can be tracked.
 Incidents can be reported.
 Trips can be completed.
Processing
 Processing facilities can see expected arrivals.
 Receiving can be recorded.
 Collected vs received quantities can be reconciled.
Analytics
 Transport cost can be calculated.
 Cost per pig can be calculated.
 Cost per kg can be calculated.
 Vehicle utilization can be calculated.
 Collection completion rate can be calculated.
Offline
 Drivers can record collection events offline.
 Records synchronize when connectivity returns.
80. Strategic Role in PigPower

This module is more important than it may initially appear.

PigPower's fundamental operating model is:

        500+ SMALL FARMERS
                │
                ▼
       DISTRIBUTED PRODUCTION
                │
                ▼
       DIGITAL COORDINATION
                │
                ▼
       PHYSICAL AGGREGATION
                │
                ▼
       CENTRAL PROCESSING
                │
                ▼
      STANDARDIZED PRODUCTS
                │
                ▼
       NATIONAL DISTRIBUTION
                │
                ▼
             MARKET

Collection & Logistics is the physical bridge between the distributed farmer network and the centralized processing business.

Without efficient logistics, PigPower could have:

Good farmers
Good genetics
Good feed
Good production
A good processing plant

…and still lose money because the cost of physically moving pigs and products is too high.

Therefore, the software should treat logistics as a core unit-economics function, not merely an administrative feature.