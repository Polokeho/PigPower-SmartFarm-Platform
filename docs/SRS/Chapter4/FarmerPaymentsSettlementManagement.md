PigPower SmartFarm Platform
Functional Requirements Specification
Module: Farmer Payments & Settlement Management

Document ID: PSP-SRS-FR-FPS
Version: 1.0
Status: Draft
Parent Document: Software Requirements Specification
Chapter: 4 – Functional Requirements
Project: PigPower Lesotho – Community-Based Circular Pork Economy Platform

1. Module Overview

The Farmer Payments & Settlement Management Module shall manage the complete financial settlement process between PigPower Lesotho and participating farmers.

The module shall calculate how much each farmer is owed based on:

Animals delivered
Animal identification
Live weight
Carcass weight where applicable
Quality grade
Agreed pricing
Bonuses
Penalties
Feed supplied on credit
Piglets supplied
Veterinary services
Other approved farmer inputs
Transport deductions where applicable
Outstanding farmer advances
Other authorized deductions

The system shall produce a transparent settlement statement showing exactly how the farmer's final payable amount was calculated.

The fundamental principle shall be:

Every farmer must be able to understand how PigPower calculated their payment.

2. Business Purpose

PigPower's farmer aggregation model depends on trust.

If farmers cannot clearly understand:

how their pigs were weighed,
how quality was assessed,
what price was applied,
what deductions were made, and
when they will be paid,

the aggregation model will eventually lose farmer participation.

Therefore, the payment system shall provide transparent, auditable and traceable farmer settlements.

3. Business Objectives

The module shall enable PigPower to:

Calculate farmer payments accurately.
Provide transparent settlement statements.
Link payments to specific animals and production batches.
Apply approved pricing rules.
Calculate quality-based premiums and penalties.
Deduct farmer inputs supplied on credit.
Track farmer advances.
Track farmer balances.
Generate payment approvals.
Record completed payments.
Prevent duplicate payments.
Maintain complete financial audit trails.
Provide farmers with digital payment statements.
Support reconciliation with the accounting system.
Provide management with farmer liability information.
Support financial planning and cash-flow management.
4. Payment Lifecycle

The settlement process shall follow:

PIG DELIVERED
      ↓
ANIMAL IDENTIFICATION
      ↓
WEIGHING
      ↓
QUALITY ASSESSMENT
      ↓
PRICE DETERMINATION
      ↓
GROSS VALUE
      ↓
BONUSES / PENALTIES
      ↓
FARMER DEDUCTIONS
      ↓
NET SETTLEMENT
      ↓
APPROVAL
      ↓
PAYMENT
      ↓
RECONCILIATION
      ↓
FARMER STATEMENT
5. Settlement Unit

The system shall support settlement at multiple levels.

Animal level
Pig ID
Weight
Grade
Price
Value
Delivery level
Delivery
 ├── Pig 1
 ├── Pig 2
 ├── Pig 3
 └── Pig 4
Farmer settlement level
Farmer
 ├── Delivery 1
 ├── Delivery 2
 ├── Delivery 3
 └── Adjustments

This allows PigPower to calculate both individual delivery values and periodic farmer statements.

6. Farmer Account

Each participating farmer shall have a financial account.

Example:

FARMER ACCOUNT

Farmer ID:
FMR-000145

Name:
Thabo M.

Account Status:
ACTIVE

Current Balance:
M12,450

Outstanding Advance:
M3,000

Unpaid Settlements:
M18,750

Outstanding Input Credit:
M6,300
7. Farmer Financial Ledger

The system shall maintain a farmer ledger.

Example:

DATE       DESCRIPTION              DEBIT      CREDIT      BALANCE

01 Aug     Feed supplied            2,500                  2,500
08 Aug     Veterinary service         500                  3,000
15 Aug     Pig delivery                         8,500     -5,500
20 Aug     Piglet supplied           1,500                  -4,000

The exact accounting convention should be finalized during the Finance/Accounting design.

8. Pricing Management
FR-FPS-001 — Configure Pig Pricing

Authorized users shall be able to configure approved pig pricing structures.

Possible pricing models:

Live-weight pricing
Payment =
Live Weight × Price/kg
Carcass-weight pricing
Payment =
Carcass Weight × Price/kg
Grade-based pricing
Grade A → M/kg
Grade B → M/kg
Grade C → M/kg
Hybrid pricing
Base Price
+
Quality Premium
-
Applicable Penalties

The pricing model shall be configurable rather than hard-coded.

9. Price Tables

The system shall maintain effective-dated price tables.

Example:

Effective Date	Grade	Price/kg
01/01/2027	A	M65
01/01/2027	B	M58
01/01/2027	C	M50

A price table must have:

Effective date
Expiry date
Product/animal category
Grade
Price
Approved by
Status
10. Price Versioning

Historical settlements must never be recalculated using today's price.

Therefore:

A settlement shall retain the exact price version used when it was calculated.

Example:

Settlement:
SET-2027-00152

Price Version:
PV-2027-03

Price:
M58/kg

Effective:
01 March 2027

This is essential for financial auditability.

11. Animal Valuation

For every eligible animal, the system shall calculate:

Gross Animal Value =
Eligible Weight × Applicable Price

Example:

Pig ID:
PIG-00452

Weight:
105 kg

Price:
M58/kg

Gross Value:
105 × 58
= M6,090
12. Weight Source

The system shall record the source of the weight.

Possible sources:

Farm scale
Collection-center scale
Processing facility scale
Certified weighing equipment

The system shall identify the authoritative weight used for settlement.

13. Weight Dispute Protection

Once a settlement has been approved, the weight used for payment shall not be silently changed.

Any amendment shall:

Create an adjustment.
Record the original value.
Record the new value.
Record the reason.
Identify the authorized user.
Create an audit entry.
14. Quality Assessment

The settlement system shall receive quality information from the production/processing modules.

Possible parameters:

Grade
Carcass weight
Fat quality
Meat quality
Health status
Age category
Weight range
Processing suitability

The precise grading standard should be configurable and aligned with PigPower's approved operating procedures.

15. Quality Premiums

PigPower may reward farmers for desirable production outcomes.

Example:

Base Value:
M6,000

Quality Premium:
M300

Final Gross:
M6,300

Premium types could include:

Target weight bonus
Quality grade bonus
Consistency bonus
Biosecurity compliance bonus
Low mortality bonus
Contract compliance bonus
16. Penalties

Authorized penalties may include:

Failure to comply with biosecurity requirements
Undersized animals
Severe quality defects
Contract violations
Unauthorized animal substitution
Repeated production non-compliance

However:

Penalties must be governed by documented PigPower policies and must never be arbitrarily entered by individual employees.

17. Bonus and Penalty Rules Engine

The system should eventually support configurable rules.

Example:

IF
Average weight >= target

THEN
Apply 5% production bonus

Another example:

IF
Biosecurity score < minimum threshold

THEN
Flag settlement for review

For the MVP, these rules may initially be configured manually by authorized administrators.

18. Gross Settlement

The gross settlement shall be:

Gross Value
=
Animal Values
+
Approved Bonuses
-
Approved Penalties
19. Farmer Input Deductions

PigPower may provide inputs to farmers on credit.

Examples:

Piglets
Feed
Vaccines
Veterinary services
Medicines where permitted
Equipment
Training-related recoverable costs
Transport
Other approved services

These transactions shall flow into the farmer ledger.

20. Feed Credit

Example:

Farmer:
FMR-000145

Feed supplied:
500 kg

Rate:
M5/kg

Credit:
M2,500

At settlement:

Gross Settlement:
M12,500

Feed Deduction:
M2,500

Net:
M10,000
21. Veterinary Service Deductions

If veterinary services are recoverable from farmers:

Veterinary Service:
M450

Settlement Deduction:
M450

The system shall distinguish between:

Company-funded services
Farmer-funded services
Subsidized services
Recoverable services

This is important because not every PigPower intervention should necessarily become a farmer debt.

22. Farmer Advances

PigPower may issue production advances.

Example:

Advance:
M5,000

Reason:
Production support

Outstanding:
M5,000

The advance shall remain visible until fully recovered or formally written off.

23. Deduction Rules

The system shall support:

Fixed amount
Percentage
Per kilogram
Per animal
Per service
Installment

Example:

Feed:
M/kg

Transport:
M/animal

Management fee:
% of settlement
24. Deduction Authorization

Each deduction shall have:

Deduction ID
Type
Amount
Source transaction
Date
Reason
Authorized by
Settlement reference

No employee should be able to create arbitrary deductions without appropriate authorization.

25. Deduction Limits

The system should support configurable deduction limits.

Example:

Maximum deduction:
40% of gross settlement

If the proposed deduction exceeds the limit:

SYSTEM:
Settlement requires approval.

The exact percentage is a business-policy decision and should not be hard-coded at this stage.

26. Minimum Farmer Payment

PigPower may establish a minimum payment protection rule.

For example:

IF
Net Settlement < Minimum Threshold

THEN
Require Financial Manager Approval

This prevents unexpected negative settlements.

27. Negative Settlement

The system shall prevent accidental negative settlements.

If:

Deductions > Gross Value

the system shall flag the settlement.

Possible outcomes:

Carry balance forward
Partial deduction
Payment of zero
Management approval
Restructured deduction plan

The chosen policy should be configurable.

28. Settlement Calculation

The core formula should be:

Gross Animal Value
        +
Bonuses
        -
Penalties
        -
Approved Deductions
        -
Outstanding Recoverable Advances
        =
NET FARMER SETTLEMENT
29. Settlement Status

Each settlement shall have a lifecycle:

DRAFT
 ↓
CALCULATED
 ↓
PENDING_REVIEW
 ↓
APPROVED
 ↓
PAYMENT_PENDING
 ↓
PAID
 ↓
RECONCILED

Additional statuses:

DISPUTED
ON_HOLD
CANCELLED
ADJUSTED
30. Settlement Approval Workflow
Collection
    ↓
Weight & Quality Data
    ↓
Settlement Calculation
    ↓
System Validation
    ↓
Finance Review
    ↓
Management Approval
    ↓
Payment Instruction
    ↓
Payment
    ↓
Reconciliation
31. Maker-Checker Principle

The person calculating a settlement should not necessarily be the same person approving it.

For example:

Collection Officer
       ↓
Settlement Officer
       ↓
Finance Manager
       ↓
Payment Authorization

This reduces fraud and accounting errors.

32. Payment Methods

The system should support configurable payment methods.

Potential methods:

Bank transfer
Mobile money
Electronic funds transfer
Cash — only where legally and operationally appropriate

For MVP:

BANK
MOBILE MONEY

may be prioritized.

33. Farmer Payment Profile

Each farmer shall have a payment profile containing:

Farmer ID
Payment method
Account/provider
Account holder
Verification status
Preferred payment method

Sensitive financial information must be encrypted and access-controlled.

34. Payment Verification

Before payment, the system should validate:

Farmer is active
Settlement is approved
Payment amount is valid
Payment account is verified
Settlement has not already been paid
No duplicate payment exists
35. Duplicate Payment Prevention

The system shall prevent duplicate settlement payments.

Example:

Settlement:
SET-2027-00152

Status:
PAID

Payment:
PAY-2027-00881

A second payment against the same settlement shall require explicit adjustment/override authorization.

36. Payment Transaction

Each payment shall have a unique ID.

Example:

PAY-2027-00881

Information:

Payment ID
Settlement ID
Farmer
Amount
Payment method
Payment reference
Payment date
Initiated by
Approved by
Status
37. Payment Status
PENDING
PROCESSING
SUCCESSFUL
FAILED
REVERSED
CANCELLED
38. Payment Reconciliation

The system shall support reconciliation between:

Settlement
      ↓
Payment Instruction
      ↓
Bank / Payment Provider
      ↓
Payment Confirmation
      ↓
Farmer Ledger

A payment shall only become RECONCILED after confirmation.

39. Farmer Statement

Farmers shall be able to view/download their settlement statement.

Example:

PIGPOWER LESOTHO

FARMER SETTLEMENT STATEMENT

Farmer:
Thabo M.

Farmer ID:
FMR-000145

Settlement:
SET-2027-00152

Animals:
5

Total Weight:
512 kg

Gross Value:
M29,696

Bonuses:
M1,000

Penalties:
M0

Feed Deduction:
M4,000

Veterinary:
M500

Net Settlement:
M26,196

Payment Status:
PAID

Payment Reference:
PAY-2027-00881

This transparency should be a major feature of the farmer application.

40. Farmer Mobile App

The farmer shall be able to view:

MY FARM ACCOUNT

Current Balance
M26,196

Pending Settlements
2

Paid Settlements
12

Outstanding Input Credit
M4,500

Recent Payment
M26,196
41. Settlement Notification

When settlement is approved:

Your PigPower settlement of M26,196 has been approved and is pending payment.

When paid:

Payment of M26,196 has been successfully processed. Reference: PAY-2027-00881.

42. Settlement Disputes
FR-FPS-002 — Farmer Dispute

Farmers shall be able to dispute a settlement.

Possible dispute reasons:

Incorrect weight
Incorrect number of animals
Incorrect price
Incorrect grade
Incorrect deduction
Missing bonus
Payment not received
Duplicate deduction
Other
43. Dispute Workflow
FARMER
  ↓
SUBMIT DISPUTE
  ↓
CASE CREATED
  ↓
INVESTIGATION
  ↓
EVIDENCE REVIEW
  ↓
DECISION
  ↓
APPROVED / REJECTED
  ↓
ADJUSTMENT IF REQUIRED
44. Dispute Evidence

The system should allow authorized users to attach:

Weighing records
Photos
Delivery documents
Quality reports
Processing records
Payment confirmations
Other supporting evidence
45. Settlement Adjustment

If an error is identified, the system shall not overwrite the original settlement.

Instead:

Original Settlement
       ↓
Adjustment Note
       ↓
New Financial Transaction

Example:

Original:
M20,000

Adjustment:
+M1,500

Adjusted Total:
M21,500

This preserves financial history.

46. Farmer Ledger Integration

The module shall integrate with the accounting/finance system.

Conceptually:

FARMER LEDGER

Receivable from Farmer
        ↕
Payable to Farmer
        ↕
Input Credits
        ↕
Advances
        ↕
Settlements
        ↕
Payments

The exact accounting implementation should be finalized in the Finance & Accounting module.

47. Separation of Responsibilities

The Farmer Payments module should not become the accounting system.

Its responsibility is:

Determine, authorize, record and communicate what PigPower owes the farmer.

The accounting system remains responsible for:

General ledger
Accounts payable
Accounts receivable
Bank reconciliation
Financial statements
Tax accounting

This architectural separation will be important as PigPower scales.

48. Farmer Financial Dashboard

Management should see:

FARMER PAYMENTS

Total Farmer Liability
M2.85M

Pending Settlements
M450K

Approved
M275K

Paid
M2.1M

Outstanding Advances
M180K

Input Credit
M320K

Disputes
14
49. Management Analytics

The system shall provide:

Average Farmer Settlement
Total Settlements ÷ Number of Settlements
Average Price/kg
Total Animal Value ÷ Total Eligible Weight
Farmer Payment Cycle
Delivery Date → Payment Date
Outstanding Farmer Liability
Approved but unpaid settlements
Input Recovery Rate
Recovered Input Credit
÷
Total Recoverable Input Credit
50. Farmer Income Analytics

PigPower can eventually calculate:

Farmer Gross Revenue
        -
Farmer Production Costs
        =
Estimated Farmer Margin

This will help the company determine whether its farmer network is actually improving farmer profitability.

51. Farmer Performance Integration

Payment information should feed into Farmer Management.

Example:

FARMER
 ↓
Production
 ↓
Weight
 ↓
Quality
 ↓
Revenue
 ↓
Profitability

This allows PigPower to identify high-performing farmers and farmers requiring support.

52. Incentive System

The platform should eventually support performance incentives.

Potential incentives:

Consistent supply
Target weight achievement
High survival rate
Good biosecurity
High-quality carcasses
Timely delivery
Contract compliance

Example:

Performance Score
       ↓
Premium
       ↓
Higher Farmer Earnings

This aligns farmer behavior with PigPower's operational objectives.

53. Farmer Ranking

The system may calculate a performance score.

Example:

FARMER PERFORMANCE

Production:
90%

Quality:
85%

Biosecurity:
95%

Supply Reliability:
92%

Overall:
91%

This should be used primarily for support and incentives, not arbitrary punishment.

54. Data Model

Core entities:

Farmer
FarmerFinancialAccount
FarmerLedger
Settlement
SettlementItem
AnimalValuation
PriceTable
PriceVersion
QualityAssessment
Bonus
Penalty
Deduction
DeductionRule
FarmerAdvance
InputCredit
Payment
PaymentMethod
PaymentAccount
PaymentReconciliation
SettlementAdjustment
SettlementDispute
DisputeEvidence
FarmerStatement
Approval
AuditLog
55. Core Relationships
FARMER
  │
  ├───────────────┐
  ▼               ▼
FARMER ACCOUNT   FARMER LEDGER
                      │
                      ├── ADVANCES
                      ├── INPUT CREDIT
                      ├── DEDUCTIONS
                      └── SETTLEMENTS
                               │
                               ▼
                         SETTLEMENT
                               │
                  ┌────────────┼───────────┐
                  ▼            ▼           ▼
              ANIMALS       BONUSES     PENALTIES
                  │
                  ▼
             VALUATION
                  │
                  ▼
               PAYMENT
                  │
                  ▼
            RECONCILIATION
56. Key Business Rules
BR-FPS-001

Every settlement must have a unique settlement ID.

BR-FPS-002

A settlement must reference one or more eligible animal deliveries.

BR-FPS-003

Only authorized price versions may be used.

BR-FPS-004

Historical settlements must retain their original pricing information.

BR-FPS-005

A settlement cannot be paid before approval.

BR-FPS-006

A paid settlement cannot be deleted.

BR-FPS-007

Settlement amendments must create adjustment records.

BR-FPS-008

The same settlement cannot be paid twice.

BR-FPS-009

All deductions must have an identifiable source.

BR-FPS-010

Farmer disputes must not delete the original settlement.

BR-FPS-011

Financial transactions must be auditable.

BR-FPS-012

Payment credentials must be protected.

BR-FPS-013

Only authorized users may approve settlements.

BR-FPS-014

A failed payment must remain unpaid until successfully reprocessed.

BR-FPS-015

Payment reconciliation must be independent of settlement calculation.

BR-FPS-016

A farmer's payment history must remain accessible even after the farmer becomes inactive.

57. Security Requirements

Financial data is highly sensitive.

The module shall implement:

Role-based access control
Encryption in transit
Encryption at rest where supported
Strong authentication
Audit logs
Approval workflows
Payment-account protection
Session management
Access logging
58. Fraud Prevention

Potential fraud scenarios include:

Fake Farmer

Mitigation:

Verified Farmer ID
+
Identity verification
+
Approved farmer account
Duplicate Animal

Mitigation:

Unique Animal ID
+
Traceability
Manipulated Weight

Mitigation:

Authorized scale
+
Digital weighing record
+
Audit trail
Unauthorized Deduction

Mitigation:

Deduction source
+
Approval
+
Audit trail
Duplicate Payment

Mitigation:

Unique Settlement ID
+
Payment status
+
Idempotency controls
Payment Account Manipulation

Mitigation:

Account verification
+
Change approval
+
Audit trail
59. Technology Architecture

The module should follow a layered architecture:

Flutter Mobile Application
          │
          ▼
     API Layer
          │
          ▼
 Business Logic Layer
          │
    ┌─────┼────────┐
    ▼     ▼        ▼
Settlement Pricing Ledger
    │     │        │
    └─────┼────────┘
          ▼
       Database
          │
          ▼
 Finance / Payment Integration
60. Offline Capability

Because PigPower will operate in rural Lesotho, connectivity cannot be assumed.

The farmer application should support offline access to:

Previous settlement statements
Farmer balance
Recent transactions
Payment history
Delivery records

When connectivity returns:

OFFLINE
  ↓
Local Database
  ↓
Synchronization Queue
  ↓
API
  ↓
Server Database

This is an important requirement for the eventual Flutter application.

61. Notifications

The system shall notify farmers when:

Settlement is calculated
Settlement requires review
Settlement is approved
Payment is initiated
Payment succeeds
Payment fails
Dispute is received
Dispute is resolved
Deduction is applied
62. Audit Trail

Every critical financial event shall record:

Who
What
When
Before
After
Why
Reference

Example:

USER:
Finance Officer

ACTION:
Approved Settlement

SETTLEMENT:
SET-2027-00152

AMOUNT:
M26,196

DATE:
12 Aug 2027

IP/DEVICE:
Recorded
63. MVP Scope

For the first version of PigPower, I recommend implementing:

1. Farmer Financial Account
2. Settlement Calculation
3. Price Tables
4. Animal Valuation
5. Bonuses
6. Penalties
7. Input Deductions
8. Farmer Advances
9. Settlement Approval
10. Payment Recording
11. Farmer Statements
12. Payment History
13. Settlement Disputes
14. Basic Reconciliation
15. Audit Trail
16. Farmer Payment Notifications
64. Phase 2

Later releases can introduce:

→ Automated bank integration
→ Mobile money integration
→ Advanced incentive engine
→ AI settlement anomaly detection
→ Farmer profitability analytics
→ Automated payment batching
→ Real-time payment reconciliation
→ Financial forecasting
→ Advanced credit scoring
→ Farmer financial health scoring
65. Acceptance Criteria

The module shall be considered complete when:

Settlement
 System calculates farmer settlement.
 Settlement references actual animal deliveries.
 Correct price version is retained.
 Bonuses and penalties can be applied.
 Deductions can be applied.
 Net amount is calculated automatically.
Approval
 Settlement requires authorization.
 Unauthorized users cannot approve payments.
 Approval is recorded in audit logs.
Payment
 Payment can be recorded.
 Duplicate payments are prevented.
 Failed payments can be reprocessed.
 Payment references are recorded.
 Payment can be reconciled.
Farmer Experience
 Farmer can view settlement.
 Farmer can view deductions.
 Farmer can view payment history.
 Farmer can submit disputes.
 Farmer receives payment notifications.
Audit
 Settlement changes are recorded.
 Payment changes are recorded.
 Deduction changes are recorded.
 Dispute history is retained.
66. Strategic Importance to PigPower

This module is more important than simply "paying farmers."

It creates the economic feedback mechanism of the PigPower platform.

The complete loop becomes:

PIGPOWER PROVIDES
       │
       ├── Piglets
       ├── Feed
       ├── Veterinary Support
       └── Training
              │
              ▼
        FARMER PRODUCES
              │
              ▼
        PIGPOWER COLLECTS
              │
              ▼
        WEIGH + GRADE
              │
              ▼
       CALCULATE VALUE
              │
              ▼
      DEDUCT APPROVED INPUTS
              │
              ▼
        PAY FARMER
              │
              ▼
      FARMER EARNS INCOME
              │
              ▼
       REINVESTS / EXPANDS
              │
              ▼
       MORE PRODUCTION
              │
              ▼
      MORE PIGPOWER SUPPLY

This is central to the community-based contract farming model.

67. Link to the BEDCO Business Case

The module also gives PigPower measurable evidence for several of the project's impact claims.

For example, management will eventually be able to report:

Metric	System Source
Total farmers paid	Farmer Payments
Total farmer income	Settlements
Average farmer income	Settlements
Youth farmer earnings	Farmer + Settlement
Women farmer earnings	Farmer + Settlement
Total pigs supplied	Collection
Total pork supplied	Processing
Average price/kg	Settlement
Input costs recovered	Farmer Ledger
Farmer profitability	Production + Settlement
Payment turnaround time	Settlement + Payment

That means the app isn't simply an operational tool—it becomes the evidence infrastructure supporting PigPower's BEDCO, investor and development-finance reporting.

Recommended next module

With the modules we have now specified, our architecture is becoming:

AUTHENTICATION
      │
      ▼
USER MANAGEMENT
      │
      ├───────────────┐
      ▼               ▼
FARMER MANAGEMENT   CUSTOMER/CRM
      │               │
      ▼               ▼
FARM MANAGEMENT     SALES
      │               │
      ▼               ▼
PIG MANAGEMENT    ORDERS
      │               │
      ▼               ▼
PRODUCTION       INVENTORY
      │               │
      ▼               │
VETERINARY          │
      │               │
      ▼               ▼
FEED MANAGEMENT → COLLECTION & LOGISTICS
                      │
                      ▼
                 PROCESSING
                      │
                      ▼
                 INVENTORY
                      │
                      ▼
                    SALES
                      │
          ┌───────────┴───────────┐
          ▼                       ▼
      CUSTOMER                FARMER
          │                       │
          ▼                       ▼
        CRM              PAYMENTS & SETTLEMENT
                                  │
                                  ▼
                               FINANCE
