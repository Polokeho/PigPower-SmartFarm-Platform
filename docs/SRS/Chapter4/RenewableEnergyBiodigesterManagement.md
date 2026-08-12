PigPower SmartFarm Platform
Functional Requirements Specification
Module: Renewable Energy & Biodigester Management

Document ID: PSP-SRS-FR-REBM
Version: 1.0
Status: Draft
Parent Document: Software Requirements Specification
Chapter: 4 – Functional Requirements
Project: PigPower Lesotho – Community-Based Circular Pork Economy Platform

1. Module Overview

The Renewable Energy & Biodigester Management Module will manage PigPower's circular-economy infrastructure for converting livestock waste into useful energy and agricultural inputs.

The module will digitally connect:

Pig production → manure collection → biodigester → biogas → energy → fertilizer → farm/processing operations.

The system will monitor and manage:

Biodigester installations
Pig-waste inputs
Feedstock collection
Digester loading
Biogas production
Gas utilization
Electricity generation
Heat generation
Generator operation
Solar-energy integration
Energy consumption
Digestate production
Organic fertilizer
Equipment maintenance
Environmental performance
Carbon-reduction indicators
Renewable-energy financial performance

The module therefore becomes a core component of PigPower's circular agricultural platform, rather than simply an equipment-monitoring system.

2. Business Purpose

PigPower's centralized processing facility and participating farms will generate significant quantities of organic waste.

Instead of treating this waste purely as a disposal problem, the platform will manage it as an economic resource.

The intended value chain is:

                    PIG FARMING
                         │
                         ▼
                    Pig Manure
                         │
                         ▼
               Collection & Handling
                         │
                         ▼
                    Biodigester
                   ┌─────┴─────┐
                   ▼           ▼
                Biogas      Digestate
                   │           │
          ┌────────┼──────┐    ▼
          ▼        ▼      ▼  Organic
       Cooking   Heat   Power Fertilizer
                         │
                         ▼
                  Farm / Factory
                  Energy Demand

The software will provide visibility across this entire cycle.

3. Business Objectives

The module shall enable PigPower to:

Monitor biodigester assets.
Track manure availability.
Track feedstock inputs.
Monitor biogas production.
Monitor energy production.
Track energy consumption.
Monitor digestate production.
Manage fertilizer production.
Track renewable-energy savings.
Monitor equipment efficiency.
Schedule maintenance.
Detect abnormal operating conditions.
Quantify environmental benefits.
Support investment reporting.
Support carbon-impact reporting.
Integrate renewable energy with PigPower's solar systems.
Reduce dependence on grid electricity and fossil fuels.
Create additional revenue opportunities from fertilizer and energy.
4. Scope

The module shall cover:

Biodigester Management
Feedstock Management
Biogas Monitoring
Energy Generation
Energy Consumption
Solar Integration
Generator Integration
Digestate Management
Fertilizer Management
Equipment Maintenance
Environmental Monitoring
Carbon Accounting
Energy Economics
Alerts
Analytics
Reporting
5. Biodigester Asset Management

Each biodigester shall have a unique asset record.

Example:

Biodigester ID:
BD-MAS-001

Location:
PigPower Processing Facility

Type:
Anaerobic Digester

Capacity:
Configured Value

Commission Date:
Configured Date

Status:
Operational

Additional information:

Manufacturer
Model
Construction type
Digester volume
Design capacity
Feedstock type
Expected gas output
Operating temperature range
Installation contractor
Warranty
Maintenance schedule
6. Biodigester Types

The system should support configurable biodigester types, for example:

Fixed-dome
Plug-flow
Covered lagoon
Complete-mix
Modular packaged digester
Other configurable designs

The application should not hard-code engineering assumptions because the final technology may differ between the pilot site and future decentralized farms.

7. Biodigester Lifecycle
Planning
   ↓
Design
   ↓
Procurement
   ↓
Construction
   ↓
Commissioning
   ↓
Operational
   ↓
Maintenance
   ↓
Decommissioning

Each state shall be recorded.

8. Feedstock Management

Feedstock refers primarily to pig manure and other approved organic materials entering the digester.

The system shall track:

Feedstock Source
Quantity
Date
Time
Type
Moisture/quality indicators where available
Operator
Destination Digester

Example:

Date: 12/08/2026

Source:
Processing Facility

Pig manure:
1,250 kg

Digester:
BD-MAS-001
9. Feedstock Sources

Potential sources include:

Participating Farms
Pig Sties
Processing Facility
Manure Collection Points
Other Approved Organic Sources

The system should identify the origin of each feedstock batch.

10. Feedstock Traceability

Every feedstock transaction should be traceable.

Farm
 ↓
Manure
 ↓
Collection
 ↓
Transport
 ↓
Biodigester
 ↓
Biogas
 ↓
Energy

This allows PigPower to establish a complete circular-economy record.

11. Manure Collection

Where manure is collected from decentralized farms, the system should support collection scheduling.

A collection record may contain:

Collection ID
Farm
Farmer
Date
Estimated Quantity
Actual Quantity
Vehicle
Driver
Collection Point
Destination
Status

This integrates naturally with the existing Collection & Logistics Management Module.

12. Biodigester Feeding

Authorized operators should record digester feeding.

Fields:

Feed Event ID
Biodigester
Feedstock Type
Quantity
Date
Time
Operator
Notes

The system should maintain daily and monthly feedstock totals.

13. Operating Parameters

Where sensors are installed, the platform should collect parameters such as:

Temperature
pH
Gas pressure
Gas flow
Feedstock volume
Digester level
Gas composition where sensors are available
Moisture indicators
Hydraulic retention indicators

Not every installation needs every sensor.

The system should therefore use a configurable sensor architecture.

14. IoT Architecture

A typical installation could be:

             BIODIGESTER
                  │
        ┌─────────┼─────────┐
        ▼         ▼         ▼
 Temperature    Gas       Pressure
   Sensor      Flow       Sensor
                Sensor
        │         │         │
        └─────────┼─────────┘
                  ▼
             IoT Gateway
                  │
             Wi-Fi/4G
                  │
                  ▼
          PigPower Backend
                  │
                  ▼
           Mobile/Web App

This is particularly suitable for the architecture we are already designing around the PigPower platform.

15. Biogas Production Monitoring

The system shall record:

Biogas Produced
Biogas Used
Biogas Stored
Biogas Flared
Biogas Lost/Unaccounted

Example dashboard:

Today's Production:     125 m³
Used:                    92 m³
Stored:                  21 m³
Flared:                   8 m³
Unaccounted:              4 m³
16. Gas Quality

Where instrumentation is available, the platform may monitor:

Methane concentration
Carbon dioxide
Hydrogen sulfide
Gas pressure
Gas temperature

Gas-quality measurements should be linked to safety and equipment-operation thresholds.

17. Gas Storage

If gas storage is installed, the system shall record:

Storage Asset
Capacity
Current Level
Pressure
Date
Status

The system can generate alerts for abnormal pressure or storage conditions.

18. Biogas Utilization

PigPower may use biogas for:

Thermal energy
Water heating
Processing operations
Boilers
Cleaning
Cooking where applicable
Electrical energy
Generator
CHP system
Electricity generation
Other approved applications

The application should track each consumption category separately.

19. Energy Production

Energy generated from biogas should be recorded.

For electrical generation:

Generation Event
Generator
Start Time
End Time
Energy Generated
Operating Hours
Fuel/Gas Consumed

Example:

Biogas Generator

Today:
86 kWh generated
20. Electricity Consumption

The module should also monitor where renewable energy is consumed.

Example:

Processing Facility
     │
     ├── Cold Room
     ├── Freezers
     ├── Pumps
     ├── Lighting
     ├── Machinery
     └── Office

Energy consumption may be measured through smart meters.

21. Solar Integration

PigPower's renewable-energy strategy should not treat biogas and solar as isolated systems.

The platform should support:

Solar PV
   +
Battery Storage
   +
Biogas Generator
   +
Grid

forming an integrated energy-management system.

A simplified architecture:

              SOLAR PV
                  │
                  ▼
              INVERTER
                  │
                  ▼
             ┌────┴────┐
             │ BATTERY │
             └────┬────┘
                  │
         ┌────────┼────────┐
         ▼        ▼        ▼
       LOAD    BIODIGESTER GRID
                  │
                  ▼
             BIOGAS
                  │
                  ▼
              GENERATOR
                  │
                  └──────► LOAD
22. Energy Source Monitoring

The system should distinguish:

Solar Energy
Biogas Energy
Grid Electricity
Generator/Fossil Fuel Energy
Battery Energy

Management should be able to determine the percentage of facility energy supplied by renewable sources.

23. Renewable Energy KPI

A major KPI should be:

Renewable Energy Share

Renewable Energy Used
÷
Total Energy Used
× 100

The dashboard could display:

Renewable Energy Share

Solar:       42%
Biogas:      31%
Grid:        27%

This allows PigPower to measure progress toward energy independence.

24. Energy Cost Savings

The platform should calculate estimated energy savings.

Conceptually:

Energy Cost Avoided
=
Renewable Energy Used
×
Applicable Energy Cost

The system should retain the assumptions used in the calculation so management can distinguish measured savings from estimated savings.

25. Biodigester Efficiency

The platform should calculate operational indicators such as:

Biogas Yield
=
Biogas Produced
÷
Feedstock Input

The exact expected yield should be configurable according to the selected feedstock and engineering design.

The application should not assume that every kilogram of manure produces a fixed amount of gas.

26. Digestate Management

After anaerobic digestion, the remaining material should be tracked as digestate.

The system shall record:

Digestate Produced
Digestate Stored
Digestate Processed
Digestate Sold
Digestate Applied
27. Organic Fertilizer Production

Digestate can be processed into agricultural fertilizer products subject to appropriate agronomic testing and regulatory requirements.

The system should track:

Fertilizer Batch ID
Source Digester
Production Date
Quantity
Processing Method
Quality Tests
Packaging
Storage
Sales
28. Fertilizer Traceability

Example:

Biodigester
    ↓
Digestate Batch
    ↓
Fertilizer Processing
    ↓
Fertilizer Batch
    ↓
Packaging
    ↓
Customer

A QR code could allow authorized users to trace a fertilizer product back to its production batch.

29. Fertilizer Inventory Integration

The fertilizer product should integrate with the existing:

Inventory & Warehouse Management Module.

For example:

Fertilizer Produced
       ↓
Warehouse
       ↓
Inventory
       ↓
Sale
       ↓
Customer
30. Fertilizer Revenue

The Finance and Sales modules should receive transactions generated by fertilizer sales.

Potential revenue streams:

Fresh Pork
Processed Pork
Fertilizer
Energy Services
Biogas
Potential Carbon Revenue

This demonstrates why the biodigester is commercially important rather than simply an environmental project.

31. Maintenance Management

The system shall manage biodigester and energy-equipment maintenance.

Assets may include:

Biodigester
Pumps
Gas storage
Gas piping
Gas purification
Generator
CHP equipment
Solar panels
Inverters
Batteries
Electrical panels
Sensors
Meters
32. Preventive Maintenance

Each asset should have a maintenance schedule.

Example:

Asset:
Biogas Generator

Maintenance:
Every 500 operating hours

Next Service:
Configured Automatically
33. Maintenance Workflow
Maintenance Due
      ↓
Work Order
      ↓
Technician Assigned
      ↓
Maintenance Performed
      ↓
Parts Used
      ↓
Cost Recorded
      ↓
Asset Status Updated

This should integrate with:

Procurement
Inventory
Finance
HR
34. Fault Management

The system should record equipment faults.

Example:

Fault:
High Gas Pressure

Severity:
Critical

Asset:
BD-MAS-001

Detected:
Automatic Sensor Alert

Action:
Operator notified
35. Alert Management

Alerts may include:

Operational
Low gas production
High pressure
Low pressure
High temperature
Abnormal temperature
Low feedstock
Generator fault
Maintenance
Maintenance due
Sensor failure
Equipment service overdue
Safety
Gas leak indication
Abnormal pressure
Gas-quality warning
Emergency shutdown
36. Alert Severity
INFO
WARNING
HIGH
CRITICAL

Critical alerts should require acknowledgement by an authorized operator.

37. Emergency Shutdown

Where the equipment supports remote or automatic shutdown, the system may expose an emergency-control interface.

However:

The mobile application must never be the sole safety mechanism for hazardous equipment.

Local physical safety controls, emergency shutoffs and appropriate engineering protections remain primary.

The application provides monitoring and secondary control where the equipment design permits it.

38. Environmental Monitoring

The module should track environmental indicators such as:

Manure diverted from uncontrolled disposal
Biogas generated
Renewable energy generated
Fossil fuel displacement
Digestate produced
Fertilizer produced
Waste processed
39. Carbon Impact

The system should provide an estimated carbon-impact dashboard.

Potential indicators:

Estimated CO₂e Avoided
Renewable kWh Generated
Fossil Energy Displaced
Organic Waste Processed
Methane Captured

The application should clearly label carbon figures as:

Measured, calculated, or estimated, depending on the underlying data quality.

This distinction will be important if PigPower eventually pursues formal carbon-credit opportunities.

40. Circular Economy KPI

One of the most important PigPower platform indicators should be:

Waste-to-Value Conversion
Pig Waste
    ↓
Biogas
    ↓
Energy
    +
Digestate
    ↓
Fertilizer
    ↓
Agricultural Production

The dashboard should measure the volume and financial value generated at each stage.

41. Circular Economy Dashboard

Example:

MONTHLY CIRCULAR ECONOMY PERFORMANCE

Pig Waste Processed       38 tonnes

Biogas Produced           1,420 m³

Renewable Electricity       940 kWh

Thermal Energy            2,100 kWh

Digestate Produced        29 tonnes

Fertilizer Produced       18 tonnes

Estimated Energy Savings  Mxx,xxx

Estimated CO₂e Avoided    xxx kg

Actual values will come from operational measurements and validated engineering assumptions.

42. Energy Financial Analytics

Management should be able to evaluate:

Energy Generated
Energy Consumed
Energy Cost Avoided
Operating Cost
Maintenance Cost
Fuel Savings
Net Energy Benefit

The system can eventually calculate:

Energy Cost per kWh

and:

Renewable Energy Cost Avoided per Month.

43. Asset Return on Investment

Each renewable-energy installation can have an economic profile:

Capital Cost
+
Installation Cost
+
Operating Cost
+
Maintenance Cost

versus:

Energy Savings
+
Energy Revenue
+
Fertilizer Revenue
+
Other Benefits

The system can then support:

Payback Period
ROI
Annual Savings
Lifetime Savings

These calculations will feed the financial model of PigPower.

44. Biodigester Site Management

Because PigPower eventually wants a decentralized farmer network, the system should support multiple sites.

Example:

National
 │
 ├── Maseru Processing Facility
 │     └── Biodigester 001
 │
 ├── Mafeteng Hub
 │     └── Biodigester 002
 │
 ├── Leribe Hub
 │     └── Biodigester 003
 │
 └── Future Regional Sites

This makes the platform scalable.

45. Decentralized Biodigester Model

Not every farmer needs an individual biodigester.

The platform should support three configurations:

Model A — Centralized

Farm waste is transported to one large facility.

Model B — Hub-Based

Multiple farmers supply a regional biodigester.

Model C — Farm-Based

Large farms operate their own biodigester.

The database should support all three.

46. Energy Site Hierarchy

The database should therefore allow:

Organization
    ↓
Energy Site
    ↓
Energy System
    ↓
Asset
    ↓
Sensor
    ↓
Measurements

Example:

PigPower
 ↓
Maseru Processing Facility
 ↓
Renewable Energy System
 ↓
Biodigester BD-001
 ↓
Gas Flow Sensor GF-001
 ↓
Measurements
47. Technology Architecture

The software architecture could eventually look like:

                   MOBILE APP
                       │
                   HTTPS/API
                       │
                       ▼
                APPLICATION API
                       │
        ┌──────────────┼──────────────┐
        ▼              ▼              ▼
   HR/Payroll      Production       Energy
        │              │              │
        └──────────────┼──────────────┘
                       ▼
                    DATABASE
                       ▲
                       │
                  IoT Gateway
                       ▲
                       │
             Sensors / Smart Meters

This is why the renewable-energy module should be designed as a proper software subsystem rather than as a simple collection of dashboard screens.

48. IoT Data Model

A sensor record should contain information such as:

Sensor ID
Asset ID
Sensor Type
Measurement Type
Unit
Installation Date
Status
Calibration Date
Last Reading

Measurements:

Measurement ID
Sensor ID
Timestamp
Value
Unit
Quality Flag
49. Offline Operation

Because some PigPower sites will be rural, the application should support offline operation.

For example:

Field Operator
      ↓
Records manure collection
      ↓
No Internet
      ↓
Data stored locally
      ↓
Network available
      ↓
Synchronization
      ↓
Central Database

This is an important requirement for Lesotho's rural deployment environment.

50. Data Synchronization

The system should use:

Local Storage
      ↓
Sync Queue
      ↓
API
      ↓
Central Database

Each transaction should have a unique identifier to prevent duplicate records during synchronization.

51. User Roles

Suggested roles include:

Role	Access
Energy Operator	Operational data
Biodigester Operator	Digester operations
Technician	Maintenance
Energy Manager	Energy analytics
Farm Manager	Farm-level energy
Operations Manager	Facility-wide data
Finance	Financial metrics
Environmental Officer	Environmental data
CEO	Executive dashboard
System Administrator	Configuration
52. Security Requirements

Because the module can eventually interact with physical infrastructure:

Authentication is mandatory.
Role-based access control is mandatory.
Critical controls require elevated permissions.
All control actions must be logged.
IoT devices must authenticate with the backend.
API communication must use secure transport.
Device credentials must not be embedded in the mobile application.
Sensor data should be timestamped.
Critical alerts should be auditable.
53. Database Entities

The module should introduce entities such as:

EnergySite
EnergySystem
EnergyAsset
Biodigester
BiodigesterConfiguration

FeedstockSource
FeedstockCollection
FeedstockBatch
DigesterFeedEvent

Sensor
SensorType
SensorReading
SensorAlert

BiogasProduction
BiogasStorage
BiogasConsumption

EnergyGeneration
EnergyConsumption
EnergyMeter
EnergyTariff

SolarSystem
BatterySystem
Generator
EnergyIntegrationEvent

DigestateBatch
FertilizerBatch
FertilizerQualityTest

MaintenanceSchedule
MaintenanceWorkOrder
MaintenanceRecord
EquipmentFault

EnvironmentalMeasurement
CarbonImpactRecord

EnergyCostRecord
EnergySavingsRecord
EnergyRevenueRecord
54. Integration With Other Modules

This module will be highly interconnected.

                 PRODUCTION
                     │
                     ▼
               Pig Population
                     │
                     ▼
                Manure Data
                     │
                     ▼
            RENEWABLE ENERGY
                     │
       ┌─────────────┼──────────────┐
       ▼             ▼              ▼
    ENERGY        FERTILIZER     FINANCE
       │             │              │
       ▼             ▼              ▼
   Operations     Inventory       Accounting
                     │
                     ▼
                    SALES

It will also integrate with:

Farmer Management
Farm Management
Pig Management
Production Management
Collection & Logistics
Inventory
Procurement
Finance
Sales
Maintenance
Impact Reporting
55. Key Business Rules
RE-BR-001 — Unique Energy Asset

Every energy asset must have a unique asset ID.

RE-BR-002 — Valid Site

Every energy asset must belong to an approved PigPower site.

RE-BR-003 — Feedstock Traceability

Every digester feed event must identify its source.

RE-BR-004 — Measurement Integrity

Sensor measurements must include timestamps.

RE-BR-005 — Manual Overrides

Manual entry of sensor readings must be identified and audited.

RE-BR-006 — Critical Alerts

Critical equipment alerts must be escalated to authorized personnel.

RE-BR-007 — Maintenance

Equipment requiring maintenance should be flagged and tracked.

RE-BR-008 — Energy Accounting

Generated energy and consumed energy must be separately recorded.

RE-BR-009 — Fertilizer Traceability

Every fertilizer batch must be traceable to its source digestate.

RE-BR-010 — Carbon Estimates

Environmental and carbon indicators must identify the methodology/status of the calculation.

56. Key Performance Indicators
Biodigester
Feedstock processed/day
Feedstock processed/month
Biogas produced/day
Biogas yield
Digester uptime
Digester downtime
Gas utilization rate
Energy
kWh generated
kWh consumed
Renewable-energy percentage
Energy cost avoided
Energy cost per kWh
Solar generation
Biogas generation
Battery utilization
Circular Economy
Manure processed
Digestate produced
Fertilizer produced
Fertilizer sold
Waste diversion rate
Environmental
Estimated methane captured
Estimated CO₂e avoided
Fossil energy displaced
Renewable energy generated
Financial
Energy savings
Fertilizer revenue
Energy revenue
Operating cost
Maintenance cost
Energy-system ROI
Payback period
57. Executive Dashboard

The CEO/management dashboard could eventually display:

┌────────────────────────────────────────────┐
│       PIGPOWER RENEWABLE ENERGY            │
├────────────────────────────────────────────┤
│                                            │
│ Biogas Produced          1,420 m³          │
│ Renewable Electricity      940 kWh         │
│ Waste Processed             38 tonnes      │
│ Digestate Produced          29 tonnes      │
│ Fertilizer Produced         18 tonnes      │
│ Energy Savings              MXX,XXX        │
│ CO₂e Avoided                XXX kg         │
│                                            │
│ Renewable Energy Share        XX%          │
│ Biodigester Uptime            XX%          │
│                                            │
└────────────────────────────────────────────┘
58. Mobile Application Screens

The Flutter application could eventually contain:

Energy Dashboard
     │
     ├── Sites
     │
     ├── Biodigesters
     │
     ├── Feedstock
     │
     ├── Biogas
     │
     ├── Electricity
     │
     ├── Solar
     │
     ├── Batteries
     │
     ├── Digestate
     │
     ├── Fertilizer
     │
     ├── Maintenance
     │
     ├── Alerts
     │
     └── Reports
59. Farmer-Facing Functionality

For farmers participating in the decentralized network, the mobile app could eventually show:

My Farm
   ↓
Pig Population
   ↓
Estimated Manure
   ↓
Waste Collection
   ↓
Energy Contribution
   ↓
Fertilizer Received
   ↓
Environmental Impact

This creates an important psychological and economic connection:

The farmer does not merely produce pigs; the farmer contributes to PigPower's circular energy ecosystem.

60. Acceptance Criteria

The module will be considered functionally complete when:

Asset Management
 Energy sites can be created.
 Biodigesters can be registered.
 Energy assets can be registered.
 Asset status can be tracked.
Feedstock
 Feedstock sources can be registered.
 Manure collections can be recorded.
 Feedstock batches can be tracked.
 Digester feed events can be recorded.
Biogas
 Biogas production can be recorded.
 Gas consumption can be recorded.
 Gas storage can be tracked.
 Gas-related alerts can be generated.
Energy
 Electricity generation can be recorded.
 Electricity consumption can be recorded.
 Solar systems can be monitored.
 Battery systems can be monitored.
 Renewable-energy share can be calculated.
Fertilizer
 Digestate batches can be recorded.
 Fertilizer production can be recorded.
 Fertilizer inventory can integrate with warehouse management.
 Fertilizer batches can be traced.
Maintenance
 Maintenance schedules can be configured.
 Work orders can be created.
 Faults can be recorded.
 Maintenance history can be retained.
Environmental
 Waste processing can be measured.
 Renewable energy can be measured.
 Carbon-impact estimates can be generated.
 Environmental reports can be produced.
61. Strategic Importance to PigPower

This module is one of the features that transforms PigPower from:

a digital pig-farming management system

into:

a circular agricultural infrastructure platform.

The complete PigPower ecosystem becomes:

                 PIGPOWER PLATFORM
                       │
       ┌───────────────┼────────────────┐
       ▼               ▼                ▼
  FARMERS          LIVESTOCK         PROCESSING
       │               │                │
       └───────────────┼────────────────┘
                       ▼
                    WASTE
                       │
                       ▼
                 BIODIGESTER
                 ┌─────┴─────┐
                 ▼           ▼
              BIOGAS     DIGESTATE
                 │           │
                 ▼           ▼
              ENERGY     FERTILIZER
                 │           │
                 └─────┬─────┘
                       ▼
                CIRCULAR VALUE
                     CREATION

