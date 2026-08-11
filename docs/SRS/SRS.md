# Software Requirements Specification (SRS)

# PigPower SmartFarm Platform

Version: 1.0

Author: PigPower Lesotho

---

## 1. Introduction

### 1.1 Purpose

The PigPower SmartFarm Platform is a digital agricultural management system designed to support PigPower Lesotho's community-based circular pork economy. The system enables farmers, veterinary officers, field officers, processors, administrators, and buyers to interact through one integrated platform.

---

### 1.2 Objectives

The system aims to:

- Digitize pig farming operations.
- Improve livestock traceability.
- Monitor animal health.
- Coordinate farmer aggregation.
- Support meat processing.
- Monitor biodigesters.
- Improve logistics.
- Increase productivity.
- Support AI-powered decision making.

---

### 1.3 Scope

The platform consists of:

- Android Mobile Application
- Administration Dashboard
- REST API
- PostgreSQL Database
- AI Analytics Engine

---

## Users

- Farmer
- Veterinary Officer
- Field Officer
- Processing Officer
- Buyer
- Administrator

---

## Modules

1. Authentication

2. Farmer Management

3. Farm Management

4. Pig Management

5. Veterinary Module

6. Feed Module

7. Collection Module

8. Processing Module

9. Marketplace

10. Renewable Energy Module

11. Reports

12. AI Analytics

# Software Requirements Specification (SRS)

# PigPower SmartFarm Platform (PSP)

**Document Version:** 1.0

**Project:** PigPower Lesotho – Community-Based Circular Pork Economy Platform

**Prepared By:** PigPower Lesotho

**Document Type:** IEEE 830 Software Requirements Specification

**Status:** Draft

**Date:** August 2026

---

# Document Revision History

| Version | Date | Author | Description |
|----------|------|---------|-------------|
| 0.1 | Aug 2026 | PigPower Team | Initial draft |
| 1.0 | TBD | PigPower Team | First approved version |

---

# Table of Contents

1. Introduction
2. Overall Description
3. Business Requirements
4. Functional Requirements
5. Non-functional Requirements
6. Data Requirements
7. System Architecture
8. Interface Requirements
9. Security Requirements
10. Quality Attributes
11. Future Enhancements
12. Appendices

---

# Chapter 1 — Introduction

## 1.1 Purpose

The purpose of this Software Requirements Specification (SRS) is to define the functional and non-functional requirements of the PigPower SmartFarm Platform (PSP), a digital agricultural management system developed to support PigPower Lesotho's community-based circular pork economy.

This document serves as the primary reference for software developers, system architects, UI/UX designers, testers, project managers, investors, and other stakeholders involved in the planning, development, deployment, and maintenance of the platform.

The SRS establishes a shared understanding of the software's expected functionality, performance, interfaces, constraints, and quality attributes. It also provides the foundation for system architecture, database design, API development, mobile application development, testing, deployment, and future enhancements.

---

## 1.2 Business Context

Agriculture remains one of the most important sectors of Lesotho's economy, providing livelihoods for a significant proportion of the population. Despite this, commercial pig farming remains fragmented, characterized by small-scale production, limited access to quality inputs, weak market coordination, inadequate veterinary support, and low levels of technology adoption.

PigPower Lesotho seeks to transform this landscape by developing a digitally enabled platform that connects farmers, veterinary professionals, logistics providers, processors, retailers, and consumers into an integrated pork value chain.

Rather than operating as a conventional pig farm, PigPower Lesotho will function as a technology-enabled agricultural enterprise responsible for coordinating production, improving traceability, facilitating market access, and supporting circular economy initiatives such as biogas generation and organic fertilizer production.

---

## 1.3 Purpose of the System

The PigPower SmartFarm Platform will provide an integrated software ecosystem that supports:

- Farmer registration and management.
- Farm registration and geolocation.
- Individual pig identification and lifecycle tracking.
- Veterinary health management.
- Feed inventory and consumption monitoring.
- Pig collection and logistics coordination.
- Meat processing and inventory management.
- Marketplace and customer order management.
- Biodigester monitoring and renewable energy reporting.
- Artificial intelligence–assisted analytics and forecasting.
- Executive dashboards and reporting.

The platform is designed to improve operational efficiency, data quality, traceability, decision-making, and commercial scalability across the PigPower ecosystem.

---

## 1.4 Project Vision

To build the leading digital livestock management platform in Southern Africa, enabling sustainable pork production through technology, innovation, data-driven decision-making, and circular economy principles.

---

## 1.5 Project Mission

To empower farmers with accessible digital tools that improve productivity, profitability, food safety, environmental sustainability, and market access while supporting PigPower Lesotho's vision of becoming a nationally recognized pork production and processing platform.

---

## 1.6 Project Objectives

The software platform shall:

- Digitize livestock production records.
- Improve traceability across the pork value chain.
- Support evidence-based farm management.
- Facilitate communication between farmers and veterinary officers.
- Enable centralized production monitoring.
- Improve logistics planning.
- Reduce paperwork and manual record keeping.
- Support renewable energy management.
- Generate business intelligence dashboards.
- Provide a scalable platform capable of supporting national expansion.

---

## 1.7 Scope

The first release of the PigPower SmartFarm Platform will include:

### Mobile Application

- Farmer Portal
- Veterinary Portal
- Field Officer Portal

### Web Administration Portal

- System Administration
- Farmer Management
- Pig Management
- Marketplace Management
- Reporting
- Dashboard

### Backend Services

- Authentication
- REST API
- Business Logic
- Data Synchronization
- Notification Services

### Database

- PostgreSQL
- SQLite offline synchronization
- Audit logging

---

## 1.8 Intended Audience

This document is intended for:

- Software Developers
- System Architects
- UI/UX Designers
- Database Engineers
- DevOps Engineers
- Quality Assurance Engineers
- Project Managers
- Investors
- BEDCO
- Government Stakeholders
- Future Technical Partners

---

## 1.9 Definitions

| Term | Definition |
|------|------------|
| PSP | PigPower SmartFarm Platform |
| Farmer | Registered livestock producer within the PigPower network |
| Farm | Physical production site registered within the system |
| Pig | Individual animal tracked throughout its lifecycle |
| Batch | Group of pigs processed together |
| Traceability | Ability to track a pig and its products from farm to consumer |
| Biodigester | System that converts pig manure into biogas and organic fertilizer |

---

## 1.10 Acronyms

| Acronym | Meaning |
|---------|---------|
| API | Application Programming Interface |
| RBAC | Role-Based Access Control |
| GPS | Global Positioning System |
| QR | Quick Response Code |
| UUID | Universally Unique Identifier |
| REST | Representational State Transfer |
| JSON | JavaScript Object Notation |
| IoT | Internet of Things |
| AI | Artificial Intelligence |

---

## 1.11 References

This software project draws upon:

- IEEE 830 Software Requirements Specification guidelines.
- Flutter documentation.
- FastAPI documentation.
- PostgreSQL documentation.
- Android developer guidelines.
- Clean Architecture principles.
- Domain-Driven Design (DDD).

# Chapter 2 – Overall Description

## 2.1 Product Perspective

The PigPower SmartFarm Platform (PSP) is an integrated Agricultural Management Information System (AgMIS) developed to support the digital transformation of Lesotho's pork value chain. The platform serves as the technological backbone of PigPower Lesotho's community-based circular pork economy, enabling collaboration among farmers, field officers, veterinarians, processors, logistics personnel, buyers, and administrators.

Rather than functioning as a standalone mobile application, the PSP is designed as a distributed enterprise software platform consisting of mobile applications, web-based administration tools, backend services, databases, and analytics components. The system will support both online and offline operation, ensuring that users in rural areas with limited internet connectivity can continue recording production activities and synchronize their data when connectivity becomes available.

The platform follows a modular architecture that allows new business capabilities to be introduced incrementally without disrupting existing services. Future modules such as IoT sensor integration, RFID livestock identification, AI-assisted disease detection, carbon credit reporting, and regional market integration can be incorporated as the business grows.

---

## 2.2 Product Vision

The vision of the PigPower SmartFarm Platform is to become the leading digital livestock management ecosystem in Southern Africa by enabling technology-driven, traceable, sustainable, and commercially viable pork production.

The platform seeks to improve agricultural productivity, strengthen food security, increase farmer incomes, reduce environmental impacts, and support evidence-based decision-making across the entire pork value chain.

---

## 2.3 Product Objectives

The primary objectives of the system are to:

- Digitize pig farming operations across Lesotho.
- Standardize production records and farm management practices.
- Improve livestock traceability from farm to consumer.
- Support disease prevention through digital health records and alerts.
- Enable centralized monitoring of distributed production sites.
- Improve coordination of logistics, processing, and distribution.
- Facilitate transparent farmer payments and business reporting.
- Integrate renewable energy monitoring for biodigester systems.
- Generate reliable operational and financial data for management decisions.
- Provide a scalable platform capable of supporting future regional expansion.

---

## 2.4 Product Functions

The initial release of the PigPower SmartFarm Platform shall provide the following functional areas:

### User and Identity Management

- User registration
- Authentication
- Role-Based Access Control (RBAC)
- Password recovery
- User profile management

### Farmer Management

- Farmer registration
- Contract management
- Farmer performance monitoring
- Farmer communication

### Farm Management

- Farm registration
- GPS location capture
- Pigsty management
- Farm inspections
- Biosecurity assessments

### Pig Management

- Individual pig registration
- Unique identification (QR code, with future RFID support)
- Breed management
- Growth monitoring
- Weight recording
- Reproductive management
- Mortality recording

### Veterinary Services

- Vaccination scheduling
- Treatment records
- Disease reporting
- Veterinary visit management
- Animal health history

### Feed Management

- Feed inventory
- Feed procurement records
- Feed consumption tracking
- Feed conversion monitoring

### Collection and Logistics

- Collection scheduling
- Route planning
- Vehicle assignment
- Delivery tracking
- Collection history

### Processing Management

- Animal reception
- Slaughter records
- Carcass grading
- Product processing
- Packaging
- Batch management
- Inventory tracking

### Marketplace

- Customer management
- Product catalogue
- Order processing
- Sales reporting
- Digital invoices

### Renewable Energy

- Biodigester registration
- Biogas production records
- Organic fertilizer production
- Environmental performance indicators

### Reporting and Analytics

- Executive dashboards
- Farmer performance reports
- Production reports
- Financial summaries
- AI-ready forecasting datasets

---

## 2.5 User Classes and Characteristics

The platform supports multiple categories of users with different responsibilities and permissions.

### Farmers

Farmers are the primary producers within the PigPower network. They use the mobile application to register production activities, monitor pig health, receive alerts, request veterinary support, and access performance information.

Typical characteristics:

- Limited technical expertise
- Android smartphone users
- May experience intermittent internet connectivity
- Require simple, multilingual interfaces

---

### Field Officers

Field officers register new farms, verify production data, conduct inspections, provide technical support, and assist with farmer onboarding.

Characteristics:

- Moderate digital literacy
- Frequent travel
- GPS-enabled mobile devices
- Offline operation required

---

### Veterinary Officers

Veterinary officers manage disease surveillance, vaccinations, treatments, and herd health monitoring.

Characteristics:

- Professional users
- Require detailed animal histories
- Access to analytical reports
- Mobile and web access

---

### Processing Officers

Processing officers manage activities at the slaughterhouse, including receiving animals, carcass grading, inventory updates, packaging, and product traceability.

Characteristics:

- High-volume transactional users
- Barcode/QR scanning
- Desktop and tablet usage

---

### Logistics Officers

Responsible for coordinating transportation of pigs and finished products.

Characteristics:

- Route planning
- Collection scheduling
- Vehicle tracking
- Delivery confirmation

---

### Buyers

Institutional buyers, retailers, wholesalers, hotels, restaurants, and individual consumers purchasing PigPower products.

Characteristics:

- Product ordering
- Invoice tracking
- Delivery status monitoring

---

### System Administrators

Administrators configure the system, manage users, monitor operations, generate reports, and maintain platform integrity.

Characteristics:

- Full system privileges
- Advanced reporting
- Security management
- Audit review

---

## 2.6 Operating Environment

The PigPower SmartFarm Platform shall operate within the following environment:

### Mobile Application

- Android 10 or later (minimum target)
- Flutter framework
- SQLite local database
- Camera support
- GPS support
- Offline synchronization

### Web Administration Portal

- Modern web browsers (Chrome, Edge, Firefox)
- Responsive interface
- Desktop and tablet support

### Backend Services

- Ubuntu Linux Server
- FastAPI
- Docker containers
- PostgreSQL database
- RESTful APIs
- HTTPS communication

### Infrastructure

- Cloud-hosted or on-premises deployment
- Daily automated backups
- Secure network communication
- Scalable architecture

---

## 2.7 Design Constraints

The system shall be designed to satisfy the following constraints:

- Operate reliably in low-bandwidth environments.
- Support offline data capture with synchronization.
- Minimize recurring software licensing costs through open-source technologies.
- Be modular and extensible.
- Maintain data integrity across distributed users.
- Protect sensitive personal and business information.
- Support future integration with IoT devices and third-party services.

---

## 2.8 Assumptions and Dependencies

The following assumptions apply:

- Farmers have access to Android smartphones.
- Periodic internet connectivity is available for synchronization.
- Field officers provide onboarding and technical assistance.
- PostgreSQL serves as the centralized operational database.
- QR codes are used initially for livestock identification, with RFID considered for future implementation.
- Government regulations permit digital livestock record keeping.
- Processing facilities maintain standardized operational procedures.

---

## 2.9 Business Process Overview

The high-level business workflow is illustrated below:

```text
Farmer Registration
        │
        ▼
Farm Registration
        │
        ▼
Pig Registration
        │
        ▼
Feeding & Health Records
        │
        ▼
Veterinary Monitoring
        │
        ▼
Growth Tracking
        │
        ▼
Collection Scheduling
        │
        ▼
Transport
        │
        ▼
Processing Plant
        │
        ▼
Packaging
        │
        ▼
Distribution
        │
        ▼
Retail / Consumer
```

This workflow forms the backbone of the PigPower SmartFarm Platform and provides end-to-end traceability across the pork value chain.

---

## 2.10 Product Success Criteria

The success of the platform will be evaluated against measurable indicators, including:

- Number of farmers actively using the platform.
- Percentage of pigs digitally registered.
- Reduction in paper-based record keeping.
- Accuracy and completeness of traceability records.
- Improved disease response times.
- Increased farmer productivity.
- Reduced logistics inefficiencies.
- Increased local pork production.
- User satisfaction and adoption rates.
- Platform scalability and system availability.

# Chapter 3 – Business Requirements

## 3.1 Business Overview

PigPower Lesotho is a technology-enabled agribusiness established to transform Lesotho's pork value chain through farmer aggregation, standardized production systems, centralized processing, renewable energy generation, and digital technologies.

Unlike conventional pig farms that focus solely on livestock production, PigPower operates as a platform business that coordinates a distributed network of independent farmers while providing technical support, veterinary services, input procurement, traceability, processing, branding, and market access.

The PigPower SmartFarm Platform (PSP) is the digital backbone of this business model. It integrates production, logistics, processing, sales, and reporting into a single enterprise platform, enabling real-time decision-making and operational transparency.

---

## 3.2 Business Goals

The platform shall support the following strategic business goals.

### BG-01: Increase National Pork Production

Expand commercial pig production by integrating smallholder farmers into a coordinated production network.

**Success Measures**

- 500 active farmers within five years.
- 20,000 pigs marketed annually by Year 5.
- Increased domestic pork availability.

---

### BG-02: Improve Farmer Profitability

Provide farmers with improved genetics, technical support, guaranteed market access, and digital production management tools.

**Success Measures**

- Increase average farmer income.
- Improve feed conversion efficiency.
- Reduce mortality rates.
- Increase average market weight.

---

### BG-03: Strengthen Food Security

Increase local production of safe, high-quality pork products and reduce dependence on imported meat.

**Success Measures**

- Increased domestic market share.
- Reduced reliance on imported pork products.
- Improved product availability throughout Lesotho.

---

### BG-04: Build a National Pork Brand

Develop PigPower into a trusted, traceable, premium pork brand recognized for quality, food safety, and sustainability.

**Success Measures**

- Product traceability from farm to consumer.
- Consistent quality standards.
- Customer satisfaction and repeat purchases.

---

### BG-05: Promote Environmental Sustainability

Implement circular economy principles by converting pig manure into renewable energy and organic fertilizer.

**Success Measures**

- Biogas generated annually.
- Organic fertilizer produced.
- Reduction in unmanaged livestock waste.
- Lower greenhouse gas emissions.

---

### BG-06: Enable Data-Driven Decision Making

Provide management with accurate operational, financial, and production data.

**Success Measures**

- Real-time dashboards.
- Automated reporting.
- Production forecasting.
- Performance benchmarking.

---

## 3.3 Business Objectives

The software platform shall enable PigPower Lesotho to:

- Digitally register all participating farmers.
- Maintain accurate records for every farm.
- Assign a unique identity to every pig.
- Record the complete lifecycle of each pig.
- Monitor production performance.
- Improve disease surveillance.
- Coordinate logistics.
- Manage processing operations.
- Support sales and inventory.
- Generate management reports.
- Facilitate future regional expansion.

---

## 3.4 Stakeholder Analysis

| Stakeholder | Role | Primary Interests |
|--------------|------|-------------------|
| PigPower Management | Strategic oversight | Growth, profitability, operational visibility |
| Farmers | Livestock production | Income, support services, guaranteed market |
| Field Officers | Farmer support | Data quality, farm inspections, onboarding |
| Veterinary Officers | Animal health | Disease control, treatment records, vaccinations |
| Processing Staff | Meat production | Efficient slaughter, quality control, traceability |
| Logistics Officers | Transport | Scheduling, routing, delivery confirmation |
| Customers | Purchasing | Safe, traceable, quality pork products |
| BEDCO | Funding partner | Innovation, sustainability, job creation |
| Government | Regulation | Food safety, compliance, agricultural development |
| Financial Institutions | Financing | Business performance and reporting |

---

## 3.5 Business Value Proposition

PigPower creates value for multiple stakeholders.

### Farmers

- Guaranteed market access.
- Better genetics.
- Veterinary support.
- Production guidance.
- Digital records.
- Business training.

### Consumers

- Safe pork.
- Traceable products.
- Consistent quality.
- Reliable supply.

### Government

- Increased food security.
- Rural economic development.
- Employment creation.
- Import substitution.
- Environmental sustainability.

### Investors

- Scalable platform business.
- Diversified revenue streams.
- Strong ESG profile.
- Data-driven operations.

---

## 3.6 Business Value Chain

The PigPower business model spans the entire pork value chain.

```text
Input Supply
      │
      ▼
Farmer Recruitment
      │
      ▼
Training & Onboarding
      │
      ▼
Pig Production
      │
      ▼
Veterinary Services
      │
      ▼
Growth Monitoring
      │
      ▼
Collection
      │
      ▼
Transport
      │
      ▼
Processing
      │
      ▼
Packaging
      │
      ▼
Cold Storage
      │
      ▼
Distribution
      │
      ▼
Retail
      │
      ▼
Consumer
```

The SmartFarm Platform shall digitally support every stage of this value chain.

---

## 3.7 Business Processes

The system shall support the following end-to-end business processes:

- Farmer onboarding.
- Farm registration.
- Pig registration.
- Feed management.
- Veterinary service delivery.
- Weight monitoring.
- Breeding management.
- Mortality reporting.
- Collection scheduling.
- Processing operations.
- Product inventory management.
- Customer order processing.
- Payment reconciliation.
- Renewable energy monitoring.
- Performance reporting.

Each process shall be traceable, auditable, and supported by digital records.

---

## 3.8 Business Rules

The following rules govern system behaviour.

### BR-01

Every farmer shall have a unique Farmer ID.

### BR-02

Every farm shall belong to one registered farmer.

### BR-03

Every pig shall have one unique identification code.

### BR-04

A pig cannot be processed unless it has been received at the processing facility.

### BR-05

Every vaccination record shall reference a registered pig.

### BR-06

Every treatment record shall identify the attending veterinary officer.

### BR-07

Orders shall only be fulfilled if sufficient inventory exists.

### BR-08

Deleted records shall be soft-deleted to preserve audit history.

### BR-09

Every transaction shall record the responsible user and timestamp.

### BR-10

Offline data shall synchronize with the central database without creating duplicate records.

---

## 3.9 Key Performance Indicators (KPIs)

The platform shall calculate and display the following KPIs.

### Farmer Performance

- Number of active farmers.
- Farmer retention rate.
- Average farmer income.
- Farmer productivity.

### Production

- Total pigs registered.
- Live pigs.
- Mortality rate.
- Average daily weight gain.
- Feed conversion ratio.
- Average market weight.

### Veterinary

- Vaccination coverage.
- Disease incidence.
- Treatment success rate.
- Response time.

### Processing

- Daily slaughter volume.
- Carcass yield.
- Product output by category.
- Processing efficiency.

### Sales

- Revenue.
- Gross profit.
- Inventory turnover.
- Customer growth.

### Renewable Energy

- Biogas generated.
- Organic fertilizer produced.
- Energy cost savings.
- Estimated carbon emissions avoided.

---

## 3.10 Business Success Metrics

The success of the PigPower platform will be measured using strategic indicators.

| Objective | Metric | Five-Year Target |
|-----------|--------|------------------|
| Farmer Network | Active farmers | 500 |
| Production | Pigs marketed annually | 20,000 |
| Employment | Direct jobs created | 100+ |
| Income | Average farmer income growth | >40% |
| Processing | Local processing capacity | 100% of PigPower production |
| Renewable Energy | Pig manure converted | >80% |
| Traceability | Digitally tracked pigs | 100% |
| System Availability | Platform uptime | 99.5% |

---

## 3.11 Business Constraints

The platform must operate within the following constraints:

- Variable internet connectivity in rural areas.
- Limited digital literacy among some users.
- Compliance with national livestock and food safety regulations.
- Cost-effective deployment using open-source technologies.
- Gradual expansion of processing capacity.
- Integration with future hardware such as RFID readers, smart weighing scales, and environmental sensors.

---

## 3.12 Business Requirements Traceability

Every functional requirement defined in Chapter 4 shall be traceable to one or more business goals in this chapter. This traceability ensures that software development effort is aligned with PigPower's strategic objectives and provides a basis for validating that the completed system delivers measurable business value.
