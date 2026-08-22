PigPower SmartFarm Platform
Functional Requirements Specification
Module: Human Resources & Payroll Management

Document ID: PSP-SRS-FR-HRPM
Version: 1.0
Status: Draft
Parent Document: Software Requirements Specification
Chapter: 4 – Functional Requirements
Project: PigPower Lesotho – Community-Based Circular Pork Economy Platform

1. Module Overview

The Human Resources & Payroll Management Module will manage PigPower's workforce throughout the organization's growth from an initial start-up into a national agricultural production, processing, logistics, renewable-energy and technology company.

The module will manage the employee lifecycle:

Recruitment
    ↓
Employee Onboarding
    ↓
Employee Records
    ↓
Employment
    ↓
Attendance & Leave
    ↓
Performance
    ↓
Payroll
    ↓
Benefits & Deductions
    ↓
Reporting
    ↓
Separation

The module is important because PigPower's business model involves multiple categories of workers:

Head-office employees
Farm support officers
Veterinary personnel
Extension officers
Production supervisors
Farm workers
Drivers
Collection personnel
Processing workers
Quality-control personnel
Warehouse personnel
Sales and marketing staff
Renewable-energy technicians
Software/IT personnel
Finance and administration staff
Temporary and seasonal workers
Interns and apprentices

The system should therefore treat HR as a strategic workforce-management system, not merely a payroll calculator.

2. Business Purpose

The module shall provide PigPower with a centralized system for managing:

Employee information
Employment contracts
Organizational structure
Job positions
Recruitment
Onboarding
Attendance
Leave
Payroll
Allowances
Deductions
Benefits
Performance
Training
Workforce costs
Employee separation

The module shall also provide management with visibility into the relationship between labour costs and operational performance.

For example:

How much does it cost PigPower to operate each processing facility, farm-support region, collection route or business unit?

3. Business Objectives

The module shall enable PigPower to:

Maintain a centralized employee database.
Digitize employee records.
Standardize recruitment and onboarding.
Track employment contracts.
Manage organizational structures.
Track attendance.
Manage employee leave.
Calculate payroll.
Track statutory and voluntary deductions.
Manage employee benefits.
Track performance.
Track employee training.
Monitor labour costs.
Support workforce planning.
Improve compliance.
Reduce payroll errors.
Prevent duplicate or unauthorized employees.
Provide management dashboards.
Support youth-employment reporting.
Support BEDCO and investor impact reporting.
4. HR Scope

The module shall cover:

Employee Management
Organizational Management
Position Management
Recruitment
Onboarding
Contracts
Attendance
Leave
Payroll
Allowances
Deductions
Benefits
Performance
Training
Employee Documents
Disciplinary Records
Employee Separation
HR Reporting
Workforce Analytics
5. Organizational Structure

PigPower should support a hierarchical organization.

Example:

BOARD / OWNERS
      │
      ▼
CHIEF EXECUTIVE OFFICER
      │
 ┌────┼────────────┬─────────────┐
 ▼    ▼            ▼             ▼
Farm Processing   Supply Chain   Finance
Operations        Operations     & Admin
 │       │           │
 ▼       ▼           ▼
Farm    Processing  Logistics
Teams   Teams       Teams

The actual organizational structure must remain configurable.

6. Departments

Example departments:

Executive Management
Finance & Accounting
Human Resources
Farmer Network
Livestock Production
Veterinary Services
Feed & Input Supply
Processing
Quality Assurance
Warehouse
Logistics
Sales & Marketing
Renewable Energy
Technology
Procurement
Administration
7. Employee Master Record

Every employee shall have a unique:

Employee ID

The employee profile may contain:

Employee ID
First Name
Middle Name
Surname
Date of Birth
Gender
National Identification Reference
Phone
Email
Address
District
Emergency Contact
Department
Position
Supervisor
Employment Type
Employment Status
Employment Start Date
Contract End Date
Salary
Payment Information
Tax Information
Benefits

Sensitive information should be subject to strict access controls.

8. Employee Status

The system shall support:

Prospective
Active
Probation
On Leave
Suspended
Inactive
Terminated
Resigned
Retired
Contract Expired
9. Employment Types

The system should support:

Permanent

Employees with indefinite employment.

Fixed-Term

Employees hired for a defined period.

Temporary

Employees hired for short-term operational requirements.

Seasonal

Useful for agricultural and processing activities.

Part-Time

Employees working reduced hours.

Casual

Short-duration labour.

Intern

Students or graduates undergoing practical training.

Apprentice

Workers participating in structured skills development.

Contractor

Individuals or organizations providing services under contract.

10. Position Management

Each organizational position should have:

Position ID
Position Title
Department
Reports To
Job Grade
Employment Type
Required Qualifications
Required Skills
Salary Range
Number of Approved Positions
Number Occupied
Status

Example:

Position:
Farm Extension Officer

Department:
Farmer Network

Approved Positions:
10

Occupied:
6

Vacancies:
4
11. Workforce Planning

The system shall distinguish between:

Approved Positions
Filled Positions
Vacant Positions

This will allow management to plan hiring.

Example:

500 Farmers
      ↓
Required Extension Officers
      ↓
Required Veterinary Staff
      ↓
Required Logistics Staff
      ↓
Workforce Budget

This is particularly important as PigPower scales.

12. Recruitment Management

The recruitment process shall support:

Workforce Requirement
       ↓
Job Requisition
       ↓
Approval
       ↓
Job Vacancy
       ↓
Applications
       ↓
Screening
       ↓
Interview
       ↓
Selection
       ↓
Offer
       ↓
Onboarding
13. Job Requisition

A department manager should be able to request a new employee.

Fields:

Requisition ID
Department
Position
Number Required
Reason
Employment Type
Expected Start Date
Budget
Required Qualifications
Required Skills
Approvals
14. Recruitment Candidate

Candidate records may contain:

Candidate ID
Name
Contact Information
Application
CV
Qualifications
Skills
Experience
Interview Score
Assessment Score
Status

Sensitive recruitment information should be visible only to authorized HR users.

15. Recruitment Status
Applied
Shortlisted
Screening
Interview
Assessment
Selected
Offer Sent
Offer Accepted
Offer Rejected
Not Selected
Withdrawn
16. Employee Onboarding

Once a candidate accepts an offer:

Candidate
   ↓
Employee Record
   ↓
Onboarding Checklist
   ↓
Documents
   ↓
System Access
   ↓
Active Employee

The onboarding checklist may include:

Employment contract
Identification
Bank information
Tax information
Emergency contact
Job description
Safety training
Biosecurity training
PPE issue
System account
Department induction
17. Employment Contracts

The system shall maintain contracts.

Contract fields:

Contract ID
Employee
Contract Type
Start Date
End Date
Job Title
Salary
Working Hours
Benefits
Probation Period
Notice Period
Status
Document

The system should generate reminders for contracts approaching expiry.

18. Contract Alerts

Example:

Contract expires in:
30 days

HR receives:

Employee contract requires review.

This prevents accidental contract expiration.

19. Employee Documents

The system should allow authorized HR users to attach documents such as:

Employment contracts
Identification documents
Qualifications
Certificates
Medical/fitness documentation where legally appropriate
Training certificates
Disciplinary documentation
Performance reviews

The application should store document metadata securely.

20. Attendance Management

Attendance shall support:

Clock In
Clock Out
Shift
Overtime
Absence
Late Arrival
Early Departure

Depending on infrastructure, attendance may eventually be captured through:

Mobile application
Web application
QR code
Biometric integration
Site terminal

The first version should not depend on expensive biometric infrastructure.

21. Mobile Attendance

For field employees such as extension officers and collection teams, the mobile application could support:

Employee
   ↓
Clock In
   ↓
GPS / Site
   ↓
Timestamp
   ↓
Work Activity

Location tracking should only be implemented where operationally justified and legally appropriate.

22. Shift Management

Processing facilities may operate shifts.

Example:

Shift A
06:00 – 14:00

Shift B
14:00 – 22:00

Shift C
22:00 – 06:00

The system shall allow shift schedules to be configured.

23. Overtime

Overtime should be recorded separately.

Fields:

Employee
Date
Normal Hours
Overtime Hours
Reason
Supervisor Approval
Rate
Amount

Payroll should automatically use approved overtime.

24. Leave Management

The system shall support:

Annual Leave
Sick Leave
Maternity Leave
Paternity Leave
Family Responsibility
Study Leave
Unpaid Leave
Other Configurable Leave

Leave rules should be configurable according to PigPower's HR policies and applicable labour requirements.

25. Leave Request Workflow
Employee
   ↓
Leave Request
   ↓
Supervisor
   ↓
Approval
   ↓
HR Record

The system should prevent leave exceeding the available balance unless an authorized exception is made.

26. Leave Balance

Example:

Annual Leave Entitlement: 15 days

Used: 7 days

Remaining: 8 days

Employees should be able to view their own balances through the mobile application.

27. Payroll Management

Payroll shall calculate employee remuneration based on configured rules.

A simplified model:

Gross Pay
   =
Basic Salary
+ Allowances
+ Overtime
+ Bonuses
+ Other Earnings

Then:

Net Pay
   =
Gross Pay
-
Statutory Deductions
-
Employee Benefits
-
Other Authorized Deductions
28. Payroll Components
Earnings
Basic salary
Overtime
Housing allowance
Transport allowance
Communication allowance
Field allowance
Performance bonus
Commission
Other approved earnings
Deductions
Applicable statutory deductions
Pension contributions
Employee benefits
Loan deductions
Other authorized deductions

The system should make statutory rules configurable rather than embedding fixed rates permanently into the application.

29. Payroll Period

The system should support configurable payroll periods.

Default:

Monthly

Potential future support:

Weekly
Biweekly
Custom
30. Payroll Processing Workflow
Attendance
    +
Leave
    +
Overtime
    +
Employee Salary
    +
Allowances
    +
Deductions
       ↓
Payroll Calculation
       ↓
Payroll Review
       ↓
Payroll Approval
       ↓
Payslips
       ↓
Finance
       ↓
Payment
31. Payroll Approval

Payroll should require authorization before payment.

Example:

HR Payroll Officer
        ↓
Payroll Review
        ↓
Finance Manager
        ↓
Executive Approval
        ↓
Payment

Approval thresholds should be configurable.

32. Payslips

Employees should be able to access digital payslips.

A payslip should contain:

Employee
Employee ID
Payroll Period
Basic Salary
Allowances
Overtime
Gross Pay
Deductions
Net Pay
Employer Contributions
33. Payroll Corrections

Payroll corrections must not overwrite the original payroll silently.

Instead:

Original Payroll
      ↓
Correction Request
      ↓
Approval
      ↓
Adjustment
      ↓
Audit Record
34. Benefits Management

The system should support employee benefits.

Examples:

Pension
Medical benefits
Insurance
Transport
Housing
Communication
Meals
Staff accommodation
Other approved benefits

Benefits should be configurable by employee category.

35. Employee Loans and Advances

If PigPower provides employee advances or loans, the system may track:

Loan ID
Employee
Principal
Date
Repayment Schedule
Installment
Balance
Status

Payroll may automatically deduct approved installments.

36. Performance Management

The system should support employee performance reviews.

Example cycle:

Performance Plan
      ↓
Objectives
      ↓
Periodic Review
      ↓
Manager Assessment
      ↓
Employee Feedback
      ↓
Final Rating
37. Performance Indicators

Different departments should have different KPIs.

Farm Extension Officer
Farmers supported
Farm visits
Farmer compliance
Pig survival rate
Production improvement
Logistics Officer
Deliveries completed
On-time delivery
Fuel efficiency
Vehicle utilization
Processing Worker
Production volume
Yield
Quality
Safety compliance
Sales Officer
Sales revenue
Customer acquisition
Order fulfillment
Customer retention

This creates an important link between employee performance and business performance.

38. Training Management

PigPower's workforce will require continuous skills development.

Training records should include:

Training ID
Employee
Course
Provider
Date
Duration
Cost
Certificate
Expiry
Status
39. PigPower-Specific Training

The platform should support training in:

Pig husbandry
Biosecurity
Animal welfare
Food safety
HACCP principles
Meat processing
Occupational health and safety
Equipment operation
Cold-chain handling
Renewable energy
Biodigester operation
Digital platform usage
40. Skills Database

Employee profiles should contain a skills inventory.

Example:

Employee:
EMP-00125

Skills:
Electrical Installation
Solar PV
PLC
Animal Production
Data Analysis
Flutter
Python

Skill proficiency can be:

Beginner
Intermediate
Advanced
Expert

This supports workforce planning.

41. Certification Management

The system should track certificates with expiry dates.

Example:

Certificate:
Forklift Operator

Expiry:
30/09/2027

Alert:
60 days before expiry
42. Disciplinary Management

Authorized HR personnel may record disciplinary matters.

Records should include:

Case ID
Employee
Date
Incident
Category
Investigation
Action
Outcome
Status
Supporting Documents

Access must be highly restricted.

43. Employee Separation

The system shall support:

Resignation
Termination
Retirement
Contract Expiry
Redundancy
Death
Other

The separation workflow:

Separation Request
      ↓
Approval
      ↓
Notice Period
      ↓
Clearance
      ↓
Final Payroll
      ↓
Benefits Settlement
      ↓
System Access Revoked
      ↓
Employee Deactivated
44. Exit Clearance

Clearance may include:

Company equipment
Vehicle
Uniform
PPE
Keys
Identification cards
Loans
Advances
Company property
Access credentials
45. HR-to-Finance Integration

HR should provide Finance with approved payroll information.

HR
 │
 ├── Employee Master
 ├── Salary
 ├── Allowances
 ├── Deductions
 └── Payroll
          │
          ▼
       FINANCE
          │
          ▼
       PAYMENT

The HR module should not independently create conflicting accounting records.

46. HR-to-Accounting Integration

Payroll should generate structured accounting information such as:

Salary Expense
Allowance Expense
Employer Contributions
Employee Deductions
Payroll Liabilities
Net Payroll Payable

Finance & Accounting remains responsible for the accounting ledger.

47. HR-to-Operations Integration

Workforce information should connect to operational activities.

For example:

Processing Facility
       ↓
Required Workforce
       ↓
Employees Assigned
       ↓
Shift Schedule
       ↓
Production Output

Management can therefore calculate:

Production output per employee.

48. Youth Employment Tracking

Because youth employment is a central PigPower impact objective, the system should support impact reporting.

The HR system should classify employees according to configurable demographic/impact categories required for reporting.

For example:

Total Employees
Youth Employees
Women Employees
Rural Employees
Interns
Apprentices
Permanent Employees
Temporary Employees

Only information necessary for legitimate reporting should be collected.

49. Employment Impact Dashboard

Example:

Total Employees:        42
Youth Employees:        29
Women Employees:        18
Interns:                 6
Apprentices:             4
Rural-Based Staff:      24

These figures can feed the Impact Assessment & Reporting Module.

50. Workforce Cost Analytics

Management should be able to see:

Total Payroll
Payroll by Department
Payroll per Farm
Payroll per Processing Facility
Payroll per Farmer
Payroll per Pig
Labour Cost per kg Pork
Overtime Cost
Employee Turnover
Training Cost

One particularly useful KPI is:

Labour Cost per kg Processed
=
Total Processing Labour Cost
÷
Kg of Pork Processed
51. Workforce Productivity

The platform should eventually calculate productivity indicators.

Examples:

Farm support
Farmers Supported
÷
Extension Officers
Processing
Kg Processed
÷
Processing Employees
Logistics
Deliveries
÷
Logistics Employees

These metrics help management determine where additional hiring is justified.

52. HR Dashboard

The HR dashboard should show:

Total Employees
Active Employees
New Hires
Vacancies
Employees on Leave
Contracts Expiring
Payroll Cost
Overtime Cost
Employee Turnover
Training Status
Certification Expiry
Performance Reviews Due
53. Employee Mobile Dashboard

Employees should eventually be able to access:

My Profile
My Payslips
My Leave
My Attendance
My Schedule
My Training
My Performance
Company Announcements

Employees should not be able to access other employees' information.

54. Manager Dashboard

Managers should see only employees under their authorized organizational scope.

For example:

Farm Manager
      ↓
Assigned Farm Staff

Processing Manager
      ↓
Processing Staff

Logistics Manager
      ↓
Drivers + Logistics Staff
55. Role-Based Access Control

Suggested roles:

Role	Access
Employee	Own information
Supervisor	Team information
Department Manager	Department
HR Officer	HR records
HR Manager	Full HR
Payroll Officer	Payroll
Finance Manager	Payroll financial data
CEO	Executive reporting
System Administrator	Technical administration

Sensitive HR records should have additional permission controls.

56. Data Security

The HR module will contain highly sensitive personal and financial information.

Therefore:

Sensitive data must be encrypted in transit.
Passwords must never be stored in plaintext.
Access must be role-based.
HR documents must have restricted access.
Payroll data must be access-controlled.
Audit logs must be maintained.
Deleted employees should normally be deactivated rather than physically deleted.
Data retention policies should be configurable.
57. Audit Trail

The system shall record:

Who
What
When
Before
After
Reason

For example:

User:
HR-002

Action:
Salary Updated

Previous:
M12,000

New:
M13,500

Date:
2027-07-01

Approved By:
HR Manager
58. HR Database Entities

The HR subsystem should eventually include entities such as:

Employee
EmployeeContact
EmployeeDocument
EmployeeEmergencyContact

Department
Position
JobGrade
EmploymentContract

RecruitmentRequest
JobVacancy
Candidate
CandidateApplication
Interview
JobOffer

Attendance
Shift
ShiftAssignment
Overtime

LeaveType
LeaveBalance
LeaveRequest

Payroll
PayrollLine
PayrollEarning
PayrollDeduction
PayrollAdjustment
Payslip

EmployeeBenefit
EmployeeLoan

PerformanceReview
PerformanceObjective

TrainingCourse
EmployeeTraining
Certification

DisciplinaryCase

EmployeeSeparation
ExitClearance

HRApproval
HRNotification
HRAuditLog
59. Integration with the Existing PigPower Platform

The HR module will integrate with almost every major subsystem.

                         HR & PAYROLL
                              │
        ┌─────────────────────┼──────────────────────┐
        │                     │                      │
        ▼                     ▼                      ▼
   FARM OPERATIONS       PROCESSING              LOGISTICS
        │                     │                      │
        └─────────────────────┼──────────────────────┘
                              │
                              ▼
                           FINANCE
                              │
                              ▼
                           PAYROLL

It also connects to:

Procurement
Inventory
Veterinary
Farmer Management
Production
Sales
Renewable Energy
Technology
Impact Reporting
60. Key Business Rules
HR-BR-001 — Unique Employee

Each employee shall have exactly one active Employee ID.

HR-BR-002 — Position Authorization

An employee cannot be hired into a position that has not been approved.

HR-BR-003 — Payroll Eligibility

Only active employees with valid employment records may be included in normal payroll.

HR-BR-004 — Payroll Approval

Payroll must be approved before payment processing.

HR-BR-005 — Separation

Separated employees must be removed from active payroll.

HR-BR-006 — Leave

Approved leave must update the employee's leave balance.

HR-BR-007 — Overtime

Overtime must be approved before being included in payroll.

HR-BR-008 — Salary Changes

Salary changes require authorized approval.

HR-BR-009 — Audit

Changes to payroll and employee compensation must be logged.

HR-BR-010 — Segregation of Duties

A user must not approve their own HR or payroll transaction.

61. Key Performance Indicators

The system should calculate:

Workforce
Total employees
Employee growth
Vacancy rate
Employee turnover
Retention rate
Payroll
Total payroll
Payroll per department
Payroll as % of revenue
Overtime expenditure
Average employee cost
Recruitment
Time to hire
Cost per hire
Vacancy duration
Offer acceptance rate
Training
Training completion rate
Training expenditure
Certification compliance
Productivity
Revenue per employee
Pork processed per employee
Farmers supported per extension officer
Deliveries per logistics employee
Impact
Youth employed
Women employed
Interns
Apprentices
Rural employment
Training opportunities created
62. Acceptance Criteria

The module will be considered functionally complete when:

Employee Management
 Employees can be created.
 Employee profiles can be updated.
 Employment status can be changed.
 Employee documents can be stored.
 Employee history is maintained.
Recruitment
 Job requisitions can be created.
 Vacancies can be created.
 Candidates can be tracked.
 Interviews can be recorded.
 Job offers can be issued.
 Candidates can become employees.
Attendance
 Attendance can be recorded.
 Shifts can be configured.
 Overtime can be recorded.
 Overtime requires approval.
Leave
 Leave types can be configured.
 Leave requests can be submitted.
 Managers can approve leave.
 Leave balances update automatically.
Payroll
 Payroll periods can be created.
 Salaries can be configured.
 Allowances can be configured.
 Deductions can be configured.
 Payroll can be calculated.
 Payroll can be reviewed.
 Payroll can be approved.
 Payslips can be generated.
Performance
 Performance objectives can be created.
 Reviews can be conducted.
 Performance ratings can be stored.
Training
 Training courses can be recorded.
 Employees can be enrolled.
 Certifications can be tracked.
 Expiry alerts can be generated.
Separation
 Employee separation can be recorded.
 Exit clearance can be performed.
 Final payroll can be calculated.
 System access can be revoked.
63. Strategic Role in PigPower

The HR module should ultimately answer a much larger business question:

Is PigPower's workforce growing at the right rate relative to the growth of its farmer network, livestock population, processing volume and revenue?

For example:

YEAR 1
50 Farmers
      ↓
Small Operations Team

YEAR 3
250 Farmers
      ↓
Regional Operations Teams

YEAR 5
500 Farmers
      ↓
National Operations Structure

The software should therefore allow management to model:

Farmers
   ↓
Pigs
   ↓
Production
   ↓
Processing Volume
   ↓
Required Employees
   ↓
Payroll
   ↓
Operating Cost
   ↓
Revenue
   ↓
Profitability

This is much more valuable than simply maintaining employee records.

64. Future AI/Analytics Layer

Once PigPower has sufficient historical data, the HR system can support workforce forecasting.

For example:

Forecast: Processing volume is projected to increase by 35% next quarter. The system recommends two additional processing teams and estimates the incremental labour cost.

Similarly:

Forecast: PigPower's farmer network is projected to reach 350 farmers. The system recommends additional extension officers and veterinary capacity.

This connects HR directly to the AI-powered decision-support layer we are designing for the wider PigPower platform.

65. Overall HR Workflow

The complete module can therefore be represented as:

                    HUMAN RESOURCES
                          │
        ┌─────────────────┼──────────────────┐
        │                 │                  │
        ▼                 ▼                  ▼
   RECRUITMENT        EMPLOYEES          WORKFORCE
        │                 │               PLANNING
        ▼                 ▼                  │
   ONBOARDING         ATTENDANCE             │
        │                 │                  │
        └────────────┬────┘                  │
                     ▼                       │
                   LEAVE                     │
                     │                       │
                     ▼                       │
                 PERFORMANCE                 │
                     │                       │
                     └──────────┬────────────┘
                                ▼
                             PAYROLL
                                │
                                ▼
                             FINANCE
                                │
                                ▼
                            PAYMENT
                                │
                                ▼
                         HR ANALYTICS

