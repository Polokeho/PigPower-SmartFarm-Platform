# PigPower SmartFarm Platform

## Functional Requirements Specification

### Module: Farm Management

**Document ID:** PSP-SRS-FR-FARM
**Version:** 1.0
**Status:** Draft
**Parent Document:** Software Requirements Specification (SRS)
**Chapter:** 4 – Functional Requirements
**Module:** Farm Management
**Project:** PigPower Lesotho – Community-Based Circular Pork Economy Platform

---

# 1. Module Overview

## 1.1 Purpose

The Farm Management Module shall provide the digital system for registering, assessing, monitoring, and managing the physical farming infrastructure used by PigPower Lesotho participating farmers.

The module shall establish a structured digital representation of each production location and its associated infrastructure.

A farmer is the participant in the PigPower network, while a farm represents the physical production environment in which pig production takes place.

The system shall therefore maintain a clear separation between:

```text
FARMER
  │
  ├── Farm A
  │     ├── Pigsty 1
  │     ├── Pigsty 2
  │     └── Feed Storage
  │
  └── Farm B
        └── Pigsty 1
```

This distinction is important because PigPower's business model is based partly on bringing **underutilized and dormant pig infrastructure back into productive use**.

---

# 2. Objectives

The Farm Management Module shall:

1. Register participating farms.
2. Associate farms with approved farmers.
3. Capture geographic information.
4. Record farm infrastructure.
5. Record pigsty capacity.
6. Assess pigsty condition.
7. Assess water availability.
8. Assess feed-storage facilities.
9. Assess biosecurity infrastructure.
10. Record farm production capacity.
11. Track infrastructure improvements.
12. Support farm eligibility assessment.
13. Support farm activation.
14. Monitor farm compliance.
15. Track farm status.
16. Support production planning.
17. Support collection and logistics planning.
18. Support disease-control planning.
19. Support environmental management.
20. Support future integration with pig, feed, veterinary, energy and production modules.

---

# 3. Definition of a Farm

For the PigPower platform, a **farm** is a physical location or agricultural production site at which pig production activities are conducted or planned.

A farmer may operate more than one farm.

A farm may contain one or more production units, such as:

* Pigsties
* Nursery areas
* Grower areas
* Finishing areas
* Quarantine areas
* Feed-storage areas
* Equipment areas
* Waste-management infrastructure
* Biodigester infrastructure

The system shall therefore not assume that:

```text
1 Farmer = 1 Farm
```

Instead:

```text
1 Farmer → 1..N Farms
```

---

# 4. Farm Lifecycle

The farm shall follow a controlled lifecycle.

```text
                         ┌─────────────┐
                         │   Prospect  │
                         └──────┬──────┘
                                │
                                ▼
                         ┌─────────────┐
                         │ Registered  │
                         └──────┬──────┘
                                │
                                ▼
                         ┌─────────────┐
                         │  Assessed   │
                         └──────┬──────┘
                                │
                         ┌──────┴──────┐
                         ▼             ▼
                    ┌──────────┐   ┌──────────┐
                    │ Approved │   │ Rejected │
                    └────┬─────┘   └──────────┘
                         │
                         ▼
                    ┌──────────┐
                    │ Prepared │
                    └────┬─────┘
                         │
                         ▼
                    ┌──────────┐
                    │  Active  │
                    └────┬─────┘
                         │
                 ┌───────┼────────┐
                 ▼       ▼        ▼
             Suspended Inactive  Closed
                 │
                 ▼
             Reactivated
                 │
                 ▼
               Active
```

---

# 5. Farm Status

The system shall support:

| Status               | Description                                 |
| -------------------- | ------------------------------------------- |
| Prospect             | Potential production site identified        |
| Registered           | Farm information captured                   |
| Under Assessment     | Farm undergoing technical assessment        |
| Approved             | Farm approved for participation             |
| Preparation Required | Infrastructure improvements required        |
| Ready                | Farm meets operational requirements         |
| Active               | Farm currently participating                |
| Suspended            | Temporarily suspended                       |
| Inactive             | Temporarily not producing                   |
| Closed               | Permanently removed from production network |
| Rejected             | Farm failed required assessment             |

---

# 6. Actors

| Actor                     | Responsibility                                      |
| ------------------------- | --------------------------------------------------- |
| Administrator             | Manage farm records and configuration               |
| Field Officer             | Register and assess farms                           |
| Farmer                    | View and maintain permitted farm information        |
| Livestock Officer         | Assess production facilities                        |
| Veterinary Officer        | Assess animal-health infrastructure                 |
| Environmental Officer     | Assess waste/environmental systems                  |
| Logistics Officer         | Use farm location and capacity information          |
| Renewable Energy Engineer | Assess energy and waste-to-energy infrastructure    |
| Management                | Monitor farm network                                |
| System                    | Maintain farm records, statuses and derived metrics |

---

# 7. Farm Identification

## FR-FARM-001 — Generate Farm ID

**Priority:** Must Have

The system shall generate a unique identifier for every registered farm.

Example:

```text
FAR-000001
FAR-000002
FAR-000003
```

The Farm ID shall remain immutable throughout the farm's lifecycle.

---

# 8. Farm Registration

## FR-FARM-002 — Register Farm

**Priority:** Must Have

Authorized users shall be able to register a farm.

The system shall capture, where applicable:

* Farm ID
* Farm name
* Farmer owner/operator
* Farm type
* Location
* District
* Community
* Village
* GPS coordinates
* Land-use status
* Ownership status
* Farm size
* Current production status
* Pigsty availability
* Estimated capacity
* Water availability
* Electricity availability
* Waste-management infrastructure
* Registration date

---

# 9. Farm Ownership and Operating Model

## FR-FARM-003 — Farm Ownership

**Priority:** Must Have

The system shall record the farm's ownership or operational relationship.

Possible classifications include:

```text
OWNED
LEASED
FAMILY-OPERATED
COMMUNITY-OPERATED
COOPERATIVE
OTHER
```

The final list shall be configurable.

---

# 10. Farm Location

## FR-FARM-004 — Capture Farm Location

**Priority:** Must Have

The system shall capture the geographic location of the farm.

The location shall include:

* District
* Community
* Village
* GPS latitude
* GPS longitude
* Optional descriptive address
* Nearest major road
* Nearest collection point where applicable

---

# 11. GPS Capture

## FR-FARM-005 — GPS Farm Coordinates

**Priority:** Must Have

The mobile application shall allow authorized field personnel to capture farm GPS coordinates.

GPS data shall support:

* Farm mapping
* Logistics
* Collection planning
* Disease containment
* Field officer routing
* Infrastructure planning
* Environmental planning

GPS coordinates shall only be accessible to authorized users.

---

# 12. Farm Area

## FR-FARM-006 — Farm Size

**Priority:** Should Have

The system should record the approximate physical area of the farm.

The system shall support units such as:

```text
m²
hectares
acres
```

The platform shall internally standardize measurements to a defined unit.

---

# 13. Farm Type

## FR-FARM-007 — Farm Classification

**Priority:** Must Have

The system shall classify farms according to their operational characteristics.

Possible classifications:

* Rural
* Peri-urban
* Commercial
* Smallholder
* Community
* Cooperative
* Demonstration
* Other

The final classification system shall be configurable.

---

# 14. Pigsty Management

## FR-FARM-008 — Register Pigsty

**Priority:** Must Have

A farm shall support registration of one or more pigsties.

Each pigsty shall have a unique identifier.

Example:

```text
FAR-000001
   │
   ├── PST-001
   ├── PST-002
   └── PST-003
```

---

# 15. Pigsty Information

## FR-FARM-009 — Pigsty Details

**Priority:** Must Have

The system shall capture:

* Pigsty ID
* Farm ID
* Pigsty type
* Construction type
* Approximate dimensions
* Floor area
* Maximum capacity
* Current capacity
* Condition
* Ventilation
* Drainage
* Water access
* Feeding infrastructure
* Cleaning facilities
* Biosecurity status
* Construction material
* Operational status

---

# 16. Pigsty Condition

## FR-FARM-010 — Assess Pigsty Condition

**Priority:** Must Have

Pigsty condition shall be classified.

Example:

```text
EXCELLENT
GOOD
FAIR
POOR
UNUSABLE
```

The system shall allow field officers to add:

* Photographs
* Notes
* Defects
* Recommended improvements

---

# 17. Underutilized Infrastructure

## FR-FARM-011 — Identify Underutilized Pigsty

**Priority:** Must Have

The system shall identify whether a pigsty is:

```text
FULLY UTILIZED
PARTIALLY UTILIZED
UNDERUTILIZED
DORMANT
ABANDONED
```

This is a core business requirement because PigPower seeks to reactivate underused pig production infrastructure.

---

# 18. Pigsty Capacity

## FR-FARM-012 — Record Pigsty Capacity

**Priority:** Must Have

The system shall record:

* Maximum capacity
* Current occupancy
* Available capacity
* Production category

Example:

```text
Maximum capacity: 40 pigs
Current pigs:     15
Available space:  25 pigs
Utilization:      37.5%
```

The system shall calculate utilization automatically.

---

# 19. Farm Production Capacity

## FR-FARM-013 — Calculate Farm Capacity

**Priority:** Must Have

The system shall calculate total farm production capacity based on registered pigsties and approved capacity.

Example:

```text
Pigsty 1 = 30 pigs
Pigsty 2 = 50 pigs
Pigsty 3 = 20 pigs

Total capacity = 100 pigs
```

---

# 20. Farm Utilization

## FR-FARM-014 — Calculate Infrastructure Utilization

**Priority:** Must Have

The system shall calculate farm infrastructure utilization.

Formula:

```text
Utilization %
=
(Current Occupied Capacity / Maximum Approved Capacity) × 100
```

The utilization metric shall support PigPower's measurement of infrastructure reactivation.

---

# 21. Water Infrastructure

## FR-FARM-015 — Water Availability

**Priority:** Must Have

The system shall record farm water availability.

Possible sources:

* Municipal supply
* Borehole
* Well
* River
* Spring
* Rainwater
* Storage tank
* Other

The system shall record:

* Source
* Reliability
* Storage capacity
* Availability status

---

# 22. Water Risk Assessment

## FR-FARM-016 — Water Risk

**Priority:** Should Have

The system should classify water availability:

```text
LOW RISK
MEDIUM RISK
HIGH RISK
```

Factors may include:

* Seasonal reliability
* Storage capacity
* Source reliability
* Distance to source
* Water quality

---

# 23. Electricity Infrastructure

## FR-FARM-017 — Energy Availability

**Priority:** Should Have

The system shall record farm energy availability.

Possible sources:

* Grid electricity
* Solar
* Generator
* Battery
* Biogas
* No electricity
* Other

The information shall support PigPower's renewable-energy strategy.

---

# 24. Feed Storage

## FR-FARM-018 — Feed Storage Infrastructure

**Priority:** Must Have

The system shall record whether suitable feed-storage infrastructure exists.

Information shall include:

* Storage type
* Approximate capacity
* Condition
* Pest protection
* Moisture protection
* Security
* Current availability

---

# 25. Biosecurity Infrastructure

## FR-FARM-019 — Biosecurity Assessment

**Priority:** Must Have

The system shall support assessment of farm biosecurity.

Assessment areas may include:

* Controlled farm access
* Visitor management
* Footbaths
* Protective clothing
* Cleaning facilities
* Isolation areas
* Quarantine facilities
* Rodent control
* Waste management
* Dead-animal disposal
* Separation of production groups

---

# 26. Biosecurity Score

## FR-FARM-020 — Calculate Biosecurity Score

**Priority:** Should Have

The system should calculate a configurable biosecurity score.

Example:

```text
Farm Access             15%
Cleaning                15%
Quarantine              20%
Waste Management        15%
Visitor Control         10%
Rodent Control          10%
Protective Equipment    10%
Other                    5%
```

The final weights shall be approved by PigPower's veterinary and operational teams.

---

# 27. Waste Management

## FR-FARM-021 — Record Waste Management

**Priority:** Must Have

The system shall record how pig waste is currently managed.

Possible methods:

* Manure collection
* Composting
* Open dumping
* Lagoon
* Biodigester
* Agricultural application
* Other

The system shall identify farms requiring waste-management intervention.

---

# 28. Biodigester Readiness

## FR-FARM-022 — Biodigester Assessment

**Priority:** Should Have

The system should assess suitability for future biodigester integration.

Assessment factors may include:

* Pig population
* Waste volume
* Available space
* Water availability
* Distance from production units
* Energy demand
* Feedstock consistency

The assessment shall produce a readiness classification.

---

# 29. Environmental Compliance

## FR-FARM-023 — Environmental Assessment

**Priority:** Must Have

The system shall support recording environmental compliance requirements.

Potential areas include:

* Waste management
* Odour management
* Water contamination prevention
* Manure management
* Dead-stock disposal
* Biodigester management

The detailed compliance requirements shall be defined in accordance with applicable Lesotho regulatory requirements.

---

# 30. Farm Infrastructure Assessment

## FR-FARM-024 — Farm Assessment

**Priority:** Must Have

Field Officers shall be able to conduct structured farm assessments.

The assessment shall capture:

* Infrastructure
* Pigsty condition
* Capacity
* Water
* Feed storage
* Biosecurity
* Waste management
* Energy
* Photographs
* GPS coordinates
* Notes
* Recommendations

---

# 31. Farm Assessment Score

## FR-FARM-025 — Calculate Farm Readiness Score

**Priority:** Should Have

The system should calculate a configurable farm-readiness score.

Example:

```text
Infrastructure          20%
Pigsty condition        20%
Water                   15%
Biosecurity             20%
Feed storage            10%
Waste management        10%
Energy                   5%
```

The score shall help determine whether a farm is ready for participation.

---

# 32. Farm Approval

## FR-FARM-026 — Approve Farm

**Priority:** Must Have

Authorized personnel shall approve or reject a farm after assessment.

The decision shall record:

* Decision
* Date
* Decision maker
* Assessment score
* Reason
* Recommended actions

---

# 33. Farm Preparation

## FR-FARM-027 — Farm Improvement Plan

**Priority:** Must Have

Where a farm is not immediately ready, the system shall allow creation of an improvement plan.

Examples:

```text
Repair pigsty roof
Install water tank
Improve drainage
Install footbath
Repair fencing
Construct quarantine area
Improve feed storage
Install waste-management system
```

---

# 34. Farm Improvement Tasks

## FR-FARM-028 — Track Improvement Tasks

**Priority:** Must Have

Each improvement task shall include:

* Task
* Responsible person
* Start date
* Target date
* Status
* Cost estimate
* Actual cost
* Completion evidence
* Photographs

Possible statuses:

```text
NOT_STARTED
IN_PROGRESS
COMPLETED
DEFERRED
CANCELLED
```

---

# 35. Farm Activation

## FR-FARM-029 — Activate Farm

**Priority:** Must Have

A farm shall only become `ACTIVE` after satisfying required operational conditions.

Activation may require:

* Approved farmer
* Approved farm
* Satisfactory pigsty
* Adequate water
* Acceptable biosecurity
* Production plan
* Agreement
* Required improvements completed

---

# 36. Farm Suspension

## FR-FARM-030 — Suspend Farm

**Priority:** Must Have

Authorized users shall be able to suspend a farm.

Possible reasons:

* Disease outbreak
* Biosecurity failure
* Infrastructure failure
* Water shortage
* Farmer non-compliance
* Contract issue
* Environmental concern

Suspension shall be recorded in the audit trail.

---

# 37. Farm Reactivation

## FR-FARM-031 — Reactivate Farm

**Priority:** Should Have

A suspended or inactive farm may be reactivated after required corrective actions.

The system shall record:

* Previous status
* New status
* Corrective action
* Approval
* Date
* Responsible user

---

# 38. Farm Closure

## FR-FARM-032 — Close Farm

**Priority:** Must Have

A farm shall not normally be deleted.

Instead, the farm shall be marked:

```text
CLOSED
```

Historical records shall remain available.

---

# 39. Farm-Farmer Relationship

## FR-FARM-033 — Associate Farmer with Farm

**Priority:** Must Have

The system shall associate farmers with farms.

A farmer may be associated with multiple farms.

The system shall record:

* Farmer
* Farm
* Relationship type
* Start date
* End date
* Status

---

# 40. Farm-User Access

## FR-FARM-034 — Farm Access Permissions

**Priority:** Must Have

Users shall only access farms according to their permissions.

Examples:

```text
Farmer
→ Own farms

Field Officer
→ Assigned farms

Veterinary Officer
→ Assigned farms

Logistics Officer
→ Operationally relevant farms

Administrator
→ Authorized administrative scope

Management
→ Approved reporting scope
```

---

# 41. Farm Photographs

## FR-FARM-035 — Capture Farm Images

**Priority:** Should Have

The mobile application should allow authorized users to capture photographs of:

* Pigsties
* Water infrastructure
* Feed storage
* Biosecurity infrastructure
* Waste facilities
* Energy systems
* General farm condition

Images shall be associated with the relevant assessment or infrastructure record.

---

# 42. Farm Document Management

## FR-FARM-036 — Farm Documents

**Priority:** Should Have

The system should support documents associated with a farm.

Potential documents:

* Lease documents
* Ownership documents
* Farm assessment forms
* Infrastructure quotations
* Improvement records
* Environmental documents
* Inspection records

---

# 43. Offline Farm Registration

## FR-FARM-037 — Offline Registration

**Priority:** Must Have

Field Officers shall be able to register farms without continuous internet connectivity.

The application shall:

1. Capture farm information locally.
2. Capture GPS coordinates.
3. Capture assessment information.
4. Store records securely.
5. Queue records for synchronization.
6. Synchronize when connectivity becomes available.

---

# 44. Offline Farm Assessment

## FR-FARM-038 — Offline Assessment

**Priority:** Must Have

Farm assessments shall operate offline.

The application shall support:

* Form completion
* Scoring
* Photographs
* GPS
* Notes
* Recommendations

---

# 45. Synchronization

## FR-FARM-039 — Farm Synchronization

**Priority:** Must Have

The application shall display synchronization status.

Possible states:

```text
SYNCED
PENDING
SYNCING
FAILED
CONFLICT
```

The system shall provide mechanisms for resolving synchronization failures.

---

# 46. Farm Search

## FR-FARM-040 — Search Farms

**Priority:** Must Have

Authorized users shall be able to search by:

* Farm ID
* Farm name
* Farmer
* District
* Village
* Status
* Capacity
* Farm type

---

# 47. Farm Filtering

## FR-FARM-041 — Filter Farms

**Priority:** Must Have

Users shall be able to filter farms by:

* District
* Community
* Status
* Production status
* Capacity
* Utilization
* Readiness
* Biosecurity score
* Water risk
* Infrastructure condition

---

# 48. Farm Map

## FR-FARM-042 — Farm Mapping

**Priority:** Should Have

Authorized users should be able to visualize farms geographically.

The map may display:

* Farm locations
* Active farms
* Inactive farms
* Underutilized farms
* Collection points
* Production capacity
* Disease-control zones

---

# 49. Farm Capacity Planning

## FR-FARM-043 — Capacity Planning

**Priority:** Must Have

The system shall provide farm capacity information to support production planning.

Management shall be able to determine:

```text
Total Network Capacity
        +
Current Utilization
        +
Available Capacity
        =
Expansion Potential
```

---

# 50. Dormant Infrastructure KPI

## FR-FARM-044 — Infrastructure Reactivation KPI

**Priority:** Must Have

The system shall track the number of dormant or underutilized pigsties activated through PigPower.

Example:

```text
Dormant pigsties identified:       150
Pigsties rehabilitated:             80
Pigsties activated:                 65
```

This KPI is strategically important to PigPower's business model.

---

# 51. Farm Productivity KPI

## FR-FARM-045 — Farm Productivity

**Priority:** Must Have

The system shall support farm productivity measurements.

Potential metrics include:

* Pigs per farm
* Pigs per pigsty
* Capacity utilization
* Production per cycle
* Production per year
* Average market weight
* Mortality

---

# 52. Farm Risk Classification

## FR-FARM-046 — Farm Risk Score

**Priority:** Should Have

The system should classify farm operational risk.

Potential risk factors:

* Disease
* Biosecurity
* Water
* Infrastructure
* Feed
* Environmental management
* Production performance

Example:

```text
LOW
MEDIUM
HIGH
CRITICAL
```

---

# 53. Farm Alerts

## FR-FARM-047 — Farm Alerts

**Priority:** Should Have

The system should generate alerts for:

* Infrastructure deterioration
* Water shortage
* Biosecurity failures
* High utilization
* Low utilization
* Disease incidents
* Required assessments
* Expiring agreements
* Outstanding improvement tasks

---

# 54. Farm Maintenance

## FR-FARM-048 — Maintenance Records

**Priority:** Should Have

The system shall support recording maintenance activities.

Maintenance may include:

* Pigsty repairs
* Plumbing
* Water tanks
* Electrical systems
* Solar equipment
* Feed storage
* Waste systems
* Biodigesters

Each record shall include:

* Date
* Maintenance type
* Description
* Cost
* Responsible party
* Status

---

# 55. Farm Environmental Management

## FR-FARM-049 — Environmental Records

**Priority:** Must Have

The system shall support environmental management information.

The system may record:

* Manure production
* Waste-disposal method
* Composting
* Biodigester status
* Organic fertilizer production
* Environmental incidents

This information will later integrate with the Circular Economy and Renewable Energy modules.

---

# 56. Farm Energy Profile

## FR-FARM-050 — Energy Profile

**Priority:** Should Have

The system should record:

* Energy source
* Estimated consumption
* Renewable energy installed
* Solar capacity
* Battery capacity
* Biogas availability
* Energy reliability

This will allow future integration with PigPower's energy-management system.

---

# 57. Farm Dashboard

## FR-FARM-051 — Farmer Farm Dashboard

**Priority:** Must Have

The farmer application shall provide a farm overview.

Example:

```text
┌─────────────────────────────────────┐
│          MY FARM                    │
├─────────────────────────────────────┤
│ Farm ID: FAR-000001                 │
│ Status: ACTIVE                      │
│ Location: Maseru                    │
├─────────────────────────────────────┤
│ Pig Capacity              50        │
│ Current Pigs              32        │
│ Utilization               64%       │
│ Biosecurity               GOOD      │
│ Water Status              GOOD      │
├─────────────────────────────────────┤
│ ACTIVE PRODUCTION CYCLE             │
│                                     │
│ Pigs: 32                            │
│ Target Weight: 90 kg                │
├─────────────────────────────────────┤
│ Tasks                               │
│ • Veterinary visit                  │
│ • Feed delivery                     │
│ • Biosecurity inspection            │
└─────────────────────────────────────┘
```

---

# 58. Field Officer Dashboard

## FR-FARM-052 — Field Officer Farm Dashboard

**Priority:** Must Have

Field Officers shall see:

* Assigned farms
* Pending assessments
* Farms requiring visits
* Farms requiring improvement
* At-risk farms
* Suspended farms
* Recently activated farms
* Offline synchronization status

---

# 59. Management Dashboard

## FR-FARM-053 — Farm Network Dashboard

**Priority:** Must Have

Management shall be able to view:

* Total farms
* Active farms
* Dormant farms
* Reactivated farms
* Total capacity
* Current utilization
* Capacity by district
* Farms by status
* Farms by readiness score
* Farm risk distribution

---

# 60. Farm Data Integrity

## FR-FARM-054 — Historical Records

**Priority:** Must Have

Important farm information shall be historically traceable.

The system shall retain changes to:

* Farm status
* Capacity
* Infrastructure
* Farmer association
* Assessment results
* Risk classification
* Biosecurity status

---

# 61. Audit Trail

## FR-FARM-055 — Farm Audit Trail

**Priority:** Must Have

The system shall record important farm-management events.

Each audit record shall include:

```text
Actor
Action
Farm
Timestamp
Previous value
New value
Reason where applicable
```

---

# 62. Business Rules

## BR-FARM-001

Every farm shall have a unique Farm ID.

## BR-FARM-002

A farmer may operate multiple farms.

## BR-FARM-003

A farm may contain multiple pigsties.

## BR-FARM-004

Every pigsty shall belong to a registered farm.

## BR-FARM-005

A farm shall be assessed before activation.

## BR-FARM-006

A farm shall satisfy required operational criteria before activation.

## BR-FARM-007

A closed farm shall not be deleted if historical production records exist.

## BR-FARM-008

Farm status changes shall be auditable.

## BR-FARM-009

Farm capacity shall be based on approved production infrastructure.

## BR-FARM-010

Current occupancy shall not exceed approved capacity without an authorized capacity adjustment.

## BR-FARM-011

Farm locations shall only be accessible to authorized users.

## BR-FARM-012

Farm assessment records shall identify the responsible assessor.

## BR-FARM-013

Infrastructure improvement activities shall be traceable.

## BR-FARM-014

A farm may be temporarily suspended without deleting its historical records.

## BR-FARM-015

Farm production records shall remain associated with the originating farm.

## BR-FARM-016

Dormant infrastructure shall be distinguishable from active production infrastructure.

## BR-FARM-017

Farm utilization shall be calculated from current occupancy and approved capacity.

---

# 63. Conceptual Data Model

The conceptual relationship shall be:

```text
                  ┌─────────────┐
                  │   Farmer    │
                  └──────┬──────┘
                         │
                       1:N
                         │
                         ▼
                  ┌─────────────┐
                  │    Farm     │
                  └──────┬──────┘
                         │
                 ┌───────┼────────┐
                 │       │        │
                1:N     1:N      1:N
                 │       │        │
                 ▼       ▼        ▼
             Pigsties  Assessments  Documents
                 │
                 ▼
           Production Units
                 │
                 ▼
              Pig Batches
                 │
                 ▼
           Production Cycles
```

---

# 64. Preliminary Entity Definitions

The following entities are proposed for the future database design.

### Farmer

Represents the person participating in the PigPower network.

### Farm

Represents the physical agricultural production location.

### FarmAssignment

Represents the relationship between a farmer and a farm.

### Pigsty

Represents a pig housing/production structure.

### FarmAssessment

Represents a structured assessment of the farm.

### FarmInfrastructure

Represents infrastructure associated with the farm.

### FarmImprovement

Represents required or completed infrastructure improvements.

### FarmDocument

Represents documents associated with the farm.

### FarmStatusHistory

Represents historical farm-status changes.

### FarmAuditLog

Represents important changes to farm information.

These are conceptual entities only. They should **not yet be treated as the final database schema**.

---

# 65. Key Farm Management KPIs

The platform shall support the following KPIs.

## Network KPIs

### Total Farms

```text
Number of registered farms
```

### Active Farms

```text
Number of farms with ACTIVE status
```

### Infrastructure Reactivation Rate

```text
Reactivated Dormant Farms
÷
Identified Dormant Farms
× 100
```

### Capacity Utilization

```text
Current Pig Population
÷
Approved Farm Capacity
× 100
```

### Average Farm Capacity

```text
Total Approved Capacity
÷
Number of Active Farms
```

### Farm Activation Rate

```text
Active Farms
÷
Registered Farms
× 100
```

---

# 66. BEDCO and Investor Impact Metrics

Farm Management shall support reporting of:

* Number of farms onboarded
* Number of dormant farms identified
* Number of dormant farms reactivated
* Number of pigsties restored
* Total production capacity activated
* Capacity utilization
* Number of rural production locations
* Geographic coverage
* Infrastructure investment
* Number of farmers supported

These indicators will demonstrate that PigPower is not simply creating new farms but is **unlocking existing underutilized productive assets**.

---

# 67. Acceptance Criteria

The module shall be considered functionally complete when:

### Farm Registration

* [ ] Authorized users can register farms.
* [ ] Every farm receives a unique Farm ID.
* [ ] Farmers can be associated with farms.
* [ ] Farm location can be captured.
* [ ] GPS coordinates can be recorded.

### Infrastructure

* [ ] Pigsties can be registered.
* [ ] Pigsty capacity can be recorded.
* [ ] Pigsty condition can be assessed.
* [ ] Underutilized pigsties can be identified.
* [ ] Farm capacity can be calculated.

### Assessment

* [ ] Farm assessments can be conducted.
* [ ] Assessments can be completed offline.
* [ ] Assessment scores can be calculated.
* [ ] Farm approval can be recorded.
* [ ] Improvement requirements can be created.

### Operations

* [ ] Farm status can be changed.
* [ ] Farms can be suspended.
* [ ] Farms can be reactivated.
* [ ] Farms can be closed without deleting historical records.
* [ ] Farm maintenance can be recorded.

### Environmental

* [ ] Waste-management information can be recorded.
* [ ] Biodigester readiness can be recorded.
* [ ] Energy information can be captured.
* [ ] Environmental information can be reported.

### Reporting

* [ ] Farms can be searched.
* [ ] Farms can be filtered.
* [ ] Farm locations can be mapped.
* [ ] Capacity can be aggregated.
* [ ] Infrastructure reactivation can be measured.

### Offline

* [ ] Farm registration works offline.
* [ ] Farm assessment works offline.
* [ ] Photographs can be queued for synchronization.
* [ ] GPS information can be synchronized.
* [ ] Synchronization status is visible.

### Security

* [ ] Farm information is role-protected.
* [ ] Farm access is restricted by authorization.
* [ ] Important farm changes are audited.

---

# 68. Requirement Traceability

| Requirement | Business Objective            |
| ----------- | ----------------------------- |
| FR-FARM-001 | Digital farm identification   |
| FR-FARM-002 | Farm network development      |
| FR-FARM-003 | Asset ownership management    |
| FR-FARM-004 | Geographic management         |
| FR-FARM-005 | Field operations              |
| FR-FARM-008 | Pigsty management             |
| FR-FARM-011 | Infrastructure reactivation   |
| FR-FARM-012 | Capacity planning             |
| FR-FARM-014 | Capacity utilization          |
| FR-FARM-015 | Water management              |
| FR-FARM-017 | Energy planning               |
| FR-FARM-019 | Biosecurity                   |
| FR-FARM-021 | Circular economy              |
| FR-FARM-022 | Renewable energy integration  |
| FR-FARM-024 | Farm assessment               |
| FR-FARM-027 | Infrastructure rehabilitation |
| FR-FARM-029 | Farm activation               |
| FR-FARM-030 | Operational risk              |
| FR-FARM-037 | Rural/offline operations      |
| FR-FARM-043 | Production planning           |
| FR-FARM-044 | Infrastructure reactivation   |
| FR-FARM-045 | Farm productivity             |
| FR-FARM-049 | Environmental sustainability  |
| FR-FARM-050 | Renewable energy strategy     |
| FR-FARM-053 | Management reporting          |

---

# 69. Dependencies

The Farm Management Module depends on:

* Authentication Module
* User Management Module
* Farmer Management Module
* Role and Permission Management
* Database
* Backend API
* Mobile Application
* Offline Synchronization Engine
* GPS/location services
* Image/document storage
* Notification system
* Audit logging

---

# 70. Future Integrations

The Farm Management Module shall eventually integrate with:

```text
Farm Management
       │
       ├── Pig Management
       │
       ├── Production Management
       │
       ├── Feed Management
       │
       ├── Veterinary Management
       │
       ├── Collection & Logistics
       │
       ├── Processing
       │
       ├── Payments
       │
       ├── Renewable Energy
       │
       ├── Biodigester Management
       │
       └── Analytics / AI
```

This integration is essential because the farm should become the **physical anchor point for the entire PigPower digital value chain**.

---

# 71. Open Design Decisions

The following decisions shall be finalized during architecture and database design:

| ID           | Decision                           |
| ------------ | ---------------------------------- |
| FARM-DEC-001 | Final Farm ID format               |
| FARM-DEC-002 | Farm ownership classifications     |
| FARM-DEC-003 | Pigsty capacity standards          |
| FARM-DEC-004 | Farm readiness scoring             |
| FARM-DEC-005 | Biosecurity scoring                |
| FARM-DEC-006 | Water-risk scoring                 |
| FARM-DEC-007 | Farm-risk algorithm                |
| FARM-DEC-008 | GPS precision requirements         |
| FARM-DEC-009 | Farm image storage architecture    |
| FARM-DEC-010 | Offline image synchronization      |
| FARM-DEC-011 | Farm-to-farmer relationship model  |
| FARM-DEC-012 | Farm-to-pigsty relationship        |
| FARM-DEC-013 | Production-unit data model         |
| FARM-DEC-014 | Farm capacity calculation          |
| FARM-DEC-015 | Biodigester-readiness algorithm    |
| FARM-DEC-016 | Environmental compliance framework |
| FARM-DEC-017 | Farm geographic hierarchy          |
| FARM-DEC-018 | Data retention policy              |

---

# 72. Architectural Principle

The Farm Management Module shall be designed as a **core domain module**, rather than as a simple farmer-profile extension.

The architectural relationship shall ultimately support:

```text
                    PIGPOWER PLATFORM

                         FARMER
                            │
                            ▼
                          FARM
                            │
          ┌─────────────────┼─────────────────┐
          │                 │                 │
          ▼                 ▼                 ▼
       PIGSTY           RESOURCES         INFRASTRUCTURE
          │                 │                 │
          ▼                 ▼                 ▼
        PIGS              FEED            BIOSECURITY
          │                                   │
          ▼                                   ▼
     PRODUCTION                           HEALTH
          │
          ▼
      COLLECTION
          │
          ▼
      PROCESSING
          │
          ▼
        MARKET
          │
          ▼
       PAYMENT
```

The farm is therefore a critical **digital twin of the physical production environment**.

Future versions of the platform may extend this concept into IoT-enabled farm monitoring, allowing sensors to provide real-time information on:

* Temperature
* Humidity
* Water availability
* Feed levels
* Energy consumption
* Solar generation
* Battery state
* Biodigester operation
* Environmental conditions

These capabilities shall be treated as future integrations rather than mandatory functionality for the first release.
