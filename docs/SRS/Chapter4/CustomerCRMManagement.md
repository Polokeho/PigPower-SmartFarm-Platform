PigPower SmartFarm Platform
Functional Requirements Specification
Module: Customer & CRM Management

Document ID: PSP-SRS-FR-CRM
Version: 1.0
Status: Draft
Parent Document: Software Requirements Specification
Chapter: 4 – Functional Requirements
Project: PigPower Lesotho – Community-Based Circular Pork Economy Platform

1. Module Overview

The Customer & CRM Management Module shall provide a centralized system for managing PigPower's relationships with all customers, prospective customers, business accounts, institutions, distributors and strategic commercial partners.

The module shall answer five fundamental questions:

Who are our customers?
What do they buy?
How frequently do they buy?
How profitable and valuable are they?
What actions should PigPower take to retain and grow the relationship?

The module will integrate directly with:

Sales & Order Management
Inventory Management
Processing & Meat Production
Logistics & Delivery
Payments & Finance
Marketing
Product Traceability
Notifications
Analytics & AI
2. Business Purpose

PigPower's commercial strategy will require more than simply selling pork.

The company needs to develop long-term relationships with:

Supermarkets
Butcheries
Restaurants
Hotels
Caterers
Wholesalers
Distributors
Institutions
Individual consumers
Regional buyers

CRM will therefore become the system through which PigPower manages the commercial demand side of the pork value chain.

3. Business Objectives

The CRM module shall enable PigPower to:

Centralize customer information.
Track prospective customers.
Convert prospects into active customers.
Segment customers.
Track customer interactions.
Understand customer purchasing behavior.
Improve customer retention.
Identify high-value customers.
Manage customer complaints.
Manage customer service cases.
Support marketing campaigns.
Track sales opportunities.
Improve customer satisfaction.
Identify cross-selling opportunities.
Support B2B relationship management.
Support future export customers.
Generate customer intelligence for demand forecasting.
4. Customer Lifecycle

The system shall model the customer lifecycle as:

PROSPECT
   ↓
LEAD
   ↓
QUALIFIED
   ↓
CUSTOMER
   ↓
ACTIVE CUSTOMER
   ↓
REPEAT CUSTOMER
   ↓
LOYAL / STRATEGIC CUSTOMER

Customers may subsequently become:

INACTIVE
    ↓
REACTIVATION

or:

ACTIVE
   ↓
SUSPENDED
   ↓
TERMINATED
5. Customer Types

The platform shall support configurable customer classifications.

Business Customers
Supermarket
Butchery
Restaurant
Hotel
Caterer
Wholesaler
Distributor
Food processor
Institutional Customers
School
Hospital
Government institution
NGO
Development organization
Individual Customers
Household
Individual consumer
Strategic Customers
National retail chain
Regional distributor
Export customer
Strategic food processor
6. Customer Master Record
FR-CRM-001 — Create Customer

Each customer shall have a unique customer record.

Example:

Customer ID:
CUS-000125

Customer:
ABC Supermarket

Type:
Retailer

Status:
ACTIVE

Region:
Maseru

Primary Contact:
John M.

Phone:
+266 XXXXXXXX

The customer profile shall include:

Customer ID
Customer name
Customer type
Business registration information where applicable
Tax information where applicable
Contact persons
Phone
Email
Physical address
Delivery address
Region
Customer status
Assigned sales representative
Payment terms
Credit status
Preferred communication channel
7. Customer Addresses

A customer may have multiple addresses.

Example:

ABC Supermarket

Head Office
Maseru

Branch 1
Mafeteng

Branch 2
Leribe

Branch 3
Maseru

Each location shall have a unique address record.

8. Contact Persons

Business customers may have multiple contacts.

Example:

Customer:
ABC Hotel

Contacts:

General Manager
Procurement Manager
Accounts Manager
Receiving Officer

Each contact may have:

Name
Position
Phone
Email
Preferred contact method
Primary contact status
9. Customer Status

Supported statuses:

PROSPECT
LEAD
QUALIFIED
ACTIVE
INACTIVE
SUSPENDED
BLOCKED
TERMINATED
10. Customer Segmentation

The CRM shall support segmentation by:

Customer type
Geographic region
Purchase volume
Purchase frequency
Revenue
Profitability
Product preference
Business size
Payment behavior
Customer lifecycle stage

Example:

HIGH VALUE B2B
MEDIUM VALUE B2B
RETAIL
INDIVIDUAL
INSTITUTIONAL
EXPORT
11. Geographic Segmentation

Customers shall be associated with geographic areas.

For example:

Maseru
Mafeteng
Leribe
Berea
Mokhotlong
Qacha's Nek
Quthing
Thaba-Tseka
Butha-Buthe
Mohale's Hoek

This enables management to determine where demand is concentrated.

12. Customer Acquisition
FR-CRM-002 — Capture Leads

The system shall allow PigPower to capture prospective customers.

Lead sources may include:

Website
Mobile application
Sales representatives
Agricultural exhibitions
Trade shows
Referrals
Social media
Direct marketing
Business development
Distributor referrals
13. Lead Record

A lead shall contain:

Lead ID
Name
Organization
Contact
Customer type
Location
Lead source
Product interest
Estimated demand
Estimated value
Assigned sales representative
Lead status
Notes
14. Lead Status
NEW
CONTACTED
QUALIFYING
QUALIFIED
PROPOSAL
NEGOTIATION
CONVERTED
LOST
DISQUALIFIED
15. Lead Qualification

The system shall support qualification criteria such as:

Customer need
Product requirement
Expected volume
Geographic location
Budget
Payment capability
Delivery requirements
Strategic importance

Example:

Restaurant X

Expected demand:
80 kg/week

Product:
Fresh pork

Payment:
30 days

Delivery:
Twice weekly

Potential annual revenue:
Estimated
16. Lead Conversion

A qualified lead may be converted into:

Lead
 ↓
Customer Account
 ↓
Contact
 ↓
Opportunity

The system should retain the original lead information.

17. Sales Opportunities
FR-CRM-003 — Manage Opportunities

CRM shall support sales opportunities.

Example:

Opportunity:
ABC Hotel Supply Contract

Potential Value:
M750,000/year

Probability:
70%

Expected Close:
30 September 2026

Sales Representative:
Assigned
18. Opportunity Pipeline

The system shall support:

LEAD
 ↓
QUALIFIED
 ↓
PROPOSAL
 ↓
NEGOTIATION
 ↓
CONTRACT
 ↓
WON

Lost opportunities shall be retained for analysis.

19. Lost Opportunity Reasons

Examples:

Price too high
Competitor selected
Customer cancelled
Insufficient supply
Delivery constraints
Payment terms
Product unavailable
Customer business closed

This information will be valuable for strategy.

20. Customer Interaction Management
FR-CRM-004 — Record Interaction

The system shall record customer interactions.

Interaction types:

Phone call
Email
SMS
WhatsApp where integrated
Meeting
Site visit
Sales presentation
Complaint
Follow-up
Contract discussion

Each interaction should include:

Customer
Contact
Date/time
Interaction type
User
Subject
Notes
Follow-up action
Follow-up date
21. Customer Activity Timeline

Each customer should have a chronological activity timeline.

Example:

12 Aug
Sales Order: M8,500

10 Aug
Phone call

05 Aug
Delivery completed

01 Aug
Quotation issued

28 Jul
Customer meeting

This gives the sales team a complete relationship history.

22. Follow-Up Management

The system shall support follow-up tasks.

Example:

TASK

Customer:
ABC Hotel

Action:
Follow up on supply contract

Assigned:
Sales Manager

Due:
20 Aug 2026

Status:
PENDING
23. CRM Tasks

Tasks may include:

Call customer
Send quotation
Visit customer
Follow up payment
Follow up complaint
Renew contract
Conduct satisfaction survey
Introduce new product
24. Customer Preferences

The system shall record customer preferences where appropriate.

Examples:

Preferred products
Preferred pack sizes
Preferred delivery days
Preferred communication channel
Preferred payment method

Example:

ABC Restaurant

Preferred Product:
Pork Sausage

Preferred Pack:
5 kg

Delivery:
Monday / Thursday

Communication:
WhatsApp
25. Purchase History

CRM shall retrieve sales history from Sales & Order Management.

The system should display:

Orders
Products
Quantities
Revenue
Order frequency
Average order value
Last purchase
Total customer value
26. Customer 360° View

The customer profile should provide a complete commercial overview.

Example:

CUSTOMER 360°

ABC SUPERMARKET

Customer since:
2027

Total purchases:
M1,850,000

Orders:
426

Average order:
M4,343

Last order:
M12,500

Outstanding:
M18,200

Primary products:
Fresh Pork
Sausages
Bacon

Complaints:
2

Open opportunities:
1

Status:
STRATEGIC CUSTOMER
27. Customer Value

The system should calculate customer value metrics.

Total Revenue
Total value of customer orders
Average Order Value
Total Revenue ÷ Number of Orders
Purchase Frequency
Orders ÷ Period
Customer Lifetime Value

A future version may estimate:

CLV =
Average Purchase Value
×
Purchase Frequency
×
Expected Customer Lifetime
×
Gross Margin
28. Customer Profitability

Where cost data is available, CRM should support profitability analysis.

Example:

Revenue:
M100,000

Product Cost:
M65,000

Delivery Cost:
M8,000

Other Cost:
M5,000

Estimated Contribution:
M22,000

This prevents PigPower from focusing only on high-revenue customers that may have low margins.

29. Customer Classification by Value

The system may classify customers:

A — Strategic / High Value
B — Medium Value
C — Low Value
D — Dormant

The classification should be configurable.

30. Customer Retention

CRM shall identify customers whose purchasing behavior declines.

Example:

Normal:
4 orders/month

Current:
0 orders in 45 days

STATUS:
CUSTOMER AT RISK

The system may generate a retention alert.

31. Customer Reactivation

The system shall support reactivation campaigns.

Example:

Dormant Customer

Last order:
90 days ago

Action:
Sales follow-up

Offer:
10% promotional discount
32. Customer Complaints
FR-CRM-005 — Manage Complaints

Customers shall be able to submit complaints.

Complaint categories:

Product quality
Packaging
Delivery
Quantity
Pricing
Payment
Customer service
Product availability
Cold-chain issue
33. Complaint Case

Each complaint shall receive a unique case number.

Example:

CASE-2026-00051

Information:

Customer
Order
Product
Batch
Complaint category
Description
Date
Priority
Assigned employee
Status
Resolution
Resolution date
34. Complaint Status
OPEN
INVESTIGATING
AWAITING_CUSTOMER
RESOLVED
CLOSED
ESCALATED
35. Complaint Escalation

High-risk complaints shall be escalated automatically.

Examples:

Suspected food contamination
Product safety issue
Cold-chain failure
Repeated quality complaint
Large financial dispute

These may require escalation to:

Customer Service
        ↓
Quality Manager
        ↓
Processing Manager
        ↓
Management
36. Product Quality Feedback

Customer feedback shall be linked to the relevant:

Customer
 ↓
Order
 ↓
Product
 ↓
Production Batch
 ↓
Processing Batch

This is important for quality assurance and traceability.

37. Customer Satisfaction

The platform should support customer satisfaction surveys.

Possible metrics:

Product quality
Delivery reliability
Price satisfaction
Packaging
Customer service
Overall satisfaction
38. Customer Rating

Customers may receive a satisfaction score.

Example:

Overall:
4.5 / 5

Product:
4.7

Delivery:
4.3

Service:
4.6

Management can identify areas requiring improvement.

39. Marketing Segmentation

CRM shall provide customer segments to the Marketing module.

Examples:

Frequent Pork Buyers
Restaurant Customers
Inactive Customers
High-Value Customers
Sausage Buyers
Bacon Buyers
New Customers
B2B Customers
40. Campaign Management

Future versions shall support campaigns such as:

Campaign:
"Buy 10 kg Sausage, Get 1 kg Free"

Target:
Restaurants

Duration:
1–30 September

Expected Customers:
50
41. Customer Notifications

The system shall support notifications for:

Order confirmation
Delivery status
Invoice
Payment receipt
Product availability
Promotions
Contract renewal
Complaint updates

Channels may include:

In-app notification
SMS
Email
WhatsApp integration where available
42. Communication Preferences

Customers shall be able to specify preferred communication methods.

Example:

Primary:
SMS

Secondary:
Email

Marketing:
Opted In

Marketing consent shall be separately recorded.

43. Privacy and Consent

The system shall record customer consent where required.

Examples:

Marketing consent
Communication consent
Data processing consent

Users should only receive marketing communications according to their consent and applicable law.

44. B2B Account Management

For major customers, PigPower shall support account-level management.

Example:

ABC Retail Group

Head Office
   │
   ├── Maseru Branch
   ├── Leribe Branch
   ├── Mafeteng Branch
   └── Mohale's Hoek Branch

The system shall support parent-child customer relationships.

45. Customer Contracts

CRM shall store references to commercial contracts.

Contract information:

Contract number
Customer
Start date
End date
Products
Minimum volume
Price
Payment terms
Delivery terms
Contract status

The actual financial/legal contract document may be stored separately.

46. Contract Expiry

The system shall generate renewal alerts.

Example:

Contract expires:
30 September

Alert:
60 days before expiry
30 days before expiry
7 days before expiry
47. Customer Credit Information

CRM shall display credit information retrieved from Finance.

Example:

Credit Limit:
M100,000

Outstanding:
M35,000

Available:
M65,000

Overdue:
M8,000

Status:
GOOD

CRM should not independently modify financial balances.

48. Sales Integration

The relationship shall be:

CRM
 │
 ├── Customer
 │
 ├── Opportunity
 │
 └── Interaction
        │
        ▼
   SALES ORDER
        │
        ▼
    INVENTORY
        │
        ▼
    DELIVERY
        │
        ▼
     PAYMENT

Sales remains responsible for transactional order management.

CRM remains responsible for the relationship.

49. Customer Demand Intelligence

CRM shall provide information to the analytics engine.

Example:

Customer Behaviour
        +
Sales History
        +
Product Preferences
        +
Seasonality
        +
Geographic Demand
        ↓
Demand Forecast

This can eventually feed the Production Management Module.

50. AI Opportunities

Future AI capabilities may include:

Customer Churn Prediction

Identify customers likely to stop purchasing.

Product Recommendation

Recommend products based on previous purchases.

Sales Opportunity Scoring

Rank leads by probability of conversion.

Customer Value Prediction

Estimate future customer value.

Demand Forecasting

Predict future purchases.

Complaint Classification

Automatically classify customer complaints.

These should be introduced after sufficient quality historical data has been collected.

51. Customer Dashboard

The customer-facing dashboard may display:

WELCOME

ABC SUPERMARKET

Current Orders
2

Outstanding Balance
M18,200

Last Purchase
M12,500

Favorite Products
Fresh Pork
Sausage

Next Delivery
Thursday

Open Complaints
0

Available Offers
3
52. CRM Management Dashboard

Management dashboard:

CUSTOMER CRM

Total Customers
1,248

Active
924

New This Month
86

At Risk
47

Dormant
122

Open Leads
143

Opportunities
38

Pipeline Value
M4.8M

Complaints
12
53. Sales Representative Dashboard
MY CUSTOMERS

Customers:
82

New Leads:
14

Open Opportunities:
7

Follow-ups:
9

Monthly Sales:
M145,000

Target:
M180,000

Achievement:
81%
54. Customer Data Security

Customer information shall be protected using role-based access.

Sensitive information should only be available to authorized users.

Examples:

Information	Sales	Manager	Finance	Admin
Customer Profile	✓	✓	✓	✓
Orders	✓	✓	✓	✓
Credit Information	Limited	✓	✓	✓
Complaints	✓	✓	Limited	✓
Marketing Consent	✓	✓	No	✓
Financial Details	No	Limited	✓	✓
55. Audit Trail

The system shall record:

Customer creation
Customer modification
Status changes
Credit status changes
Contact changes
Consent changes
Complaint updates
Opportunity updates
Assignment changes

Example:

CUSTOMER:
CUS-000125

ACTION:
STATUS CHANGE

Previous:
PROSPECT

New:
ACTIVE

Changed by:
Sales Manager

Date:
12 Aug 2026
56. Database Entities

The conceptual database shall include:

Customer
CustomerType
CustomerStatus
CustomerAddress
CustomerContact
CustomerSegment

Lead
LeadSource
LeadActivity
LeadStatus

SalesOpportunity
OpportunityStage
OpportunityActivity

CustomerInteraction
InteractionType
FollowUpTask

CustomerPreference
CommunicationPreference
MarketingConsent

CustomerComplaint
ComplaintCategory
ComplaintStatus
ComplaintResolution

CustomerSurvey
CustomerFeedback

CustomerContract
ContractProduct

CustomerRelationship
CustomerAccountGroup

CustomerCreditProfile

CustomerSegmentMembership

MarketingCampaign
CampaignRecipient

CustomerNote
CustomerAttachment
57. Core Database Relationships

The central CRM structure should be:

                    CUSTOMER
                       │
          ┌────────────┼─────────────┐
          ▼            ▼             ▼
       CONTACT      ADDRESS       SEGMENT
          │
          ▼
    INTERACTIONS
          │
          ▼
    OPPORTUNITIES
          │
          ▼
     SALES ORDERS
          │
          ▼
       PAYMENTS

Complaints form another relationship:

CUSTOMER
   ↓
ORDER
   ↓
PRODUCT
   ↓
BATCH
   ↓
COMPLAINT

This provides powerful traceability.

58. Key Business Rules
BR-CRM-001

Every customer shall have a unique customer ID.

BR-CRM-002

A business customer may have multiple contacts.

BR-CRM-003

A customer may have multiple addresses.

BR-CRM-004

A lead must have a defined lifecycle status.

BR-CRM-005

Only qualified leads may be converted into active customers.

BR-CRM-006

Customer records shall not be physically deleted if they have historical transactions.

BR-CRM-007

Inactive customers shall retain historical sales information.

BR-CRM-008

Customer financial information shall be controlled by role-based permissions.

BR-CRM-009

Marketing communications shall respect customer consent.

BR-CRM-010

Complaints involving product safety shall be escalated.

BR-CRM-011

Customer complaints shall retain links to relevant orders where available.

BR-CRM-012

Customer interactions shall be auditable.

BR-CRM-013

Customer credit balances shall originate from the Finance module.

BR-CRM-014

Sales orders shall originate from the Sales & Order Management module.

BR-CRM-015

CRM shall not duplicate authoritative transactional data maintained by other modules.

That last rule is particularly important from a software architecture perspective.

59. Key Performance Indicators
KPI	Purpose
Active Customers	Customer base
New Customers	Acquisition
Customer Retention	Loyalty
Customer Churn	Customer loss
Customer Lifetime Value	Long-term value
Average Order Value	Customer purchasing behavior
Purchase Frequency	Engagement
Customer Acquisition Cost	Acquisition efficiency
Lead Conversion Rate	Sales effectiveness
Opportunity Win Rate	Sales effectiveness
Pipeline Value	Future revenue
Complaint Rate	Customer satisfaction
Complaint Resolution Time	Service efficiency
Repeat Purchase Rate	Loyalty
Customer Satisfaction Score	Service quality
Net Promoter Score	Customer advocacy
60. Customer Acquisition Cost

The system may eventually calculate:

CAC =
Sales + Marketing Acquisition Cost
÷
Number of New Customers

This will help determine whether customer acquisition is commercially sustainable.

61. Customer Lifetime Value

The system should eventually calculate:

CLV =
Average Order Value
×
Purchase Frequency
×
Customer Lifetime
×
Gross Margin

For example, a restaurant buying weekly may be more strategically valuable than a household making occasional purchases, even if the household has a higher individual transaction margin.

62. Customer Churn

The platform should define churn according to customer type.

For example:

Retail Customer:
No purchase for 90 days

B2B Customer:
No purchase for 30 days

These thresholds must remain configurable.

63. Customer Retention Workflow
Customer Purchase Declines
          ↓
CRM Detects Risk
          ↓
Customer Risk Alert
          ↓
Sales Representative
          ↓
Customer Contact
          ↓
Identify Problem
          ↓
Resolution / Offer
          ↓
Customer Reactivated
64. Customer Feedback Loop

The CRM should create a feedback loop into operations:

CUSTOMER
   ↓
FEEDBACK
   ↓
CRM
   ↓
QUALITY ANALYSIS
   ↓
PROCESSING
   ↓
PRODUCTION
   ↓
FARMER NETWORK

For example, repeated complaints about product consistency could trigger investigation into:

Feed quality
Animal genetics
Farm management
Processing parameters
Packaging
Cold-chain performance

This makes CRM a continuous improvement mechanism, not merely a contact database.

65. MVP Scope

For the first production release, implement:

1. Customer Registration
2. Customer Profiles
3. Customer Types
4. Addresses
5. Contacts
6. Customer Segmentation
7. Lead Management
8. Basic Opportunities
9. Interaction History
10. Follow-Up Tasks
11. Customer Order History
12. Customer Complaints
13. Customer Preferences
14. Customer Status
15. Basic Customer Dashboard
16. Role-Based Access
17. Audit Trail
Phase 2
→ Customer Portal
→ B2B Accounts
→ Contract Management
→ Customer Credit Integration
→ Marketing Campaigns
→ Customer Surveys
→ Loyalty Program
→ Customer Churn Prediction
→ AI Recommendations
→ Advanced CLV
→ WhatsApp integration
→ Advanced customer analytics
66. Acceptance Criteria

The CRM module shall be considered functionally complete when:

Customer Management
 Customers can be registered.
 Customers can be classified.
 Customer addresses can be maintained.
 Multiple contacts can be associated with a customer.
 Customer status can be changed.
Lead Management
 Leads can be created.
 Leads can be assigned to sales representatives.
 Lead status can be changed.
 Qualified leads can become customers.
 Lost leads can be analyzed.
Relationship Management
 Customer interactions can be recorded.
 Follow-up tasks can be created.
 Opportunities can be tracked.
 Customer history can be viewed.
Customer Service
 Complaints can be submitted.
 Complaints can be assigned.
 Complaints can be escalated.
 Complaints can be resolved.
 Complaints can be linked to orders/products.
Analytics
 Customer value can be calculated.
 Customer activity can be analyzed.
 Customer retention can be monitored.
 Customer segmentation can be performed.
67. Architectural Principle: CRM Is Not the Sales Module

We should explicitly preserve this distinction in the architecture.

CRM answers:

"What do we know about this customer and our relationship with them?"

Sales answers:

"What did this customer order and how much did they pay?"

Therefore:

CRM
 │
 ├── Customer
 ├── Contacts
 ├── Leads
 ├── Opportunities
 ├── Interactions
 ├── Follow-ups
 ├── Complaints
 └── Customer Intelligence
          │
          ▼
      SALES MODULE
          │
          ├── Orders
          ├── Invoices
          ├── Payments
          └── Fulfillment

This separation will prevent the database from becoming tightly coupled and difficult to maintain.

68. Strategic Role in PigPower

CRM creates the commercial intelligence layer of PigPower.

The ultimate architecture becomes:

                         CUSTOMER
                            │
                            ▼
                         CRM
                            │
             ┌──────────────┼──────────────┐
             ▼              ▼              ▼
          DEMAND         SALES          FEEDBACK
          SIGNAL          ORDERS           │
             │              │              │
             └──────┬───────┘              │
                    ▼                      │
              PRODUCTION PLANNING          │
                    │                      │
                    ▼                      │
              FARMER NETWORK               │
                    │                      │
                    ▼                      │
              PIG PRODUCTION               │
                    │                      │
                    ▼                      │
                COLLECTION                 │
                    │                      │
                    ▼                      │
                PROCESSING ────────────────┘
                    │
                    ▼
              FINISHED GOODS
                    │
                    ▼
                  SALES
                    │
                    ▼
                 CUSTOMER

This is exactly the type of architecture we want for PigPower: a closed-loop agricultural value-chain platform rather than a collection of disconnected CRUD application.