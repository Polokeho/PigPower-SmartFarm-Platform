PigPower SmartFarm Platform
Software Requirements Specification — Functional Requirements
Module: System Administration & Configuration Management

Document ID: PSP-SRS-FR-SACM
Version: 1.0
Status: Draft
Parent Document: PigPower SmartFarm Platform SRS
Chapter: 4 – Functional Requirements
Project: PigPower Lesotho – Community-Based Circular Pork Economy Platform

## 1. Module Overview

The System Administration & Configuration Management Module (SACM) will provide the control layer through which authorized administrators configure, govern and adapt the PigPower SmartFarm Platform without requiring changes to application source code.

Every other module specified so far — Farmer Management, Production, Veterinary, Feed, Logistics, Processing, Sales, CRM, Payments, Finance, Energy, M&E, Reporting/BI, Notifications, and Document Management — depends on reference data, business rules, roles, permissions and parameters that must be defined somewhere.

SACM is that "somewhere."

Rather than hard-coding districts, breeds, feed types, roles, notification rules, KPI targets, document types and numbering sequences into the application, the platform shall treat these as **configuration**, owned and maintained by authorized administrators through a dedicated administration interface.

## 2. Business Purpose

PigPower is expected to evolve continuously — new districts will be added, new products introduced, new roles created, new partners onboarded, and new regulatory requirements imposed.

A platform that requires a software release every time a district, feed type or role changes would be operationally fragile and expensive to maintain.

SACM exists to make the platform **configurable rather than hard-coded**, so that:

```
Business Change
      ↓
Configuration Update
      ↓
Immediate Effect
      ↓
No Code Deployment Required
```

wherever this is practically and safely achievable.

## 3. Strategic Objectives

The module shall enable PigPower to:

1. Centrally manage system-wide configuration.
2. Manage roles and permissions.
3. Manage organizational and geographic reference data.
4. Manage master/lookup data used across modules.
5. Manage numbering and ID sequences.
6. Manage business rules and thresholds.
7. Manage workflow and approval configuration.
8. Manage localization and language settings.
9. Manage mobile application configuration.
10. Manage integration and provider configuration.
11. Manage security policy configuration.
12. Support controlled, auditable configuration change.
13. Reduce dependency on developers for routine operational changes.
14. Provide a single source of truth for reference data across all modules.
15. Support the platform's growth from pilot to national scale without re-architecture.

## 4. System Administration Architecture

```
                    ADMINISTRATOR
                          │
                          ▼
                 ADMINISTRATION CONSOLE
                          │
        ┌─────────────────┼─────────────────┐
        ▼                 ▼                 ▼
   ACCESS CONTROL    MASTER DATA       SYSTEM SETTINGS
        │                 │                 │
        └─────────────────┼─────────────────┘
                          ▼
                CONFIGURATION SERVICE
                          │
                          ▼
                CONFIGURATION STORE
                          │
        ┌─────────────────┼─────────────────┐
        ▼                 ▼                 ▼
   ALL OTHER          MOBILE APP        REPORTING /
   MODULES            CONFIGURATION     BI MODULE
```

All operational modules shall read configuration from SACM rather than maintaining their own private copies of shared reference data.

## 5. Configuration Domains

The module shall organize configuration into the following domains:

| Domain | Examples |
|---|---|
| Access Control | Roles, permissions, role assignment |
| Organizational | Districts, regions, communities, farms, facilities |
| Master / Lookup Data | Breeds, feed types, product types, units of measure |
| Veterinary Reference Data | Disease types, vaccine types, treatment types |
| Commercial Reference Data | Customer types, supplier categories, price lists |
| Numbering | ID sequences and document numbering formats |
| Workflow | Approval chains, escalation rules |
| Notification | Notification rules, channel strategy, templates (referencing NCM) |
| Document | Document types, categories, retention policies (referencing DFM) |
| Reporting / KPI | KPI definitions, targets, thresholds (referencing RBIM) |
| Localization | Supported languages, translations |
| Security | Password policy, session policy, MFA policy |
| Mobile | App version control, feature flags, forced-update policy |
| Integration | External provider configuration (SMS, email, storage, payments) |
| System-Wide | General parameters (file size limits, timeouts, defaults) |

## 6. User & Role Management

### FR-SACM-001 — Role Management

The system shall allow authorized administrators to create, edit, activate and deactivate roles.

Example roles:

```
SUPER_ADMIN
ADMINISTRATOR
OPERATIONS_MANAGER
FARM_MANAGER
FIELD_OFFICER
VETERINARIAN
COLLECTION_OFFICER
DRIVER
PROCESSING_MANAGER
WAREHOUSE_MANAGER
SALES_MANAGER
SALES_REPRESENTATIVE
FINANCE_MANAGER
FINANCE_OFFICER
HR_MANAGER
PROCUREMENT_OFFICER
ENERGY_TECHNICIAN
M&E_OFFICER
CEO
INVESTOR (external, read-only)
BEDCO_REVIEWER (external, read-only)
FARMER (self-service, mobile)
CUSTOMER (self-service, portal)
```

Roles shall be configurable rather than fixed in code, so that new operational roles can be introduced as the organization grows.

### 7. Permissions

### FR-SACM-002 — Permission Management

The system shall maintain a catalog of granular permissions.

Example:

```
farmer.create
farmer.view
farmer.edit
farmer.approve
farmer.delete

production.view
production.edit

veterinary.record.create
veterinary.record.view

finance.view
finance.approve

payroll.view
payroll.process

document.upload
document.approve
document.delete

report.view.executive
report.view.financial

admin.configuration.edit
admin.role.manage
```

Permissions should follow a consistent `module.action` or `module.entity.action` naming convention to keep the catalog manageable as the platform grows.

### 8. Role-Permission Matrix

### FR-SACM-003 — Role-Permission Assignment

The system shall allow administrators to assign permissions to roles through a configurable matrix rather than through code changes.

Example:

| Permission | Field Officer | Farm Manager | Finance Manager | Admin |
|---|---|---|---|---|
| farmer.create | ✓ | ✓ | – | ✓ |
| farmer.approve | – | ✓ | – | ✓ |
| finance.view | – | – | ✓ | ✓ |
| payroll.process | – | – | ✓ | ✓ |
| admin.configuration.edit | – | – | – | ✓ |

### 9. User-Role Assignment

### FR-SACM-004 — User-Role Assignment

The system shall allow one or more roles to be assigned to a user, and shall support scoping a role to a specific district, farm cluster, or facility where relevant.

Example:

```
User: Thabo M.
Role: Field Officer
Scope: Berea District
```

This allows the same role definition to be reused across the country while limiting each user's operational reach to their assigned area.

### 10. Delegated Administration

### FR-SACM-005 — Delegated Administration

The system shall support delegated administration, allowing a District/Operations Manager to manage users and limited configuration within their own scope, without requiring full system-administrator rights.

## 11. Organizational & Geographic Configuration

### FR-SACM-006 — Geographic Reference Data

The system shall maintain a configurable hierarchy of geographic reference data used throughout the platform.

```
LESOTHO
   │
   ├── Maseru
   ├── Berea
   ├── Leribe
   ├── Mafeteng
   ├── Mohale's Hoek
   ├── Quthing
   ├── Qacha's Nek
   ├── Mokhotlong
   ├── Thaba-Tseka
   └── Butha-Buthe
```

Each district may be further broken down into communities/villages as the farmer network grows, without requiring code changes.

### FR-SACM-007 — Facility Configuration

The system shall maintain a configurable register of PigPower-operated and partner facilities, for example:

```
FACILITY TYPE
   Toll-Processing Partner
   Owned Processing Facility
   Warehouse
   Biodigester Site
   Collection Point
```

Facility records should include location, capacity, status and operational dates, and shall be referenced by Processing, Inventory, Logistics and Energy modules rather than duplicated within them.

## 12. Master / Lookup Data Management

### FR-SACM-008 — Generic Lookup Table Engine

The system shall provide a generic lookup-table mechanism so that new configurable lists can be introduced without a database schema change wherever practical.

Conceptual model:

```
LookupTable
   │
   ▼
LookupValue
   ├── code
   ├── label
   ├── description
   ├── sort_order
   ├── active
   └── metadata (JSON, optional)
```

Examples of lists managed this way:

```
Pig Breeds
Feed Types
Vaccine Types
Disease Types
Treatment Types
Product Categories
Unit of Measure
Customer Types
Supplier Categories
Complaint Categories
Lead Sources
Document Types
Communication Channels
```

### 13. Breed Configuration

### FR-SACM-009 — Breed Management

The system shall allow administrators to define pig breeds and hybrid crosses used across Farmer, Pig and Production modules, including expected growth benchmarks used for production forecasting.

### 14. Feed Type Configuration

### FR-SACM-010 — Feed Type Management

The system shall allow administrators to define feed types, feed categories and standard feed-conversion benchmarks referenced by the Feed and BI modules.

### 15. Veterinary Reference Data

### FR-SACM-011 — Veterinary Reference Data Management

The system shall allow administrators to configure:

```
Disease Types
Vaccine Types
Treatment Types
Biosecurity Checklist Items
```

used by the Veterinary Management module, including default vaccination schedules where applicable.

### 16. Product & Pricing Configuration

### FR-SACM-012 — Product Catalog Configuration

The system shall allow administrators to configure the product catalog (fresh pork cuts, bacon, ham, sausages, smoked products, fertiliser, and future SKUs) referenced by Processing, Inventory, Sales and CRM.

### FR-SACM-013 — Price List Configuration

The system shall allow administrators to configure price lists, including customer-segment-specific pricing where applicable, with an effective date range for each price.

Example:

```
Product: Fresh Pork (per kg)
Standard Price: M55.00
Restaurant Segment Price: M52.00
Effective: 01 Sep 2026 – 31 Dec 2026
```

### 17. Customer & Supplier Reference Data

### FR-SACM-014 — Customer/Supplier Category Configuration

The system shall allow administrators to configure customer types, customer segments and supplier categories referenced by CRM and Procurement, consistent with the classifications defined in the Customer & CRM Management module.

## 18. Numbering & Sequence Configuration

### FR-SACM-015 — ID Sequence Configuration

The system shall provide a configurable numbering engine for entity identifiers and document numbers, so numbering formats can be adapted without code changes.

Example:

```
Entity: Farmer
Format: FMR-{000000}
Next Value: FMR-000246

Entity: Sales Order
Format: SO-{YYYY}-{00000}
Next Value: SO-2026-00842

Entity: Complaint Case
Format: CASE-{YYYY}-{00000}
Next Value: CASE-2026-00052
```

### FR-SACM-016 — Sequence Integrity

The numbering engine shall guarantee unique, non-repeating values even under concurrent creation across multiple users and devices, including offline-created records that are later synchronized.

## 19. Workflow & Approval Configuration

### FR-SACM-017 — Workflow Configuration

The system shall provide a generic, configurable workflow/approval engine that other modules (Document Management, CRM contracts, Finance, Procurement) can use rather than each implementing its own approval logic.

Example generic workflow definition:

```
Workflow: Supplier Contract Approval
Step 1: Procurement Officer submits
Step 2: Procurement Manager reviews
Step 3: Finance Manager approves (if value > M50,000)
Step 4: Operations Manager final sign-off
```

### FR-SACM-018 — Approval Thresholds

The system shall allow monetary and operational thresholds used in approval workflows (e.g. purchase order approval limits, discretionary discount limits) to be configured rather than hard-coded.

## 20. Notification, Document & KPI Configuration (Cross-Module Settings)

### FR-SACM-019 — Notification Rule Administration

The system shall provide an administration interface for the notification rules described in the Notification & Communication Management module (event, condition, recipient, channel, priority), so operational thresholds (e.g. "vaccination due within 24 hours") can be tuned without code changes.

### FR-SACM-020 — Document Type Administration

The system shall provide an administration interface for the document types, categories and retention policies described in the Document & File Management module.

### FR-SACM-021 — KPI & Target Administration

The system shall provide an administration interface for KPI definitions and targets described in the Reporting & Business Intelligence module, including the ability to set and revise annual/quarterly targets aligned to the business plan (e.g. Year 1: 30 farmers, Year 5: 500 farmers).

## 21. Localization Configuration

### FR-SACM-022 — Language Configuration

The system shall support configuration of supported languages (initially English and Sesotho) and shall allow administrators to manage translated labels and message templates without requiring a new application build.

### FR-SACM-023 — Regional Formatting

The system shall support configurable regional formatting for currency (Maloti, M), date format, and number format.

## 22. System-Wide Parameters

### FR-SACM-024 — Global Parameter Management

The system shall maintain a configurable set of global parameters, for example:

```
PARAMETER                          VALUE
max_upload_file_size_mb            10
max_report_file_size_mb            25
session_timeout_minutes            30
otp_expiry_minutes                 5
default_language                   en
default_currency                   LSL
low_stock_threshold_default        10%
customer_churn_threshold_b2b_days  30
customer_churn_threshold_retail_days 90
```

Parameters shall be grouped by module and shall support type validation (numeric, boolean, text, date, enumerated) to prevent invalid configuration.

## 23. Security Policy Configuration

### FR-SACM-025 — Password & Session Policy

The system shall allow administrators to configure:

```
Minimum password length
Password complexity rules
Password expiry period
Failed login lockout threshold
Session timeout duration
Multi-factor authentication requirement (by role)
```

### FR-SACM-026 — Access Restriction Configuration

The system shall allow administrators to configure IP or device restrictions for sensitive administrative functions where required.

## 24. Mobile Application Configuration

### FR-SACM-027 — Mobile Feature Flags

The system shall support remotely configurable feature flags for the Flutter mobile application, allowing features to be enabled/disabled for specific roles or app versions without requiring an app-store release.

Example:

```
FEATURE                     STATUS
offline_production_capture  ENABLED
digital_marketplace         DISABLED (Phase 2)
ai_forecasting_widget       DISABLED (Phase 2)
biogas_dashboard            ENABLED
```

### FR-SACM-028 — App Version Control

The system shall allow administrators to configure minimum supported app version and to force an update prompt when a device is running a version below the configured minimum, particularly important for offline-capable field devices operating in rural connectivity conditions.

### FR-SACM-029 — Mobile Sync Configuration

The system shall allow administrators to configure offline synchronization parameters (sync interval, maximum offline queue size, conflict-resolution defaults) referenced by the mobile application's offline-first architecture.

## 25. Integration & Provider Configuration

### FR-SACM-030 — External Provider Configuration

The system shall allow administrators to configure external service providers (SMS gateway, email service, file/object storage, payment gateway) behind the provider-abstraction layers defined in the Notification and Document Management modules.

Example:

```
PROVIDER TYPE     ACTIVE PROVIDER      STATUS
SMS               Provider A           ACTIVE
Email             Provider B           ACTIVE
File Storage      S3-Compatible Store  ACTIVE
Payment Gateway   Not yet configured   PENDING
```

Provider credentials shall be stored securely in the backend configuration store and shall never be embedded in the Flutter application code, consistent with the security principle established in the Notification & Communication Management module.

## 26. Configuration Change Control

### FR-SACM-031 — Configuration Approval

The system shall optionally require a second-user approval for changes to high-impact configuration (e.g. approval thresholds, price lists, security policy), consistent with the generic workflow engine in Section 19.

### FR-SACM-032 — Configuration Versioning

The system shall maintain a version history of configuration changes, allowing administrators to view what a setting's value was at any point in time.

### FR-SACM-033 — Configuration Audit Trail

The system shall log:

```
Who changed a configuration value
Previous value
New value
Date/time
Reason (where captured)
Approval status
```

Example:

```
CONFIGURATION: notification_rule.vaccination_due_hours
PREVIOUS VALUE: 48
NEW VALUE: 24
CHANGED BY: Operations Manager
APPROVED BY: Administrator
DATE: 14 Aug 2026
```

## 27. Bulk Reference Data Import

### FR-SACM-034 — Bulk Import

The system shall allow administrators to bulk-import reference data (e.g. an initial district/community list, an initial product catalog) via CSV/Excel upload, with validation and an error report for rejected rows.

## 28. System Health & Administration Visibility

### FR-SACM-035 — System Health Dashboard

The system shall provide administrators with a basic operational health view, for example:

```
Active Users (last 24h)
Failed Login Attempts
Pending Sync Queue Size
Notification Delivery Failures (last 24h)
Storage Utilization
Last Successful Backup
```

This complements, but does not replace, the deeper diagnostic capability expected from infrastructure-level monitoring tools introduced later at the architecture stage.

## 29. Backup & Restore Administration

### FR-SACM-036 — Backup Configuration Visibility

The system shall allow administrators to view backup status and schedule (backup execution itself is an infrastructure concern, but visibility and restore-request initiation should be accessible to authorized administrators).

## 30. Relationship With Other Modules

SACM does not duplicate operational data; it supplies the reference data, rules and settings that operational modules consume.

```
                         SACM
                           │
        ┌──────────┬───────┴───────┬──────────┐
        ▼          ▼               ▼          ▼
    Farmer &     Veterinary     Notification  Document
    Farm Mgmt    Management     & Comms       Management
        │          │               │          │
        ▼          ▼               ▼          ▼
   uses Districts uses Disease  uses Rules  uses Doc
   & Breeds       & Vaccine     & Channels  Types &
                  Types                     Retention
```

A key architectural rule follows directly from this relationship:

**BR-SACM-001** — Operational modules shall read shared reference data from SACM rather than maintaining independent copies, to prevent inconsistent lists (e.g. two different district spellings) from emerging across the platform.

## 31. Core Database Entities

```
Role
Permission
RolePermission
UserRole

LookupTable
LookupValue

District
Community
Facility

Sequence
SequenceFormat

Workflow
WorkflowStep
WorkflowApproval

SystemParameter
SystemParameterGroup

SecurityPolicy

FeatureFlag
AppVersionPolicy
SyncConfiguration

ProviderConfiguration

ConfigurationChangeLog
ConfigurationVersion
```

## 32. Functional Requirements Summary

| ID | Requirement |
|---|---|
| SACM-FR-001 | The system shall allow role creation and management. |
| SACM-FR-002 | The system shall maintain a permission catalog. |
| SACM-FR-003 | The system shall support role-permission assignment. |
| SACM-FR-004 | The system shall support scoped user-role assignment. |
| SACM-FR-005 | The system shall support delegated administration. |
| SACM-FR-006 | The system shall maintain geographic reference data. |
| SACM-FR-007 | The system shall maintain facility configuration. |
| SACM-FR-008 | The system shall provide a generic lookup-table engine. |
| SACM-FR-009 | The system shall support breed configuration. |
| SACM-FR-010 | The system shall support feed-type configuration. |
| SACM-FR-011 | The system shall support veterinary reference data configuration. |
| SACM-FR-012 | The system shall support product catalog configuration. |
| SACM-FR-013 | The system shall support price list configuration. |
| SACM-FR-014 | The system shall support customer/supplier reference data configuration. |
| SACM-FR-015 | The system shall provide configurable ID/document numbering. |
| SACM-FR-016 | The system shall guarantee unique sequence values under concurrency and offline sync. |
| SACM-FR-017 | The system shall provide a generic workflow/approval engine. |
| SACM-FR-018 | The system shall support configurable approval thresholds. |
| SACM-FR-019 | The system shall provide notification rule administration. |
| SACM-FR-020 | The system shall provide document type administration. |
| SACM-FR-021 | The system shall provide KPI and target administration. |
| SACM-FR-022 | The system shall support language configuration. |
| SACM-FR-023 | The system shall support regional formatting configuration. |
| SACM-FR-024 | The system shall maintain global system parameters. |
| SACM-FR-025 | The system shall support password and session policy configuration. |
| SACM-FR-026 | The system shall support access restriction configuration. |
| SACM-FR-027 | The system shall support mobile feature flags. |
| SACM-FR-028 | The system shall support app version control / forced update. |
| SACM-FR-029 | The system shall support mobile sync configuration. |
| SACM-FR-030 | The system shall support external provider configuration. |
| SACM-FR-031 | The system shall support configuration approval workflow. |
| SACM-FR-032 | The system shall maintain configuration version history. |
| SACM-FR-033 | The system shall maintain a configuration audit trail. |
| SACM-FR-034 | The system shall support bulk reference-data import. |
| SACM-FR-035 | The system shall provide a system health dashboard. |
| SACM-FR-036 | The system shall provide backup status visibility. |

## 33. Non-Functional Requirements

**Security** — Administrative functions shall be restricted to authorized roles, with sensitive actions (role changes, security policy changes, provider credential changes) requiring elevated permissions.

**Reliability** — Configuration changes shall take effect predictably and shall not silently fail.

**Consistency** — All modules shall read shared reference data from a single authoritative source to prevent drift.

**Auditability** — All configuration changes shall be attributable to a specific user and timestamp.

**Usability** — The administration console shall be usable by non-technical operations staff for routine reference-data maintenance, reserving developer involvement for genuine architectural change.

**Scalability** — Configuration architecture shall support growth from a handful of districts and roles in the pilot to a full national deployment without redesign.

**Safety** — Destructive configuration actions (deleting a role in use, deleting a lookup value referenced by existing records) shall be prevented or require explicit confirmation and impact assessment.

## 34. Example End-to-End Scenario — Adding a New District

```
Step 1
PigPower expands operations into Mafeteng.

Step 2
Administrator opens SACM → Geographic Reference Data.

Step 3
Administrator adds "Mafeteng" as an active district.

Step 4
Change is logged in the Configuration Audit Trail.

Step 5
"Mafeteng" is now immediately selectable in:
   Farmer registration
   Collection route planning
   Sales & CRM geographic segmentation
   BI geographic dashboards

Step 6
No application redeployment was required.
```

## 35. Example End-to-End Scenario — Adjusting a Notification Threshold

```
Step 1
Operations Manager notices vaccination reminders arrive too late.

Step 2
Administrator opens SACM → Notification Rule Administration.

Step 3
Rule "VACCINATION_DUE" reminder window changed from 48 hours to 24 hours.

Step 4
Change requires approval (per Section 26 configuration approval policy).

Step 5
Administrator (second user) approves the change.

Step 6
Notification Engine immediately applies the new rule to all future events.
```

## 36. Recommended GitHub File

Create:

```
docs/SRS/Chapter4/SystemAdministrationConfiguration.md
```

Then commit it:

```
git add docs/SRS/Chapter4/SystemAdministrationConfiguration.md
git commit -m "docs: add system administration and configuration management requirements"
git push
```

## 37. Where We Are Now

Chapter 4 functional requirements now cover:

```
Authentication
User Management
Farmer Management
Farm Management
Pig Management
Production Management
Veterinary Management
Feed Management
Collection & Logistics
Processing & Meat Production
Inventory & Warehouse
Sales & Orders
Customer & CRM
Farmer Payments & Settlements
Finance & Accounting
Procurement & Suppliers
HR & Payroll
Renewable Energy & Biodigester
Impact, Monitoring & Evaluation
Reporting & Business Intelligence
Notification & Communication
Document & File Management
System Administration & Configuration   ← this document
```

The remaining modules to close out Chapter 4 are:

```
Audit, Compliance & Regulatory Management
Offline Synchronization & Data Synchronization Management
Integration & API Management
```

## 38. Next Module

I recommend **Audit, Compliance & Regulatory Management** next, because several modules already specified (Farmer & CRM data privacy, Finance, HR, Document retention, Configuration change control) have referenced audit and compliance requirements without yet defining them formally in one place. That module should consolidate:

- platform-wide audit logging standards (what must be logged, how long it is retained, who can view it);
- regulatory compliance tracking (food safety, environmental, tax, labour law, data protection);
- compliance certificate/licence tracking (tying back into Document & File Management expiry tracking);
- internal control and segregation-of-duties principles across Finance, Procurement and Farmer Payments;
- BEDCO/grant compliance obligations specifically.

After that, **Offline Synchronization & Data Synchronization Management** should be specified in detail — it has been referenced repeatedly (farmer production capture, document capture, notification queuing) but deserves its own formal chapter given how central offline-first operation is to a rural Lesotho deployment. **Integration & API Management** would then close out Chapter 4 before moving into system architecture, database architecture, API architecture and Flutter architecture.
