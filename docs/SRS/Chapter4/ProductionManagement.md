PigPower SmartFarm Platform
Functional Requirements Specification
Module: Production Management

Document ID: PSP-SRS-FR-PROD
Version: 1.0
Status: Draft
Parent Document: Software Requirements Specification
Chapter: 4 – Functional Requirements
Project: PigPower Lesotho – Community-Based Circular Pork Economy Platform

1. Module Overview
1.1 Purpose

The Production Management Module shall provide the operational management layer for PigPower Lesotho's distributed pig-production network.

The module shall allow PigPower, field officers, farmers and authorized personnel to plan, monitor, evaluate and optimize livestock production cycles.

It shall transform raw livestock data into actionable production information.

The module shall manage:

Production cycles
Production targets
Growth targets
Feed programs
Production activities
Production costs
Feed consumption
Growth performance
Mortality performance
Production efficiency
Market projections
Collection forecasts
Farmer production performance
Network-level production forecasting
2. Business Purpose

PigPower's business model depends on predictable production.

The company must be able to estimate:

How many pigs will be available, at what weight, at what time, and at what production cost?

This information is required for:

Feed procurement
Veterinary planning
Farmer support
Cash-flow planning
Slaughterhouse scheduling
Meat-production forecasting
Customer order planning
Working-capital management
Farmer payments
Investor reporting

Therefore, Production Management shall become one of the core operational modules of the platform.

3. Production Management Scope

The module shall operate across:

Farm
  ↓
Pigsty
  ↓
Production Batch
  ↓
Production Cycle
  ↓
Production Activities
  ↓
Feed & Health Inputs
  ↓
Growth Performance
  ↓
Market Readiness
  ↓
Collection Forecast
  ↓
Processing Supply Forecast
4. Production Cycle
FR-PROD-001 — Create Production Cycle

Priority: Must Have

Authorized users shall be able to create a production cycle.

A production cycle shall include:

Production Cycle ID
Farm ID
Pigsty ID
Batch ID
Start date
Expected end date
Production type
Starting population
Target population
Starting average weight
Target market weight
Expected market date
Production status
Responsible farmer
Supervising field officer

Example:

Cycle:
PC-2026-00045

Farm:
FAR-0012

Batch:
BAT-2026-0042

Starting pigs:
25

Average starting weight:
18 kg

Target weight:
90 kg

Expected market date:
15 December 2026
5. Production Cycle Status
FR-PROD-002 — Maintain Production Status

The system shall support:

PLANNED
ACTIVE
ON_HOLD
AT_RISK
MARKET_READY
COMPLETED
CANCELLED

The status shall be updated according to defined business rules.

6. Production Planning
FR-PROD-003 — Create Production Plan

Authorized users shall be able to create a production plan for a batch.

The plan shall define:

Production duration
Target weight
Expected growth
Feed program
Veterinary schedule
Vaccination schedule
Expected mortality
Expected market date
Expected market quantity
7. Production Targets
FR-PROD-004 — Define Production Targets

The system shall allow authorized users to establish production targets.

Targets may include:

Average daily gain
Market weight
Production-cycle duration
Mortality rate
Feed conversion ratio
Market-ready percentage
8. Target Weight
FR-PROD-005 — Set Target Market Weight

Each production cycle shall have a target market weight.

Example:

Target:
90 kg

Acceptable range:
85–100 kg

The target shall be configurable by production type and market requirements.

9. Growth Targets
FR-PROD-006 — Define Growth Curve

The system shall support expected growth targets.

Example:

Age	Target Weight
Day 0	18 kg
Day 30	35 kg
Day 60	55 kg
Day 90	72 kg
Day 120	90 kg

Actual values shall be determined by PigPower's livestock production standards.

10. Actual vs Target Performance
FR-PROD-007 — Compare Actual and Target Growth

The system shall compare actual livestock performance against production targets.

Example:

Target weight: 72 kg
Actual weight: 68 kg

Variance: -4 kg
Status: BELOW TARGET
11. Production Performance Status

The system shall classify production performance as:

ON TARGET
ABOVE TARGET
BELOW TARGET
AT RISK
CRITICAL

The thresholds shall be configurable.

12. Feed Program
FR-PROD-008 — Create Feed Program

Authorized users shall be able to assign a feed program to a production cycle.

The program shall include:

Feed type
Production stage
Expected daily quantity
Feeding frequency
Start date
End date
Supplier
Cost per kilogram

Detailed inventory management shall later be handled by the Feed Management Module.

13. Feed Allocation
FR-PROD-009 — Allocate Feed

The system shall record feed allocated to a production cycle.

The record shall include:

Feed type
Quantity
Unit
Date
Production cycle
Farm
Cost
Supplier
Responsible user
14. Feed Consumption
FR-PROD-010 — Record Feed Consumption

Farmers or authorized personnel shall be able to record actual feed consumption.

The system shall support:

Date
Feed type
Quantity
Production batch
Farmer
15. Feed Variance
FR-PROD-011 — Calculate Feed Variance

The system shall compare:

Planned Feed
vs
Actual Feed

Example:

Planned:
100 kg

Actual:
108 kg

Variance:
+8 kg

Significant deviations shall trigger alerts.

16. Feed Conversion Ratio
FR-PROD-012 — Calculate FCR

The system shall calculate Feed Conversion Ratio where sufficient data is available.

FCR =
Feed Consumed
÷
Liveweight Gain

Example:

Feed consumed = 250 kg
Weight gain = 100 kg

FCR = 2.5

The system shall retain the underlying data used for the calculation.

17. Weight Monitoring
FR-PROD-013 — Record Production Weight

The system shall receive weight records from the Pig Management Module.

Weights may be captured:

Individually
By batch
By sampling
Through digital scales
Through future IoT systems
18. Average Daily Gain
FR-PROD-014 — Calculate ADG

The system shall calculate Average Daily Gain.

ADG =
Weight Gain
÷
Number of Days

The system shall identify invalid or insufficient measurements.

19. Growth Variance
FR-PROD-015 — Calculate Growth Variance

The system shall calculate the difference between expected and actual growth.

Growth Variance =
Actual Weight
-
Target Weight
20. Production Efficiency
FR-PROD-016 — Calculate Production Efficiency

The platform shall calculate configurable production-efficiency indicators.

Possible factors:

ADG
FCR
Mortality
Cycle duration
Market-weight achievement
Feed cost
Veterinary cost
21. Mortality Performance
FR-PROD-017 — Monitor Mortality

The system shall receive mortality records from Pig Management.

The system shall calculate:

Number of deaths
Mortality rate
Mortality by production stage
Mortality by farm
Mortality by batch
22. Mortality Alert
FR-PROD-018 — Generate Mortality Alerts

The system shall generate alerts when mortality exceeds configured thresholds.

Example:

⚠ PRODUCTION ALERT

Farm: FAR-0023
Batch: BAT-0045

Mortality:
8%

Threshold:
5%

Action:
Veterinary inspection required
23. Production Activities
FR-PROD-019 — Create Production Activity

The system shall allow authorized users to create production activities.

Examples:

Feeding
Weighing
Cleaning
Biosecurity inspection
Vaccination
Veterinary visit
Pig movement
Sorting
Market assessment
24. Production Activity Scheduling
FR-PROD-020 — Schedule Activity

Activities shall have:

Activity ID
Activity type
Production cycle
Farm
Due date
Assigned person
Status
Completion date
Notes
25. Activity Status

The system shall support:

SCHEDULED
IN_PROGRESS
COMPLETED
MISSED
CANCELLED
26. Missed Activity
FR-PROD-021 — Detect Missed Activities

The system shall identify activities that have passed their due date without completion.

Field officers shall receive alerts for critical missed activities.

27. Production Cost Tracking
FR-PROD-022 — Record Production Costs

The system shall record production costs associated with a production cycle.

Potential cost categories:

Piglets
Feed
Veterinary
Medication
Vaccination
Transport
Labour
Utilities
Biosecurity
Housing
Other inputs
28. Cost per Pig
FR-PROD-023 — Calculate Cost per Pig

The system shall calculate:

Total Production Cost
÷
Number of Marketable Pigs

This metric shall support farmer profitability analysis.

29. Cost per Kilogram
FR-PROD-024 — Calculate Production Cost per kg

The system shall calculate:

Total Production Cost
÷
Total Liveweight Produced

Example:

Production cost:
M45,000

Liveweight:
1,000 kg

Cost/kg:
M45
30. Revenue Forecast
FR-PROD-025 — Calculate Production Revenue Forecast

The system shall estimate expected production revenue based on:

Expected market pigs
Expected liveweight
Expected selling price
Contract price where applicable

Example:

Expected pigs: 20
Average weight: 90 kg
Price: M45/kg

Forecast revenue:
20 × 90 × M45
= M81,000

The actual pricing model shall be implemented through the Marketplace/Pricing module.

31. Gross Production Margin
FR-PROD-026 — Calculate Production Margin

The system shall calculate estimated production margin.

Production Margin =
Expected Revenue
-
Production Cost

This shall be an operational estimate and not replace formal accounting records.

32. Production Risk
FR-PROD-027 — Identify At-Risk Cycles

The system shall identify production cycles showing abnormal performance.

Risk indicators may include:

Low growth
High mortality
Excessive feed consumption
Missed activities
Disease events
Excessive production cost
Delayed market readiness
33. Production Risk Score
FR-PROD-028 — Calculate Production Risk Score

The system should generate a configurable risk score.

Example:

Production Risk Score: 72/100

Risk level:
HIGH

Main drivers:
• Growth below target
• Feed variance
• Mortality above threshold
34. Farmer Performance
FR-PROD-029 — Calculate Farmer Production Performance

The platform shall aggregate production performance at farmer level.

Metrics may include:

Mortality
ADG
FCR
Production-cycle completion
Market-weight achievement
Feed efficiency
Cost efficiency
Record-keeping compliance
35. Farmer Benchmarking
FR-PROD-030 — Benchmark Farmers

Authorized management users shall be able to compare production performance between participating farmers.

The system shall avoid exposing commercially sensitive farmer information to unauthorized users.

36. Production Forecasting
FR-PROD-031 — Forecast Future Production

The system shall estimate future production volumes.

Forecasts may include:

Number of market pigs
Expected liveweight
Expected market date
Expected pork supply
37. Network Production Forecast
FR-PROD-032 — Aggregate Production Forecast

Management shall be able to view expected production across the entire PigPower network.

Example:

Expected production:

August       1.2 tonnes
September    1.8 tonnes
October      2.4 tonnes
November     3.1 tonnes
December     4.0 tonnes
38. Processing Supply Forecast
FR-PROD-033 — Forecast Processing Supply

The system shall provide expected livestock availability to the processing operation.

This shall support:

Slaughter planning
Labour planning
Cold-chain planning
Packaging planning
Sales planning
39. Collection Forecast
FR-PROD-034 — Forecast Collections

The system shall estimate future collection requirements.

Forecast parameters may include:

Expected market date
Number of pigs
Expected weight
Farm location
Collection capacity
40. Production Calendar
FR-PROD-035 — Production Calendar

The application shall provide a calendar containing important production events.

Examples:

12 Aug – Weighing
15 Aug – Veterinary visit
18 Aug – Vaccination
22 Aug – Feed delivery
30 Aug – Expected market assessment
41. Production Alerts
FR-PROD-036 — Generate Production Alerts

Alerts may be triggered by:

Weight below target
Mortality above threshold
Feed variance
Missed activities
Delayed production cycle
Approaching market date
Expected feed shortage
Veterinary intervention requirement
42. Production Dashboard
FR-PROD-037 — Farmer Production Dashboard

The farmer dashboard shall show:

PRODUCTION OVERVIEW

Active cycles:          3
Total pigs:             48

Average weight:         61 kg
Target weight:          90 kg

Average ADG:            0.72 kg/day
Mortality:              3.1%

Feed this month:        1,240 kg

Market-ready:           7

Expected next collection:
22 Aug
43. Field Officer Dashboard
FR-PROD-038 — Field Officer Production Dashboard

Field officers shall see assigned farms and identify:

Underperforming cycles
Missed activities
High mortality
Low growth
Feed anomalies
Veterinary issues
Upcoming collections
44. Management Dashboard
FR-PROD-039 — Network Production Dashboard

Management shall see:

Total active production cycles
Total pigs
Expected production
Production by district
Production by farmer
Mortality
Average ADG
FCR
Market-ready animals
Expected collection volumes
Production cost
Estimated revenue
45. Offline Production Management
FR-PROD-040 — Offline Production Capture

The mobile application shall support offline capture of:

Weight records
Feed consumption
Production activities
Mortality
Production notes
Health-related production events
46. Synchronization
FR-PROD-041 — Synchronize Production Records

Offline records shall synchronize when connectivity is restored.

The system shall maintain:

PENDING
SYNCING
SYNCED
FAILED
CONFLICT
47. Production Data Validation
FR-PROD-042 — Validate Production Records

The system shall validate:

Production dates
Batch membership
Weight values
Feed quantities
Production-cycle status
Activity dates
Cost values
Market projections
48. Production History
FR-PROD-043 — Maintain Historical Production Records

Completed production cycles shall remain available for analysis.

Historical data shall support:

Farmer benchmarking
Production forecasting
Financial analysis
AI model development
Grant reporting
Investor reporting
49. Production Cycle Closure
FR-PROD-044 — Close Production Cycle

A production cycle may only be closed when:

Livestock has been collected/sold/transferred
Mortality has been reconciled
Production records are complete
Feed usage has been recorded
Costs have been recorded
Outstanding activities have been resolved
50. Production Reconciliation
FR-PROD-045 — Reconcile Production

At cycle completion the system shall compare:

Starting Population
+
Added Animals
-
Deaths
-
Transfers
-
Collected Animals
=
Ending Population

The system shall flag discrepancies.

51. Production Reporting
FR-PROD-046 — Generate Production Reports

The system shall generate reports covering:

Production cycles
Growth
Feed
Mortality
Costs
Market readiness
Forecasts
Farmer performance
52. Export
FR-PROD-047 — Export Production Data

Authorized users shall be able to export production data in appropriate formats such as:

CSV
Excel
PDF

Export permissions shall be role-controlled.

53. Business Rules
BR-PROD-001

Every active production batch shall belong to an active production cycle.

BR-PROD-002

A production cycle shall have a defined start date.

BR-PROD-003

A production cycle shall have defined production targets.

BR-PROD-004

Production targets may vary by production type.

BR-PROD-005

Actual production data shall not overwrite historical measurements.

BR-PROD-006

Weight measurements must include a timestamp.

BR-PROD-007

Feed consumption records must be associated with a production cycle or batch.

BR-PROD-008

FCR shall only be calculated when valid feed and weight-gain data exist.

BR-PROD-009

ADG shall only be calculated from valid time-separated weight measurements.

BR-PROD-010

Production costs shall be traceable to their production cycle where practical.

BR-PROD-011

A production cycle cannot be closed while unresolved livestock discrepancies exist.

BR-PROD-012

Market forecasts shall be distinguishable from confirmed market orders.

BR-PROD-013

Production forecasts shall display the forecast date/time.

BR-PROD-014

Production alerts shall not automatically modify production records.

BR-PROD-015

Critical production events shall generate audit records.

54. Production Data Model

The conceptual relationship shall be:

FARM
  │
  ▼
PIGSTY
  │
  ▼
PIG BATCH
  │
  ▼
PRODUCTION CYCLE
  │
  ├───────────────┐
  │               │
  ▼               ▼
PRODUCTION      FEED PROGRAM
TARGETS             │
  │                 ▼
  ▼             FEED RECORDS
WEIGHT
  │
  ▼
GROWTH ANALYSIS
  │
  ├───────────────┐
  ▼               ▼
FCR             ADG
  │               │
  └───────┬───────┘
          ▼
   PERFORMANCE
          │
          ▼
    MARKET READY
          │
          ▼
     COLLECTION
55. Preliminary Database Entities

The module shall introduce or use the following entities:

ProductionCycle

Stores the production-cycle definition.

ProductionTarget

Stores target production values.

GrowthTarget

Stores expected weight/growth milestones.

FeedProgram

Stores feed-program assignments.

FeedConsumption

Stores actual feed usage.

ProductionActivity

Stores production activities.

ProductionCost

Stores production-related costs.

ProductionPerformance

Stores calculated or aggregated performance indicators.

ProductionForecast

Stores production forecasts.

ProductionAlert

Stores production alerts.

ProductionRiskAssessment

Stores production-risk assessments.

ProductionReport

Represents generated production reports where persistence is required.

56. Relationship With Pig Management

Production Management shall not duplicate individual livestock information.

Instead:

Pig Management
       │
       │ livestock data
       ▼
Production Management
       │
       │ production analytics
       ▼
Performance
       │
       ▼
Forecast

For example:

Pig Management records:

PIG-001
Weight = 65 kg

Production Management uses that information to calculate:

Target = 70 kg
Variance = -5 kg
Performance = BELOW TARGET
57. Relationship With Farmer Management

Production records shall be associated with the farmer responsible for the production cycle.

This enables calculation of:

Farmer
   ↓
Production Cycles
   ↓
Production Performance

This information may later support:

Farmer incentives
Contract renewal
Access to additional piglets
Feed-credit decisions
Performance-based support
58. Relationship With Feed Management

Production Management shall consume information from the future Feed Management Module.

Feed Management
       ↓
Feed availability
Feed price
Feed inventory
Feed allocation
       ↓
Production Management
       ↓
Feed efficiency
FCR
Production cost
59. Relationship With Veterinary Management

Veterinary events shall influence production risk.

For example:

Disease event
      ↓
Production risk
      ↓
Growth impact
      ↓
Market-date adjustment
      ↓
Collection forecast adjustment
60. Relationship With Collection & Logistics

Production Management shall generate supply forecasts for Collection & Logistics.

Production Forecast
        ↓
Expected market-ready pigs
        ↓
Collection forecast
        ↓
Transport planning
61. Relationship With Processing

The processing operation requires predictable livestock supply.

Production Management shall provide:

Expected pigs
Expected liveweight
Expected collection date
Farm distribution
Batch information

This shall support processing capacity planning.

62. AI and Machine Learning

AI functionality shall be implemented progressively.

Phase 1

Rule-based forecasting.

Phase 2

Statistical forecasting.

Phase 3

Machine-learning forecasting.

Potential models:

Historical Data
      ↓
Growth Model
      ↓
Expected Weight
      ↓
Expected Market Date

Additional models may forecast:

Feed demand
Mortality risk
Production delays
Market supply
Collection requirements

AI predictions shall always display that they are predictions rather than confirmed facts.

63. Production KPIs

The platform shall support the following KPIs.

KPI	Purpose
Average Daily Gain	Growth performance
FCR	Feed efficiency
Mortality Rate	Animal survival
Market Weight Achievement	Production quality
Cycle Duration	Production efficiency
Feed Cost/kg	Cost efficiency
Production Cost/kg	Profitability
Market Readiness Rate	Supply planning
Forecast Accuracy	Planning quality
Capacity Utilization	Infrastructure efficiency
Revenue/kg	Commercial performance
Gross Production Margin	Farmer economics
64. Production Forecast Accuracy

The system shall eventually measure:

Forecast
vs
Actual Production

Example:

Forecast:
2,500 kg

Actual:
2,380 kg

Forecast variance:
-120 kg

This metric will become particularly important once PigPower begins supplying its centralized processing facility.

65. Acceptance Criteria

The module shall be considered functionally complete when:

Production Planning
 Production cycles can be created.
 Production targets can be defined.
 Growth targets can be established.
 Feed programs can be assigned.
 Production activities can be scheduled.
Monitoring
 Weight data can be received.
 Growth can be calculated.
 ADG can be calculated.
 FCR can be calculated when sufficient data exists.
 Mortality can be monitored.
Economics
 Production costs can be recorded.
 Cost per pig can be calculated.
 Cost per kg can be calculated.
 Revenue forecasts can be generated.
 Production margins can be estimated.
Forecasting
 Market-ready pigs can be forecast.
 Liveweight can be forecast.
 Collection requirements can be forecast.
 Network production can be aggregated.
Alerts
 Production deviations generate alerts.
 Mortality thresholds generate alerts.
 Missed activities generate alerts.
 At-risk production cycles are identifiable.
Offline
 Production records can be captured offline.
 Records synchronize after connectivity returns.
66. MVP Scope

For the initial MVP, implement:

Production cycle creation
Batch association
Production targets
Weight monitoring
Growth tracking
ADG
Basic feed recording
Basic mortality monitoring
Production activities
Production costs
Market-readiness estimation
Production dashboard
Basic production forecasting
Offline data capture
Synchronization

Defer:

Advanced AI
IoT integration
Automated scales
Computer vision
Advanced optimization
Predictive disease modelling

until sufficient operational data has been collected.

67. Strategic Importance

Production Management is the bridge between livestock records and business intelligence.

The platform will evolve from:

"What pigs do we have?"

to:

"What are our pigs producing?"

and ultimately:

"How much pork will PigPower be able to supply,
when will it be available,
what will it cost to produce,
and what margin can we generate?"

This is essential for turning PigPower from a livestock-management application into a commercial agricultural operating platform.

68. Open Design Decisions
ID	Decision
PROD-DEC-001	Production-stage definitions
PROD-DEC-002	Standard growth curves
PROD-DEC-003	Target market weights
PROD-DEC-004	Standard FCR targets
PROD-DEC-005	ADG targets
PROD-DEC-006	Mortality thresholds
PROD-DEC-007	Feed-consumption recording frequency
PROD-DEC-008	Production-cost categories
PROD-DEC-009	Farmer performance scoring
PROD-DEC-010	Production-risk algorithm
PROD-DEC-011	Forecasting methodology
PROD-DEC-012	AI implementation threshold
PROD-DEC-013	Production reporting requirements
PROD-DEC-014	Processing-supply forecast interface
PROD-DEC-015	Collection forecasting methodology