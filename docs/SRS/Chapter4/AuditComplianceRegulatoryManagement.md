PigPower SmartFarm Platform
Software Requirements Specification — Functional Requirements
Module: Audit, Compliance & Regulatory Management

Document ID: PSP-SRS-FR-ACRM
Version: 1.0
Status: Draft
Parent Document: PigPower SmartFarm Platform SRS
Chapter: 4 – Functional Requirements
Project: PigPower Lesotho – Community-Based Circular Pork Economy Platform

## 1. Module Overview

The Audit, Compliance & Regulatory Management Module (ACRM) will consolidate, into a single formal specification, the audit logging standards, regulatory compliance tracking, internal control principles and grant/funder compliance obligations that earlier modules have referenced but not yet defined centrally.

Nearly every module specified so far has included its own local audit trail:

```
CRM               → customer/lead/opportunity audit trail
Farmer Payments   → settlement audit trail
Document Mgmt     → document access/version audit trail
Notifications     → communication audit trail
SACM              → configuration change audit trail
```

ACRM does not replace these module-level audit trails. Instead, it defines the **platform-wide standard** they must all follow, and adds the compliance, regulatory and internal-control capability that sits above individual modules.

## 2. Business Purpose

PigPower will be accountable to multiple stakeholders with different assurance needs:

```
BEDCO              → grant compliance and reporting integrity
Investors           → financial and operational integrity
Farmers             → fair, transparent treatment
Government agencies → food safety, environmental, tax, labour compliance
Customers           → product safety and traceability
Employees           → fair labour practice
```

A platform that cannot demonstrate **who did what, when, and under what authority** — and that cannot demonstrate compliance with applicable Lesotho law and BEDCO funding conditions — will struggle to pass institutional due diligence, however good its farming and processing operations are.

ACRM exists to make PigPower **audit-ready and compliance-ready by design**, rather than needing to reconstruct evidence after the fact.

## 3. Strategic Objectives

The module shall enable PigPower to:

1. Define a consistent, platform-wide audit logging standard.
2. Consolidate audit evidence across all modules for review.
3. Track regulatory compliance obligations and their status.
4. Track compliance certificates, licences and permits.
5. Support food-safety and biosecurity compliance evidence.
6. Support environmental compliance evidence.
7. Support tax and statutory compliance evidence.
8. Support labour law and HR compliance evidence.
9. Support data protection and privacy compliance.
10. Support BEDCO grant compliance and reporting integrity.
11. Support segregation-of-duties and internal control principles.
12. Support internal and external audit engagements.
13. Detect and flag potential control breaches.
14. Provide a defensible, exportable compliance record for due diligence.
15. Reduce PigPower's regulatory and reputational risk as it scales.

## 4. Relationship to Other Modules

ACRM sits above the operational modules as a governance layer, not a transactional one.

```
                    OPERATIONAL MODULES
   (Farmer, Production, Veterinary, Processing, Finance,
    HR, Procurement, CRM, Documents, Notifications, SACM)
                            │
                    generate audit events
                            │
                            ▼
                  AUDIT & COMPLIANCE LAYER
                            │
        ┌───────────────────┼───────────────────┐
        ▼                   ▼                   ▼
  AUDIT LOG            COMPLIANCE           INTERNAL CONTROL
  CONSOLIDATION         TRACKING             MONITORING
        │                   │                   │
        └───────────────────┼───────────────────┘
                            ▼
                 COMPLIANCE & AUDIT REPORTS
                            │
                            ▼
            BEDCO / INVESTORS / REGULATORS / AUDITORS
```

**BR-ACRM-001** — ACRM shall consume audit events emitted by operational modules; it shall not become an alternative place where those modules record their primary transactional data.

## 5. Platform-Wide Audit Logging Standard

### FR-ACRM-001 — Minimum Audit Event Content

Every auditable event across the platform shall record, at minimum:

```
event_id
event_type
module
entity_type
entity_id
action              (CREATE / UPDATE / DELETE / APPROVE / REJECT / VIEW / EXPORT / LOGIN / etc.)
performed_by        (user_id)
performed_by_role
timestamp
previous_value       (where applicable)
new_value             (where applicable)
reason                (where captured)
source                (web / mobile / API / system)
ip_address / device_id (where available)
```

### FR-ACRM-002 — Auditable Event Categories

At minimum, the following categories of event shall be audited across all modules:

```
Authentication          login, logout, failed login, password change, MFA change
Authorization            permission change, role change, access denial
Master/Reference Data    creation, modification, deactivation
Transactional Data       creation, modification, cancellation, deletion attempt
Financial Transactions   payment, settlement, invoice, journal entry
Approvals                approval, rejection, escalation
Document Activity        upload, view, download, share, delete
Configuration Changes    any SACM configuration change
Data Export               report export, bulk export, data-room access
Sensitive Data Access     veterinary records, HR records, financial records, farmer ID documents
```

### FR-ACRM-003 — Immutable Audit Records

Audit log entries shall not be editable or deletable by any user, including administrators, through normal application functions. Correction of an erroneous business record shall be represented as a new event (e.g. a reversing entry), never as an edit to the original audit record.

### FR-ACRM-004 — Audit Log Retention

Audit log retention periods shall be configurable per event category (via SACM), with a sensible default minimum retention period (e.g. 7 years for financial and farmer-payment events, consistent with typical statutory record-keeping expectations) pending confirmation against applicable Lesotho requirements.

### FR-ACRM-005 — Centralized Audit Log Viewer

The system shall provide authorized users with a consolidated audit log viewer that can filter across modules by user, entity, date range, event type and module, rather than requiring reviewers to inspect each module separately.

## 6. Regulatory Compliance Domains

PigPower's operations span several distinct regulatory domains. The system shall track compliance obligations within each.

### 6.1 Food Safety & Animal Health

```
Abattoir/processing registration and licensing
Meat inspection requirements
HACCP-aligned process compliance
Biosecurity protocol compliance
Disease notification obligations (e.g. African Swine Fever)
Veterinary certification requirements
Cold-chain compliance
```

### 6.2 Environmental Compliance

```
Environmental Impact Assessment requirements for processing/biodigester facilities
Waste management compliance
Water use/discharge compliance
Biodigester operating compliance
```

### 6.3 Tax & Statutory Compliance

```
Business registration
VAT/tax registration and filing
PAYE and statutory payroll deductions
Statutory returns and filing deadlines
```

### 6.4 Labour Law Compliance

```
Employment contracts
Minimum wage compliance
Working hours and leave entitlements
Occupational health and safety
Youth employment considerations relevant to BEDCO's mandate
```

### 6.5 Data Protection & Privacy

```
Farmer personal data handling
Customer personal data handling
Employee personal data handling
Marketing consent (as defined in CRM)
Data access and sharing controls
```

### 6.6 Grant & Funder Compliance

```
BEDCO Bacha Entrepreneurship Project funding conditions
Use-of-funds compliance against the approved budget
Milestone/reporting obligations
Any future development-partner or investor covenants
```

### FR-ACRM-006 — Compliance Domain Configuration

The system shall allow administrators (via SACM) to configure the list of applicable regulatory domains and specific obligations within each, so the compliance register can be adapted as PigPower's regulatory footprint changes (e.g. when it moves from toll-processing to an owned, licensed facility).

## 7. Compliance Obligation Register

### FR-ACRM-007 — Compliance Obligation Record

The system shall maintain a register of compliance obligations, each with:

```
Obligation ID
Domain               (Food Safety / Environmental / Tax / Labour / Data Protection / Grant)
Description
Regulatory Authority
Applicable Legislation/Standard (where known)
Frequency             (one-time / annual / quarterly / continuous)
Responsible Owner
Due Date / Next Due Date
Status                (COMPLIANT / DUE / OVERDUE / NON_COMPLIANT / NOT_APPLICABLE)
Supporting Evidence   (linked documents via DFM)
Last Reviewed Date
```

Example:

```
OBLIGATION: Abattoir Partner Registration Verification
DOMAIN: Food Safety
AUTHORITY: Ministry of Agriculture and Food Security
FREQUENCY: Annual
OWNER: Operations Manager
NEXT DUE: 15 Mar 2027
STATUS: COMPLIANT
EVIDENCE: Toll-Processing Partner Registration Certificate (DFM link)
```

### FR-ACRM-008 — Compliance Status Dashboard

The system shall provide a compliance dashboard summarizing obligation status by domain, for example:

```
COMPLIANCE STATUS
Food Safety          8/8   COMPLIANT
Environmental         3/4   1 DUE
Tax & Statutory        5/5   COMPLIANT
Labour                 6/6   COMPLIANT
Data Protection        4/4   COMPLIANT
Grant (BEDCO)           3/3   COMPLIANT
```

## 8. Certificate & Licence Compliance

### FR-ACRM-009 — Certificate/Licence Tracking

The system shall track certificates, licences and permits required for operation, integrating with the expiry-tracking capability already defined in the Document & File Management module (Section 30–31 of DFM).

```
Certificate/Licence
      ↓
Linked Document (DFM)
      ↓
Expiry Date
      ↓
Renewal Reminder (via Notification module)
      ↓
Renewal Status
```

Example:

```
LICENCE: Toll-Processing Partner Food Handling Certificate
EXPIRES: 30 Nov 2026
REMINDER: 60 / 30 / 7 days before expiry
STATUS: VALID
```

### FR-ACRM-010 — Farmer & Employee Compliance Documentation

The system shall support tracking of farmer-level and employee-level compliance documentation status (e.g. signed farmer agreement, biosecurity training completion, employment contract on file), consistent with the "documentation complete" concept introduced in DFM Section 63.

## 9. Internal Control & Segregation of Duties

### FR-ACRM-011 — Segregation of Duties Configuration

The system shall allow administrators to define segregation-of-duties rules that prevent a single user from performing conflicting actions on the same transaction, for example:

```
RULE: The user who creates a supplier payment request
      shall not be the same user who approves it.

RULE: The user who records a farmer settlement
      shall not be the same user who processes the payment.

RULE: The user who creates a new supplier
      shall not be the same user who approves that supplier's first purchase order.
```

### FR-ACRM-012 — Segregation of Duties Enforcement

Where configured, the system shall prevent (or flag for review) an action that would violate a defined segregation-of-duties rule.

### FR-ACRM-013 — Control Exception Log

Where a segregation-of-duties conflict is unavoidable (e.g. small pilot-phase team), the system shall allow a documented, approved exception rather than silently permitting the conflict.

Example:

```
CONTROL EXCEPTION
Rule: Settlement creator ≠ Settlement approver
Reason: Pilot-phase team has only one finance officer
Compensating Control: Monthly settlement batch reviewed by Operations Manager
Approved By: CEO
Review Date: Quarterly
```

### FR-ACRM-014 — High-Risk Transaction Flagging

The system shall flag transactions meeting configurable high-risk criteria for review, for example:

```
Payment above threshold value
New supplier's first payment
Round-number payment amounts
Payment to a newly added bank account
Weekend/after-hours approval
Repeated reversed transactions
```

## 10. Internal & External Audit Support

### FR-ACRM-015 — Audit Engagement Workspace

The system shall support the creation of an audit engagement record to organize evidence requested by an internal or external auditor.

```
AUDIT ENGAGEMENT
Type: External Financial Audit / BEDCO Compliance Review / Internal Audit
Period: FY2026
Auditor: [Name/Firm]
Status: IN_PROGRESS
Requested Items: [linked list]
Responses: [linked documents via DFM]
```

### FR-ACRM-016 — Evidence Request Tracking

The system shall allow an audit engagement to track individual evidence requests, their status, and the linked supporting document(s), avoiding the ad-hoc email-based evidence gathering that is common in early-stage organizations.

```
REQUEST: Farmer settlement records, Jan–Jun 2026
STATUS: PROVIDED
LINKED EVIDENCE: 6 monthly settlement batch reports (DFM)
```

### FR-ACRM-017 — Read-Only Auditor Access

The system shall support a restricted, time-limited, read-only access profile for external auditors and BEDCO reviewers, scoped to only the records and documents relevant to their engagement, consistent with the external document-sharing controls defined in DFM Section 39.

## 11. BEDCO & Grant-Specific Compliance

### FR-ACRM-018 — Grant Condition Register

The system shall maintain a register of the specific conditions attached to the BEDCO Bacha Entrepreneurship Project funding (and any future grants), each trackable to compliance status.

Example:

```
GRANT: BEDCO Bacha Entrepreneurship Project 2026
CONDITION: Funds to be used per approved M250,000 use-of-funds budget
STATUS: COMPLIANT
CONDITION: Quarterly progress reporting
NEXT DUE: 30 Sep 2026
STATUS: DUE
CONDITION: Minimum 60% youth employment among direct jobs
CURRENT: 67%
STATUS: COMPLIANT
```

### FR-ACRM-019 — Use-of-Funds Compliance Tracking

The system shall allow actual expenditure (sourced from Finance & Accounting) to be tracked against the approved use-of-funds budget line items defined in the funding proposal, and shall flag material variances for management attention.

Example:

```
BUDGET LINE: Toll-processing fees & equipment
APPROVED: M55,000
SPENT TO DATE: M58,200
VARIANCE: +5.8%
STATUS: FLAGGED FOR REVIEW
```

### FR-ACRM-020 — Milestone Compliance Tracking

The system shall track delivery against the milestones defined in the project's implementation timeline (Section 11 of the BEDCO proposal), distinguishing planned vs. actual dates.

## 12. Data Protection & Privacy Compliance

### FR-ACRM-021 — Data Subject Registry

The system shall be able to identify all personal data held about a given individual (farmer, employee, customer, contact) across modules, to support data-subject access or correction requests.

### FR-ACRM-022 — Consent Compliance Monitoring

The system shall monitor and report on marketing/communication consent status recorded in CRM (Section 43 of the CRM module), and shall prevent marketing communications from being sent to individuals without recorded consent, where technically enforceable.

### FR-ACRM-023 — Sensitive Data Access Reporting

The system shall be able to report who has accessed sensitive personal data categories (veterinary records containing farmer information, HR records, financial/credit information) over a given period, for privacy compliance review.

## 13. Compliance Alerts & Escalation

### FR-ACRM-024 — Compliance Alerting

The system shall generate alerts, via the Notification & Communication Management module, for:

```
Obligation approaching due date
Obligation overdue
Certificate/licence approaching expiry
Certificate/licence expired
Use-of-funds variance beyond threshold
Segregation-of-duties exception created
High-risk transaction flagged
```

### FR-ACRM-025 — Compliance Escalation

Unresolved overdue compliance obligations shall escalate according to a configurable escalation chain (consistent with the escalation pattern defined in the Notification module), for example:

```
Obligation Overdue
      ↓
Responsible Owner notified
      ↓
7 days unresolved
      ↓
Operations Manager notified
      ↓
14 days unresolved
      ↓
CEO notified
```

## 14. Compliance & Audit Reporting

### FR-ACRM-026 — Standard Compliance Reports

The system shall support standard reports, including:

```
Compliance Status Summary (by domain)
Certificate/Licence Expiry Report
Overdue Obligations Report
Segregation-of-Duties Exception Report
High-Risk Transaction Report
BEDCO Grant Compliance Report
Use-of-Funds Variance Report
Audit Trail Extract (by module, user, entity or date range)
```

### FR-ACRM-027 — Board/Investor Compliance Summary

The system shall support a summarized compliance report suitable for board, investor or BEDCO review, distinguishing:

```
Fully Compliant
Compliant with Minor Exceptions
Non-Compliant (with remediation plan)
```

### FR-ACRM-028 — Report Evidentiary Integrity

Consistent with the report versioning and data-snapshotting principles defined in the Reporting & BI module (RBIM Sections 50–51), compliance and audit reports shall preserve the data snapshot used to generate them, so a historical compliance report remains reproducible even if underlying records later change.

## 15. Functional Requirements Summary

| ID | Requirement |
|---|---|
| ACRM-FR-001 | The system shall record a standardized minimum audit event structure across all modules. |
| ACRM-FR-002 | The system shall audit the defined categories of platform activity. |
| ACRM-FR-003 | Audit records shall be immutable through normal application functions. |
| ACRM-FR-004 | Audit log retention shall be configurable per event category. |
| ACRM-FR-005 | The system shall provide a consolidated, filterable audit log viewer. |
| ACRM-FR-006 | The system shall allow configuration of applicable regulatory compliance domains. |
| ACRM-FR-007 | The system shall maintain a compliance obligation register. |
| ACRM-FR-008 | The system shall provide a compliance status dashboard. |
| ACRM-FR-009 | The system shall track certificates and licences with expiry integration. |
| ACRM-FR-010 | The system shall track farmer/employee compliance documentation status. |
| ACRM-FR-011 | The system shall support configurable segregation-of-duties rules. |
| ACRM-FR-012 | The system shall enforce or flag segregation-of-duties violations. |
| ACRM-FR-013 | The system shall support documented control exceptions. |
| ACRM-FR-014 | The system shall flag high-risk transactions by configurable criteria. |
| ACRM-FR-015 | The system shall support audit engagement workspaces. |
| ACRM-FR-016 | The system shall track individual audit evidence requests. |
| ACRM-FR-017 | The system shall support restricted, time-limited external auditor access. |
| ACRM-FR-018 | The system shall maintain a grant condition register. |
| ACRM-FR-019 | The system shall track use-of-funds compliance against approved budgets. |
| ACRM-FR-020 | The system shall track milestone delivery against the implementation timeline. |
| ACRM-FR-021 | The system shall support identification of an individual's personal data across modules. |
| ACRM-FR-022 | The system shall monitor and enforce marketing consent compliance. |
| ACRM-FR-023 | The system shall report on sensitive personal data access. |
| ACRM-FR-024 | The system shall generate compliance alerts. |
| ACRM-FR-025 | The system shall support configurable compliance escalation. |
| ACRM-FR-026 | The system shall provide standard compliance and audit reports. |
| ACRM-FR-027 | The system shall provide a summarized compliance report for external stakeholders. |
| ACRM-FR-028 | Compliance/audit reports shall preserve their underlying data snapshot. |

## 16. Non-Functional Requirements

**Integrity** — Audit and compliance records must be tamper-evident; any attempted unauthorized modification must itself be logged.

**Completeness** — Every module in the platform must emit audit events per the platform-wide standard; ACRM should provide a shared library/service so modules do not each reimplement audit logging inconsistently.

**Availability** — Audit and compliance data must remain accessible even if the originating operational record is later archived or deleted (subject to retention policy).

**Performance** — Audit logging must not materially degrade the performance of the transaction it accompanies; writes should be asynchronous where safe to do so.

**Security** — Access to the audit log and compliance register must itself be role-restricted and logged.

**Regulatory accuracy** — Compliance domain content (applicable legislation, filing frequencies) must be periodically reviewed with qualified local legal/accounting/regulatory advisors, since this specification defines the *system capability* to track compliance, not the specific legal content of Lesotho's regulatory requirements.

**Usability** — Compliance dashboards must be understandable to non-specialist management, not only to auditors.

## 17. Example End-to-End Scenario — BEDCO Quarterly Compliance Review

```
Step 1
BEDCO requests a quarterly compliance update per the grant agreement.

Step 2
Operations Manager opens ACRM → Grant Condition Register (BEDCO 2026).

Step 3
System shows:
   Use-of-Funds: within approved budget (1 flagged variance, explained)
   Milestones: 3 of 4 Q1 milestones completed on schedule
   Youth Employment: 67% (condition: ≥60%) — COMPLIANT
   Reporting: Q1 report submitted on time

Step 4
Operations Manager generates the BEDCO Grant Compliance Report (Section 14),
which pulls the underlying data snapshot for the quarter.

Step 5
Report is routed through the standard document approval workflow (via SACM's
generic workflow engine) before external distribution.

Step 6
Approved report is shared with BEDCO through a controlled, expiring external
link (per DFM Section 39), with access logged in the Audit Log.
```

## 18. Example End-to-End Scenario — Segregation-of-Duties Exception

```
Step 1
Pilot-phase PigPower has only one Finance Officer.

Step 2
That officer both records and would normally need to approve a farmer
settlement batch — violating the configured segregation-of-duties rule.

Step 3
System blocks self-approval and requires an alternative approver.

Step 4
Operations Manager is assigned as compensating approver for this batch.

Step 5
A Control Exception record is logged, referencing the compensating control
(monthly review) and requiring periodic re-approval by the CEO.

Step 6
When a second Finance Officer is hired in Year 2, the exception is retired
and normal segregation of duties resumes — visible in the audit trail.
```

## 19. Recommended GitHub File

Create:

```
docs/SRS/Chapter4/AuditComplianceRegulatoryManagement.md
```

Then commit it:

```
git add docs/SRS/Chapter4/AuditComplianceRegulatoryManagement.md
git commit -m "docs: add audit, compliance and regulatory management requirements"
git push
```

## 20. Where We Are Now

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
System Administration & Configuration
Audit, Compliance & Regulatory Management   ← this document
```

The remaining modules to close out Chapter 4 are:

```
Offline Synchronization & Data Synchronization Management
Integration & API Management
```

## 21. Next Module

I recommend **Offline Synchronization & Data Synchronization Management** next. It has been referenced repeatedly — farmer production capture (Production Management), field-captured documents (DFM Sections 50–52), notification queuing while offline (NCM Sections 32–33), and mobile sync configuration (SACM Section 24) all assume an offline-first architecture without yet defining, in one place:

- the conflict-resolution strategy when the same record is edited both offline and on the server before sync;
- the sync protocol and payload structure between the Flutter app and backend;
- what data each user role should pre-cache locally, and how much (storage-constrained rural devices cannot cache everything);
- how partial connectivity (slow 2G/3G, intermittent signal) should be handled, not just fully-offline vs. fully-online;
- how sync failures are surfaced to the field user without blocking their work.

Given that PigPower's entire operating premise is a distributed rural farmer network, this module is arguably as strategically important as Notification & Communication was — and should be specified carefully before we move into the Flutter application architecture itself, since the local data model on the device needs to be designed around it from day one rather than retrofitted later.
