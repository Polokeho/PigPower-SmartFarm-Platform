# PigPower SmartFarm Platform

## Functional Requirements Specification

### Module: User Management

**Document ID:** PSP-SRS-FR-USER
**Version:** 1.0
**Status:** Draft
**Parent Document:** Software Requirements Specification (SRS)
**Chapter:** 4 – Functional Requirements
**Module:** User Management
**Prepared For:** PigPower Lesotho

---

# 1. Module Overview

## 1.1 Purpose

The User Management Module provides authorized PigPower administrators with the ability to create, manage, organize, monitor, and deactivate user accounts within the PigPower SmartFarm Platform.

The module builds upon the Authentication and Identity Management Module.

Authentication answers:

> "Who are you?"

User Management answers:

> "What type of user are you, what organization or operational unit are you associated with, and what are you allowed to do?"

The module shall therefore manage the relationship between:

```text
User
 │
 ├── Role
 │    └── Permissions
 │
 ├── Organization
 │
 ├── Farmer Profile
 │
 ├── Farm
 │
 └── Operational Responsibilities
```

---

# 2. Objectives

The User Management Module shall:

1. Maintain a centralized registry of platform users.
2. Support different categories of PigPower users.
3. Associate users with appropriate roles.
4. Associate users with farmers, farms, teams, or operational units where applicable.
5. Support role-based access control.
6. Allow administrators to activate and deactivate accounts.
7. Maintain user profiles.
8. Maintain user status.
9. Maintain user audit history.
10. Support secure user lifecycle management.
11. Prevent unauthorized privilege escalation.
12. Support future organizational expansion.

---

# 3. User Categories

The initial platform shall support the following user categories.

| User Category      | Description                                                          |
| ------------------ | -------------------------------------------------------------------- |
| Administrator      | Manages the platform and system configuration.                       |
| Farmer             | Participates in PigPower livestock production.                       |
| Field Officer      | Supports and monitors farmers and farms.                             |
| Veterinary Officer | Provides veterinary services and animal-health management.           |
| Processing Officer | Operates within the processing facility.                             |
| Logistics Officer  | Coordinates livestock collection and transportation.                 |
| Finance Officer    | Manages financial and payment-related operations.                    |
| Management User    | Accesses management dashboards and reports.                          |
| System User        | Non-human account used by approved software services where required. |

The role model shall be configurable so that additional roles can be introduced without restructuring the entire application.

---

# 4. User Lifecycle

A user account shall follow a defined lifecycle.

```text
                    ┌───────────────┐
                    │     Draft     │
                    └───────┬───────┘
                            │
                            ▼
                    ┌───────────────┐
                    │     Active    │
                    └───────┬───────┘
                            │
                 ┌──────────┴──────────┐
                 ▼                     ▼
          ┌─────────────┐       ┌─────────────┐
          │   Suspended │       │  Deactivated│
          └──────┬──────┘       └─────────────┘
                 │
                 ▼
             Reactivated
                 │
                 ▼
              Active
```

User accounts shall not normally be permanently deleted because historical transactions, farm records, livestock records, financial records, and audit events may depend on the user's identity.

---

# 5. Actors

| Actor           | Permissions                                         |
| --------------- | --------------------------------------------------- |
| Administrator   | Full user-management functionality                  |
| Management User | View authorized users and reports                   |
| Field Officer   | Limited user/profile management where authorized    |
| Farmer          | View and maintain own permitted profile information |
| System          | Performs automated account and status operations    |

---

# 6. Functional Requirements

## FR-USER-001 — Create User

**Priority:** Must Have

### Description

The system shall allow an authorized administrator to create a new user account.

### Required Information

The user record may include:

* User ID
* First name
* Middle name
* Last name
* Phone number
* Email address
* Username
* Role
* Account status
* Organization
* District
* Associated farmer profile where applicable
* Associated farm where applicable
* Date created

### Main Flow

1. Administrator opens User Management.
2. Administrator selects "Create User".
3. System displays the registration form.
4. Administrator enters required information.
5. System validates the information.
6. System checks for duplicate identifiers.
7. System creates the user record.
8. System assigns the selected role.
9. System records the creation event.
10. System displays confirmation.

### Acceptance Criteria

A valid user registration shall create exactly one user account with a unique identifier.

---

# 7. FR-USER-002 — Generate Unique User ID

**Priority:** Must Have

The system shall assign a unique immutable identifier to every user.

The User ID shall not be reused after an account has been deactivated.

The implementation shall preferably use a globally unique identifier such as UUID.

Example:

```text
USR-7f8c2d6a-...
```

The final identifier format shall be determined during database architecture.

---

# 8. FR-USER-003 — View User Profile

**Priority:** Must Have

Authorized users shall be able to view user profiles according to their permissions.

A user profile may contain:

* Name
* Contact information
* Role
* Account status
* Organization
* Assigned operational unit
* Associated farmer
* Associated farm
* Date created
* Last login
* Profile photograph where applicable

Sensitive authentication information shall not be displayed.

---

# 9. FR-USER-004 — Update User Profile

**Priority:** Must Have

Authorized users shall be able to update permitted user information.

### Editable Fields

Depending on the user's role and permissions:

* Name
* Phone number
* Email
* Address
* Photograph
* District
* Operational assignment

### Restricted Fields

The following shall require elevated authorization:

* Role
* Account status
* User ID
* Security settings

---

# 10. FR-USER-005 — User Self-Service Profile

**Priority:** Should Have

Users shall be able to update permitted personal information.

A user shall not be allowed to modify:

* Their own role
* Their own permissions
* Their account status
* Administrative privileges

---

# 11. FR-USER-006 — Assign User Role

**Priority:** Must Have

An authorized administrator shall be able to assign a role to a user.

Example:

```text
User
  │
  ▼
Field Officer
  │
  ▼
Field Management Permissions
```

### Requirements

* A user must have at least one valid role before becoming active.
* Role assignment shall be audited.
* Users shall not assign roles to themselves.
* Users shall not grant themselves elevated privileges.

---

# 12. FR-USER-007 — Change User Role

**Priority:** Must Have

An administrator shall be able to change a user's role.

The system shall record:

* Previous role
* New role
* Administrator performing the change
* Date and time
* Reason where applicable

The new permissions shall become effective according to the authorization policy.

---

# 13. FR-USER-008 — Role Assignment Validation

**Priority:** Must Have

The system shall validate role assignments.

For example:

A Farmer role may require association with a registered farmer profile.

A Veterinary Officer role may require appropriate professional authorization information where required by business policy.

A Processing Officer role may require assignment to a processing facility.

The exact validation requirements shall be defined by PigPower management and applicable regulations.

---

# 14. FR-USER-009 — Account Activation

**Priority:** Must Have

An authorized administrator shall be able to activate an account.

### Preconditions

* User profile exists.
* Required registration information is available.
* Required role has been assigned.

### Result

The account status shall change to:

```text
ACTIVE
```

The event shall be recorded in the audit log.

---

# 15. FR-USER-010 — Account Deactivation

**Priority:** Must Have

An administrator shall be able to deactivate a user account.

### Requirements

Deactivation shall:

* Prevent future authentication.
* Revoke active sessions where appropriate.
* Preserve historical records.
* Preserve audit history.
* Preserve transactions created by the user.

The user record shall not normally be physically deleted.

---

# 16. FR-USER-011 — Suspend User

**Priority:** Should Have

The system shall support temporary suspension of user accounts.

Suspension may be used for:

* Security investigations
* Administrative review
* Extended inactivity
* Policy violations
* Temporary operational restrictions

Suspension shall not delete user data.

---

# 17. FR-USER-012 — Reactivate User

**Priority:** Must Have

Authorized administrators shall be able to reactivate suspended or deactivated accounts where permitted.

The system shall record:

* Previous status
* New status
* Administrator
* Timestamp
* Reason

---

# 18. FR-USER-013 — Search Users

**Priority:** Must Have

Authorized users shall be able to search the user directory.

Search criteria may include:

* User ID
* Name
* Phone number
* Email
* Username
* Role
* District
* Status
* Organization

---

# 19. FR-USER-014 — Filter Users

**Priority:** Must Have

The system shall allow users with appropriate permissions to filter user records.

Supported filters shall include:

* Active
* Inactive
* Suspended
* Role
* District
* Organization
* Registration period

---

# 20. FR-USER-015 — Sort Users

**Priority:** Should Have

The user directory should support sorting by:

* Name
* Registration date
* Last login
* Role
* Status

---

# 21. FR-USER-016 — User Pagination

**Priority:** Must Have

The backend shall support pagination when retrieving user records.

This shall prevent the application from loading the entire user database into memory.

---

# 22. FR-USER-017 — Associate User with Farmer

**Priority:** Must Have

The system shall allow an appropriate user account to be associated with a registered farmer profile.

Example:

```text
User
 │
 ▼
Farmer Profile
 │
 ▼
Farm
 │
 ▼
Pig Population
```

This relationship will allow farmer users to access only the operational data they are authorized to view.

---

# 23. FR-USER-018 — Associate User with Farm

**Priority:** Must Have

Authorized users shall be assignable to one or more farms where required.

Examples include:

* Field Officer → multiple farms
* Farmer → own farm
* Veterinary Officer → assigned farms
* Regional Manager → district farms

The database design shall support one-to-many and many-to-many relationships where operational requirements require them.

---

# 24. FR-USER-019 — Organizational Assignment

**Priority:** Should Have

The system should support assignment of users to organizational units.

Possible organizational structures include:

```text
PigPower Lesotho
       │
       ├── Headquarters
       │
       ├── District
       │     ├── Field Team
       │     └── Farmers
       │
       └── Processing Facility
```

This will support future expansion across multiple districts and facilities.

---

# 25. FR-USER-020 — District Assignment

**Priority:** Must Have

Users involved in field operations shall be assignable to a district.

This will allow the system to control and report geographically relevant information.

Potential districts include all administrative districts in Lesotho.

---

# 26. FR-USER-021 — User Status

**Priority:** Must Have

The system shall maintain an account status.

Initial statuses shall include:

```text
PENDING
ACTIVE
SUSPENDED
INACTIVE
```

The status shall determine whether the user may authenticate.

---

# 27. FR-USER-022 — Last Login

**Priority:** Must Have

The system shall record the most recent successful login.

The information shall support:

* Security monitoring
* User activity monitoring
* Inactive-user identification

---

# 28. FR-USER-023 — User Activity Summary

**Priority:** Should Have

Authorized administrators shall be able to view a summary of user activity.

Potential metrics include:

* Last login
* Number of successful logins
* Number of failed logins
* Recent activities
* Account status

Sensitive information shall only be accessible to authorized administrators.

---

# 29. FR-USER-024 — User Deletion Protection

**Priority:** Must Have

The system shall prevent ordinary users from permanently deleting accounts.

Where deletion is legally or operationally required, the system shall use a controlled administrative process.

Historical business records shall remain associated with the original user identifier.

---

# 30. FR-USER-025 — Audit User Changes

**Priority:** Must Have

The system shall record changes to user information.

Auditable changes shall include:

* Profile updates
* Role changes
* Status changes
* District changes
* Farm assignments
* Organization assignments

Each event shall record:

```text
Who
What changed
Previous value
New value
When
Reason
```

---

# 31. FR-USER-026 — Bulk User Import

**Priority:** Could Have

The system may support bulk user creation using an approved structured file format.

Potential use cases include:

* Initial migration
* Farmer onboarding campaigns
* Regional expansion
* Staff onboarding

Bulk imports shall validate each record before committing data.

Invalid records shall not corrupt valid records.

---

# 32. FR-USER-027 — User Export

**Priority:** Should Have

Authorized administrators may export permitted user information for reporting purposes.

Exported data shall exclude:

* Passwords
* Authentication tokens
* Sensitive security information

The system shall record export events where required.

---

# 33. FR-USER-028 — Duplicate User Prevention

**Priority:** Must Have

The system shall prevent duplicate user accounts based on configured unique identifiers.

Potential unique identifiers include:

* Username
* Email
* Phone number

The final uniqueness rules shall be defined during database design.

---

# 34. FR-USER-029 — User Validation

**Priority:** Must Have

The system shall validate user information before persistence.

Validation shall include:

* Required fields
* Field lengths
* Character formats
* Contact information
* Role validity
* Organization validity
* Association validity

Invalid information shall not be saved.

---

# 35. FR-USER-030 — User Notifications

**Priority:** Should Have

The system should notify users when significant account events occur.

Potential notifications include:

* Account created
* Account activated
* Account suspended
* Role changed
* Password changed
* Account reactivated

The notification mechanism may include:

* In-app notification
* SMS
* Email

The initial implementation shall prioritize low-cost communication mechanisms appropriate for Lesotho.

---

# 36. FR-USER-031 — User Language Preference

**Priority:** Could Have

The platform may allow users to select a preferred application language.

Potential initial languages:

* English
* Sesotho

Language support shall be implemented using internationalization rather than hard-coded strings.

---

# 37. FR-USER-032 — User Time and Locale

**Priority:** Should Have

The system shall store and display timestamps consistently.

The backend shall use a standardized timezone strategy.

The user interface shall display dates and times according to the configured application or user locale.

---

# 38. FR-USER-033 — Mobile Device Association

**Priority:** Could Have

The system may associate a user account with registered mobile devices.

The information may include:

* Device identifier
* Operating system
* Application version
* Registration timestamp
* Last synchronization timestamp

This functionality shall support future device-security controls.

---

# 39. FR-USER-034 — Offline User Profile

**Priority:** Must Have

The mobile application shall maintain a limited local representation of the authenticated user's profile.

The local profile may contain:

* User ID
* Display name
* Role
* Farmer ID where applicable
* Farm ID where applicable
* Permissions required for offline operation

Sensitive information shall not be unnecessarily cached.

---

# 40. FR-USER-035 — User Synchronization

**Priority:** Must Have

The mobile application shall synchronize user profile changes with the backend when connectivity is available.

The synchronization mechanism shall:

* Detect connectivity.
* Queue permitted local changes.
* Submit changes to the backend.
* Resolve conflicts according to defined synchronization rules.
* Record synchronization status.

Security-sensitive role and permission changes shall always be authoritative from the backend.

---

# 41. FR-USER-036 — Permission Refresh

**Priority:** Must Have

The application shall periodically refresh the user's authorization information.

This is necessary to ensure that a user whose role has been changed or revoked does not retain outdated permissions indefinitely.

---

# 42. FR-USER-037 — Administrator Dashboard

**Priority:** Must Have

The system shall provide administrators with a user-management dashboard.

The dashboard shall display summary information such as:

* Total users
* Active users
* Suspended users
* Inactive users
* Users by role
* Users by district
* Recently created users
* Recent account changes

---

# 43. FR-USER-038 — User Management Dashboard Filtering

**Priority:** Should Have

Administrators shall be able to filter dashboard information by:

* Date
* District
* Role
* Account status
* Organization

---

# 44. FR-USER-039 — Privilege Escalation Protection

**Priority:** Must Have

The system shall prevent users from obtaining privileges beyond those assigned by authorized administrators.

Examples of prohibited behaviour include:

* Farmer assigning themselves Administrator privileges.
* Field Officer modifying their own role.
* User modifying another user's permissions without authorization.
* Mobile application bypassing backend authorization.

Authorization shall always be enforced server-side.

---

# 45. FR-USER-040 — User Management Security

**Priority:** Must Have

User-management operations shall comply with the platform security architecture.

The system shall:

* Authenticate administrators.
* Authorize administrative actions.
* Validate input.
* Log security-sensitive operations.
* Protect sensitive user information.
* Prevent unauthorized access.

---

# 46. User Management Business Rules

## BR-USER-001

Every user shall have a unique immutable User ID.

## BR-USER-002

Every active user shall have at least one valid role.

## BR-USER-003

Users shall not assign roles to themselves.

## BR-USER-004

Users shall not modify their own administrative privileges.

## BR-USER-005

Deactivated users shall not establish new authentication sessions.

## BR-USER-006

Historical records associated with a user shall not be destroyed through normal account deactivation.

## BR-USER-007

Role changes shall be auditable.

## BR-USER-008

Administrative functions shall require appropriate authorization.

## BR-USER-009

Farmer users shall only access farmer and farm information permitted by their role.

## BR-USER-010

Authentication and authorization decisions shall be enforced by the backend.

---

# 47. User Permission Model

The initial permission architecture shall use:

```text
Role-Based Access Control

User
 │
 ▼
Role
 │
 ▼
Permission
 │
 ▼
Resource
```

Example:

```text
Farmer
 │
 ├── VIEW_OWN_PROFILE
 ├── EDIT_OWN_PROFILE
 ├── VIEW_OWN_FARM
 ├── VIEW_OWN_PIGS
 ├── CREATE_PIG_RECORD
 └── RECORD_PIG_WEIGHT
```

Field Officer:

```text
Field Officer
 │
 ├── VIEW_FARMERS
 ├── CREATE_FARMER
 ├── EDIT_FARMER
 ├── VIEW_FARMS
 ├── CREATE_FARM
 ├── INSPECT_FARM
 └── VIEW_PRODUCTION
```

Administrator:

```text
Administrator
 │
 ├── MANAGE_USERS
 ├── MANAGE_ROLES
 ├── MANAGE_PERMISSIONS
 ├── VIEW_AUDIT_LOG
 ├── MANAGE_CONFIGURATION
 └── VIEW_SYSTEM_REPORTS
```

The complete permission matrix shall be defined during the Authorization and System Architecture design phase.

---

# 48. Data Requirements

The User Management Module shall require, at minimum, the following conceptual entities:

```text
User
Role
Permission
UserRole
RolePermission
Organization
District
UserOrganization
UserFarm
UserFarmer
UserDevice
AuditEvent
```

These entities are conceptual at this stage.

The final relational model shall be defined during database architecture.

---

# 49. Non-Functional Considerations

The module shall comply with the following requirements:

### Security

User data shall be protected against unauthorized access.

### Performance

Common user-management operations should return within an acceptable application response time under normal operating conditions.

### Scalability

The design shall support expansion from hundreds to potentially tens of thousands of users.

### Availability

User authentication and management services shall support the platform's availability objectives.

### Auditability

Administrative actions shall be traceable.

### Maintainability

Roles and permissions should be configurable rather than hard-coded throughout the application.

---

# 50. Acceptance Criteria

The User Management Module shall be considered functionally complete when:

### User Lifecycle

* [ ] Administrators can create users.
* [ ] Users receive unique IDs.
* [ ] Users can be activated.
* [ ] Users can be suspended.
* [ ] Users can be deactivated.
* [ ] Users can be reactivated.

### Profiles

* [ ] Users can view their permitted profile information.
* [ ] Authorized users can update permitted information.
* [ ] Restricted fields require appropriate privileges.

### Roles

* [ ] Administrators can assign roles.
* [ ] Administrators can change roles.
* [ ] Role changes are audited.
* [ ] Users cannot escalate their own privileges.

### Associations

* [ ] Users can be associated with farmers.
* [ ] Users can be associated with farms.
* [ ] Users can be assigned to districts.
* [ ] Organizational assignments are supported.

### Administration

* [ ] Administrators can search users.
* [ ] Administrators can filter users.
* [ ] Administrators can view user status.
* [ ] Administrators can review user activity.
* [ ] Administrative actions are auditable.

### Offline

* [ ] Limited user information is available offline.
* [ ] Authorization information can be refreshed.
* [ ] Security-sensitive authorization remains backend-controlled.

---

# 51. Requirement Traceability

| Requirement | Business Goal |
| ----------- | ------------- |
| FR-USER-001 | BG-06         |
| FR-USER-002 | BG-06         |
| FR-USER-003 | BG-06         |
| FR-USER-004 | BG-06         |
| FR-USER-005 | BG-06         |
| FR-USER-006 | BG-06         |
| FR-USER-007 | BG-06         |
| FR-USER-008 | BG-06         |
| FR-USER-009 | BG-06         |
| FR-USER-010 | BG-06         |
| FR-USER-011 | BG-06         |
| FR-USER-012 | BG-06         |
| FR-USER-013 | BG-06         |
| FR-USER-014 | BG-06         |
| FR-USER-015 | BG-06         |
| FR-USER-016 | BG-06         |
| FR-USER-017 | BG-02         |
| FR-USER-018 | BG-02         |
| FR-USER-019 | BG-06         |
| FR-USER-020 | BG-02         |
| FR-USER-021 | BG-06         |
| FR-USER-022 | BG-06         |
| FR-USER-023 | BG-06         |
| FR-USER-024 | BG-06         |
| FR-USER-025 | BG-06         |
| FR-USER-026 | BG-06         |
| FR-USER-027 | BG-06         |
| FR-USER-028 | BG-06         |
| FR-USER-029 | BG-06         |
| FR-USER-030 | BG-06         |
| FR-USER-031 | BG-02         |
| FR-USER-032 | BG-06         |
| FR-USER-033 | BG-06         |
| FR-USER-034 | BG-06         |
| FR-USER-035 | BG-06         |
| FR-USER-036 | BG-06         |
| FR-USER-037 | BG-06         |
| FR-USER-038 | BG-06         |
| FR-USER-039 | BG-06         |
| FR-USER-040 | BG-06         |

---

# 52. Dependencies

The User Management Module depends on:

* Authentication Module
* Role and permission system
* User database
* Organization structure
* Farmer Management Module
* Farm Management Module
* Audit logging
* Backend API
* Mobile application
* Secure local storage
* Synchronization engine

---

# 53. Open Design Decisions

The following decisions shall be finalized during the architecture phase:

| ID           | Decision                                       |
| ------------ | ---------------------------------------------- |
| USER-DEC-001 | UUID versus alternative user identifier format |
| USER-DEC-002 | Exact RBAC implementation                      |
| USER-DEC-003 | Role versus permission architecture            |
| USER-DEC-004 | Organization hierarchy                         |
| USER-DEC-005 | District assignment model                      |
| USER-DEC-006 | User-to-farm relationship model                |
| USER-DEC-007 | User-to-farmer relationship model              |
| USER-DEC-008 | User-device relationship                       |
| USER-DEC-009 | User synchronization strategy                  |
| USER-DEC-010 | Data-retention policy                          |
| USER-DEC-011 | Administrative privilege hierarchy             |
| USER-DEC-012 | SMS/email notification provider                |

---

# 54. Future Enhancements

Potential future capabilities include:

* Biometric identity verification
* National identity integration
* Advanced workforce management
* Employee attendance
* GPS-based field assignment
* Digital staff contracts
* Digital training certificates
* Performance management
* Advanced identity verification
* Single Sign-On
* Multi-tenant organizational architecture
