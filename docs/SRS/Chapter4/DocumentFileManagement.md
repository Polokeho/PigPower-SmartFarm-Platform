PigPower SmartFarm Platform
Software Requirements Specification — Functional Requirements
Module: Document & File Management

Document ID: PSP-SRS-FR-DFM
Version: 1.0
Status: Draft
Parent Document: PigPower SmartFarm Platform SRS
Chapter: 4 – Functional Requirements
Project: PigPower Lesotho – Community-Based Circular Pork Economy Platform

1. Module Overview

The Document & File Management Module (DFM) will provide a centralized mechanism for creating, uploading, storing, organizing, retrieving, sharing, versioning and controlling documents and files generated throughout the PigPower ecosystem.

PigPower will operate across multiple farms, farmers, employees, veterinarians, suppliers, customers, processing operations, logistics activities and financial transactions. Consequently, important business information will exist in many different forms:

Farmer identification documents
Farmer agreements
Farm registration documents
Pig purchase records
Veterinary certificates
Vaccination records
Feed invoices
Supplier contracts
Purchase orders
Sales invoices
Customer contracts
Processing records
Meat inspection documentation
Delivery documents
Payment statements
Employee documents
Training certificates
Equipment manuals
Biodigester records
Environmental documentation
Grant reports
Investor reports
Compliance certificates
Photographs
Scanned documents
PDFs
Spreadsheets
Images

The module will ensure that these documents are associated with the appropriate business entities and remain accessible, secure, traceable and auditable.

2. Business Purpose

The objective is to move PigPower from:

Paper-based and fragmented document storage

towards:

Centralized, searchable and controlled digital document management.

The system should allow a user to move from a business record directly to its supporting documents.

For example:

Farmer
  ↓
Farmer Agreement
  ↓
Identification Documents
  ↓
Training Certificates
  ↓
Farm Records
  ↓
Veterinary Records
  ↓
Payment Statements

Similarly:

Purchase Order
      ↓
Supplier
      ↓
Delivery Note
      ↓
Invoice
      ↓
Payment

This creates a complete digital audit trail.

3. Strategic Objectives

The module shall enable PigPower to:

Centralize business documents.
Reduce dependence on paper records.
Associate documents with business entities.
Improve document retrieval.
Protect sensitive documents.
Maintain document versions.
Maintain document history.
Support document approval workflows.
Support electronic signatures where required.
Support document expiry tracking.
Support compliance documentation.
Support grant reporting.
Support investor due diligence.
Support farmer documentation.
Support veterinary documentation.
Support supplier documentation.
Support customer documentation.
Support employee documentation.
Support operational documentation.
Provide an auditable document trail.
4. Document Management Architecture

The conceptual architecture should be:

                  PIGPOWER PLATFORM
                         │
                         ▼
                 BUSINESS ENTITY
                         │
                         ▼
                DOCUMENT SERVICE
                         │
             ┌───────────┼───────────┐
             ▼           ▼           ▼
          Metadata     Storage     Access
             │           │           │
             └───────────┼───────────┘
                         ▼
                 Document Repository
                         │
                  ┌──────┼──────┐
                  ▼      ▼      ▼
               Search  Version  Audit
5. Document Types

The system should support multiple document categories.

5.1 Farmer Documents

Examples:

National identification
Farmer registration
Farmer agreement
Bank/payment information documentation
Training certificates
Compliance certificates
Farm ownership/lease documentation
5.2 Farm Documents

Examples:

Farm registration
Farm assessment
Pigsty inspection
Biosecurity assessment
Farm photographs
Infrastructure documentation
Equipment records
5.3 Pig & Livestock Documents

Examples:

Pig purchase records
Breeding records
Health certificates
Movement documentation
Veterinary certificates
Quarantine records
6. Veterinary Documents

The system should support:

Vaccination certificates
Veterinary reports
Treatment records
Laboratory results
Disease investigation reports
Veterinary prescriptions where applicable
Health certificates
Biosecurity inspection reports

Veterinary documents may contain sensitive information and should be access-controlled.

7. Feed & Procurement Documents

Examples:

Supplier quotations
Purchase orders
Delivery notes
Feed invoices
Supplier contracts
Certificates of analysis
Quality certificates
8. Logistics Documents

Examples:

Collection manifests
Delivery notes
Vehicle inspection documents
Driver documentation
Route records
Proof of delivery
Cold-chain records
9. Processing Documents

Processing documentation may include:

Processing batch records
Slaughter documentation
Meat inspection records
Quality-control reports
Food-safety documentation
Product specifications
Production reports
Waste-management records
10. Sales & Customer Documents

Examples:

Customer agreements
Quotations
Sales orders
Invoices
Delivery notes
Statements
Product specifications
Complaints
Credit documentation
11. Financial Documents

The module should support storage and association of:

Invoices
Receipts
Payment confirmations
Farmer settlement statements
Bank documents
Tax documents
Financial reports
Supporting expense documents

The actual financial transaction remains authoritative in the Finance & Accounting module.

The document module stores the supporting evidence.

12. HR Documents

Examples:

Employment contracts
Identification documents
CVs
Qualifications
Training certificates
Leave documentation
Performance documentation
Payroll supporting documents

Access must be strictly restricted.

13. Renewable Energy Documents

Examples:

Solar installation documentation
Equipment specifications
Biodigester specifications
Installation reports
Maintenance records
Energy audits
Environmental reports
Equipment warranties
14. Grant & Investor Documents

This is strategically important for PigPower.

The repository should support:

BEDCO application documents
Grant agreements
Progress reports
Financial reports
Investor reports
Pitch decks
Business plans
Due-diligence documents
Funding utilization reports
Monitoring and evaluation evidence

This will allow PigPower to maintain a structured digital data room.

15. Document Categories

Documents should be classified using categories.

Example:

FARMER
FARM
PIG
VETERINARY
FEED
LOGISTICS
PROCESSING
INVENTORY
SALES
CUSTOMER
FINANCE
PROCUREMENT
HR
ENERGY
M&E
GRANT
INVESTOR
LEGAL
COMPLIANCE
16. Document Metadata

Each uploaded document should have metadata.

Minimum metadata:

document_id
document_number
document_type
file_name
file_extension
file_size
mime_type
description
category
owner
uploaded_by
uploaded_at
created_date
expiry_date
status
version
related_entity_type
related_entity_id

Additional metadata may be introduced later.

17. Entity Association

Documents should be associated with business entities.

Example:

Document
   │
   ├── Farmer
   ├── Farm
   ├── Pig
   ├── Production Batch
   ├── Veterinary Event
   ├── Purchase Order
   ├── Sales Order
   ├── Invoice
   └── Employee

This enables contextual document retrieval.

18. Example: Farmer Document Repository

A farmer profile could contain:

FARMER: FMR-000123

Documents
│
├── ID Document
├── Farmer Agreement
├── Farm Assessment
├── Training Certificate
├── Veterinary Compliance
├── Payment Statements
└── Other Supporting Documents

The farmer should only see documents they are authorized to access.

19. File Upload

Authorized users shall be able to upload files.

The upload interface should capture:

Document type
Description
Related entity
Document date
Expiry date
Confidentiality level
File

The system should validate the file before storage.

20. Supported File Types

The initial platform should support common business formats.

Documents
PDF
DOCX
DOC
TXT
Spreadsheets
XLSX
XLS
CSV
Images
JPG
JPEG
PNG
WEBP

Additional formats may be introduced later.

21. File Size Limits

The system should enforce configurable file-size limits.

For example:

Standard document: 10 MB
Large document: 25 MB
Photograph: 10 MB
Report: 25 MB

These values should remain configurable because storage economics will depend on the final infrastructure.

22. Document Validation

Before accepting an upload, the system should validate:

File type
MIME type
Extension
File size
File integrity
User permissions
Storage availability

Where appropriate, uploaded files should also undergo malware/security scanning.

23. Document Naming

The system should support standardized document names.

Example:

FMR-000123_FarmerAgreement_2026_v1.pdf

However, the system should not depend exclusively on filenames for identification.

The database metadata remains authoritative.

24. Document Versioning

The system shall support document versions.

Example:

Farmer Agreement

Version 1.0
     ↓
Version 1.1
     ↓
Version 2.0

Each version should maintain:

Version number
Uploaded by
Upload date
Change description
File reference
Approval status
25. Version History

Authorized users should be able to view previous versions.

Example:

Agreement

v3 — Current
v2
v1

The system should not overwrite historical versions.

26. Document Status

Documents should support statuses such as:

DRAFT
PENDING_REVIEW
APPROVED
REJECTED
EXPIRED
ARCHIVED
REVOKED

The applicable statuses should depend on document type.

27. Document Approval

Certain documents should support approval workflows.

Examples:

Farmer agreements
Supplier contracts
Customer contracts
Purchase orders
Financial documents
Compliance documents

Example:

Uploaded
   ↓
Pending Review
   ↓
Reviewed
   ↓
Approved
28. Rejection Workflow

If a document is rejected:

Pending Review
       ↓
Rejected
       ↓
Reason Recorded
       ↓
Uploader Notified
       ↓
Corrected Version Uploaded

The rejection reason must be retained.

29. Electronic Signatures

The architecture should allow future integration with electronic-signature services.

Potential workflow:

Contract
   ↓
Approval
   ↓
Signature Request
   ↓
Farmer Signs
   ↓
Company Signs
   ↓
Signed Document

The first version of the system may simply store manually signed documents.

30. Document Expiry Management

Some documents have expiry dates.

Examples:

Certificates
Licences
Permits
Contracts
Insurance
Employee certificates
Vehicle documentation
Veterinary certifications

The system should track expiry dates.

31. Expiry Notifications

Example:

Certificate expires:
30 days
     ↓
Reminder

14 days
     ↓
Reminder

7 days
     ↓
High-priority alert

Expired
     ↓
Escalation

Notification thresholds should be configurable.

32. Document Search

Authorized users should be able to search documents using:

Document ID
File name
Document type
Category
Entity
Farmer
Farm
Date
Expiry date
Status
Uploaded by
Tags
33. Full-Text Search

The architecture should allow future implementation of OCR and full-text search.

For example, a scanned PDF containing:

"Farmer Agreement — Leribe"

could eventually be searchable using those words.

This should be considered a future enhancement, not a mandatory first release.

34. Document Tags

Users with appropriate permissions should be able to assign tags.

Example:

#farmer
#contract
#2026
#leribe
#compliance

Tags can improve document discovery.

35. Document Preview

The application should support previewing common file types where technically practical.

For example:

PDF preview
Image preview

For unsupported formats, the system should offer secure download/open functionality.

36. Secure Download

Downloads should require appropriate authorization.

The backend should verify permissions before providing access to the file.

The application should never rely solely on hiding a download button.

37. Temporary File Access

Where object storage is used, files should preferably be accessed through controlled, time-limited URLs rather than exposing permanent public URLs.

Conceptually:

User
 ↓
Backend authorization
 ↓
Temporary file URL
 ↓
File storage

This is important for confidential documents.

38. Document Sharing

Authorized users should be able to share documents internally.

Example:

Veterinary Report
      ↓
Share with
Farm Manager
Veterinary Manager
Operations Manager

Sharing must respect access permissions.

39. External Sharing

External sharing should be more restrictive.

For example, management may share an investor report through a controlled link.

The link should support:

Expiration
Password/protection where appropriate
Access logging
Revocation
40. Digital Data Room

PigPower should eventually have a dedicated Investor & Grant Data Room.

Example:

DATA ROOM
│
├── Corporate
├── Legal
├── Financial
├── Operations
├── Farmers
├── Processing
├── Technology
├── Environmental
├── Impact
└── Funding

This will significantly improve investor due diligence.

41. Document Access Levels

The system should support confidentiality levels.

Example:

PUBLIC
INTERNAL
CONFIDENTIAL
RESTRICTED
Public

Can be accessed by approved external audiences.

Internal

Employees and authorized users.

Confidential

Restricted departments.

Restricted

Highly sensitive information.

42. Role-Based Document Access

Access should be based on:

User
+
Role
+
Department
+
Entity
+
Document Classification

For example, an ordinary field officer should not be able to access employee payroll documents.

43. Farmer Data Isolation

A farmer should normally be able to access only documents associated with:

their account;
their farm;
their production activities;
their payments;
documents explicitly shared with them.
44. Audit Trail

The system shall record:

Upload
View
Download
Share
Edit metadata
Version creation
Approval
Rejection
Archive
Restore
Delete attempt

Example:

Document: FMR-000123-AGR-01

08:42 — Uploaded by User A
09:15 — Viewed by Manager B
10:05 — Approved by Manager B
14:30 — Downloaded by Finance C
45. Soft Deletion

Documents should normally not be permanently deleted immediately.

Instead:

Active
 ↓
Archived / Deleted
 ↓
Retention Period
 ↓
Permanent Deletion

Permanent deletion should require appropriate authorization.

46. Document Retention

Different document categories may have different retention requirements.

The system should therefore support configurable retention policies.

Example:

Document Type
     ↓
Retention Policy
     ↓
Retention Period
     ↓
Archive
     ↓
Eligible for Destruction

Actual legal retention periods should be configured according to applicable Lesotho regulatory requirements and PigPower's legal/accounting policies.

47. Document Storage Architecture

The application should separate:

Metadata

Stored in the relational database.

Actual file

Stored in a file/object storage system.

Conceptually:

Relational Database
       │
       │ metadata
       ▼
Document Record
       │
       │ storage reference
       ▼
File/Object Storage
       │
       ▼
Actual File

This is an important architectural decision for the database design we will eventually make.

48. Why Not Store Files Directly in the Database?

For the PigPower platform, large binary files should generally not be stored directly inside ordinary database tables.

Instead:

Database
→ Document metadata

Object/File Storage
→ Actual PDF/image/document

This generally provides better:

performance;
backup management;
scalability;
storage management;
cost control.

The database stores the reference, not necessarily the entire file.

49. Cost-Effective Storage Strategy

Since you previously specified that you want to avoid unnecessary monthly database subscriptions, this module should be designed around a cost-conscious storage architecture.

The application should keep the storage layer abstract:

Document Service
       │
       ▼
Storage Interface
       │
 ┌─────┼────────┐
 ▼     ▼        ▼
Local  S3      Other
Storage Compatible

This allows PigPower to begin with a low-cost/self-hosted solution and migrate later without redesigning the entire application.

The exact database and file-storage technology should be selected in the Database Architecture chapter, after we compare the available options.

50. Offline Document Capture

Field users may need to capture documents where internet access is unavailable.

Example:

Farmer
 ↓
Photograph ID
 ↓
No Internet
 ↓
Store locally
 ↓
Upload queue
 ↓
Internet restored
 ↓
Synchronize

This is particularly useful for:

farmer onboarding;
farm inspections;
veterinary visits;
delivery documentation;
proof of delivery.
51. Offline Upload Queue

The mobile application should maintain:

Pending Uploads
      │
      ├── ID.jpg
      ├── FarmAssessment.pdf
      └── VeterinaryCertificate.jpg

Each item should have:

local ID;
upload status;
retry count;
creation date;
error message where applicable.
52. Synchronization

The document synchronization process should support:

LOCAL
  ↓
PENDING
  ↓
UPLOADING
  ↓
UPLOADED
  ↓
SERVER CONFIRMED

If upload fails:

FAILED
  ↓
RETRY
53. Duplicate Detection

The system should attempt to detect accidental duplicate uploads.

Possible techniques include:

file hash;
file size;
filename;
related entity;
document type.

A cryptographic hash such as SHA-256 may be used to identify identical files.

54. Document Integrity

The system should maintain a file checksum/hash where appropriate.

Example:

Document
 ↓
SHA-256 Hash
 ↓
Storage

When retrieving the file, the system can verify integrity.

55. Image Compression

Because field users may upload photographs from mobile devices, the application should support configurable image compression before upload.

Example:

Camera Image
   ↓
Resize / Compress
   ↓
Preview
   ↓
Upload

This reduces:

mobile data usage;
upload time;
storage requirements.

Original-quality images should only be retained when operationally necessary.

56. Document Security

The system should protect documents against unauthorized access.

Controls should include:

authentication;
authorization;
encrypted transmission;
secure storage;
access logging;
temporary access URLs;
permission checks.
57. Backup & Recovery

The document repository should be included in the overall backup strategy.

Backups should cover:

Database
+
Document Metadata
+
File Storage
+
Configuration

A backup must preserve the relationship between the document metadata and the physical file.

58. Disaster Recovery

The architecture should support restoration following:

server failure;
storage failure;
accidental deletion;
corruption;
cyber incident.

The system should eventually define:

Recovery Point Objective (RPO)
Recovery Time Objective (RTO)

These values will be established during infrastructure architecture design.

59. Integration With Notification Module

The two modules should work together.

Example:

Document expires
      ↓
Document Module
      ↓
Expiry Event
      ↓
Notification Module
      ↓
User receives reminder

The Document module should therefore generate events rather than directly implementing SMS/email logic.

60. Integration With BI Module

Document analytics can provide:

Number of expired certificates
Pending approvals
Missing farmer documents
Compliance status
Document upload rates
Outstanding documentation

Example:

Registered Farmers: 250

Complete Documentation: 218
Incomplete: 32

Compliance Rate: 87.2%
61. Functional Requirements
DFM-FR-001 — Document Upload

The system shall allow authorized users to upload documents.

DFM-FR-002 — File Validation

The system shall validate file type, size and integrity before accepting uploads.

DFM-FR-003 — Document Metadata

The system shall maintain metadata for uploaded documents.

DFM-FR-004 — Entity Association

The system shall associate documents with relevant business entities.

DFM-FR-005 — Document Categorization

The system shall support document categories and types.

DFM-FR-006 — Document Search

The system shall allow authorized users to search documents.

DFM-FR-007 — Document Preview

The system shall support preview of supported file types.

DFM-FR-008 — Secure Download

The system shall provide authorized users with secure document access.

DFM-FR-009 — Document Versioning

The system shall maintain document versions.

DFM-FR-010 — Version History

The system shall preserve historical document versions.

DFM-FR-011 — Document Status

The system shall support configurable document statuses.

DFM-FR-012 — Approval Workflow

The system shall support document approval workflows.

DFM-FR-013 — Rejection Workflow

The system shall record document rejection reasons.

DFM-FR-014 — Document Expiry

The system shall track document expiry dates.

DFM-FR-015 — Expiry Alerts

The system shall generate events for approaching and expired documents.

DFM-FR-016 — Document Sharing

The system shall support controlled internal document sharing.

DFM-FR-017 — External Sharing

The system shall support controlled external document sharing.

DFM-FR-018 — Access Control

The system shall enforce role-based document access.

DFM-FR-019 — Confidentiality Classification

The system shall support document confidentiality classifications.

DFM-FR-020 — Audit Trail

The system shall maintain a document access and activity audit trail.

DFM-FR-021 — Soft Deletion

The system shall support controlled document archival and deletion.

DFM-FR-022 — Retention Policies

The system shall support configurable document retention policies.

DFM-FR-023 — Offline Capture

The mobile application shall support offline document capture.

DFM-FR-024 — Upload Synchronization

The mobile application shall synchronize pending document uploads when connectivity becomes available.

DFM-FR-025 — Duplicate Detection

The system shall support duplicate document detection.

DFM-FR-026 — File Integrity

The system shall support file integrity verification.

DFM-FR-027 — Image Optimization

The mobile application shall support configurable image compression.

DFM-FR-028 — Backup

The document repository shall be included in the system backup strategy.

DFM-FR-029 — Document Analytics

The system shall provide document-management metrics.

DFM-FR-030 — Data Room

The system shall support controlled document collections for investors, grants and due diligence.

62. Non-Functional Requirements
Security

Documents must be protected against unauthorized access.

Reliability

Uploaded documents must not be silently lost.

Scalability

The architecture must support growth from the initial pilot to the national farmer network.

Performance

Document metadata searches should remain responsive as the repository grows.

Availability

Authorized users should be able to access documents whenever the platform is available.

Maintainability

Storage providers should be replaceable without rewriting the business modules.

Cost Efficiency

The architecture should minimize recurring storage and infrastructure costs while maintaining appropriate reliability.

Auditability

Document access and modification history must be traceable.

Usability

Field workers should be able to capture documents with minimal steps.

63. Example End-to-End Scenario — Farmer Onboarding

Consider a new farmer joining PigPower.

Step 1

Field officer creates the farmer profile.

Step 2

The officer captures the farmer's identification document.

ID.jpg
Step 3

The document is stored locally if there is no connectivity.

Pending Upload
Step 4

Internet becomes available.

Pending
 ↓
Uploading
 ↓
Uploaded
Step 5

The backend associates the document with:

Farmer FMR-000245
Step 6

A manager reviews the documentation.

PENDING_REVIEW
Step 7

The manager approves it.

APPROVED
Step 8

The farmer's documentation status becomes:

DOCUMENTATION COMPLETE
Step 9

The BI system can now include the farmer in the compliant farmer count.

64. Example — Investor Due Diligence

An investor requests:

"Provide the latest financial statements, farmer agreements, processing documentation and environmental reports."

Management can access:

PigPower Data Room
│
├── Financial
│   ├── FY2026 Financial Report
│   └── Management Accounts
│
├── Farmer Network
│   └── Standard Farmer Agreement
│
├── Processing
│   └── Processing Facility Documentation
│
└── Environmental
    ├── Biodigester Documentation
    └── Environmental Reports

This provides a professional due-diligence capability as PigPower progresses toward institutional investment.
