PigPower SmartFarm Platform
Functional Requirements Specification
Module: Sales & Order Management

Document ID: PSP-SRS-FR-SOM
Version: 1.0
Status: Draft
Parent Document: Software Requirements Specification
Chapter: 4 – Functional Requirements
Project: PigPower Lesotho – Community-Based Circular Pork Economy Platform

1. Module Overview

The Sales & Order Management Module shall manage the complete commercial sales lifecycle of PigPower's products and services.

The module shall support the process:

Product Availability → Customer → Quotation/Order → Stock Reservation → Order Confirmation → Picking → Dispatch → Delivery → Invoice → Payment → Settlement → Reporting

The module will primarily support sales of:

Fresh pork
Sausages
Bacon
Ham
Smoked pork
Other processed pork products
By-products where commercially applicable
Organic fertilizer
Other future PigPower products

The module must integrate directly with:

Inventory Management
Processing & Meat Production
Farmer Management
Farm Management
Collection & Logistics
Customer Management
Finance & Accounting
Payment Management
Traceability
Notification services
2. Business Purpose

PigPower is not only a pork production company. It is intended to become a national pork aggregation and commercialization platform.

The sales system must therefore support multiple customer segments rather than a simple retail checkout.

Potential customers include:

B2B
Supermarkets
Butcheries
Restaurants
Hotels
Caterers
Schools
Hospitals
Food processors
Wholesalers
Distributors
B2C
Individual consumers
Households
Farmers
Community buyers
Institutional
Government institutions
NGOs
Development organizations
Large procurement programs
Regional

Potential future customers in:

South Africa
Botswana
Eswatini
Other SADC markets
3. Business Objectives

The module shall enable PigPower to:

Increase pork sales.
Establish predictable customer demand.
Reduce product wastage.
Improve order fulfillment.
Maintain accurate product availability.
Improve customer experience.
Enable recurring B2B orders.
Improve revenue forecasting.
Integrate sales with inventory.
Provide traceability from customer back to production.
Support digital payments.
Generate reliable sales data.
Support future regional expansion.
4. Sales Channels

The platform shall support multiple sales channels.

4.1 Direct Sales

PigPower staff create orders for customers.

Customer
   ↓
Sales Agent
   ↓
Order
   ↓
Processing
4.2 Mobile Application

Customers may eventually order through a mobile application.

Customer App
      ↓
Browse Products
      ↓
Add to Cart
      ↓
Checkout
      ↓
Payment
      ↓
Delivery
4.3 B2B Portal

Business customers shall eventually have dedicated accounts.

They can:

View contracted prices
View product availability
Place bulk orders
Schedule deliveries
View invoices
View previous orders
Track deliveries
4.4 Sales Agent Portal

Sales representatives can:

Register customers
Create orders
Manage quotations
Record customer interactions
Monitor sales targets
Track outstanding orders
5. Customer Types

The system shall support configurable customer classifications.

INDIVIDUAL
RETAILER
BUTCHERY
RESTAURANT
HOTEL
CATERER
WHOLESALER
DISTRIBUTOR
INSTITUTION
PROCESSOR
EXPORTER
6. Customer Account

Each customer shall have a unique customer ID.

Example:

CUS-000124

Customer profile fields should include:

Customer ID
Customer name
Customer type
Contact person
Phone
Email
Physical address
Delivery address
Tax information where applicable
Payment terms
Credit limit
Customer status
Assigned sales representative
7. Customer Status

Customer accounts shall support:

PROSPECT
ACTIVE
INACTIVE
SUSPENDED
BLOCKED

A blocked customer shall not be able to place new orders unless authorized.

8. Product Catalogue

The Sales Module shall retrieve products from the Product/Inventory system.

Example:

Product	Unit	Available
Fresh Pork Leg	kg	350
Pork Sausage	kg	180
Bacon	kg	120
Smoked Pork	kg	90
Ham	kg	75

The sales system must not maintain an independent stock quantity.

Inventory Management remains the authoritative source for stock.

9. Product Pricing

The system shall support configurable pricing.

Pricing can depend on:

Product
Customer type
Quantity
Location
Contract
Sales channel
Promotional campaign
Season
Delivery requirement

Example:

Retail Price:
M95/kg

Wholesale:
M82/kg

Contract Customer:
M78/kg
10. Price Lists

The system shall support multiple price lists.

Example:

RETAIL
WHOLESALE
RESTAURANT
HOTEL
DISTRIBUTOR
EXPORT
PROMOTIONAL

A customer may be assigned a default price list.

11. Quotations
FR-SOM-001 — Create Quotation

Sales staff shall be able to create quotations.

Quotation information shall include:

Quotation number
Customer
Products
Quantity
Unit price
Discounts
Tax where applicable
Delivery charge
Total
Validity period
Terms and conditions
12. Quotation Status
DRAFT
SENT
VIEWED
ACCEPTED
REJECTED
EXPIRED
CONVERTED
CANCELLED

An accepted quotation may be converted into a sales order.

13. Sales Order
FR-SOM-002 — Create Sales Order

A sales order shall contain:

Order ID
Customer
Order date
Products
Quantity
Price
Discount
Delivery address
Delivery date
Payment method
Payment terms
Sales channel
Sales representative
Order status
14. Sales Order Number

Every order shall have a unique identifier.

Example:

SO-2026-000184
15. Order Status

The system shall support:

DRAFT
PENDING_APPROVAL
CONFIRMED
PARTIALLY_FULFILLED
READY_FOR_PICKING
PICKED
DISPATCHED
DELIVERED
COMPLETED
CANCELLED
ON_HOLD
16. Order Validation

Before confirming an order, the system shall validate:

Customer status
Product availability
Quantity
Price
Payment terms
Credit status
Delivery requirements
17. Inventory Availability

When a customer places an order:

Customer Order
      ↓
Inventory Check
      ↓
Available?
   ↙       ↘
 YES       NO
 ↓          ↓
Reserve    Backorder/
Stock      Alternative

The system shall not allow normal fulfillment beyond available stock.

18. Stock Reservation

Once an order is confirmed, inventory may be reserved.

Example:

Available Stock:
1,000 kg

Customer Order:
300 kg

Reserved:
300 kg

Remaining Available:
700 kg

This directly integrates with the Inventory & Warehouse Management Module.

19. Partial Fulfillment

If only part of an order is available:

Order:
500 kg

Available:
350 kg

The system shall support:

Option A

Deliver 350 kg and backorder 150 kg.

Option B

Offer alternative products.

Option C

Allow customer to modify the order.

20. Backorders

The system shall support backorders.

Example:

SO-000184

Requested:
500 kg

Available:
350 kg

Backorder:
150 kg

The system shall notify relevant users when stock becomes available.

21. Order Modification

Orders may be modified only according to their status.

For example:

DRAFT → freely editable

CONFIRMED → restricted

PICKED → cannot normally be modified

DISPATCHED → cannot be modified

Changes after confirmation may require authorization.

22. Order Cancellation

Authorized users shall be able to cancel orders.

Cancellation reasons:

Customer request
Stock unavailable
Payment failure
Production issue
Logistics issue
Customer credit issue
Other approved reason

If stock was reserved, cancellation shall release the reservation.

23. Picking
FR-SOM-003 — Generate Picking List

When an order becomes ready for fulfillment, the system shall generate a picking list.

Example:

PICKING LIST
SO-2026-000184

Fresh Pork:
50 kg

Sausage:
20 kg

Bacon:
10 kg

Destination:
Customer CUS-00124
24. Batch Selection

For traceability-controlled products, the picking process shall identify the specific batch.

The system should support FEFO where applicable.

Example:

BATCH A
Expiry: 15 Aug

BATCH B
Expiry: 21 Aug

→ Select BATCH A first
25. Quality Verification

Before dispatch, the system may require verification of:

Product quantity
Product quality
Packaging
Label
Batch
Expiry date
Temperature
Order accuracy
26. Dispatch
FR-SOM-004 — Dispatch Order

When the order leaves the warehouse:

Order
 ↓
Picked
 ↓
Verified
 ↓
Dispatched
 ↓
Delivery

The system shall record:

Dispatch time
Warehouse
Driver
Vehicle
Delivery reference
Products
Quantity
Batch
27. Logistics Integration

Sales shall integrate with Collection & Logistics Management.

Sales Order
     ↓
Delivery Request
     ↓
Route Planning
     ↓
Vehicle Assignment
     ↓
Dispatch
     ↓
GPS/Delivery Tracking
     ↓
Proof of Delivery
28. Delivery Scheduling

Customers may specify:

Preferred delivery date
Delivery time window
Delivery location
Special instructions

The logistics module shall determine final delivery feasibility.

29. Delivery Tracking

Where GPS functionality is available:

Order
 ↓
Dispatched
 ↓
Vehicle Location
 ↓
Estimated Arrival
 ↓
Delivered

Customers may receive delivery status notifications.

30. Proof of Delivery

The system shall support digital proof of delivery.

Possible methods:

Customer signature
OTP
QR scan
Photo
GPS coordinates
Timestamp

Example:

DELIVERY COMPLETED

Order:
SO-000184

Received by:
John M.

OTP:
******

Time:
14:35

GPS:
Recorded
31. Invoice Generation
FR-SOM-005 — Generate Invoice

After order confirmation or fulfillment according to the company's accounting policy, the system shall generate an invoice.

Invoice fields:

Invoice number
Customer
Order number
Products
Quantities
Unit prices
Discounts
Taxes where applicable
Delivery charges
Total
Payment terms
Due date
32. Payment Status

Orders shall support:

UNPAID
PARTIALLY_PAID
PAID
OVERDUE
REFUNDED
CANCELLED
33. Payment Integration

The platform should eventually support:

Cash
Bank transfer
Card
Mobile money
Online payment
Account credit

The exact payment providers should be determined during implementation based on availability in Lesotho.

34. Credit Sales

B2B customers may receive approved credit terms.

Example:

Customer:
ABC Supermarket

Credit Limit:
M50,000

Payment Terms:
30 Days

Current Outstanding:
M32,000

Available Credit:
M18,000

The system shall prevent unauthorized credit exposure.

35. Customer Credit Control

Before approving a credit order, the system should check:

Current Outstanding
+
New Order Value
≤
Credit Limit

If not:

CREDIT LIMIT EXCEEDED

The order may require management approval.

36. Discounts

The system shall support:

Percentage discount
Fixed discount
Volume discount
Customer-specific pricing
Promotional pricing

Discount authorization levels should be configurable.

37. Bulk Pricing

Example:

1–20 kg:
M95/kg

21–100 kg:
M88/kg

101+ kg:
M82/kg

This will be important for supermarkets, hotels, restaurants and distributors.

38. Recurring Orders

The system should support recurring B2B orders.

Example:

ABC Hotel

Every Monday:
100 kg pork
50 kg sausage

Every Thursday:
80 kg pork

The platform can automatically generate draft orders for approval.

39. Subscription-Like Supply Contracts

PigPower may eventually enter supply agreements.

Example:

Customer:
Hotel Group

Contract:
12 months

Minimum:
500 kg/week

Price:
M82/kg

Delivery:
Twice weekly

The system shall track contract commitments.

40. Demand Forecasting

Historical sales data shall be available for forecasting.

The system can eventually estimate:

Expected Demand
+
Current Inventory
+
Production Capacity
=
Required Production

This creates a direct feedback loop between Sales and Production.

41. Sales-to-Production Integration

This is strategically important.

The platform should enable:

CUSTOMER DEMAND
       ↓
SALES ORDERS
       ↓
DEMAND FORECAST
       ↓
PRODUCTION PLANNING
       ↓
PIG REQUIREMENT
       ↓
FARMER PRODUCTION
       ↓
PIG COLLECTION
       ↓
PROCESSING
       ↓
FINISHED PRODUCTS
       ↓
SALES

This transforms PigPower from a reactive meat business into a demand-driven agricultural platform.

42. Product Traceability

Every applicable pork product sold shall be traceable.

Example:

Customer Order
      ↓
Product
      ↓
Production Batch
      ↓
Processed Pig
      ↓
Pig
      ↓
Farm
      ↓
Farmer
      ↓
Production Cycle

The system should support QR-based traceability.

43. Customer QR Traceability

A future customer may scan a QR code on a product and receive information such as:

PigPower Lesotho

Product:
Premium Pork Sausage

Production Batch:
PB-2026-00821

Processed:
12 Aug 2026

Origin:
Participating PigPower Farm

Quality:
Approved

Traceability:
Verified

Sensitive farmer information should not be exposed.

44. Returns
FR-SOM-006 — Manage Sales Returns

The system shall support customer returns.

Reasons:

Damaged product
Wrong product
Quality complaint
Incorrect quantity
Delivery error
Temperature issue

Returned stock shall be integrated with Inventory Management.

45. Refunds

Where applicable, the system shall support:

Full refund
Partial refund
Credit note
Replacement product

Refund authorization shall be role controlled.

46. Customer Complaints

Sales shall integrate with Customer Management.

A customer may report:

Product quality issue
Late delivery
Missing product
Incorrect order
Packaging problem

Each complaint shall have a case/reference number.

47. Sales Representative Management

The system shall track sales representatives.

Each sales representative may have:

Assigned customers
Sales targets
Orders
Revenue
Commission where applicable
48. Sales Targets

Managers shall be able to establish:

Monthly sales targets
Product targets
Customer targets
Regional targets
Sales representative targets

Example:

August Target:
M500,000

Actual:
M420,000

Achievement:
84%
49. Sales Dashboard

The dashboard shall display:

SALES DASHBOARD

Today's Sales
M45,200

Monthly Sales
M820,000

Orders
128

Pending
24

Delivered
91

Outstanding
13

Top Product
Pork Sausage

Top Customer
ABC Supermarket
50. Management Analytics

The system shall provide:

Revenue by product
Revenue by customer
Revenue by region
Revenue by sales channel
Revenue by sales representative
Average order value
Order fulfillment rate
Customer retention
Product return rate
Gross margin
Sales growth
51. Key Performance Indicators
KPI	Description
Total Sales Revenue	Total sales value
Sales Growth	Period-over-period growth
Number of Orders	Sales volume
Average Order Value	Revenue/order
Order Fulfillment Rate	Orders successfully fulfilled
On-Time Delivery	Delivery reliability
Product Return Rate	Product quality/service
Customer Retention	Repeat customers
Gross Margin	Sales profitability
Revenue per Customer	Customer value
B2B Revenue Share	Commercial penetration
Retail Revenue Share	Consumer penetration
Backorder Rate	Supply constraint
Cancellation Rate	Order reliability
Days Sales Outstanding	Credit efficiency
52. Business Rules
BR-SOM-001

Every sales order shall have a unique identifier.

BR-SOM-002

An order must belong to a valid customer.

BR-SOM-003

Blocked customers cannot place normal orders.

BR-SOM-004

An order cannot be confirmed without valid product and pricing information.

BR-SOM-005

Inventory availability must be checked before order confirmation.

BR-SOM-006

Reserved inventory cannot be allocated to another order unless released.

BR-SOM-007

Dispatched orders cannot normally be modified.

BR-SOM-008

Cancelled orders must release their inventory reservations.

BR-SOM-009

Credit orders must comply with approved credit limits.

BR-SOM-010

Discounts above configured limits require authorization.

BR-SOM-011

Traceable products must retain batch information throughout fulfillment.

BR-SOM-012

Every completed delivery must have a delivery confirmation.

BR-SOM-013

Sales transactions must maintain an audit trail.

BR-SOM-014

Returned products must be assessed before being returned to sellable inventory.

BR-SOM-015

Financial transactions should not be physically deleted after posting.

53. Database Entities

The conceptual database should include:

Customer
CustomerAddress
CustomerContact
CustomerType
CustomerCreditAccount

Product
PriceList
PriceListItem

Quotation
QuotationItem

SalesOrder
SalesOrderItem

OrderStatus
OrderStatusHistory

StockReservation

PickingList
PickingListItem

Dispatch
DispatchItem

Delivery
DeliveryItem
ProofOfDelivery

Invoice
InvoiceItem

Payment
PaymentAllocation

CreditNote
Refund

SalesReturn
SalesReturnItem

SalesContract
SalesContractItem

SalesRepresentative
SalesTarget

DiscountRule
Promotion

SalesChannel

CustomerComplaint
54. Core Database Relationship

The central relationship should be:

CUSTOMER
   │
   ▼
QUOTATION
   │
   ▼
SALES ORDER
   │
   ├───────────────┐
   ▼               ▼
STOCK           PAYMENT
RESERVATION
   │
   ▼
PICKING
   │
   ▼
DISPATCH
   │
   ▼
DELIVERY
   │
   ▼
INVOICE
   │
   ▼
PAYMENT
55. Integration Architecture

Sales should sit between the commercial side and the operational side of PigPower.

                    CUSTOMER
                       │
                       ▼
                SALES & ORDERS
                       │
          ┌────────────┼────────────┐
          ▼            ▼            ▼
     INVENTORY     PAYMENTS     LOGISTICS
          │
          ▼
      PROCESSING
          │
          ▼
       PRODUCTION
          │
          ▼
       COLLECTION
          │
          ▼
         FARMS
          │
          ▼
        FARMERS

This is one of the most important architectural relationships in the entire platform.

56. Offline Considerations

Sales agents operating in rural areas may encounter poor connectivity.

The mobile application should therefore support offline capabilities for selected operations:

Customer lookup
Product catalogue
Draft order creation
Customer registration
Order capture

When connectivity returns:

Local Order
    ↓
Synchronization Queue
    ↓
API
    ↓
Server
    ↓
Order Confirmation

However, real-time inventory reservation should require server confirmation where possible to prevent two sales agents from selling the same stock.

57. Security Requirements

The system shall implement role-based access.

Example:

Function	Sales Agent	Sales Manager	Finance	Admin
Create Customer	✓	✓	Limited	✓
Create Order	✓	✓	No	✓
Approve Discount	Limited	✓	No	✓
View Revenue	Limited	✓	✓	✓
Issue Refund	No	Limited	✓	✓
Modify Price	No	✓	✓	✓
Cancel Order	Limited	✓	Limited	✓
58. Audit Trail

The system shall record:

User
Date/time
Order
Action
Previous value
New value
Device
Authorization

Example:

ORDER:
SO-2026-000184

Action:
PRICE CHANGE

Previous:
M95/kg

New:
M88/kg

Reason:
Approved wholesale discount

Approved by:
Sales Manager

Timestamp:
12 Aug 2026 10:42
59. MVP Scope

For the first production version, I recommend implementing:

1. Customer Management
2. Product Catalogue
3. Price Lists
4. Sales Orders
5. Order Items
6. Inventory Availability
7. Stock Reservation
8. Picking Lists
9. Dispatch
10. Delivery Status
11. Basic Invoice Generation
12. Payment Recording
13. Sales Dashboard
14. Customer Order History
15. Basic Reports
16. Role-Based Access
17. Audit Trail
Phase 2
→ B2B Customer Portal
→ Recurring Orders
→ Supply Contracts
→ Credit Management
→ Mobile Payments
→ Digital Proof of Delivery
→ QR Product Traceability
→ Customer Loyalty
→ Sales Forecasting
→ AI Demand Forecasting
→ Advanced CRM
60. Acceptance Criteria

The module shall be considered functionally complete when:

Customers
 Customers can be created.
 Customer types can be assigned.
 Customer addresses can be stored.
 Customer status can be managed.
Products
 Products can be displayed.
 Prices can be assigned.
 Price lists can be managed.
 Product availability can be retrieved from inventory.
Orders
 Orders can be created.
 Orders can be modified before confirmation.
 Orders can be confirmed.
 Orders can be cancelled.
 Orders can be partially fulfilled.
 Orders can be tracked.
Inventory
 Stock availability is checked.
 Stock can be reserved.
 Reservations can be released.
 Picking lists can be generated.
Delivery
 Orders can be dispatched.
 Delivery status can be updated.
 Proof of delivery can be recorded.
Financial
 Invoices can be generated.
 Payments can be recorded.
 Outstanding balances can be displayed.
Analytics
 Revenue can be reported.
 Orders can be analyzed.
 Customer performance can be analyzed.
 Product performance can be analyzed.
61. Strategic Importance to PigPower

This module is more than an e-commerce component.

It creates the demand signal that drives the entire PigPower agricultural value chain.

The strategic data flow becomes:

                 CUSTOMER DEMAND
                       │
                       ▼
                  SALES ORDERS
                       │
                       ▼
                DEMAND FORECAST
                       │
                       ▼
              PRODUCTION PLANNING
                       │
                       ▼
               PIG REQUIREMENTS
                       │
                       ▼
                 FARM NETWORK
                       │
                       ▼
                  PIG GROWTH
                       │
                       ▼
                 COLLECTION
                       │
                       ▼
                  PROCESSING
                       │
                       ▼
              FINISHED INVENTORY
                       │
                       ▼
                     SALES
                       │
                       └───────────┐
                                   │
                                   ▼
                              CUSTOMER DATA
                                   │
                                   ▼
                            BETTER FORECASTS

That feedback loop is one of the core differentiators of PigPower as an agri-tech platform.

62. Recommended next module

With Authentication → User Management → Farmer Management → Farm Management → Pig Management → Production Management → Veterinary Management → Feed Management → Collection & Logistics → Processing & Meat Production → Inventory → Sales & Order Management, we now have most of the core physical pork value chain specified