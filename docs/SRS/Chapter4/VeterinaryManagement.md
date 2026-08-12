PigPower SmartFarm Platform
Functional Requirements Specification
Module: Veterinary Management

Document ID: PSP-SRS-FR-VET
Version: 1.0
Status: Draft
Parent Document: Software Requirements Specification
Chapter: 4 – Functional Requirements
Project: PigPower Lesotho – Community-Based Circular Pork Economy Platform

1. Module Overview

The Veterinary Management Module will provide the animal-health management layer of the PigPower SmartFarm Platform.

Its purpose is to enable PigPower, veterinarians, field officers and farmers to systematically monitor animal health, manage veterinary interventions, control disease risks, maintain treatment records, manage vaccination programs, enforce medicine withdrawal periods, and identify health events that could affect production, food safety and the wider farmer network.

The module must operate at both:

Individual pig level, where an animal has an identifiable health history; and
Farm/batch level, where diseases, treatments or biosecurity events may affect multiple animals.

The module is therefore critical not only for livestock health but also for:

Production efficiency
Farmer profitability
Disease prevention
Food safety
Meat traceability
Regulatory compliance
Processing eligibility
Consumer confidence
2. Business Purpose

PigPower's distributed farming model creates a major operational challenge:

A disease event at one farm can potentially affect an entire production network.

The platform therefore needs to detect health problems early and provide management with visibility across the network.

The Veterinary Management Module shall help PigPower answer:

Which pigs are currently sick?
Which farms have active health incidents?
Which animals have received treatment?
Which medicines were administered?
Who administered the treatment?
When was the treatment administered?
Is the animal still within its withdrawal period?
Which animals are vaccinated?
Which farms require veterinary visits?
Which farms are at elevated disease risk?
Which pigs are eligible for collection?
Which pigs must be excluded from slaughter because of treatment restrictions?
Are there emerging disease patterns across the network?
3. Module Objectives

The module shall:

Maintain comprehensive animal-health records.
Record veterinary examinations.
Manage vaccination programs.
Record disease and illness events.
Manage treatment records.
Track medication usage.
Calculate medicine withdrawal periods.
Generate veterinary alerts.
Support farm-level disease surveillance.
Support biosecurity monitoring.
Track veterinary visits.
Support laboratory testing.
Record diagnostic results.
Monitor treatment outcomes.
Support quarantine management.
Integrate health information with production management.
Integrate health information with traceability.
Prevent medically restricted animals from being incorrectly sent to processing.
Generate veterinary reports and analytics.
Support early disease detection.
4. Scope

The module covers:

Animal Health
      │
      ├── Disease
      ├── Examination
      ├── Diagnosis
      ├── Treatment
      ├── Medication
      ├── Vaccination
      ├── Laboratory Testing
      ├── Withdrawal Period
      ├── Quarantine
      ├── Biosecurity
      └── Veterinary Visits
               │
               ▼
        Health Risk Assessment
               │
               ▼
       Production Management
               │
               ▼
       Collection Eligibility
               │
               ▼
        Processing / Traceability
5. User Roles

The module shall support role-based access.

Farmer

Can:

Report illness
View animal health records
Record permitted observations
View vaccination schedules
View treatment instructions
Record approved farm activities
Receive alerts
Field Officer

Can:

Inspect farms
Record health observations
Create veterinary requests
Record biosecurity inspections
Monitor treatment compliance
Escalate health events
Veterinarian

Can:

Conduct examinations
Record diagnoses
Prescribe/administer treatments
Record vaccinations
Create treatment plans
Set withdrawal periods
Order laboratory tests
Manage quarantine
Close health cases
Veterinary Manager

Can:

Monitor network health
Review disease trends
Manage veterinary programs
Configure health protocols
Monitor medicine usage
System Administrator

Can configure system-level settings but shall not automatically receive permission to perform veterinary clinical activities.

6. Animal Health Record
FR-VET-001 — Maintain Health Record

The system shall maintain a health record for each identifiable pig.

The record shall include:

Pig ID
Farm ID
Batch ID
Production cycle
Health status
Vaccination history
Disease history
Treatment history
Medication history
Examination history
Laboratory results
Withdrawal status
Quarantine status
7. Health Status
FR-VET-002 — Maintain Health Status

The system shall support configurable health statuses.

Initial statuses:

HEALTHY
UNDER_OBSERVATION
SICK
UNDER_TREATMENT
RECOVERING
QUARANTINED
CRITICAL
DECEASED

Health status changes shall be recorded in the audit history.

8. Health Observation
FR-VET-003 — Record Health Observation

Authorized users shall be able to record health observations.

Examples:

Reduced appetite
Coughing
Diarrhea
Fever
Lethargy
Abnormal movement
Skin abnormalities
Respiratory symptoms
Injury
Behavioural changes

The system shall not interpret observations as confirmed diagnoses unless a qualified user records a diagnosis.

9. Health Incident
FR-VET-004 — Create Health Incident

A health incident shall contain:

Incident ID
Date/time
Farm
Pig or batch
Reported by
Symptoms
Severity
Initial observations
Current status
Assigned veterinarian
Follow-up date
10. Incident Severity

The system shall support:

LOW
MODERATE
HIGH
CRITICAL

Severity classification shall be configurable according to PigPower veterinary protocols.

11. Veterinary Examination
FR-VET-005 — Record Veterinary Examination

A veterinarian shall be able to record an examination.

The examination shall include:

Pig ID
Date/time
Veterinarian
Reason for examination
Clinical observations
Temperature where applicable
Weight where applicable
Diagnosis
Recommended treatment
Follow-up date
Notes
12. Diagnosis
FR-VET-006 — Record Diagnosis

Authorized veterinary personnel shall be able to record a diagnosis.

Diagnosis records shall include:

Diagnosis ID
Condition
Date
Pig/batch
Veterinarian
Confidence/diagnostic status
Supporting laboratory result where applicable
Treatment recommendation

The system shall distinguish:

SUSPECTED
PROVISIONAL
CONFIRMED
RULED_OUT
13. Disease Registry
FR-VET-007 — Maintain Disease Registry

The platform shall maintain a configurable disease/condition registry.

Each condition may contain:

Disease/condition name
Description
Symptoms
Transmission risk
Severity
Recommended response
Reporting requirement
Quarantine requirement

The registry shall be maintained by authorized personnel.

14. Treatment Plan
FR-VET-008 — Create Treatment Plan

Authorized veterinary users shall create treatment plans.

A treatment plan shall include:

Patient animal/batch
Diagnosis
Treatment
Medication
Dosage
Administration route
Frequency
Start date
End date
Duration
Responsible person
Withdrawal period
Follow-up date

The system shall not make autonomous clinical treatment decisions.

15. Medication Record
FR-VET-009 — Record Medication Administration

The system shall record:

Medicine
Animal/batch
Date/time
Quantity
Dose
Route
Administrator
Veterinary authorization
Treatment reason
Withdrawal period
16. Medicine Registry
FR-VET-010 — Maintain Medicine Registry

The system shall maintain a registry of approved medicines used within the PigPower system.

Information may include:

Product name
Active ingredient
Manufacturer
Medicine category
Form
Strength
Unit
Administration routes
Standard withdrawal period
Storage requirements

Withdrawal periods must be based on the applicable product label, veterinary direction and regulatory requirements rather than being invented by the software.

17. Withdrawal Period
FR-VET-011 — Calculate Withdrawal Period

When a treatment requiring a withdrawal period is recorded, the system shall calculate the earliest eligible date for slaughter/collection.

Conceptually:

Treatment Date
        +
Withdrawal Period
        =
Earliest Eligible Date

Example:

Treatment:
10 September

Withdrawal:
14 days

Earliest eligible date:
24 September

The actual calculation shall follow the configured veterinary rules.

18. Withdrawal Alert
FR-VET-012 — Generate Withdrawal Alert

If an animal is within a withdrawal period, the system shall display:

NOT ELIGIBLE FOR PROCESSING

The alert shall be visible to authorized collection and processing users.

19. Processing Eligibility
FR-VET-013 — Determine Processing Eligibility

Before a pig is marked as eligible for collection, the system shall evaluate applicable restrictions.

Potential restrictions include:

Active treatment
Withdrawal period
Quarantine
Health status
Pending laboratory result
Disease-control restriction

The system shall not permit a normal collection workflow to mark a medically restricted animal as eligible without authorized override.

20. Veterinary Override
FR-VET-014 — Authorized Override

Certain restrictions may require an authorized veterinary override.

Any override shall require:

Authorized user
Reason
Date/time
Supporting notes
Audit trail

The system shall never silently remove a veterinary restriction.

21. Vaccination Management
FR-VET-015 — Create Vaccination Program

Veterinary management shall be able to define vaccination programs.

A program may specify:

Vaccine
Target animals
Age/stage
Dose
Schedule
Administration method
Booster requirement
Target date
Responsible person
22. Vaccination Record
FR-VET-016 — Record Vaccination

The system shall record:

Pig ID/batch
Vaccine
Date
Dose
Batch/lot number
Expiry date
Administrator
Veterinarian
Next vaccination date
23. Vaccination Reminder
FR-VET-017 — Generate Vaccination Reminders

The system shall notify users before scheduled vaccinations.

Reminder periods shall be configurable.

24. Missed Vaccination
FR-VET-018 — Detect Missed Vaccination

The system shall identify overdue vaccinations.

The system shall notify appropriate users.

25. Veterinary Visit
FR-VET-019 — Schedule Veterinary Visit

Authorized users shall schedule veterinary visits.

A visit shall include:

Farm
Date
Veterinarian
Purpose
Priority
Assigned field officer
Status
26. Veterinary Visit Status
SCHEDULED
CONFIRMED
IN_PROGRESS
COMPLETED
CANCELLED
MISSED
27. Veterinary Visit Report
FR-VET-020 — Record Visit Report

After a veterinary visit, the veterinarian shall record:

Farms visited
Animals examined
Findings
Treatments
Vaccinations
Disease observations
Biosecurity issues
Recommendations
Follow-up actions
28. Laboratory Testing
FR-VET-021 — Request Laboratory Test

Authorized veterinary users shall be able to request laboratory testing.

The request shall contain:

Sample ID
Animal/batch
Farm
Sample type
Collection date
Requested test
Reason
Veterinarian
Laboratory
29. Laboratory Result
FR-VET-022 — Record Laboratory Result

The system shall store:

Sample ID
Test
Result
Laboratory
Date
Veterinarian
Attachments where applicable

Results shall support:

NEGATIVE
POSITIVE
INCONCLUSIVE
PENDING

where appropriate.

30. Laboratory Restrictions
FR-VET-023 — Apply Health Restrictions

Where a laboratory result requires action, authorized veterinary personnel shall be able to apply:

Observation
Treatment
Quarantine
Collection restriction
Processing restriction
31. Quarantine
FR-VET-024 — Create Quarantine

Authorized users shall be able to place a pig, batch or farm under quarantine.

The record shall include:

Subject
Start date
Reason
Responsible veterinarian
Restrictions
Review date
Expected end date
Status
32. Quarantine Status
ACTIVE
UNDER_REVIEW
RELEASED
EXTENDED
CANCELLED
33. Quarantine Enforcement
FR-VET-025 — Restrict Movement

Animals under quarantine shall be restricted from normal movement workflows.

The Collection and Logistics modules shall receive the restriction.

34. Disease Outbreak Management
FR-VET-026 — Create Disease Outbreak Event

Authorized veterinary management shall be able to create an outbreak event when a disease pattern requires network-level investigation.

The event shall contain:

Outbreak ID
Suspected condition
Date detected
Affected farms
Affected pigs
Geographic area
Severity
Response status
35. Disease Cluster Detection
FR-VET-027 — Identify Disease Clusters

The system should identify unusual concentrations of similar health incidents.

For example:

Farm A → respiratory symptoms
Farm B → respiratory symptoms
Farm C → respiratory symptoms

The platform should flag this pattern for veterinary investigation.

The system shall present this as a risk signal, not a confirmed disease diagnosis.

36. Farm Health Score
FR-VET-028 — Calculate Farm Health Risk Score

The platform should calculate a configurable health-risk indicator using factors such as:

Recent disease events
Mortality
Vaccination compliance
Biosecurity compliance
Treatment frequency
Quarantine events
Laboratory results

Example:

Farm Health Risk

Score: 27/100
Risk: LOW
37. Network Health Dashboard
FR-VET-029 — Veterinary Management Dashboard

Management shall be able to view:

Healthy farms
Farms under observation
Active disease cases
Farms under quarantine
Animals under treatment
Withdrawal restrictions
Vaccination compliance
Pending laboratory tests
Veterinary visits
High-risk farms
38. Farmer Veterinary Dashboard
FR-VET-030 — Farmer Health Dashboard

Farmers shall see:

ANIMAL HEALTH

Healthy:              42
Under observation:     2
Under treatment:       3
Quarantined:           1

Vaccinations due:      4
Veterinary visit:      18 Aug

Processing restricted: 3

Sensitive veterinary information shall be displayed according to the user's permissions.

39. Field Officer Dashboard
FR-VET-031 — Field Officer Health Dashboard

Field officers shall see:

Assigned health incidents
Farms requiring inspection
Overdue veterinary activities
Vaccination compliance
Biosecurity issues
Quarantine restrictions
High-risk farms
40. Biosecurity Inspection
FR-VET-032 — Conduct Biosecurity Inspection

The platform shall support structured biosecurity inspections.

Potential categories:

Farm access control
Visitor management
Animal isolation
Cleaning
Disinfection
Feed storage
Water hygiene
Pest control
Carcass disposal
Equipment sanitation
Animal movement control

The actual checklist shall be configured according to PigPower veterinary/biosecurity protocols.

41. Biosecurity Score
FR-VET-033 — Calculate Biosecurity Score

The platform shall calculate a farm-level biosecurity score from inspection results.

Example:

Biosecurity Score: 82%
Risk: LOW
42. Corrective Actions
FR-VET-034 — Create Corrective Action

A veterinary or field officer inspection may generate corrective actions.

Each action shall include:

Issue
Farm
Responsible person
Priority
Due date
Status
Completion evidence
43. Treatment Outcome
FR-VET-035 — Record Treatment Outcome

After treatment, authorized users shall record:

RECOVERED
IMPROVED
NO_CHANGE
WORSENED
DECEASED
REFERRED
44. Follow-Up
FR-VET-036 — Schedule Follow-Up

Treatment plans and health cases may require follow-up.

The system shall generate follow-up tasks.

45. Mortality Integration
FR-VET-037 — Integrate Veterinary and Mortality Records

When an animal dies, the system shall link the mortality event to the relevant health information where available.

Possible information:

Cause of death
Suspected disease
Treatment history
Date of illness
Date of death
Veterinary investigation

This information shall support mortality analysis in Production Management.

46. Production Integration

The Veterinary Module shall integrate with Production Management.

Health Event
     ↓
Treatment
     ↓
Possible growth impact
     ↓
Production performance
     ↓
Market-date forecast

For example, prolonged illness may cause:

Lower ADG
Increased feed cost
Longer production cycle
Delayed market readiness

Production Management should receive relevant status changes without duplicating clinical records.

47. Traceability Integration

Health events shall become part of the livestock traceability chain.

Pig ID
 ↓
Farm
 ↓
Batch
 ↓
Production Cycle
 ↓
Vaccination
 ↓
Treatment
 ↓
Withdrawal
 ↓
Collection
 ↓
Slaughter
 ↓
Processing
 ↓
Product Batch

This will be important for PigPower's long-term food-safety and product-traceability strategy.

48. Collection Integration

Before collection, the platform shall evaluate veterinary restrictions.

Pig
 ↓
Health Check
 ↓
Withdrawal Check
 ↓
Quarantine Check
 ↓
Collection Eligibility

Possible results:

ELIGIBLE
RESTRICTED
QUARANTINED
WITHDRAWAL_ACTIVE
PENDING_REVIEW
49. Processing Integration

The processing system shall receive only the information necessary to establish whether livestock is eligible for processing.

Where a pig is restricted, the system shall prevent accidental processing.

This creates a digital food-safety control point.

50. Notifications

The module shall generate notifications for:

New health incident
Veterinary appointment
Treatment due
Vaccination due
Withdrawal period ending
Withdrawal violation risk
Laboratory result
Quarantine
Quarantine review
Follow-up visit
Disease-risk escalation

Notifications may be delivered through:

Mobile application
Push notification
SMS
Email

The initial MVP should prioritize mobile push notifications and in-app alerts.

51. Offline Veterinary Data Capture

Because many PigPower farmers may operate in areas with unreliable connectivity, the mobile application shall support offline capture of appropriate veterinary records.

Offline records may include:

Health observations
Treatment records
Vaccinations
Veterinary visits
Biosecurity inspections
Mortality observations

Records shall synchronize when connectivity is restored.

52. Synchronization

The system shall track:

PENDING
SYNCING
SYNCED
FAILED
CONFLICT

Veterinary records shall not be silently overwritten during synchronization conflicts.

53. Data Validation

The system shall validate:

Animal ID
Farm
Batch
Treatment date
Medication
Dosage
Withdrawal period
Veterinarian
Vaccination date
Laboratory sample ID
Quarantine dates
54. Veterinary Audit Trail
FR-VET-038 — Maintain Audit Trail

The system shall maintain an immutable audit trail for critical veterinary events.

Audit records shall include:

User
Action
Date/time
Record affected
Previous value where appropriate
New value where appropriate
Device/source where appropriate

Critical records include:

Diagnosis
Treatment
Medication
Withdrawal period
Quarantine
Processing restriction
Veterinary override
Laboratory result
55. Security Requirements

Veterinary information shall be protected through role-based access control.

For example:

Farmer
   ↓
Own farm information

Field Officer
   ↓
Assigned farms

Veterinarian
   ↓
Assigned/authorized farms

Veterinary Manager
   ↓
Network veterinary information

Administrator
   ↓
System administration

Administrative access shall not automatically grant clinical authorization.

56. Business Rules
BR-VET-001

Every veterinary event must be associated with a farm.

BR-VET-002

Where applicable, a veterinary event must be associated with a pig or batch.

BR-VET-003

Only authorized veterinary personnel may record confirmed diagnoses.

BR-VET-004

Treatment records must contain sufficient information to determine the applicable withdrawal restriction.

BR-VET-005

Animals within an active withdrawal period shall not be normally eligible for processing.

BR-VET-006

Quarantined animals shall not be eligible for normal movement.

BR-VET-007

Veterinary restrictions shall not be deleted to bypass collection controls.

BR-VET-008

Critical veterinary records shall be auditable.

BR-VET-009

Vaccination records shall retain vaccine batch/lot information where available.

BR-VET-010

Laboratory results shall not be altered by ordinary users.

BR-VET-011

A health observation shall not automatically become a confirmed diagnosis.

BR-VET-012

Treatment outcomes shall remain linked to the original treatment plan.

BR-VET-013

Veterinary overrides require authorization and a recorded reason.

BR-VET-014

Withdrawal periods shall be based on configured veterinary/product information.

BR-VET-015

Disease-risk signals shall not be represented as confirmed diagnoses without veterinary confirmation.

57. Database Entities

The Veterinary Management Module will introduce the following conceptual entities:

VeterinaryCase
HealthObservation
VeterinaryExamination
Diagnosis
Disease
TreatmentPlan
TreatmentRecord
Medication
MedicationAdministration
VaccinationProgram
VaccinationRecord
VeterinaryVisit
LaboratoryTest
LaboratoryResult
Quarantine
BiosecurityInspection
CorrectiveAction
HealthAlert
HealthRiskAssessment
WithdrawalRestriction
58. Conceptual Database Relationship
FARM
 │
 ├───────────────┐
 │               │
 ▼               ▼
PIG            BATCH
 │               │
 └───────┬───────┘
         ▼
   VETERINARY CASE
         │
    ┌────┼─────────────┐
    ▼    ▼             ▼
EXAM  DIAGNOSIS    OBSERVATION
         │
         ▼
   TREATMENT PLAN
         │
         ▼
 TREATMENT RECORD
         │
         ▼
   MEDICATION
         │
         ▼
WITHDRAWAL PERIOD
         │
         ▼
PROCESSING ELIGIBILITY

Vaccination operates as another health-history branch:

PIG/BATCH
    │
    ▼
VACCINATION
    │
    ├── Vaccine
    ├── Date
    ├── Lot
    └── Next Due Date
59. Key Veterinary KPIs
KPI	Purpose
Mortality Rate	Animal health
Disease Incidence	Disease surveillance
Treatment Rate	Health intervention
Recovery Rate	Treatment effectiveness
Vaccination Compliance	Prevention
Biosecurity Compliance	Disease prevention
Withdrawal Compliance	Food safety
Quarantine Events	Disease control
Veterinary Response Time	Operational performance
Repeat Disease Rate	Farm health
Health Cost/Pig	Production economics
Disease-Related Production Loss	Financial impact
60. Veterinary Response Time

The system shall measure:

Health Incident Reported
        ↓
Veterinarian Assigned
        ↓
Veterinary Intervention

This allows PigPower to calculate response time.

Example:

Incident reported:
08:30

Veterinarian assigned:
09:00

Visit:
11:30

Response time:
3 hours

This will become a critical operational KPI as the network scales.

61. Disease Surveillance

The platform should eventually support network-level surveillance.

Example:

Week 1
Farm A → 2 cases

Week 2
Farm B → 3 cases

Week 3
Farm C → 4 cases

The system could flag:

Potential emerging health pattern – veterinary review required.

The software should assist veterinary professionals rather than replace them.

62. AI Roadmap

Veterinary AI should be implemented cautiously.

Phase 1 — Rules
High mortality
+
Similar symptoms
=
Alert
Phase 2 — Statistical analysis

Use historical data to identify unusual disease patterns.

Phase 3 — Predictive models

Potential applications:

Disease-risk prediction
Mortality prediction
Treatment-response prediction
Farm health scoring
Outbreak-risk detection
Phase 4 — Advanced analytics

Integrate:

Weather
Geography
Animal movement
Production performance
Disease history
Feed data

This could eventually create a PigPower National Swine Health Intelligence System.

63. MVP Scope

For the first version, implement:

Animal health records
Health observations
Veterinary cases
Veterinary examinations
Treatment records
Medication records
Withdrawal-period tracking
Vaccination records
Veterinary visits
Basic quarantine
Veterinary alerts
Biosecurity inspections
Health dashboard
Production integration
Collection eligibility integration
Offline capture
Synchronization
Audit trail

Defer:

Advanced disease prediction
Computer vision
AI diagnosis
IoT health monitoring
Automated temperature monitoring
Advanced epidemiological modelling

until PigPower has sufficient real-world data.

64. Acceptance Criteria

The Veterinary Management Module shall be considered functionally complete when:

Health
 Health observations can be recorded.
 Veterinary cases can be created.
 Veterinary examinations can be recorded.
 Diagnoses can be recorded by authorized personnel.
 Health history can be viewed.
Treatment
 Treatment plans can be created.
 Medication administration can be recorded.
 Withdrawal periods can be calculated.
 Treatment outcomes can be recorded.
Vaccination
 Vaccination programs can be configured.
 Vaccinations can be recorded.
 Vaccination reminders can be generated.
 Overdue vaccinations can be identified.
Disease Control
 Quarantine can be applied.
 Restricted animals cannot enter normal collection workflows.
 Disease incidents can be monitored.
 Health alerts can be generated.
Biosecurity
 Biosecurity inspections can be recorded.
 Biosecurity scores can be calculated.
 Corrective actions can be created.
Integration
 Veterinary status integrates with Pig Management.
 Veterinary events can affect Production Management.
 Withdrawal restrictions integrate with Collection.
 Health information contributes to Traceability.
Security
 Role-based access is enforced.
 Critical veterinary events are audited.
 Veterinary overrides are traceable.
65. Strategic Importance to PigPower

Veterinary Management is more than a digital record-keeping system.

It becomes a risk-control mechanism for the entire PigPower value chain.

The architecture will eventually look like:

                  PIGPOWER PLATFORM
                         │
        ┌────────────────┼────────────────┐
        │                │                │
     FARMERS          LIVESTOCK        VETERINARY
        │                │                │
        └────────────────┼────────────────┘
                         │
                    PRODUCTION
                         │
                         ▼
                  MARKET READINESS
                         │
              ┌──────────┴──────────┐
              │                     │
          COLLECTION            TRACEABILITY
              │                     │
              └──────────┬──────────┘
                         ▼
                    PROCESSING
                         │
                         ▼
                     PRODUCTS

The most important control is:

HEALTH
  ↓
TREATMENT
  ↓
WITHDRAWAL
  ↓
ELIGIBILITY
  ↓
COLLECTION
  ↓
PROCESSING
  ↓
SAFE PORK PRODUCT