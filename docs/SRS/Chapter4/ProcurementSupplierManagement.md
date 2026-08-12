PigPower SmartFarm Platform
Functional Requirements Specification
Module: Procurement & Supplier Management

Document ID: PSP-SRS-FR-PSM
Version: 1.0
Status: Draft
Parent Document: Software Requirements Specification
Chapter: 4 – Functional Requirements
Project: PigPower Lesotho – Community-Based Circular Pork Economy Platform

1. Module Overview

The Procurement & Supplier Management Module will manage the acquisition of goods and services required throughout the PigPower value chain.

The module will control the procurement lifecycle from identification of a requirement through:

Requirement
    ↓
Purchase Requisition
    ↓
Supplier Selection
    ↓
Quotation
    ↓
Purchase Order
    ↓
Goods/Services Received
    ↓
Inspection & Verification
    ↓
Supplier Invoice
    ↓
Finance Approval
    ↓
Payment

The module will integrate closely with:

Inventory & Warehouse Management
Feed Management
Veterinary Management
Farmer Management
Pig Management
Processing Management
Logistics Management
Renewable Energy Management
Finance & Accounting
User Management
2. Business Purpose

PigPower will operate a distributed agricultural network.

As the farmer network expands toward the five-year target of 500 farmers, procurement will become a major cost and operational-control function.

The platform must therefore prevent a situation where procurement is handled through:

WhatsApp messages
spreadsheets
paper quotations
uncontrolled supplier lists
informal purchasing
undocumented cash purchases

Instead, procurement should become a controlled digital process.

The system should allow PigPower management to answer:

What do we need, who supplied it, how much did we pay, who approved it, when was it received, and where was it consumed?

3. Business Objectives

The module shall enable PigPower to:

Centralize supplier information.
Standardize procurement processes.
Reduce procurement costs.
Improve supplier competition.
Prevent unauthorized purchases.
Track supplier performance.
Improve purchasing transparency.
Reduce stock-outs.
Integrate procurement with inventory.
Integrate procurement with finance.
Support bulk purchasing.
Improve farmer-support procurement.
Track procurement budgets.
Maintain an auditable procurement trail.
Support BEDCO and investor reporting.
Identify procurement fraud and irregularities.
Support long-term supplier contracts.
Enable data-driven supplier selection.
4. Procurement Scope

The system shall support procurement for:

Agricultural inputs
Piglets
Feed
Feed additives
Veterinary medicines
Vaccines
Disinfectants
Farm equipment
Farm tools
Processing
Packaging materials
Processing consumables
Cleaning chemicals
PPE
Labels
Spare parts
Logistics
Fuel
Vehicle parts
Tyres
Maintenance services
Refrigeration equipment
Renewable energy
Solar equipment
Batteries
Inverters
Biodigester components
Pumps
Electrical components
Maintenance services
Corporate operations
Computers
Office supplies
Internet services
Professional services
Insurance
Marketing services
5. Procurement Categories

The system shall classify purchases.

Recommended categories:

PROC-01 Livestock
PROC-02 Feed
PROC-03 Veterinary
PROC-04 Farm Equipment
PROC-05 Processing
PROC-06 Packaging
PROC-07 Logistics
PROC-08 Fuel
PROC-09 Renewable Energy
PROC-10 ICT
PROC-11 Office
PROC-12 Professional Services
PROC-13 Construction
PROC-14 Maintenance
PROC-15 Other

This classification will later support procurement analytics.

6. Supplier Management

Every supplier shall have a digital supplier profile.

A supplier record should contain:

Supplier ID
Business Name
Trading Name
Supplier Type
Contact Person
Phone
Email
Physical Address
Postal Address
District
Bank Details
Tax Information
Registration Information
Product Categories
Status
Risk Rating
Payment Terms
Credit Terms
Contract Status
7. Supplier Types

The system should support supplier classification.

Examples:

Feed Supplier
Piglet Supplier
Veterinary Supplier
Equipment Supplier
Transport Provider
Fuel Supplier
Packaging Supplier
Energy Supplier
Professional Services
Construction Contractor
8. Supplier Status

Possible statuses:

Prospective
Under Review
Approved
Active
Suspended
Blacklisted
Inactive

A supplier must be Approved before being used for controlled procurement.

9. Supplier Onboarding

Supplier onboarding shall follow:

Supplier Application
        ↓
Document Verification
        ↓
Supplier Evaluation
        ↓
Approval
        ↓
Supplier Activation

Required documentation may include:

Business registration
Tax documentation
Banking information
Relevant licences
Product certifications
Contact information
References where applicable

The exact documentation should depend on supplier category.

10. Supplier Due Diligence

The platform should allow procurement officers to record:

Registration verification
Tax compliance verification
References
Product quality
Financial reliability
Delivery history
Regulatory compliance

High-risk suppliers should require additional approval.

11. Supplier Risk Rating

Suppliers may be classified:

LOW
MEDIUM
HIGH
CRITICAL

Risk factors may include:

Poor delivery history
Quality problems
Excessive price volatility
Regulatory concerns
Payment disputes
Incomplete documentation
Dependence on a single supplier
12. Supplier Performance Score

The platform shall calculate supplier performance based on:

Quality
Delivery
Price
Reliability
Responsiveness
Compliance

An example weighted score:

Metric	Weight
Quality	30%
Delivery	25%
Price	20%
Reliability	15%
Compliance	10%

The weights should remain configurable.

13. Supplier Performance Example
Supplier: ABC Feeds

Quality       90%
Delivery      85%
Price         80%
Reliability   92%
Compliance    100%

Overall Score: 88.6%

Management can use this to determine preferred suppliers.

14. Purchase Requisition

Procurement shall begin with a Purchase Requisition (PR).

A requisition shall contain:

PR Number
Requesting Department
Requester
Date
Required Date
Items
Quantity
Estimated Cost
Cost Centre
Purpose
Priority
Budget
Supporting Documents
Approval Status
15. Requisition Example
PR-2027-00231

Department:
Farmer Network

Requirement:
Pig feed

Quantity:
5,000 kg

Estimated Value:
M75,000

Required:
15 September 2027

Purpose:
Farmer production support
16. Procurement Priority

The system should support:

Low
Normal
High
Urgent
Emergency

Emergency procurement should require an explicit justification.

17. Budget Validation

Before a requisition is approved, the system should check:

Requested Amount
        ↓
Available Budget

If the purchase exceeds the budget:

Budget Exception
        ↓
Management Approval
18. Approval Workflow

The workflow should be configurable according to transaction value.

Example:

M0 – M10,000
Department Manager

M10,001 – M50,000
Procurement Manager

M50,001 – M250,000
Finance + Senior Management

> M250,000
Executive Approval

These thresholds should be configurable rather than hard-coded.

19. Segregation of Duties

The system shall prevent one person from controlling the entire procurement process.

For example:

Requester
   ≠
Approver
   ≠
Receiver
   ≠
Payment Approver

This is an important internal-control mechanism.

20. Request for Quotation

For applicable purchases, procurement officers shall be able to create an RFQ.

The RFQ shall include:

RFQ number
Description
Quantity
Specifications
Required delivery date
Delivery location
Response deadline
Supplier list
21. Supplier Quotation

Suppliers shall be associated with quotations.

Quotation information:

Supplier
Quotation Number
Date
Validity
Items
Unit Price
Quantity
Discount
Tax
Delivery Cost
Total
Delivery Time
Payment Terms
22. Quotation Comparison

The system should provide a quotation comparison interface.

Example:

Supplier	Price	Delivery	Quality	Terms
Supplier A	M72,000	5 days	High	30 days
Supplier B	M68,000	10 days	Medium	COD
Supplier C	M75,000	3 days	High	30 days

The cheapest quotation should not automatically win.

Selection should consider total value.

23. Supplier Selection

The procurement officer shall record:

Selected supplier
Selection reason
Evaluation score
Approval
Supporting documentation

Example:

Supplier C selected because its higher quotation was offset by superior quality, shorter delivery time and 30-day payment terms.

This creates an audit trail.

24. Purchase Order

An approved purchase shall generate a Purchase Order.

The PO shall contain:

PO Number
Supplier
Date
Items
Quantity
Unit Price
Discount
Tax
Total
Delivery Location
Expected Delivery Date
Payment Terms
Special Conditions
Approvals
25. Purchase Order Lifecycle
Draft
 ↓
Submitted
 ↓
Approved
 ↓
Sent to Supplier
 ↓
Acknowledged
 ↓
Partially Received
 ↓
Fully Received
 ↓
Closed

Possible exception:

Cancelled
26. Purchase Order Modification

Approved POs should not be freely edited.

If a material change is required:

Change Request
      ↓
Approval
      ↓
PO Revision

The system should preserve previous versions.

27. Goods Received Note

When goods arrive, the receiving team shall create a GRN.

The GRN should capture:

GRN number
PO number
Supplier
Date
Items
Quantity ordered
Quantity received
Quantity rejected
Condition
Batch number
Expiry date
Receiver
Inspection status
28. Partial Deliveries

The system must support partial deliveries.

Example:

PO:
5,000 kg feed

Delivery 1:
2,000 kg

Delivery 2:
2,000 kg

Delivery 3:
1,000 kg

The PO remains open until fully received or formally closed.

29. Quality Inspection

Certain purchases require inspection.

Examples:

Feed
Medicines
Piglets
Packaging
Processing equipment

Inspection results may include:

Accepted
Accepted with Conditions
Rejected
30. Feed Procurement

Feed procurement requires additional data.

The system should record:

Feed Type
Manufacturer
Batch Number
Production Date
Expiry Date
Quantity
Nutritional Specification
Supplier
Price

This should integrate with Feed Management.

31. Veterinary Procurement

Veterinary procurement shall integrate with Veterinary Management.

Records may include:

Medicine
Vaccine
Batch
Expiry
Quantity
Dosage Category
Supplier
Storage Requirement

This is particularly important for traceability.

32. Piglet Procurement

Piglet sourcing should integrate with Pig Management.

The system should record:

Source farm
Breed
Quantity
Age
Weight
Health status
Vaccination status
Supplier
Price
Transport
Receiving farm

This allows PigPower to calculate the true landed cost of piglets.

33. Procurement of Services

Not all procurement involves physical goods.

The module shall support service procurement.

Examples:

Veterinary services
Transport
Equipment maintenance
Software development
Consulting
Security
Construction

Service purchases may use:

Service Order

rather than a conventional inventory-based PO.

34. Contract Management

The platform should support supplier contracts.

Contract fields:

Contract ID
Supplier
Start Date
End Date
Products/Services
Price
Volume
Payment Terms
Delivery Terms
Renewal Terms
Status
35. Framework Agreements

PigPower may negotiate long-term agreements for high-volume inputs.

Examples:

Feed
Packaging
Fuel
Veterinary supplies

The system should track agreed:

Unit prices
Minimum volumes
Maximum volumes
Contract period
Delivery schedules
36. Bulk Procurement

The system should support consolidated purchasing.

For example:

500 Farmers
     ↓
Individual Feed Requirements
     ↓
Aggregate Requirement
     ↓
20,000 kg Feed
     ↓
Bulk Supplier Negotiation

This is strategically important to PigPower because aggregation should create purchasing power.

37. Procurement Savings

The system should calculate savings.

Example:

Market Price:
M16/kg

Negotiated Price:
M13/kg

Volume:
20,000 kg

Savings:
M60,000

This KPI can demonstrate the economic value PigPower provides to farmers.

38. Inventory Integration

Once goods are received:

PO
 ↓
GRN
 ↓
Inventory

The inventory system should automatically update:

Quantity
Warehouse
Batch
Expiry
Stock value
39. Finance Integration

Once the supplier invoice is approved:

Supplier Invoice
       ↓
Finance
       ↓
Accounts Payable

This should link back to:

PO
+
GRN
+
Invoice
40. Three-Way Matching

The system should support:

Purchase Order
       +
Goods Received Note
       +
Supplier Invoice
       ↓
Three-Way Match

Example:

PO:
1,000 units

GRN:
1,000 units

Invoice:
1,000 units

Match = Valid

If invoice quantity is 1,200:

Exception = Requires investigation.

41. Procurement-to-Payment

The complete process becomes:

Need Identified
      ↓
Purchase Requisition
      ↓
Budget Check
      ↓
Approval
      ↓
RFQ
      ↓
Quotation
      ↓
Supplier Evaluation
      ↓
Purchase Order
      ↓
Goods Received
      ↓
Quality Inspection
      ↓
GRN
      ↓
Supplier Invoice
      ↓
3-Way Match
      ↓
Finance Approval
      ↓
Payment

This should be one of the major workflows in the system.

42. Supplier Invoice Integration

The module should not duplicate accounting logic.

Instead:

Procurement
     ↓
Supplier Invoice
     ↓
Finance & Accounting
     ↓
Accounts Payable

The Finance module remains responsible for the accounting entry.

43. Purchase Returns

The system shall support returning defective goods.

Workflow:

Goods Received
      ↓
Inspection
      ↓
Rejected
      ↓
Return to Supplier
      ↓
Supplier Credit Note

The inventory and finance records should be adjusted accordingly.

44. Supplier Credit Notes

The system shall support:

Credit notes
Debit notes
Quantity adjustments
Price adjustments
Returned goods

All adjustments must maintain an audit trail.

45. Supplier Payment Terms

Supplier profiles should support:

Cash on Delivery
7 Days
15 Days
30 Days
60 Days
90 Days
Custom

The system should use these terms to forecast cash requirements.

46. Procurement Forecasting

Procurement should be driven by operational forecasts.

For example:

Production Forecast
       ↓
Pig Population
       ↓
Feed Requirement
       ↓
Feed Forecast
       ↓
Procurement Requirement

Similarly:

Expected Processing Volume
       ↓
Packaging Requirement
       ↓
Packaging Procurement

This reduces emergency purchases.

47. Automatic Reorder Recommendations

The system should use inventory thresholds.

Example:

Feed Inventory

Current:
3,000 kg

Minimum:
5,000 kg

Status:
REORDER REQUIRED

The system may automatically create a purchase requisition recommendation.

48. Supplier Price History

The system shall retain historical prices.

Example:

Supplier	Product	Jan	Apr	Jul
Supplier A	Feed	M13	M14	M15
Supplier B	Feed	M14	M14	M14

This helps procurement identify inflation and negotiate better prices.

49. Price Variance

The system should flag unusual price changes.

Example:

Previous Price:
M13/kg

New Price:
M17/kg

Increase:
30.8%

Procurement management should receive an alert.

50. Supplier Concentration Risk

The platform should monitor dependency on individual suppliers.

Example:

Total Feed Procurement:
M5,000,000

Supplier A:
M4,000,000

Dependency:
80%

The system should flag this as a potential supply-chain risk.

51. Procurement Fraud Controls

The system should detect or flag:

Duplicate suppliers
Duplicate invoices
Duplicate POs
Unusual price increases
Purchases just below approval thresholds
Repeated emergency procurement
Self-approval
Supplier bank-account changes
Invoice/GRN mismatches
Excessive single-supplier concentration
52. Supplier Bank Account Changes

Changes to supplier banking information should require additional authorization.

Recommended workflow:

Change Requested
      ↓
Verification
      ↓
Independent Confirmation
      ↓
Approval
      ↓
Bank Details Updated

This protects against payment fraud.

53. Procurement Dashboard

Management dashboard should display:

Open Purchase Orders
Pending Approvals
Pending Deliveries
Outstanding Supplier Invoices
Procurement Spend
Budget Utilization
Supplier Performance
Procurement Savings
Emergency Purchases
Top Suppliers
54. Procurement KPIs

Key indicators should include:

Procurement Spend

Total value purchased.

Purchase Price Variance

Difference between expected and actual purchase prices.

Supplier On-Time Delivery
On-time deliveries ÷ Total deliveries × 100
Supplier Quality Rate
Accepted deliveries ÷ Total deliveries × 100
Procurement Cycle Time

Time between:

Requisition → PO
Order Fulfillment Rate

Percentage of orders fully supplied.

Procurement Savings

Difference between benchmark/previous price and negotiated price.

Emergency Procurement Rate

Percentage of purchases classified as emergency.

Supplier Concentration

Percentage of procurement dependent on major suppliers.

55. Farmer Procurement Economics

One of PigPower's strongest procurement advantages should be collective purchasing.

Instead of 500 farmers purchasing feed independently:

500 Farmers
     ↓
PigPower Aggregation
     ↓
Bulk Procurement
     ↓
Lower Unit Cost
     ↓
Farmer Savings

The system should therefore distinguish between:

Company procurement

and

Farmer-support procurement.

This distinction will be valuable when calculating the economic benefit delivered to participating farmers.

56. Circular Procurement

Procurement should eventually incorporate sustainability criteria.

Supplier evaluation can consider:

Local sourcing
Recyclable packaging
Energy efficiency
Renewable-energy compatibility
Waste reduction
Environmental compliance
Local employment

This supports PigPower's circular-economy positioning.

57. Local Supplier Development

The platform should support identifying Basotho suppliers where commercially viable.

For example:

Local Supplier
      ↓
Supplier Development
      ↓
PigPower Procurement
      ↓
Local Economic Multiplier

This contributes to PigPower's rural-development objectives.

58. Procurement Data Model

Core entities should include:

Supplier
SupplierContact
SupplierDocument
SupplierCategory
SupplierEvaluation
SupplierPerformance
SupplierContract

PurchaseRequisition
PurchaseRequisitionLine

RFQ
RFQSupplier
Quotation
QuotationLine
QuotationEvaluation

PurchaseOrder
PurchaseOrderLine
PurchaseOrderApproval
PurchaseOrderRevision

GoodsReceivedNote
GRNLine
QualityInspection

SupplierInvoice
PurchaseReturn
SupplierCreditNote

ProcurementBudget
ProcurementCategory
ProcurementApproval

ProcurementEvent
ProcurementAuditLog
59. Integration Architecture
                 FARMER NETWORK
                       │
                       ▼
                 REQUIREMENTS
                       │
                       ▼
               PROCUREMENT MODULE
                       │
       ┌───────────────┼────────────────┐
       ▼               ▼                ▼
   SUPPLIERS         RFQs              POs
       │               │                │
       └───────────────┼────────────────┘
                       ▼
                    RECEIVING
                       │
                       ▼
                   INVENTORY
                       │
                       ▼
                    FINANCE
                       │
                       ▼
                  PAYMENT
60. Procurement Event Architecture

Like the Finance module, procurement should use structured events.

Examples:

PURCHASE_REQUISITION_CREATED
PURCHASE_REQUISITION_APPROVED
RFQ_CREATED
QUOTATION_RECEIVED
SUPPLIER_SELECTED
PURCHASE_ORDER_CREATED
PURCHASE_ORDER_APPROVED
PURCHASE_ORDER_SENT
GOODS_RECEIVED
GOODS_REJECTED
GOODS_RETURNED
SUPPLIER_INVOICE_RECEIVED
SUPPLIER_INVOICE_APPROVED
PURCHASE_COMPLETED

These events will later make integration with Finance, Inventory and Analytics much cleaner.

61. Role-Based Access
Procurement Officer

Can:

Create requisitions
Manage suppliers
Create RFQs
Record quotations
Prepare POs
Procurement Manager

Can:

Approve procurement
Approve suppliers
Evaluate suppliers
Approve PO amendments
Warehouse Officer

Can:

Receive goods
Create GRNs
Record inspection results

Cannot:

Approve their own purchases.
Finance Officer

Can:

Verify supplier invoices
Perform financial matching
Process payments
Finance Manager

Can:

Approve payments
Review procurement expenditure
CEO/Executive

Can:

Approve high-value procurement
Review procurement analytics
Approve strategic contracts
62. Security Requirements

The system shall provide:

Role-based access
Authentication
Authorization
Audit logging
Approval controls
Supplier data protection
Secure document storage
Bank-account protection
Change tracking
63. Audit Requirements

The system must preserve the history of:

Supplier creation
Supplier modification
Supplier suspension
Price changes
Quotations
Supplier selection
PO creation
PO amendments
Goods receipt
Invoice approval
Payment authorization

No user should be able to silently modify historical procurement records.

64. Acceptance Criteria

The Procurement & Supplier Management Module shall be considered functionally complete when:

Supplier Management
 Suppliers can be registered.
 Supplier documents can be stored.
 Suppliers can be approved.
 Suppliers can be suspended.
 Supplier performance can be evaluated.
Procurement
 Purchase requisitions can be created.
 Requisitions can be approved.
 RFQs can be created.
 Supplier quotations can be recorded.
 Quotations can be compared.
 Purchase orders can be generated.
 Purchase orders can be approved.
 Purchase orders can be revised through controlled workflow.
Receiving
 Goods received can be recorded.
 Partial deliveries are supported.
 Quality inspection can be recorded.
 Rejected goods can be recorded.
 Returns can be processed.
Finance
 Supplier invoices can be linked to POs.
 Three-way matching is supported.
 Approved invoices integrate with Finance.
 Supplier payment status can be viewed.
Inventory
 Received goods update inventory.
 Batch information can be recorded.
 Expiry dates can be recorded.
 Procurement and inventory records remain linked.
Analytics
 Procurement expenditure can be reported.
 Supplier performance can be reported.
 Procurement savings can be calculated.
 Price trends can be analyzed.
 Supplier concentration can be monitored.
65. Strategic Importance to PigPower

Procurement is particularly important to the PigPower business model because feed is likely to become one of the largest recurring costs in the production network.

Therefore, the platform should eventually connect:

Pig Population
      ↓
Production Forecast
      ↓
Feed Requirement
      ↓
Inventory Level
      ↓
Procurement Requirement
      ↓
Bulk Supplier Negotiation
      ↓
Purchase
      ↓
Warehouse
      ↓
Farmer Distribution
      ↓
Farmer Production

That turns procurement from a basic purchasing function into a strategic supply-chain optimization system.

66. Recommended Future Intelligence Layer

Once enough historical data exists, PigPower can introduce predictive procurement.

For example:

"Based on current pig population, growth rates, feed consumption and projected farmer onboarding, approximately 38,500 kg of feed will be required over the next 30 days."

The system can then compare this against:

Current Inventory
+
Open Purchase Orders
-
Forecast Consumption
=
Projected Shortfall

This can automatically recommend procurement.

That is where the Agri-Tech component becomes commercially meaningful rather than simply putting paper procurement processes into an app.

67. Position in the Overall Architecture

At this point our core architecture is becoming:

                         PIGPOWER PLATFORM
                                │
       ┌────────────────────────┼────────────────────────┐
       │                        │                        │
       ▼                        ▼                        ▼
   FARMER/FARM              PRODUCTION              PROCESSING
       │                        │                        │
       └────────────────────────┼────────────────────────┘
                                │
                                ▼
                         SUPPLY CHAIN
                                │
                  ┌─────────────┼─────────────┐
                  ▼             ▼             ▼
             PROCUREMENT    INVENTORY      LOGISTICS
                  │             │             │
                  └─────────────┼─────────────┘
                                ▼
                              SALES
                                │
                                ▼
                         FINANCE & ACCOUNTING
                                │
                                ▼
                         ANALYTICS & BI

This is a good point in the SRS to recognize that Procurement, Inventory, Finance, Sales and Farmer Payments form one integrated financial/supply-chain subsystem.

