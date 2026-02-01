\# Project 2 – Azure Front Door + YARP Gateway Architecture



\## Overview



This project demonstrates a \*\*production‑style API exposure architecture\*\* using \*\*Azure Front Door (Standard)\*\* as a global edge, a \*\*YARP-based Gateway\*\* for internal routing, and multiple \*\*backend APIs hosted on Azure App Service\*\*.



The goal is to expose multiple backend services through \*\*one stable public endpoint\*\*, while keeping backend services isolated and independently deployable.



---



\## High-Level Architecture



Client → \*\*Azure Front Door (Standard)\*\* → \*\*Gateway (YARP on App Service)\*\* → \*\*Backend APIs (App Service)\*\*



\* \*\*Azure Front Door\*\*: Global HTTPS entry point and path-based routing

\* \*\*Gateway (YARP)\*\*: Internal reverse proxy and routing layer

\* \*\*Backend APIs\*\*: Mortgage API and Loan API, independently deployed



---



\## Backend Services



\### Mortgage API



\* Hosted on Azure App Service

\* Exposes:



&nbsp; \* `/api/mortgages`



\### Loan API



\* Hosted on Azure App Service

\* Exposes:



&nbsp; \* `/api/loans`



Both APIs are \*\*not exposed directly to clients\*\* in the final architecture.



---



\## Gateway (YARP)



The Gateway is implemented using \*\*YARP (Yet Another Reverse Proxy)\*\* and performs \*\*path-based routing\*\*.



\### Routing Rules



| Incoming Path  | Destination  |

| -------------- | ------------ |

| `/mortgages/\*` | Mortgage API |

| `/loans/\*`     | Loan API     |



\### Key Benefits



\* Centralized routing logic

\* Backend APIs remain decoupled from clients

\* Easy to add new services without changing Front Door



---



\## Azure Resources Used



\* \*\*Azure App Service Plan (B1, Windows)\*\* – shared compute

\* \*\*Azure App Service\*\*



&nbsp; \* Mortgage API

&nbsp; \* Loan API

&nbsp; \* Gateway

\* \*\*Azure Front Door (Standard)\*\*



&nbsp; \* Profile

&nbsp; \* Origin Group

&nbsp; \* Origin (Gateway)

&nbsp; \* Endpoint

&nbsp; \* Route (`/\*`)



---



\## Deployment Flow (Summary)



1\. Validate APIs and Gateway locally

2\. Deploy backend APIs to Azure App Service

3\. Validate APIs directly in Azure

4\. Deploy Gateway to Azure App Service

5\. Validate Azure Gateway → Azure APIs

6\. Introduce Azure Front Door

7\. Route traffic from Front Door → Gateway → APIs

8\. Validate end-to-end flow using Front Door endpoint



---



\## Validation



The following end-to-end flows were validated successfully:



\* \*\*AFD → Gateway → Mortgage API\*\* → `200 OK`

\* \*\*AFD → Gateway → Loan API\*\* → `200 OK`



This confirms correct configuration of:



\* Azure Front Door routing

\* Gateway routing (YARP)

\* Backend API accessibility



---



\## Why This Architecture Matters



This design solves key enterprise problems:



\* Single public API entry point

\* Backend service isolation

\* Centralized routing and governance

\* Scalability without client impact

\* Foundation for security, WAF, authentication, and monitoring



This pattern is commonly used in \*\*banking, fintech, and large enterprise platforms\*\*.



---



\## Resume Summary



> Designed and implemented a multi‑API gateway architecture using Azure Front Door and YARP, routing traffic to independently deployed backend services hosted on Azure App Service, with full end‑to‑end validation.



---



\## Status



✅ Project completed and validated end‑to‑end



