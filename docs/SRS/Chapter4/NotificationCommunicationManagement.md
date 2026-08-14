PigPower SmartFarm Platform
Software Requirements Specification — Functional Requirements
Module: Notification & Communication Management

Document ID: PSP-SRS-FR-NCM
Version: 1.0
Status: Draft
Parent Document: PigPower SmartFarm Platform SRS
Chapter: 4 – Functional Requirements
Project: PigPower Lesotho – Community-Based Circular Pork Economy Platform

1. Module Overview

The Notification & Communication Management Module will provide the communication infrastructure through which the PigPower platform communicates important information to farmers, employees, veterinarians, drivers, customers, suppliers, managers and administrators.

The module will support both automated system-generated notifications and user-initiated communications.

The design must account for the operating environment of PigPower, particularly:

rural and peri-urban farmers;
intermittent internet connectivity;
smartphone and potentially basic-phone users;
time-sensitive veterinary information;
collection and logistics coordination;
farmer production activities;
payment notifications;
customer orders;
inventory alerts;
management alerts.

The module should therefore not assume that every user is continuously connected to the internet.

2. Business Purpose

The platform will generate events requiring timely communication.

For example:

Pig becomes due for vaccination
          ↓
Veterinary notification

Pig reaches market-ready weight
          ↓
Collection notification

Collection scheduled
          ↓
Farmer + Driver notification

Farmer payment processed
          ↓
Farmer payment notification

Inventory below threshold
          ↓
Warehouse Manager notification

Customer order received
          ↓
Sales notification

The Notification & Communication Module converts these system events into appropriate communications.

3. Strategic Objectives

The module shall enable PigPower to:

Improve communication with farmers.
Reduce missed veterinary activities.
Improve collection coordination.
Improve delivery coordination.
Notify farmers about payments.
Improve customer communication.
Support internal staff communication.
Provide operational alerts.
Support emergency notifications.
Support SMS communication.
Support push notifications.
Support email communication.
Provide in-app notifications.
Support offline-first communication patterns.
Maintain communication history.
Track message delivery status.
Reduce unnecessary manual communication.
Improve accountability.
Provide auditable communication records.
4. Communication Architecture

The conceptual architecture should be:

                    PIGPOWER PLATFORM
                           │
                           ▼
                     SYSTEM EVENT
                           │
                           ▼
                  NOTIFICATION ENGINE
                           │
             ┌─────────────┼─────────────┐
             ▼             ▼             ▼
          PUSH           SMS           EMAIL
             │             │             │
             └─────────────┼─────────────┘
                           ▼
                    USER / RECIPIENT
                           │
                           ▼
                  DELIVERY CONFIRMATION
                           │
                           ▼
                    MESSAGE HISTORY
5. Communication Channels

The platform should support the following channels.

5.1 In-App Notifications

Primary channel for smartphone users.

Examples:

New collection scheduled
Veterinary appointment
Payment processed
New order
Feed delivery
Farm task
System alert
5.2 Push Notifications

Push notifications should be used for time-sensitive events when the user's device is connected.

Examples:

"Your collection is scheduled for tomorrow at 08:00."

"Your farmer settlement has been processed."

5.3 SMS

SMS is particularly important for PigPower because some farmers may have:

poor mobile data coverage;
limited smartphone access;
limited data affordability;
intermittent internet connectivity.

SMS should therefore be treated as an important communication channel rather than merely a backup.

5.4 Email

Email should primarily support:

management;
administrators;
suppliers;
customers;
investors;
external stakeholders.
6. Multi-Channel Notification Strategy

The system should allow notification rules such as:

Critical
   ↓
Push + SMS

High
   ↓
Push

Normal
   ↓
In-App

Management Report
   ↓
Email

The exact channel strategy should be configurable.

7. Notification Types

Notifications should be categorized.

Operational
Production task
Collection
Delivery
Feed
Veterinary
Processing
Financial
Payment
Invoice
Settlement
Outstanding balance
Inventory
Low stock
Reorder
Expiry
Stock movement
Commercial
New order
Order confirmation
Delivery
Customer complaint
Security
Login
Password change
Account activity
System
Maintenance
System errors
Service interruptions
Emergency
Disease outbreak
Biosecurity alert
Severe weather
Security incident
8. Notification Priority

Each notification shall have a priority.

LOW
NORMAL
HIGH
CRITICAL

Example:

Priority	Example
Low	General information
Normal	Routine task
High	Upcoming collection
Critical	Disease outbreak

Priority determines delivery strategy.

9. Notification Lifecycle

Each notification should follow a defined lifecycle.

Created
   ↓
Queued
   ↓
Sent
   ↓
Delivered
   ↓
Read

Possible failure states:

Failed
Expired
Cancelled
10. Notification Status

The system should maintain:

Created
Queued
Sending
Sent
Delivered
Read
Failed
Expired
Cancelled

This provides traceability.

11. Automated Notifications

Notifications should be generated automatically from system events.

Examples:

Pig Management
Pig reaches target weight
        ↓
Market readiness notification
Veterinary
Vaccination due
        ↓
Farmer notification
        ↓
Veterinarian notification
Logistics
Collection confirmed
        ↓
Farmer + Driver notification
Finance
Settlement completed
        ↓
Farmer notification
12. Notification Rules Engine

The system should provide configurable notification rules.

A rule should contain:

Rule ID
Event
Condition
Priority
Recipient
Channel
Message template
Retry policy
Escalation policy
Active/inactive status

Example:

EVENT:
Vaccination Due

CONDITION:
Vaccination date <= 24 hours

RECIPIENT:
Farmer + Veterinarian

CHANNEL:
Push + SMS

PRIORITY:
High
13. Event-Driven Communication

The notification architecture should be event-driven.

Example:

Production Module
       │
       │ ProductionReady
       ▼
Notification Engine
       │
       ├── Farmer
       ├── Collection Officer
       └── Logistics Officer

This prevents every operational module from having to implement its own notification logic.

14. Message Templates

The platform should use standardized templates.

Example:

Template:
COLLECTION_SCHEDULED

Hello {farmer_name},

Your pigs are scheduled for collection on
{collection_date} at {collection_time}.

Collection Reference:
{collection_reference}

PigPower Lesotho

Templates should support variables.

15. Template Variables

Supported variables may include:

{farmer_name}
{farm_name}
{pig_id}
{batch_id}
{collection_date}
{collection_time}
{order_id}
{payment_reference}
{amount}
{district}
{veterinarian_name}
{driver_name}
16. Multilingual Communication

The platform should be designed to support multiple languages.

The initial architecture should support:

English
Sesotho

Additional languages may be introduced later.

Messages should be stored independently from application logic so that translations can be added without changing source code.

17. Farmer Communication

Farmers should receive relevant notifications such as:

Production
Piglet allocation
Production task
Market readiness
Veterinary
Vaccination
Treatment
Veterinary visit
Biosecurity warning
Feed
Feed delivery
Feed collection
Feed shortage
Logistics
Collection schedule
Driver arrival
Collection completed
Finance
Payment processed
Settlement statement available
18. Farmer Notification Preferences

Farmers should be able to configure permitted communication channels where appropriate.

Example:

SMS                 ✓
Push Notifications  ✓
Email               ✗

However, users should not be able to disable mandatory emergency or security communications where legally or operationally necessary.

19. Staff Notifications

Employees may receive:

assigned tasks;
approvals;
alerts;
operational updates;
meetings;
system notifications;
performance-related notifications.
20. Veterinarian Notifications

Veterinarians should receive:

vaccination schedules;
treatment tasks;
disease alerts;
veterinary visit assignments;
overdue veterinary activities;
farm health alerts.
21. Driver Notifications

Drivers should receive:

collection assignments;
route information;
pickup locations;
delivery instructions;
schedule changes;
cancellation notifications.
22. Customer Notifications

Customers should receive:

order confirmation;
payment confirmation;
order status;
delivery notification;
invoice;
delivery delay;
order cancellation.
23. Supplier Notifications

Suppliers may receive:

purchase orders;
delivery schedules;
order changes;
delivery confirmations;
payment information where applicable.
24. Payment Notifications

When a farmer payment is processed:

Payment Module
      ↓
Payment Completed Event
      ↓
Notification Engine
      ↓
SMS / Push

Example:

"PigPower settlement of M2,450 has been processed. Reference: SET-000124."

Financial notifications must use the official settlement record as their source.

25. Collection Notifications

Collection communication is operationally critical.

The notification chain could be:

Pig becomes ready
       ↓
Collection planned
       ↓
Farmer notified
       ↓
Driver assigned
       ↓
Driver notified
       ↓
Collection confirmed
       ↓
Farmer notified
26. Veterinary Alerts

The system should support escalation.

Example:

Vaccination Due
       ↓
Reminder
       ↓
No completion recorded
       ↓
Escalation
       ↓
Farm Manager
       ↓
Veterinary Manager
27. Emergency Notifications

Emergency communication should support rapid distribution.

Examples:

African swine fever alert
Disease outbreak
Farm biosecurity incident
Severe weather
Road closure
Major equipment failure
Food-safety incident

Emergency messages should have CRITICAL priority.

28. Emergency Communication Workflow
Emergency Event
       ↓
Authorized User
       ↓
Emergency Notification
       ↓
Affected Farms
       ↓
Farmers
       ↓
Veterinary Team
       ↓
Management

The system should record who authorized the alert.

29. Notification Escalation

The system should support escalation rules.

Example:

Alert generated
      ↓
Farmer notified
      ↓
No acknowledgement
      ↓
30 minutes
      ↓
Farm Manager
      ↓
60 minutes
      ↓
Operations Manager

Escalation intervals should be configurable.

30. Acknowledgement

Certain notifications should require acknowledgement.

Examples:

Disease outbreak
Emergency biosecurity instruction
Critical collection change
Safety incident

The system should distinguish:

Delivered

from

Acknowledged

because delivery does not prove that the recipient understood the message.

31. Read Receipts

For in-app notifications, the system should record:

Delivered
Opened
Read

Read receipts should not be assumed for SMS unless the provider explicitly supports delivery/read information.

32. Offline-First Communication

This is an important requirement for PigPower.

The mobile application should maintain a local notification queue.

Server Notification
       ↓
Mobile App
       ↓
Local Storage
       ↓
Display

If the device temporarily loses connectivity:

Offline
  ↓
Notification stored locally
  ↓
Connection restored
  ↓
Synchronization
33. Outbox Pattern

For actions initiated while offline, the application should support an outbox.

Example:

Farmer submits production record
          ↓
Local Outbox
          ↓
Internet unavailable
          ↓
Record remains pending
          ↓
Internet restored
          ↓
Synchronization
          ↓
Server confirmation

This is particularly important for field operations.

34. SMS Reliability

SMS delivery should be treated as an external dependency.

The system should record:

provider;
message ID;
recipient;
timestamp;
status;
failure reason where available.

If SMS fails, the system may retry according to configurable rules.

35. Retry Policy

The notification engine should support configurable retry policies.

Example:

Attempt 1
   ↓
Failure
   ↓
Wait
   ↓
Attempt 2
   ↓
Failure
   ↓
Attempt 3
   ↓
Escalate

The system should avoid uncontrolled retry loops.

36. Notification Queue

The backend should maintain a notification queue.

Conceptually:

Application Event
       ↓
Notification Queue
       ↓
Notification Worker
       ↓
Provider
       ↓
Delivery Status

This prevents communication providers from blocking normal application transactions.

37. Communication History

Each communication should be traceable.

The system should maintain:

Message ID
Sender
Recipient
Channel
Template
Content/version
Timestamp
Related entity
Delivery status
Error
Priority

Example relationship:

SMS
 ↓
Payment Settlement SET-000124
 ↓
Farmer FMR-00023
38. Communication Search

Authorized users should be able to search communication history using:

recipient;
date;
channel;
message type;
status;
reference;
priority.
39. Bulk Messaging

Authorized administrators should be able to send bulk communications.

Example:

Notify all farmers in Leribe about a veterinary campaign.

Filters could include:

District
Community
Farmer Status
Production Status
Disease Risk Group

Bulk communication must be permission-controlled.

40. Bulk Messaging Safeguards

To reduce accidental mass messaging:

require confirmation;
show recipient count;
preview message;
display channels;
require appropriate authorization;
log sender;
log campaign ID.

Example:

You are about to send an SMS to:

327 farmers

Message:
"Veterinary vaccination campaign..."

[Cancel] [Confirm Send]
41. Communication Campaigns

The system should support communication campaigns.

Examples:

Farmer onboarding campaign
Vaccination campaign
Biosecurity campaign
Feed management campaign
Marketing campaign

A campaign should contain:

Campaign ID
Name
Objective
Audience
Message
Channel
Schedule
Owner
Status
Results
42. Communication Analytics

The system should provide:

Messages sent
Messages delivered
Messages failed
Delivery rate
Read rate
Acknowledgement rate
SMS usage
Push usage
Email usage

These metrics should feed into the Reporting & BI module.

43. Notification Analytics

Management should be able to answer:

How effective are our communications?

Example:

SMS Sent:           2,000
Delivered:          1,920
Delivery Rate:      96%

Push Sent:          1,500
Opened:             1,120
Open Rate:          74.7%
44. Communication Cost Monitoring

Because PigPower must control operating costs, the system should track communication costs where provider pricing information is available.

Examples:

SMS Cost
Email Cost
Push Cost
Campaign Cost
Cost per Farmer
Cost per Campaign

This is particularly useful when scaling from dozens to hundreds of farmers.

45. Integration With Other Modules

The Notification module should integrate with almost every major module.

Module	Notification Examples
Authentication	Login/security alerts
Farmer	Onboarding
Farm	Farm tasks
Pig	Pig status
Production	Production alerts
Veterinary	Vaccination/treatment
Feed	Feed delivery
Logistics	Collection
Processing	Processing schedules
Inventory	Stock alerts
Sales	Orders
CRM	Customer communication
Payments	Settlement
Finance	Financial events
Procurement	Purchase orders
HR	Staff events
Energy	Equipment alerts
M&E	Reporting deadlines
BI	KPI alerts
46. Notification Event Catalog

A central event catalog should be maintained.

Example:

USER_REGISTERED
USER_PASSWORD_CHANGED

FARMER_APPROVED
FARMER_SUSPENDED

PIG_REGISTERED
PIG_MARKET_READY

VACCINATION_DUE
VETERINARY_VISIT_SCHEDULED

FEED_DELIVERY_SCHEDULED
FEED_STOCK_LOW

COLLECTION_SCHEDULED
COLLECTION_COMPLETED

PROCESSING_BATCH_CREATED
PROCESSING_COMPLETED

INVENTORY_LOW
INVENTORY_EXPIRING

ORDER_CREATED
ORDER_CONFIRMED
ORDER_DISPATCHED

PAYMENT_PROCESSED
PAYMENT_FAILED

DISEASE_ALERT
BIOSECURITY_ALERT

KPI_THRESHOLD_BREACHED

The event catalog will expand as the system develops.

47. Notification Entity Model

The module should eventually introduce entities such as:

Notification
NotificationTemplate
NotificationPreference
NotificationRule
NotificationEvent
NotificationQueue
NotificationDelivery
NotificationRecipient
NotificationCampaign
NotificationCampaignRecipient
NotificationEscalation
NotificationAcknowledgement
CommunicationLog
CommunicationProvider
CommunicationProviderConfig
48. Core Notification Entity

Conceptually:

Notification
────────────────────────
notification_id
event_id
notification_type
priority
title
message
template_id
created_at
scheduled_at
expires_at
status
related_entity_type
related_entity_id
49. Notification Recipient
NotificationRecipient
────────────────────────
recipient_id
notification_id
user_id
channel
delivery_status
delivered_at
read_at
acknowledged_at
failure_reason

This allows one notification to have multiple recipients and channels.

50. Notification Preference
NotificationPreference
────────────────────────
preference_id
user_id
notification_type
channel
enabled
priority_override
created_at
updated_at

Mandatory system notifications should override preferences where necessary.

51. Communication Provider Abstraction

The application should not hard-code itself to one SMS or email provider.

Instead:

PigPower Notification Service
          │
          ▼
Provider Interface
          │
     ┌────┼────┐
     ▼    ▼    ▼
   SMS   Email Push
 Provider Provider Provider

This makes it possible to change providers later without redesigning the entire application.

52. Security Requirements

The module shall:

authenticate senders;
authorize bulk messaging;
protect recipient data;
protect message contents;
encrypt sensitive communications where appropriate;
maintain audit logs;
prevent unauthorized message impersonation;
protect communication-provider credentials.

Provider API keys must never be stored in Flutter application code.

They belong in the secure backend environment.

53. Privacy

The platform should minimize sensitive information contained in notifications.

For example, rather than:

"Your account with full financial details..."

use:

"Your PigPower settlement has been processed. Log in to view details."

This reduces exposure if a phone is lost or a notification appears on a locked screen.

54. Notification Expiration

Some notifications become irrelevant.

Example:

Collection scheduled for 08:00

At 14:00, a reminder about that collection may no longer be useful.

The system should therefore support notification expiration.

55. Notification Deduplication

The system should prevent duplicate messages caused by repeated system events.

Example:

Vaccination Due Event
       ↓
Notification sent

Duplicate event
       ↓
Same notification already exists
       ↓
Do not send duplicate

This should be implemented using an appropriate event/idempotency reference.

56. Critical Communication Reliability

Critical notifications should have stronger delivery controls.

For example:

Disease Alert
     ↓
Push
     ↓
SMS
     ↓
Acknowledgement
     ↓
Escalation if necessary

This should be configurable based on the type of emergency.

57. Functional Requirements
NCM-FR-001 — Notification Creation

The system shall create notifications from configured system events.

NCM-FR-002 — In-App Notifications

The system shall provide in-app notifications.

NCM-FR-003 — Push Notifications

The system shall support push notifications.

NCM-FR-004 — SMS

The system shall support SMS notifications through an external provider.

NCM-FR-005 — Email

The system shall support email notifications.

NCM-FR-006 — Notification Prioritization

The system shall support configurable notification priorities.

NCM-FR-007 — Notification Templates

The system shall support reusable message templates.

NCM-FR-008 — Template Variables

The system shall support dynamic variables in templates.

NCM-FR-009 — Notification Preferences

The system shall allow users to configure permitted notification preferences.

NCM-FR-010 — Notification Rules

The system shall support configurable notification rules.

NCM-FR-011 — Delivery Tracking

The system shall record delivery status where supported.

NCM-FR-012 — Read Tracking

The system shall record in-app read status.

NCM-FR-013 — Acknowledgement

The system shall support acknowledgement for configured notifications.

NCM-FR-014 — Notification Retry

The system shall support configurable retry policies.

NCM-FR-015 — Escalation

The system shall support notification escalation.

NCM-FR-016 — Emergency Notifications

The system shall support authorized emergency broadcasts.

NCM-FR-017 — Bulk Messaging

The system shall support authorized bulk messaging.

NCM-FR-018 — Communication Campaigns

The system shall support communication campaigns.

NCM-FR-019 — Communication History

The system shall maintain communication history.

NCM-FR-020 — Communication Search

The system shall allow authorized users to search communication history.

NCM-FR-021 — Offline Notification Handling

The mobile application shall support local handling of notifications when connectivity is unavailable.

NCM-FR-022 — Message Queuing

The backend shall queue outgoing notifications.

NCM-FR-023 — Provider Abstraction

The system shall isolate external communication providers behind a provider abstraction layer.

NCM-FR-024 — Communication Analytics

The system shall provide communication performance metrics.

NCM-FR-025 — Communication Cost Tracking

The system shall support communication-cost tracking where provider cost data is available.

NCM-FR-026 — Multilingual Templates

The system shall support multilingual message templates.

NCM-FR-027 — Notification Expiration

The system shall support notification expiration.

NCM-FR-028 — Notification Deduplication

The system shall prevent duplicate notification delivery caused by repeated events.

NCM-FR-029 — Security

The system shall enforce role-based authorization for communication functions.

NCM-FR-030 — Audit Logging

The system shall maintain an audit trail for communication activities.

58. Non-Functional Requirements
Reliability

Critical notifications should have mechanisms for retry and escalation.

Availability

The notification service should remain available independently of individual operational modules where practical.

Scalability

The system should support growth from the initial farmer network to 500+ farmers and subsequently larger national networks.

Performance

Normal notifications should be queued rapidly without blocking the underlying business transaction.

Security

External provider credentials must never be exposed to mobile clients.

Maintainability

New communication providers should be replaceable without major changes to business modules.

Usability

Messages must be short, understandable and actionable.

Accessibility

The system should support users with different literacy and technology levels.

59. Example End-to-End Scenario

Consider a farmer whose pigs become ready for collection.

Step 1 — Production

The production module records that pigs have reached the required market condition.

Step 2 — Event
PIG_BATCH_READY

is generated.

Step 3 — Notification Engine

The notification rule determines:

Recipients:
Farmer
Collection Officer
Operations Manager

Priority:
High
Step 4 — Channels
Farmer:
Push + SMS

Collection Officer:
Push

Operations Manager:
In-app
Step 5 — Collection

The collection is scheduled.

Step 6 — Notification

Farmer receives:

"Your pigs are scheduled for collection on 18 August at 08:00. Collection reference: COL-00124."

Step 7 — Delivery tracking

The system records:

SMS → Delivered
Push → Delivered
Push → Read
Step 8 — Collection

Driver completes collection.

Step 9 — Confirmation

Farmer receives:

"Collection COL-00124 has been completed."

This creates a complete communication audit trail.

60. Strategic Importance to PigPower

Notification & Communication Management is particularly important because PigPower is not a centralized farm.

It is a distributed agricultural network:

                 PIGPOWER
                     │
       ┌─────────────┼─────────────┐
       │             │             │
    Farmers       Veterinarians   Drivers
       │             │             │
       └─────────────┼─────────────┘
                     │
              Processing Facility
                     │
          ┌──────────┼──────────┐
          │          │          │
       Customers  Suppliers   Management

Without reliable communication, the distributed model becomes difficult to coordinate.

Therefore, communication is not merely a convenience feature—it is a core infrastructure component of the PigPower operating model.

