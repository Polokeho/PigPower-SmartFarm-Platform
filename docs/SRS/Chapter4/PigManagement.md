# PigPower SmartFarm Platform

## Functional Requirements Specification

### Module: Pig Management

**Document ID:** PSP-SRS-FR-PIG
**Version:** 1.0
**Status:** Draft
**Parent Document:** Software Requirements Specification (SRS)
**Chapter:** 4 – Functional Requirements
**Module:** Pig Management
**Project:** PigPower Lesotho – Community-Based Circular Pork Economy Platform

---

# 1. Module Overview

## 1.1 Purpose

The Pig Management Module shall provide the digital system for registering, identifying, monitoring, and managing pigs within the PigPower Lesotho production network.

The module shall create a digital record for livestock entering the PigPower production system and maintain traceability throughout the animal's production lifecycle.

The module shall support:

* Individual pig identification where practical
* Batch-level identification
* Piglet allocation
* Production-cycle management
* Growth monitoring
* Weight recording
* Health records
* Vaccination records
* Treatment records
* Mortality records
* Breeding records where applicable
* Feed-performance monitoring
* Movement tracking
* Farm transfers
* Collection readiness
* Traceability
* Production forecasting
* Meat-processing traceability

The module is therefore a critical component of PigPower's **farm-to-market traceability architecture**.

---

# 2. Business Context

PigPower is not intended to operate as a conventional pig farm.

The company will operate a distributed network of participating farmers.

Therefore, the platform must answer questions such as:

* Where did this pig originate?
* Which farmer raised it?
* Which farm did it come from?
* Which pigsty housed it?
* Which batch did it belong to?
* When was it introduced?
* What feed was used?
* What vaccinations were administered?
* What treatments were administered?
* What was its growth performance?
* When was it ready for market?
* When was it collected?
* Which processing facility received it?
* Which pork products originated from it?

The Pig Management Module shall provide the livestock-level foundation required to answer these questions.

---

# 3. Design Principle

The system shall support both:

```text
INDIVIDUAL TRACEABILITY
```

and:

```text
BATCH TRACEABILITY
```

This distinction is important.

For smallholder production environments, individually registering every pig may introduce unnecessary administrative complexity.

PigPower shall therefore support:

```text
Individual Pig
       +
Pig Batch
       +
Production Cycle
```

The final operating model shall determine which animals require individual identification.

---

# 4. Pig Lifecycle

A pig shall follow a controlled lifecycle.

```text
                 ┌──────────────┐
                 │   Piglet     │
                 └──────┬───────┘
                        │
                        ▼
                 ┌──────────────┐
                 │   Nursery    │
                 └──────┬───────┘
                        │
                        ▼
                 ┌──────────────┐
                 │    Grower    │
                 └──────┬───────┘
                        │
                        ▼
                 ┌──────────────┐
                 │   Finisher   │
                 └──────┬───────┘
                        │
             ┌──────────┴──────────┐
             ▼                     ▼
       Market Ready             Breeding
             │                     │
             ▼                     ▼
        Collected             Breeding Herd
             │
             ▼
         Processing
```

Other terminal states may include:

* Sold
* Transferred
* Deceased
* Lost
* Removed from program
* Retained for breeding

---

# 5. Pig Identification

## FR-PIG-001 — Generate Pig ID

**Priority:** Must Have

The system shall support generation of a unique Pig ID.

Example:

```text
PIG-000001
PIG-000002
PIG-000003
```

The Pig ID shall remain permanently associated with the animal record.

---

# 6. Batch Identification

## FR-PIG-002 — Generate Batch ID

**Priority:** Must Have

The system shall support creation of production batches.

Example:

```text
BAT-2026-0001
BAT-2026-0002
```

A batch shall represent a defined group of pigs managed under a common production cycle.

---

# 7. Pig Registration

## FR-PIG-003 — Register Pig

**Priority:** Must Have

Authorized users shall be able to register an individual pig.

The system shall capture, where applicable:

* Pig ID
* Batch ID
* Farm ID
* Pigsty ID
* Farmer ID
* Sex
* Breed
* Date of birth
* Source
* Date introduced
* Initial weight
* Identification method
* Production purpose
* Status

---

# 8. Pig Source

## FR-PIG-004 — Record Pig Source

**Priority:** Must Have

The system shall record where a pig originated.

Possible sources include:

```text
PIGPOWER BREEDING PROGRAM
APPROVED SUPPLIER
PARTICIPATING FARM
FARMER'S EXISTING STOCK
OTHER APPROVED SOURCE
```

The system shall maintain source traceability.

---

# 9. Pig Identification Method

## FR-PIG-005 — Identification Method

**Priority:** Should Have

The system should support multiple identification methods.

Examples:

* Ear tag
* Electronic tag
* QR code
* RFID
* Batch identification
* Manual identifier

The architecture shall allow additional identification technologies in future.

---

# 10. QR Code Identification

## FR-PIG-006 — Generate QR Code

**Priority:** Should Have

The system should generate a unique QR code associated with a pig or batch.

Scanning the QR code shall allow an authorized user to retrieve permitted livestock information.

Example:

```text
┌──────────────────────┐
│      QR CODE         │
│                      │
│      PIG-000421      │
│                      │
└──────────────────────┘
```

Sensitive information shall not be exposed through an unauthenticated QR scan.

---

# 11. Pig Sex

## FR-PIG-007 — Record Sex

**Priority:** Must Have

The system shall record:

```text
MALE
FEMALE
UNKNOWN
```

---

# 12. Breed

## FR-PIG-008 — Record Breed

**Priority:** Must Have

The system shall record pig breed.

The breed catalogue shall be configurable.

The system should support:

* Pure breeds
* Crossbreeds
* Commercial hybrids
* Local breeds
* Unknown

---

# 13. Production Purpose

## FR-PIG-009 — Record Production Purpose

**Priority:** Must Have

Each pig shall be classified according to intended purpose.

Possible values:

```text
MEAT PRODUCTION
BREEDING
REPLACEMENT
RESEARCH / DEMONSTRATION
OTHER
```

---

# 14. Pig Birth Information

## FR-PIG-010 — Record Birth Information

**Priority:** Should Have

Where known, the system shall record:

* Date of birth
* Birth farm
* Birth batch
* Dam
* Sire
* Litter number

Unknown information shall be explicitly represented rather than fabricated.

---

# 15. Pig Introduction

## FR-PIG-011 — Record Introduction

**Priority:** Must Have

When an existing pig enters the PigPower network, the system shall record:

* Introduction date
* Source
* Destination farm
* Destination pigsty
* Initial weight
* Health status
* Responsible user

---

# 16. Pig Batch

## FR-PIG-012 — Create Pig Batch

**Priority:** Must Have

Authorized users shall be able to create a pig batch.

A batch shall contain:

* Batch ID
* Farm
* Pigsty
* Production cycle
* Date established
* Number of pigs
* Average starting weight
* Target market weight
* Expected market date
* Status

---

# 17. Batch Membership

## FR-PIG-013 — Assign Pig to Batch

**Priority:** Must Have

An individual pig may be assigned to a production batch.

The system shall maintain batch membership history.

---

# 18. Batch Capacity Validation

## FR-PIG-014 — Validate Batch Capacity

**Priority:** Must Have

The system shall verify that the number of pigs assigned to a batch does not exceed approved pigsty capacity.

Where capacity is exceeded, the system shall require authorized override or corrective action.

---

# 19. Production Cycle

## FR-PIG-015 — Create Production Cycle

**Priority:** Must Have

The system shall support production-cycle records.

A production cycle shall include:

* Cycle ID
* Batch ID
* Farm
* Start date
* Expected end date
* Production stage
* Target weight
* Status

---

# 20. Production Stages

## FR-PIG-016 — Track Production Stage

**Priority:** Must Have

The system shall support production-stage tracking.

Example:

```text
WEANER
   ↓
NURSERY
   ↓
GROWER
   ↓
FINISHER
   ↓
MARKET READY
```

The actual stages shall be configurable according to PigPower's livestock production standards.

---

# 21. Weight Recording

## FR-PIG-017 — Record Pig Weight

**Priority:** Must Have

Authorized users shall be able to record livestock weight.

Each measurement shall include:

* Pig or batch
* Date
* Weight
* Measurement method
* Recorded by
* Notes

---

# 22. Weight History

## FR-PIG-018 — Maintain Weight History

**Priority:** Must Have

The system shall retain historical weight measurements.

Example:

```text
Day 0     12 kg
Day 30    25 kg
Day 60    48 kg
Day 90    72 kg
Day 120   92 kg
```

---

# 23. Growth Rate

## FR-PIG-019 — Calculate Growth Rate

**Priority:** Must Have

The system shall calculate growth indicators from available weight data.

For example:

```text
Average Daily Gain (ADG)

ADG =
Weight Gain / Number of Days
```

The system shall not calculate growth metrics when insufficient valid measurements exist.

---

# 24. Target Weight

## FR-PIG-020 — Record Target Weight

**Priority:** Must Have

The production cycle shall contain a target market weight.

The system shall compare:

```text
Current Weight
vs
Target Weight
```

and determine production progress.

---

# 25. Market Readiness

## FR-PIG-021 — Determine Market Readiness

**Priority:** Must Have

The system shall support identification of pigs or batches approaching market readiness.

Readiness may consider:

* Weight
* Age
* Health status
* Production stage
* Contract requirements
* Market demand
* Collection schedule

The final market-readiness algorithm shall be configurable.

---

# 26. Health Status

## FR-PIG-022 — Record Health Status

**Priority:** Must Have

The system shall record livestock health status.

Possible classifications:

```text
HEALTHY
UNDER OBSERVATION
SICK
QUARANTINED
RECOVERING
UNFIT FOR MOVEMENT
```

---

# 27. Health Events

## FR-PIG-023 — Record Health Event

**Priority:** Must Have

The system shall record livestock health events.

Examples:

* Disease
* Injury
* Veterinary inspection
* Abnormal symptoms
* Recovery
* Quarantine
* Other health incidents

---

# 28. Veterinary Treatment

## FR-PIG-024 — Record Treatment

**Priority:** Must Have

Authorized veterinary personnel shall be able to record treatments.

Information shall include:

* Pig/batch
* Condition
* Treatment
* Medication
* Dosage
* Start date
* End date
* Veterinarian
* Withdrawal period where applicable
* Notes

---

# 29. Medication Traceability

## FR-PIG-025 — Medication History

**Priority:** Must Have

The system shall maintain medication history.

This information shall be used to support food-safety and processing decisions.

---

# 30. Withdrawal Period

## FR-PIG-026 — Enforce Withdrawal Period

**Priority:** Must Have

Where a treatment has an applicable withdrawal period, the system shall prevent or flag livestock from being designated for collection until the required period has elapsed.

This is a critical food-safety control.

---

# 31. Vaccination Records

## FR-PIG-027 — Record Vaccination

**Priority:** Must Have

The system shall record vaccination events.

Information shall include:

* Vaccine
* Date
* Pig/batch
* Dose
* Administrator
* Next scheduled vaccination
* Notes

---

# 32. Vaccination Schedule

## FR-PIG-028 — Vaccination Reminders

**Priority:** Should Have

The system should generate reminders for scheduled vaccinations.

Notifications may be sent to:

* Farmer
* Veterinary officer
* Field officer

---

# 33. Mortality

## FR-PIG-029 — Record Mortality

**Priority:** Must Have

The system shall record pig deaths.

Information shall include:

* Pig/batch
* Date
* Farm
* Pigsty
* Suspected cause
* Veterinary findings where available
* Disposal method
* Recorded by

---

# 34. Mortality Rate

## FR-PIG-030 — Calculate Mortality Rate

**Priority:** Must Have

The system shall calculate mortality rates.

Example:

```text
Mortality Rate =
Number of deaths
÷
Number of pigs introduced
× 100
```

The exact denominator shall be defined by the production analytics specification.

---

# 35. Pig Movement

## FR-PIG-031 — Record Pig Movement

**Priority:** Must Have

The system shall record movement between:

* Pigsties
* Farms
* Quarantine areas
* Collection points
* Processing facilities

Each movement shall include:

* Origin
* Destination
* Date
* Reason
* Number of pigs
* Authorized user
* Health clearance where required

---

# 36. Farm Transfer

## FR-PIG-032 — Transfer Pig

**Priority:** Must Have

Authorized personnel shall be able to transfer pigs between participating farms.

The system shall preserve complete movement history.

---

# 37. Movement Restrictions

## FR-PIG-033 — Restrict Movement

**Priority:** Must Have

The system shall prevent or flag movement where:

* Animal is quarantined
* Animal has a movement restriction
* Withdrawal period has not elapsed
* Disease-control restrictions apply
* Required authorization is missing

---

# 38. Quarantine

## FR-PIG-034 — Quarantine Pig

**Priority:** Must Have

Authorized veterinary personnel shall be able to place pigs or batches under quarantine.

The record shall include:

* Start date
* Reason
* Location
* Responsible officer
* Expected review date
* Release conditions
* Release date

---

# 39. Quarantine Release

## FR-PIG-035 — Release from Quarantine

**Priority:** Must Have

Only authorized users shall be able to release livestock from quarantine.

The system shall record the authorization.

---

# 40. Feed Association

## FR-PIG-036 — Associate Feed Program

**Priority:** Should Have

The Pig Management Module shall support association with a feed program.

Information may include:

* Feed type
* Production stage
* Quantity
* Start date
* End date
* Supplier

Detailed feed management shall be implemented through a dedicated Feed Management Module.

---

# 41. Feed Consumption

## FR-PIG-037 — Record Feed Consumption

**Priority:** Should Have

The system should support recording feed consumption at pig or batch level.

This information shall support:

* Feed conversion analysis
* Cost analysis
* Production forecasting

---

# 42. Feed Conversion Ratio

## FR-PIG-038 — Calculate FCR

**Priority:** Should Have

The system should calculate Feed Conversion Ratio.

Conceptually:

```text
FCR =
Feed Consumed
÷
Weight Gain
```

The system shall use validated feed and weight records.

---

# 43. Breeding

## FR-PIG-039 — Record Breeding Information

**Priority:** Should Have

For pigs classified for breeding, the system shall support:

* Mating
* Breeding date
* Sire
* Dam
* Expected farrowing date
* Actual farrowing date
* Litter size
* Piglet count

Breeding functionality shall be expanded in a future Breeding Management Module.

---

# 44. Piglet Allocation

## FR-PIG-040 — Allocate Piglets

**Priority:** Must Have

PigPower administrators shall be able to allocate piglets to approved participating farms.

The allocation shall record:

* Source
* Destination farm
* Farmer
* Number of piglets
* Breed
* Average weight
* Allocation date
* Batch
* Cost or subsidy value
* Responsible officer

---

# 45. Piglet Distribution

## FR-PIG-041 — Track Piglet Distribution

**Priority:** Must Have

The system shall track piglets from source through delivery.

This shall support accountability for PigPower's farmer-support model.

---

# 46. Pig Ownership

## FR-PIG-042 — Record Ownership

**Priority:** Must Have

The system shall distinguish between:

```text
PIGPOWER-OWNED
FARMER-OWNED
CONTRACT-FARMING
OTHER
```

This distinction is important for accounting and contract management.

---

# 47. Contract Farming Association

## FR-PIG-043 — Associate Pig with Contract

**Priority:** Should Have

Where applicable, a pig or batch shall be associated with a farmer production agreement.

This shall later integrate with the Contract Management Module.

---

# 48. Production Performance

## FR-PIG-044 — Record Performance Indicators

**Priority:** Must Have

The system shall support:

* Starting weight
* Current weight
* Target weight
* Weight gain
* ADG
* Mortality
* Age
* FCR where available
* Feed cost
* Production cost

---

# 49. Pig Performance Score

## FR-PIG-045 — Calculate Performance Score

**Priority:** Should Have

The system should calculate a configurable performance score.

Potential factors:

```text
Growth
Health
Mortality
Feed efficiency
Market readiness
```

The scoring algorithm shall be defined by the livestock production team.

---

# 50. Production Forecasting

## FR-PIG-046 — Production Forecast

**Priority:** Should Have

The platform should estimate:

* Expected market date
* Expected market weight
* Expected number of market pigs
* Expected production volume

Forecasting shall initially use rule-based calculations.

AI-based forecasting may be introduced once sufficient historical data has been accumulated.

---

# 51. Collection Readiness

## FR-PIG-047 — Collection Readiness

**Priority:** Must Have

The system shall identify pigs or batches ready for collection.

A collection-ready record may require:

```text
Target weight reached
+
Health clearance
+
Withdrawal period completed
+
Production cycle complete
+
Farmer confirmation
```

---

# 52. Collection Request

## FR-PIG-048 — Request Collection

**Priority:** Must Have

Authorized farmers or field officers shall be able to request collection.

The request shall contain:

* Farm
* Batch
* Number of pigs
* Estimated weight
* Requested collection date
* Readiness status
* Notes

---

# 53. Collection Approval

## FR-PIG-049 — Approve Collection

**Priority:** Must Have

Authorized PigPower personnel shall approve collection requests.

The system shall create a collection record for approved requests.

---

# 54. Processing Traceability

## FR-PIG-050 — Processing Traceability

**Priority:** Must Have

The system shall preserve the relationship:

```text
Pig
 ↓
Batch
 ↓
Farm
 ↓
Collection
 ↓
Processing Lot
 ↓
Finished Product
```

This shall become the foundation of PigPower's product traceability system.

---

# 55. Processing Lot Association

## FR-PIG-051 — Associate Processing Lot

**Priority:** Must Have

Collected pigs shall be associated with a processing lot.

The processing module shall be responsible for detailed slaughter and processing records.

---

# 56. Pig Status

## FR-PIG-052 — Maintain Pig Status

**Priority:** Must Have

The system shall support statuses such as:

```text
REGISTERED
ACTIVE
QUARANTINED
SICK
RECOVERING
MARKET_READY
COLLECTION_SCHEDULED
COLLECTED
PROCESSED
TRANSFERRED
SOLD
DECEASED
LOST
REMOVED
BREEDING
```

---

# 57. Pig History

## FR-PIG-053 — Maintain Complete Pig History

**Priority:** Must Have

The system shall maintain chronological history of:

* Location
* Weight
* Health
* Treatments
* Vaccinations
* Feed
* Production stage
* Transfers
* Collection
* Processing

Historical records shall not be overwritten.

---

# 58. Pig Search

## FR-PIG-054 — Search Pigs

**Priority:** Must Have

Authorized users shall be able to search by:

* Pig ID
* Batch ID
* Farm
* Farmer
* Breed
* Sex
* Status
* Production stage

---

# 59. Pig Filtering

## FR-PIG-055 — Filter Livestock

**Priority:** Must Have

The system shall allow filtering by:

* Farm
* District
* Batch
* Status
* Production stage
* Weight range
* Age range
* Health status
* Market readiness

---

# 60. Pig Dashboard

## FR-PIG-056 — Farmer Pig Dashboard

**Priority:** Must Have

The farmer application shall provide a livestock summary.

Example:

```text
MY LIVESTOCK

Total pigs                 38
Healthy                    35
Under observation           2
Quarantined                 1

Average weight           67 kg
Market-ready               8

Active batches              2

Upcoming:
• Vaccination – 12 Aug
• Vet visit – 15 Aug
• Collection – 22 Aug
```

---

# 61. Batch Dashboard

## FR-PIG-057 — Batch Dashboard

**Priority:** Must Have

Users shall be able to view:

* Batch size
* Current number
* Mortality
* Average weight
* Target weight
* Production stage
* Feed program
* Health status
* Expected market date
* Collection readiness

---

# 62. Management Livestock Dashboard

## FR-PIG-058 — Network Livestock Dashboard

**Priority:** Must Have

Management shall be able to monitor:

* Total pigs
* Total batches
* Pigs by district
* Pigs by farm
* Pigs by production stage
* Average weight
* Mortality
* Market-ready pigs
* Expected production volume
* Disease alerts
* Collection pipeline

---

# 63. Offline Operation

## FR-PIG-059 — Offline Pig Management

**Priority:** Must Have

The mobile application shall support livestock data capture when internet connectivity is unavailable.

The application shall support offline:

* Pig registration
* Batch creation
* Weight recording
* Health records
* Vaccination records
* Treatment records
* Mortality records
* Farm movement records

---

# 64. Synchronization

## FR-PIG-060 — Synchronize Livestock Records

**Priority:** Must Have

The application shall synchronize offline livestock records with the central backend when connectivity becomes available.

Synchronization states shall include:

```text
SYNCED
PENDING
SYNCING
FAILED
CONFLICT
```

---

# 65. Conflict Management

## FR-PIG-061 — Resolve Data Conflicts

**Priority:** Should Have

Where multiple users modify the same livestock record, the system shall identify conflicts.

Conflicts shall not silently overwrite existing information.

The system shall preserve:

* Original value
* Updated value
* User
* Timestamp
* Conflict status

---

# 66. Notifications

## FR-PIG-062 — Livestock Notifications

**Priority:** Should Have

The platform should generate notifications for:

* Vaccinations
* Veterinary visits
* Treatment completion
* Withdrawal-period completion
* Quarantine reviews
* Market readiness
* Collection schedules
* Abnormal mortality

---

# 67. Data Validation

## FR-PIG-063 — Validate Livestock Data

The system shall validate:

* Weight values
* Dates
* Batch membership
* Farm membership
* Pigsty capacity
* Production-stage transitions
* Status transitions
* Health restrictions
* Movement restrictions

---

# 68. Business Rules

## BR-PIG-001

Every individually tracked pig shall have a unique Pig ID.

## BR-PIG-002

Every batch shall have a unique Batch ID.

## BR-PIG-003

Every pig shall belong to a registered farm while actively participating in the network.

## BR-PIG-004

Every active pig shall belong to a pigsty or approved production location.

## BR-PIG-005

Pigsty capacity shall not be exceeded without authorized intervention.

## BR-PIG-006

Historical livestock records shall not be deleted.

## BR-PIG-007

Health-related movement restrictions shall be enforced.

## BR-PIG-008

Quarantined pigs shall not be eligible for normal collection.

## BR-PIG-009

Animals under applicable medication withdrawal periods shall not be approved for collection.

## BR-PIG-010

Only authorized personnel may modify veterinary records.

## BR-PIG-011

Only authorized personnel may release animals from quarantine.

## BR-PIG-012

Pig movements shall be recorded.

## BR-PIG-013

Mortality events shall be recorded rather than deleting the animal record.

## BR-PIG-014

A deceased pig shall not remain classified as active.

## BR-PIG-015

Market-ready status shall require defined production criteria.

## BR-PIG-016

Collection shall require an approved collection request.

## BR-PIG-017

Collected animals shall no longer be treated as active farm inventory.

## BR-PIG-018

Processing records shall remain linked to originating livestock records.

## BR-PIG-019

A pig's historical farm locations shall remain traceable.

## BR-PIG-020

The system shall distinguish PigPower-owned livestock from farmer-owned livestock.

---

# 69. Conceptual Data Model

The initial conceptual model shall be:

```text
                         FARMER
                            │
                            │
                            ▼
                           FARM
                            │
                            ▼
                         PIGSTY
                            │
                            ▼
                       PIG BATCH
                            │
                ┌───────────┴───────────┐
                │                       │
                ▼                       ▼
               PIG                PRODUCTION CYCLE
                │
      ┌─────────┼─────────┬─────────┐
      │         │         │         │
      ▼         ▼         ▼         ▼
   WEIGHT     HEALTH     FEED    MOVEMENT
      │         │         │         │
      ▼         ▼         ▼         ▼
   GROWTH    TREATMENT   COST    LOCATION
      │
      ▼
 MARKET READY
      │
      ▼
 COLLECTION
      │
      ▼
 PROCESSING LOT
      │
      ▼
 FINISHED PRODUCT
```

---

# 70. Preliminary Entities

The following entities are proposed for database design.

### Pig

Individual livestock record.

### PigBatch

Group of pigs managed under a common production cycle.

### ProductionCycle

Defines a production period.

### PigIdentification

Stores identification information.

### PigWeightRecord

Stores weight history.

### PigHealthRecord

Stores health events.

### PigTreatment

Stores veterinary treatments.

### PigVaccination

Stores vaccination events.

### PigMovement

Stores movement history.

### PigMortality

Stores mortality events.

### PigFeedRecord

Stores feed-related livestock information.

### PigBreedingRecord

Stores breeding information.

### PigletAllocation

Stores distribution of piglets to farmers.

### QuarantineRecord

Stores quarantine events.

### CollectionRequest

Stores requests for livestock collection.

### ProcessingLot

Stores association between collected livestock and processing.

These entities shall be refined during database architecture.

---

# 71. Important Database Design Principle

The database shall **not** treat a pig's current state as the only source of truth.

For example, the system should not simply store:

```text
Farm = FAR-001
Weight = 80 kg
Status = ACTIVE
```

without maintaining historical records.

Instead:

```text
Pig
 │
 ├── Current Status
 ├── Current Farm
 ├── Current Batch
 │
 ├── Weight History
 ├── Health History
 ├── Treatment History
 ├── Vaccination History
 ├── Movement History
 └── Production History
```

This is essential for traceability.

---

# 72. Traceability Architecture

The system shall ultimately support:

```text
PIG ID
   │
   ▼
BATCH ID
   │
   ▼
FARM ID
   │
   ▼
FARMER ID
   │
   ▼
COLLECTION ID
   │
   ▼
PROCESSING LOT ID
   │
   ▼
PRODUCT BATCH ID
   │
   ▼
CUSTOMER / MARKET
```

This architecture is strategically important for:

* Food safety
* Quality assurance
* Consumer confidence
* Regulatory compliance
* Product recalls
* Export readiness
* Premium product positioning

---

# 73. Livestock KPIs

The platform shall support calculation of:

### Total Livestock

Number of active pigs within the network.

### Total Batches

Number of active production batches.

### Average Weight

```text
Total measured weight
÷
Number of measured pigs
```

### Average Daily Gain

```text
Weight gain
÷
Number of production days
```

### Mortality Rate

```text
Deaths
÷
Starting population
× 100
```

### Capacity Utilization

```text
Current pigs
÷
Approved capacity
× 100
```

### Market Readiness Rate

```text
Market-ready pigs
÷
Active pigs
× 100
```

### Collection Conversion

```text
Collected pigs
÷
Market-ready pigs
× 100
```

### Production Forecast

Expected kilograms of liveweight available for future collection.

---

# 74. Farmer Performance Metrics

Pig-level information shall contribute to farmer performance analysis.

Potential metrics include:

* Mortality rate
* Average daily gain
* FCR
* Market-weight achievement
* Production-cycle duration
* Treatment compliance
* Vaccination compliance
* Biosecurity compliance
* Collection fulfillment
* Livestock losses

These metrics may later contribute to farmer incentives and performance-based support.

---

# 75. AI Integration

The first release shall use deterministic business rules.

Once sufficient historical data exists, the platform may introduce AI/ML models for:

* Growth prediction
* Market-date prediction
* Mortality-risk prediction
* Feed-demand forecasting
* Disease-risk detection
* Collection forecasting
* Production-volume forecasting

The AI system shall not automatically make veterinary diagnoses.

Veterinary decisions shall remain under qualified professional oversight.

---

# 76. Data Privacy and Security

Livestock data shall be protected according to user roles.

Farmers shall primarily access their own livestock.

Field officers shall access assigned farms.

Veterinary personnel shall access appropriate health records.

Management shall have authorized aggregated reporting access.

Sensitive information shall not be exposed through public QR codes.

---

# 77. Audit Trail

The system shall record important livestock changes.

Audit records shall include:

* User
* Timestamp
* Pig
* Action
* Previous value
* New value
* Reason where required

Examples:

```text
PIG-000421
Weight changed
72 kg → 76 kg
Recorded by Field Officer
12-Aug-2026 09:35
```

---

# 78. Acceptance Criteria

The module shall be considered functionally complete when:

### Identification

* [ ] Individual pigs can be registered.
* [ ] Pig IDs are unique.
* [ ] Batches can be created.
* [ ] QR identification can be generated.
* [ ] Pig source can be recorded.

### Production

* [ ] Production cycles can be created.
* [ ] Production stages can be tracked.
* [ ] Weight measurements can be recorded.
* [ ] Growth metrics can be calculated.
* [ ] Market readiness can be determined.

### Health

* [ ] Health events can be recorded.
* [ ] Treatments can be recorded.
* [ ] Vaccinations can be recorded.
* [ ] Withdrawal periods can be enforced.
* [ ] Quarantine can be managed.
* [ ] Mortality can be recorded.

### Movement

* [ ] Pig movements can be recorded.
* [ ] Farm transfers can be recorded.
* [ ] Movement restrictions can be enforced.
* [ ] Historical movement can be viewed.

### Collection

* [ ] Market-ready pigs can be identified.
* [ ] Collection requests can be created.
* [ ] Collection can be approved.
* [ ] Collection can be linked to processing.

### Offline

* [ ] Livestock records can be captured offline.
* [ ] Weight records can be captured offline.
* [ ] Health records can be captured offline.
* [ ] Records synchronize when connectivity returns.

### Traceability

* [ ] Pig → Farm relationship is maintained.
* [ ] Pig → Batch relationship is maintained.
* [ ] Pig → Collection relationship is maintained.
* [ ] Collection → Processing relationship is maintained.
* [ ] Historical records remain available.

---

# 79. Requirement Traceability

| Requirement Area        | Business Objective                |
| ----------------------- | --------------------------------- |
| Pig identification      | Livestock traceability            |
| Batch management        | Distributed production management |
| Weight monitoring       | Productivity improvement          |
| Health records          | Disease control                   |
| Vaccination             | Animal health                     |
| Treatment               | Food safety                       |
| Withdrawal periods      | Consumer protection               |
| Mortality               | Production efficiency             |
| Movement tracking       | Biosecurity                       |
| Piglet allocation       | Farmer support                    |
| Feed tracking           | Cost optimization                 |
| Production forecasting  | Market planning                   |
| Collection readiness    | Supply-chain efficiency           |
| Processing traceability | Food traceability                 |
| Offline operation       | Rural accessibility               |
| QR identification       | Digital traceability              |
| Historical records      | Auditability                      |

---

# 80. Dependencies

The Pig Management Module depends on:

* Authentication
* User Management
* Farmer Management
* Farm Management
* Pigsty Management
* Backend API
* Database
* Offline storage
* Synchronization engine
* Notification system

It will later integrate with:

* Feed Management
* Veterinary Management
* Production Management
* Collection & Logistics
* Processing Management
* Payments
* Marketplace
* Analytics
* AI forecasting
* Renewable Energy
* Circular Economy

---

# 81. Future Extensions

Future versions may support:

* RFID livestock identification
* IoT weight scales
* Automated water monitoring
* Automated feed monitoring
* Computer vision
* Smart cameras
* Environmental sensors
* Automated health alerts
* Digital veterinary consultations
* Genetic-performance tracking
* Automated production forecasting
* Blockchain-based traceability where commercially justified

These features are not mandatory for the initial MVP.

---

# 82. MVP Scope

The first production version shall prioritize:

1. Pig registration
2. Batch registration
3. Pig identification
4. Farm association
5. Pigsty association
6. Weight recording
7. Production-stage tracking
8. Health status
9. Vaccination records
10. Treatment records
11. Mortality
12. Movement tracking
13. Market readiness
14. Collection readiness
15. Offline operation
16. Synchronization
17. Basic dashboards
18. Basic traceability

Advanced AI, IoT, RFID and computer vision shall be deferred until the core system is stable.

---

# 83. Strategic Importance

Pig Management transforms PigPower from a conventional farmer-registration application into a genuine **digital livestock management platform**.

The module establishes the livestock data layer required to connect:

```text
FARMER
   ↓
FARM
   ↓
PIG
   ↓
PRODUCTION
   ↓
COLLECTION
   ↓
PROCESSING
   ↓
PRODUCT
   ↓
MARKET
```

This creates the foundation for PigPower's long-term vision of a digitally integrated, traceable and scalable national pork value chain.

---

# 84. Open Design Decisions

The following decisions shall be finalized during system architecture and database design:

| ID          | Decision                                                   |
| ----------- | ---------------------------------------------------------- |
| PIG-DEC-001 | Individual vs batch identification thresholds              |
| PIG-DEC-002 | Final Pig ID structure                                     |
| PIG-DEC-003 | Final Batch ID structure                                   |
| PIG-DEC-004 | QR-code architecture                                       |
| PIG-DEC-005 | RFID integration requirements                              |
| PIG-DEC-006 | Approved breed catalogue                                   |
| PIG-DEC-007 | Production-stage definitions                               |
| PIG-DEC-008 | Weight-recording frequency                                 |
| PIG-DEC-009 | Market-weight thresholds                                   |
| PIG-DEC-010 | Withdrawal-period rules                                    |
| PIG-DEC-011 | Vaccination schedules                                      |
| PIG-DEC-012 | Disease classification                                     |
| PIG-DEC-013 | Quarantine rules                                           |
| PIG-DEC-014 | Mortality classification                                   |
| PIG-DEC-015 | Movement authorization                                     |
| PIG-DEC-016 | Feed-record architecture                                   |
| PIG-DEC-017 | Production forecasting algorithm                           |
| PIG-DEC-018 | AI model requirements                                      |
| PIG-DEC-019 | Livestock data retention                                   |
| PIG-DEC-020 | Individual traceability requirements for processing/export |
