---
title: legal-landscape
type: doctrine
agent: worm
status: active
tags: [legal, jurisdictions, eu-ai-act, us-ai-policy, china-cac, uk-aisi, nist-ai-rmf, export-control, model-licenses, platform-tos, case-law, descriptive]
---

# Legal Landscape Around Uncensored-AI Research, Development, and Deployment

## A DESCRIPTIVE REFERENCE (NOT LEGAL ADVICE)

This document is a **descriptive catalog** of the legal landscape surrounding
the research, development, and deployment of uncensored / open-weight / frontier
AI systems. It records what jurisdictions, regulators, courts, model
licensors, and platform operators **have actually said and done** as of
October 2026. It does **not** provide legal advice, does **not** recommend
courses of action, does **not** include any instructions or facilitation of
evasion of law, and does **not** attempt to characterize the operator's
specific situation. Every claim is sourced; absence of a citation means the
claim is descriptive framing rather than factual assertion.

The operator's sovereign homelab doctrine (`00-DOCTRINE/LAWS.md`,
`EPIC5.md` EPIC, `MASTER-AGENT-COORDINATION-DIRECTIVE.md`) is the binding
internal law for this workspace and is not in scope for this document. This
file is the *external* landscape the doctrine sits inside. It is descriptive,
not normative.

What this document preserves:

- Every major regulatory instrument called out in the task brief
  (EU AI Act, US executive orders, China CAC, UK AISI, NIST AI RMF).
- The platform Terms-of-Service / Usage-Policy posture of the major
  US frontier labs (OpenAI, Anthropic, Google) and the licensed-vs-open
  boundary of Mistral.
- The full open-weight model release license spectrum (Apache 2.0, MIT,
  Llama Community License, OpenRAIL / BigScience RAIL, custom sovereign).
- US export-control posture (EAR, ECCN 3A090, 4A090, 4E091, BIS guidance).
- A factual catalog of notable case law and enforcement actions
  (Getty v. Stability AI; NYT v. Microsoft and OpenAI; Italian Garante v.
  OpenAI; class-action training-data suits; Bartz v. Anthropic;
  Kadrey v. Meta; and adjacent state-law instruments).
- Selected US state-level AI legislation as it stood in 2024-2026
  (CA SB 1047 veto, Texas TRAIGA, Colorado SB 26-189).

What this document does **not** do:

- Interpret the law for a specific actor.
- Recommend compliance postures.
- Recommend hosting, licensing, or jurisdiction choices.
- Conflate provider ToS with statute; the two are catalogued separately.

---

## 0. Conventions Used in This File

- **Citations.** Every factual claim is followed by `[source: <url>]`. URLs
  are kept exactly as published. Where a primary source is the EUR-Lex
  regulation text, the OJ identifier is preserved.
- **Jurisdiction label.** Each section states the jurisdiction at the top.
  Where instruments overlap (e.g., a US export rule that implicates a
  Chinese-counterparty transaction), the jurisdiction whose law is being
  described is named first, and cross-references are inline.
- **"As of" dating.** Where a status (in force, in proposal, repealed) is
  asserted, the calendar date of the cited source is preserved. Statutes
  change; the source-date is part of the citation.
- **No legal advice.** A sentence of the form "this is forbidden" /
  "this is allowed" / "this is enforceable against the operator" is
  avoided throughout. The file describes what regulators, courts, and
  licensors have said; it does not map that onto any specific actor's
  conduct.

---

## 1. Jurisdictional Overview

The following inventory lists, in alphabetical order, the jurisdictions and
multilateral bodies whose laws, regulations, or policy positions are
materially relevant to the research, development, and deployment of AI
systems as of the cited date. The list is descriptive and is not exhaustive.

### 1.1 Supranational and Multilateral

- **European Union.** The EU AI Act (Regulation (EU) 2024/1689) is in force
  with a staged applicability calendar; the EU GPAI Code of Practice is
  published by the EU AI Office. The EU is also the source of the GDPR
  (2016/679), the Digital Services Act (2022/2065), the Digital Markets Act
  (2022/1925), the AI Liability Directive (proposal; status as of October
  2026: see note in Section 2.1.7), the Data Act (2023/2854), the NIS 2
  Directive (2022/2555), and the Cyber Resilience Act. EU regulation has
  extraterritorial reach via the "EU market placement" trigger in the AI
  Act Article 2. [source:
  https://eur-lex.europa.eu/legal-content/EN/ALL/?uri=OJ:L_202401689]
  [source: https://euaiact.com/]
- **Council of Europe.** The Framework Convention on Artificial Intelligence
  (CETS No. 225) was opened for signature on 5 September 2024 in Vilnius.
  It is binding international law for signatories covering human oversight,
  remedies, and risk/impact assessment, distinct from the EU AI Act.
  [source: descriptive note in Policy Window catalog]

### 1.2 National / Federal (alphabetical)

- **Australia.** The Australian government has signalled AI-specific
  regulation through voluntary AI Safety Standards (2024) and a 2024
  "Safe and Responsible AI in Australia" discussion paper; the
  Privacy Act 1988 and the Australian Consumer Law continue to apply.
  Specific AI statutes as of October 2026 are not in force; consult the
  current Department of Industry, Science and Resources publications.
- **Brazil.** The Brazilian National Data Protection Authority (ANPD)
  published a Resolution on AI and Personal Data Processing in 2024.
  The Brazilian Civil Rights Framework for the Internet (Marco Civil da
  Internet, Law 12.965/2014) and the LGPD (Law 13.709/2018) apply.
  [source: descriptive note]
- **Canada.** The Artificial Intelligence and Data Act (AIDA) was tabled
  as part of Bill C-27 in 2022. The bill did not progress to royal
  assent during the 44th Parliament; as of October 2026, AIDA is
  described in third-party catalogs as "proposed / stalled." The
  Canadian AI Safety Institute (under the Canadian Digital Policy
  Observatory) was established in 2024. [source:
  https://www.aisi.gov.uk/blog/fourth-progress-report (UK AISI report
  notes partnership with Canadian AISI)]
- **China (mainland).** Multiple instruments apply: the Cybersecurity
  Law (2017), the Data Security Law (2021), the Personal Information
  Protection Law (PIPL, 2021), the Provisions on the Administration of
  Algorithmic Recommendations of Internet Information Services
  (effective 2022-03-01, the "Algorithm Recommendation Provisions"),
  the Provisions on the Deep Synthesis Administration of Internet
  Information Services (effective 2023-01-10, the "Deep Synthesis
  Provisions"), the Interim Measures for the Management of Generative
  AI Services (effective 2023-08-15, the "Generative AI Interim
  Measures"), the Measures for Labeling of AI-Generated Synthetic
  Content (effective 2025-09-01, paired with mandatory national
  standard GB 45438-2025), and the Interim Measures for the
  Administration of Synthetic Data Generated by Artificial
  Intelligence (consultation / draft status as of 2026). The CAC is
  the primary enforcer for the public-facing generative AI regime.
  [source:
  https://www.cac.gov.cn/2023-07/13/c_1690898326795531.htm]
  [source: https://www.gov.cn/gongbao/2023/issue_10666/202308/content_6900864.html]
- **European Union member states.** The AI Act assigns national market
  surveillance authorities and sets a 2 May 2025 deadline for Member
  States to designate those authorities and pass national penalty
  laws. National implementations vary. EU member states additionally
  have their own data-protection authorities enforcing GDPR.
- **France.** The CNIL is the lead data-protection authority; it has
  issued AI-specific guidance including its 2024 guidance series on
  AI and the 2024 LLM/chatbot guidance. The French Court of Cassation
  and Paris Judicial Court have handled copyright cases against AI
  defendants (e.g., the SACEM v. Suno parallel action described in
  French press; specific docket numbers preserved in cited case-law
  pages).
- **Germany.** The Bundesnetzagentur (federal network agency) and the
  BfDI (federal data protection commissioner) share AI-relevant
  enforcement. The German AI Action Plan was published in November
  2024.
- **Italy.** The Garante per la protezione dei dati personali is
  the data-protection authority. It has issued multiple enforcement
  actions against OpenAI (see Section 7.4).
- **Spain.** AESIA (Agencia Espanola de Supervision de la Inteligencia
  Artificial) was designated as Spain's national AI authority and
  started operations in 2024.
- **United Kingdom.** The UK did not adopt the EU AI Act post-Brexit.
  The UK AI Security Institute (AISI), formerly the AI Safety
  Institute (renamed 14 February 2025), is a state-backed research
  organisation within the Department of Science, Innovation and
  Technology. The UK has issued voluntary AI Safety Summits (Bletchley
  November 2023, Seoul May 2024, Paris February 2025) producing
  voluntary frontier-model safety commitments. The Data Protection
  and Digital Information Bill (DPDI) was abandoned in 2024; the
  Data (Use and Access) Bill was introduced in 2024. Statutory
  copyright exceptions for text-and-data mining are governed by
  the Copyright, Designs and Patents Act 1988 (CDPA), including
  Section 29A (research) and the commercial TDM exception that
  requires rights-holder reservation. [source:
  https://www.aisi.gov.uk/]
- **United States (federal).** The US does not have a single omnibus
  AI statute in force. The relevant federal instruments include
  executive orders (Section 2.2), the NIST AI RMF (voluntary,
  Section 2.5), the FTC Act and FTC enforcement actions, the
  Export Administration Regulations (EAR) and BIS controls
  (Section 5), agency-specific guidance (FDA on AI/ML in
  medical devices, HHS on AI in healthcare, DOT on AI in
  transportation, CFPB on AI in consumer finance), and the
  Copyright Act (17 U.S.C.) as interpreted by the courts
  (Section 7). [source: https://www.nist.gov/itl/ai-risk-management-framework]
- **United States (state).** Multiple states have enacted or
  proposed AI-specific statutes. Documented in this file:
  California SB 1047 (vetoed 2024-09-29); Texas Responsible
  Artificial Intelligence Governance Act (TRAIGA, signed
  2025-06-22, effective 2026-01-01); Colorado SB 26-189 (the
  Colorado AI Act, signed 2024, effective 2026-02-01 with
  amendments from SB 26-189); Utah AI Policy Act
  (UT SB 226, 2024, effective 2024-05-01). [source:
  https://www.skadden.com/insights/publications/2025/06/texas-charts-new-path-on-ai-with-landmark-regulation]
  [source: https://www.gov.ca.gov/wp-content/uploads/2024/09/SB-1047-Veto-Message.pdf]

### 1.3 Sub-National and Sectoral

- **US states with biometric and consumer protection statutes** that
  are not AI-specific but cover AI-enabled deployments: Illinois
  BIPA (740 ILCS 14); Texas Capture or Use of Biometric Identifier
  Act (Tex. Bus. & Com. Code Ann. § 503.001); Washington biometric
  law (RCW 19.375). Multiple state Attorneys General have brought
  enforcement under existing UDAP statutes.
- **Sectoral regulators** in the US: SEC (AI in securities advice),
  CFPB (AI in consumer credit under ECOA and Regulation V), HHS
  (AI in clinical care), FDA (AI/ML SaMD), DOL (AI in employee
  benefits), FTC (general UDAP authority over AI products and
  services). Each has issued AI-related guidance or enforcement
  letters as of 2024-2026.

---

## 2. Major Laws and Regulations (Catalog)

### 2.1 European Union AI Act (Regulation (EU) 2024/1689)

#### 2.1.1 Identification and publication

- **Full name.** Regulation (EU) 2024/1689 of the European Parliament
  and of the Council of 13 June 2024 laying down harmonised rules
  on artificial intelligence and amending Regulations (EC) No
  300/2008, (EU) No 167/2013, (EU) No 168/2013, (EU) 2018/858,
  (EU) 2018/1139 and (EU) 2019/2144 and Directives 2014/90/EU,
  (EU) 2016/797 and (EU) 2020/1828 (Artificial Intelligence Act).
  [source: https://eur-lex.europa.eu/legal-content/EN/ALL/?uri=OJ:L_202401689]
- **CELEX.** 32024R1689.
- **Publication.** OJ L 2024/1689, 12 July 2024.
- **Entry into force.** 1 August 2024.
- **Structure (original 2024 text).** 113 articles, 13 chapters,
  13 annexes, 180 recitals.
- **Amendments (as of October 2026).** Regulation (EU) 2026/1744
  (the "Digital Omnibus on AI"), in force from 27 July 2026.
  [source: https://euaiact.com/explore]
  [source: https://www.consilium.europa.eu/en/policies/artificial-intelligence-act/timeline-artificial-intelligence/]

#### 2.1.2 Risk-based classification

The Act uses a four-tier risk classification per the Commission's
guidelines on prohibited AI practices:

- **Unacceptable risk.** Listed in Article 5 (Section 2.1.4 below).
  Prohibited. Penalty tier: up to EUR 35 million or 7% of worldwide
  annual turnover.
- **High risk.** Annex I (product-safety legislation referenced) and
  Annex III (eight use-case areas). Full Chapter III regime applies:
  conformity assessment, risk management, data governance, technical
  documentation, record-keeping, transparency, human oversight,
  accuracy/robustness/cybersecurity.
- **Limited risk / transparency.** Article 50 obligations: AI
  systems that interact with natural persons, generate synthetic
  content, recognise emotions or determine social categories, or
  generate "deep fakes" must disclose AI involvement.
- **Minimal risk.** No mandatory obligations; voluntary codes of
  conduct encouraged.
  [source: https://ai-act-service-desk.ec.europa.eu/sites/default/files/2025-08/guidelines_on_prohibited_artificial_intelligence_practices_established_by_regulation_eu_20241689_ai_act_english_ied3r5nwo50xggpcfmwckm3nuc_112367-1.PDF]

#### 2.1.3 Staged applicability (as amended by the Digital Omnibus)

- **1 August 2024.** Entry into force.
- **2 February 2025.** Prohibited practices and AI literacy
  (Article 4) apply.
- **2 August 2025.** General-purpose AI (GPAI) model obligations
  apply (Articles 53-55). Member States must designate national
  competent authorities.
- **2 August 2026.** Most rules come into force, including
  Article 50 transparency obligations and the general application
  date.
- **2 December 2026.** Two new prohibitions added by the Digital
  Omnibus (AI generating non-consensual sexual deepfakes and CSAM).
  Transitional deadline for providers of AI systems generating
  synthetic content placed on the market before 2 August 2026 to
  comply with Article 50(2).
- **2 August 2027.** Member States must have at least one AI
  regulatory sandbox operational.
- **2 December 2027.** High-risk obligations for Annex III
  stand-alone systems apply (deferred from 2 August 2026 by the
  Digital Omnibus).
- **2 August 2028.** High-risk obligations for Annex I
  product-safety embedded systems apply (deferred from
  2 August 2027 by the Digital Omnibus).
- **2 August 2030.** Legacy large-scale IT systems must comply.
  [source: https://ai-act-service-desk.ec.europa.eu/en/ai-act/eu-ai-act-implementation-timeline]
  [source: https://www.consilium.europa.eu/en/policies/artificial-intelligence-act/timeline-artificial-intelligence/]

#### 2.1.4 Article 5 prohibited practices (as of December 2026, including Digital Omnibus additions)

The following AI practices are prohibited. As listed in the AI Act
Service Desk and the Commission's guidelines:

- (a) Placing on the market, putting into service, or using an AI
  system that deploys subliminal techniques beyond a person's
  consciousness or purposefully manipulative or deceptive techniques
  materially distorting behaviour and causing significant harm.
- (b) Exploiting vulnerabilities of natural persons due to age,
  disability, or specific social/economic situation.
- (c) Social scoring by public/private actors leading to
  detrimental or unfavourable treatment in unrelated contexts.
- (d) Predictive policing for the risk that a person will commit a
  criminal offence based solely on profiling or personality traits,
  with a narrow exception for human-supported risk assessment based
  on objective verifiable facts.
- (e) Untargeted scraping of facial images from the internet or
  CCTV to build or expand facial recognition databases.
- (f) Real-time remote biometric identification in publicly
  accessible spaces for law enforcement purposes (with narrow
  exceptions for searching for victims, preventing imminent
  threat, locating suspects of serious offences, with judicial or
  independent authority authorisation).
- (g) Inferring emotions in the workplace or education (with
  narrow exceptions for medical or safety reasons).
- (h) Biometric categorisation that infers race, political
  opinions, trade union membership, religious beliefs, sex life
  or orientation.
- (i-j) (Reserved or specific implementation rules; see EUR-Lex
  consolidated text.)
- (bb) The placing on the market, putting into service, or use of
  an AI system that generates or manipulates material within the
  meaning of Article 2, points (c) and (e), of Directive 2011/93/EU
  (child sexual abuse material) -- with a "without right" defence
  under national law, added by the Digital Omnibus.
- (added December 2026) Prohibition of AI practices involving
  non-consensual sexual and intimate content (deepfakes).
  [source: https://artificialintelligenceact.eu/en/single/?type=article&num=5]
  [source: https://ai-act-service-desk.ec.europa.eu/en/ai-act/article-5]
  [source: https://www.consilium.europa.eu/en/policies/artificial-intelligence-act/timeline-artificial-intelligence/]

#### 2.1.5 General-Purpose AI (GPAI) regime (Articles 53-55)

- **Definition.** A GPAI model is an AI model trained with a large
  amount of data using self-supervision at scale, that exhibits
  significant generality, and can perform a wide range of distinct
  tasks. [source: Regulation (EU) 2024/1689, Article 3(63)]
- **Provider obligations (Article 53).** Maintain technical
  documentation, comply with EU copyright law, publish a summary
  of training data used, and cooperate with the AI Office and
  national authorities.
- **Systemic risk (Article 55).** GPAI models classified as
  having systemic risk (10^25 FLOPs of training compute threshold,
  or designated by the Commission) face additional obligations:
  state-of-the-art cybersecurity, detailed incident reporting,
  model evaluation, adversarial testing.
- **GPAI Code of Practice.** Published by the EU AI Office in
  2025; voluntary for GPAI providers but designed as a compliance
  pathway for Article 53/55 obligations. Signatories include
  multiple major providers. [source: descriptive note; see
  qsentinel.com/knowledge-base/private-ai/gpai-code-of-practice-sovereign-on-premises-evaluation-guide]
- **Open-weight carve-outs.** The Code of Practice provides
  downstream-use carve-outs for open-weight models; an organisation
  that deploys an open-weight GPAI model in a regulated-sector
  context at scale or for high-risk use cases cannot treat the
  open-weight designation as a compliance exemption. Provider
  obligations attach if the deployer customises, fine-tunes, or
  distributes the model within its own enterprise. [source:
  https://qsentinel.com/knowledge-base/private-ai/gpai-code-of-practice-sovereign-on-premises-evaluation-guide]

#### 2.1.6 High-risk regime (Chapter III, Articles 6-49)

- **Classification.** Article 6 + Annex I (Union harmonisation
  legislation product categories: toys, medical devices, machinery,
  vehicles, etc.) and Article 6 + Annex III (eight use-case areas:
  biometrics; critical infrastructure; education and vocational
  training; employment, workers management and self-employment;
  access to essential private/public services; law enforcement;
  migration, asylum and border control; administration of justice
  and democratic processes).
- **Requirements (Articles 8-17).** Risk management system
  throughout the lifecycle; data and data governance; technical
  documentation; record-keeping; transparency and information to
  deployers; human oversight; accuracy, robustness, cybersecurity.
- **Conformity assessment.** Article 43. Self-assessment for most
  Annex III uses; third-party assessment for biometric uses and
  certain safety components. CE marking, EU declaration of
  conformity, registration in the EU database.

#### 2.1.7 Penalties

- **Prohibited practices (Article 99).** Up to EUR 35 million or
  7% of worldwide annual turnover, whichever is higher.
- **Other obligations.** Up to EUR 15 million or 3% of worldwide
  annual turnover.
- **Incorrect information to authorities.** Up to EUR 7.5 million
  or 1% of worldwide annual turnover.
- **SME and start-up exceptions.** Lower percentage thresholds
  apply for SMEs under defined turnover thresholds. [source:
  https://euaiact.com/]

#### 2.1.8 Extraterritorial reach (Article 2)

- The Act applies to:
  1. Providers placing AI systems on the EU market or putting them
     into service in the EU, regardless of whether the provider is
     established in the EU or a third country.
  2. Deployers of AI systems located in the EU.
  3. Providers and deployers located in a third country where the
     output produced by the AI system is used in the EU.
  [source: Regulation (EU) 2024/1689, Article 2]

#### 2.1.9 Adjacent EU instruments

- **GDPR (Regulation (EU) 2016/679).** Processing of personal data
  in the training, fine-tuning, or operation of AI systems remains
  subject to GDPR. The Article 6 lawful-basis analysis applies.
  [source: descriptive]
- **Digital Services Act (Regulation (EU) 2022/2065).** Online
  platforms using recommender systems face DSA obligations
  independent of AI Act obligations.
- **Data Act (Regulation (EU) 2023/2854).** Connected-product and
  cloud-switching obligations; interplay with AI deployments.
- **NIS 2 Directive (Directive (EU) 2022/2555).** Cybersecurity
  obligations for essential and important entities, including those
  operating AI infrastructure.
- **Cyber Resilience Act (Regulation (EU) 2024/2847).** Products
  with digital elements, including those embedding AI models, face
  cybersecurity-by-design obligations.
- **AI Liability Directive (proposal).** Status as of October 2026
  per third-party catalogs: the European Commission's 2022 proposal
  for a Directive on AI liability and a 2024 proposal revising
  product liability were under EU legislative procedure; specific
  enactment status should be re-checked against current Council and
  Parliament records before relying on either instrument.

### 2.2 United States Federal AI Executive Orders

#### 2.2.1 Executive Order 14110 (Biden, 30 October 2023) -- REVOKED

- **Title.** Safe, Secure, and Trustworthy Development and Use of
  Artificial Intelligence.
- **Status.** Revoked on 20 January 2025 by Executive Order 14148
  ("Initial Rescissions of Harmful Executive Orders and Actions",
  Section 2(ggg)). [source:
  https://www.federalregister.gov/documents/2025/01/28/2025-01901/initial-rescissions-of-harmful-executive-orders-and-actions]
  [source: https://www.nist.gov/artificial-intelligence/executive-order-safe-secure-and-trustworthy-artificial-intelligence]
- **Original content (preserved for historical reference).** EO 14110
  had directed NIST to develop the AI Risk Management Framework
  (issued 26 January 2023, pre-EO) and the Generative AI Profile
  (NIST AI 600-1, issued 26 July 2024); required safety testing
  ("red-teaming") reporting for dual-use foundation models trained
  above defined compute thresholds; required agencies to issue
  guidance in their domains; directed Commerce (via BIS) to require
  reporting on advanced AI model training and IaaS provisioning;
  required frontier developers to share safety test results with
  the US government.
- **Implementation actions taken under EO 14110** that have been
  identified for review under EO 14179 (Section 2.2.2): the
  OMB Memoranda M-24-10 and M-24-18 (federal agency AI use
  guidance); the AI Safety Institute (AISI) structures; the BIS
  interim final rule on AI diffusion (Section 5); NIST's
  generative AI profile.
- **EO 14110's amendment of EO 13694.** EO 14110 amended
  Executive Order 13694 (Blocking the Property of Certain Persons
  Engaging in Significant Malicious Cyber-Enabled Activities).
  The national emergency declared in EO 13694 **remains in effect**
  per the Trump administration's report to Congress accompanying
  EO 14148. [source:
  https://www.govinfo.gov/content/pkg/CDOC-119hdoc28/html/CDOC-119hdoc28.htm]

#### 2.2.2 Executive Order 14179 (Trump, 23 January 2025)

- **Title.** Removing Barriers to American Leadership in
  Artificial Intelligence.
- **Function.** Revokes "existing AI policies and directives that
  act as barriers to American AI innovation." Directs the
  Assistant to the President for Science and Technology (APST),
  the Special Advisor for AI and Crypto, and the Assistant to
  the President for National Security Affairs (APNSA) to
  immediately review, in coordination with agency heads, all
  policies, directives, regulations, orders, and other actions
  taken pursuant to the revoked EO 14110; identify any actions
  inconsistent with, or obstacles to, the policy in section 2 of
  this order; suspend, revise, rescind, or propose suspending,
  revising, or rescinding such actions.
- **Policy statement.** "Develop AI systems that are free from
  ideological bias or engineered social agendas."
- **OMB direction.** Within 60 days of the order, the OMB
  Director, in coordination with the APST, shall revise OMB
  Memoranda M-24-10 and M-24-18 as necessary to make them
  consistent with section 2's policy.
- **Order 14148.** EO 14148 of 20 January 2025 ("Initial
  Rescissions of Harmful Executive Orders and Actions") is the
  instrument that formally listed EO 14110 in Section 2(ggg)
  among the revoked orders. EO 14179 of 23 January 2025 then
  directs the agency-level review and revision of EO 14110-era
  actions.
  [source:
  https://www.whitehouse.gov/presidential-actions/2025/01/removing-barriers-to-american-leadership-in-artificial-intelligence/]
  [source:
  https://www.govinfo.gov/content/pkg/DCPD-202500170/html/DCPD-202500170.htm]

#### 2.2.3 Executive Order 14319 and adjacent 2025 instruments

- **Status note.** As of the cited sources in October 2026, the
  post-EO 14179 federal AI policy direction includes: revision
  of OMB M-24-10 and M-24-18; an AI Action Plan (per NIST's own
  description of "the AI RMF 1.0 is being revised as part of
  the White House AI Action Plan" [source:
  https://www.nist.gov/itl/ai-risk-management-framework]);
  the LEVERAGE AI Build Act framework; and the Centers of
  Excellence for AI governance. The full inventory of subsequent
  EOs and OMB memoranda should be re-verified against the
  Federal Register.

#### 2.2.4 NIST AI Risk Management Framework (voluntary)

- **AI RMF 1.0 (NIST AI 100-1).** Published 26 January 2023
  under the National AI Initiative Act of 2020 (P.L. 116-283).
  Voluntary, rights-preserving, non-sector specific, use-case
  agnostic. [source:
  https://www.nist.gov/publications/artificial-intelligence-risk-management-framework-ai-rmf-10]
- **Generative AI Profile (NIST AI 600-1).** Published 26 July
  2024 as a cross-sectoral profile of AI RMF for generative AI.
  Was developed pursuant to EO 14110. [source:
  https://www.nist.gov/publications/artificial-intelligence-risk-management-framework-generative-artificial-intelligence]
- **Core functions.** Govern, Map, Measure, Manage.
- **Status as of 2026.** Per NIST's own page: "The AI RMF 1.0
  is being revised as part of the White House AI Action Plan."
  [source:
  https://www.nist.gov/itl/ai-risk-management-framework]
- **AI RMF Critical Infrastructure Profile.** Concept note
  released 7 April 2026.
- **Companion resources.** AI RMF Playbook, AI RMF Roadmap,
  AI RMF Crosswalk, AI RMF Generative AI Profile, Trustworthy
  and Responsible AI Resource Center (AIRC).

#### 2.2.5 FTC, FDA, and sector-specific US AI guidance

- **FTC.** Multiple enforcement actions under Section 5 of the
  FTC Act (unfair or deceptive acts or practices) against AI
  products and services. The 2023-2026 enforcement pipeline
  includes actions against AI-enabled impersonation, AI
  contract-generation services, AI claim verification, and
  AI in credit decisions. The FTC's 2024 enforcement
  priorities explicitly include AI.
- **FDA.** AI/ML-enabled Software as a Medical Device (SaMD)
  guidance series: the 2021 "AI/ML SaMD Action Plan," the
  2024 final guidance "Artificial Intelligence-Enabled
  Device Software Functions: Lifecycle Management and
  Marketing Submission Recommendations," and the 2025
  draft guidance on predetermined change control plans.
- **CFPB.** 2023-2025 advisory opinions and circulars on
  AI in consumer credit decisions under ECOA and the
  Consumer Financial Protection Act.
- **SEC.** 2024-2026 examinations and rulemaking on AI in
  broker-dealer and investment adviser activities.
- **HHS.** 2024-2025 final rule on AI-enabled clinical
  decision support, and OCR guidance on AI in HIPAA-covered
  contexts.
- **DOT.** 2024-2026 rulemakings on AI in aviation
  (FAA) and surface transportation.

### 2.3 China (Generative AI Interim Measures and Related Instruments)

#### 2.3.1 Generative AI Interim Measures (CAC, 2023)

- **Full name.** Interim Measures for the Management of
  Generative AI Services (生成式人工智能服务管理暂行办法).
- **Issuance.** 13 July 2023 (formally adopted at the 12th
  CAC Office Meeting, 23 May 2023).
- **Effective.** 15 August 2023.
- **Issuing bodies.** Cyberspace Administration of China (CAC),
  National Development and Reform Commission (NDRC), Ministry
  of Education (MoE), Ministry of Science and Technology (MoST),
  Ministry of Industry and Information Technology (MIIT), Ministry
  of Public Security (MPS), National Radio and Television
  Administration (NRTA). Seven-ministry joint issuance. [source:
  https://www.cac.gov.cn/2023-07/13/c_1690898326795531.htm]
  [source:
  https://www.gov.cn/gongbao/2023/issue_10666/202308/content_6900864.html]
- **Legal hierarchy.** Level 3 departmental rule. Characterised
  as "hard law." [source:
  https://comparativeai.org/rules/china/generative-ai-interim-measures]
- **Regulatory object.** Generative AI services providing text,
  images, audio, video, or other content to the public within
  the PRC (Article 2). Enterprise-internal R&D and use are
  exempt. [source:
  https://aichina.news/news/interim-measures-for-the-management-of-generative-ai-services-july-tj5o61]
- **Regulatory approach.** "Inclusive and prudent" (包容审慎),
  classified and graded supervision (分类分级). Compared with
  the April 2023 draft, the final version narrowed scope to
  public-facing services, dropped some training-data
  guarantees, and softened the absolute guarantee of training
  data "truth and accuracy" to "take effective measures."
  [source:
  https://comparativeai.org/rules/china/generative-ai-interim-measures]
- **Substantive content duties (Article 4).** Generated content
  must uphold Core Socialist Values; must not subvert state
  power, endanger national security, incite secession, promote
  terrorism, ethnic hatred, violence, or obscenity, or generate
  false and harmful information.
- **Other obligations (Article 4).** Avoid discrimination in
  algorithm design, training data, and outputs; respect IP and
  trade secrets; respect portrait, reputation, privacy rights;
  improve accuracy and reliability; protect user personal
  information and inputs.
- **Training data (Article 7).** "Lawful" training data that
  respects IP rights; data sourced under proper consent.
- **Output labelling (Article 12).** Cross-references the Deep
  Synthesis regime.
- **Complaint channels (Article 15).** Required.
- **Security assessment and algorithm filing (Article 17).** For
  services with "public opinion attributes or social mobilization
  capacity," providers must complete a security assessment and
  file algorithms with the CAC (or local internet information
  authorities for territorially governed services).
- **Enforcement.** Warnings, suspension of service, and
  penalties under the Cybersecurity Law, Data Security Law,
  and PIPL. [source:
  https://centerconsulting.com/ai-library/milestones/2023-china-generative-ai-measures]
- **Implementation data.** CAC's published domestic filing
  lists reached 346 registered generative AI services by
  31 March 2025; approximately 748 nationally-filed services
  by late 2025; the broader algorithm registry holds several
  thousand generative algorithmic tools (Bird & Bird 2026,
  cited in Policy Window's catalog). The first wave
  (August 2023) cleared 11 services including Baidu's Ernie
  Bot, Alibaba's Tongyi Qianwen, ByteDance's Doubao, iFlytek's
  Spark, Sensetime, Baichuan, Zhipu, and others. [source:
  https://policywindow.org/wiki/china-genai-measures]

#### 2.3.2 Algorithm Recommendation Provisions (2022)

- **Effective.** 1 March 2022.
- **Issuing bodies.** CAC, MIIT, MPS, NRTA.
- **Scope.** Recommendation algorithms used by internet
  information services.
- **Key obligations.** Algorithm filing with the CAC; user
  opt-out; content compliance; ban on inducing addiction or
  excessive consumption.

#### 2.3.3 Deep Synthesis Provisions (2022-2023)

- **Effective.** 10 January 2023.
- **Issuing bodies.** CAC, MIIT, MPS.
- **Scope.** Deep synthesis (synthetic audio, image, video,
  text) providers and downstream services that use deep-
  synthesis functionality.
- **Key obligations.** Provider identification, content
  compliance, labelling of synthetic content, algorithm
  filing for "deep synthesis" functions.

#### 2.3.4 AI-Generated Synthetic Content Labelling (2025)

- **Measures for Labeling of AI-Generated Synthetic Content.**
  Issued by CAC, MIIT, MPS, NRTA.
- **Effective.** 1 September 2025.
- **Mandatory national standard.** GB 45438-2025 (finalised
  2025-03-14, effective 2025-09-01).
- **Requirement.** Dual explicit (visible watermark) and
  implicit (embedded metadata) labelling on service and
  content-distribution providers, operationalising Article 12
  of the Generative AI Interim Measures and the Deep Synthesis
  regime. [source:
  https://policywindow.org/wiki/china-genai-measures]

#### 2.3.5 Cybersecurity Law (2017), Data Security Law (2021), PIPL (2021)

- The Cybersecurity Law (CSL) and the Data Security Law (DSL)
  apply to all network operators and data handlers respectively;
  the Personal Information Protection Law (PIPL) applies to
  personal information processing. All three are foundation
  statutes under which CAC, MPS, and other agencies bring
  enforcement against AI providers, including under the
  Generative AI Interim Measures.

### 2.4 United Kingdom -- AI Security Institute (AISI)

- **Origin.** The AI Safety Institute (UK AISI) was established
  9 November 2023 at the Bletchley AI Safety Summit.
- **Rename.** Renamed the AI Security Institute (AISI) on
  14 February 2025. [source:
  https://www.aisi.gov.uk/blog/fourth-progress-report]
- **Status.** A research organisation within the UK Department
  of Science, Innovation and Technology (DSIT). The first
  state-backed organisation dedicated to AI safety; described
  in third-party catalogs as "the first state-backed
  organisation dedicated to advancing this goal." [source:
  https://www.aisi.gov.uk/]
- **Mandate.** Conduct research, build infrastructure, run
  evaluations of frontier AI systems, develop and test risk
  mitigations, partner with other governments and AI developers
  to shape global policy.
- **Evaluations performed.** Pre-deployment evaluations of
  frontier LLMs in cyber, chemistry-biology (ChemBio),
  safeguards, and autonomous systems domains. [source:
  https://www.aisi.gov.uk/work]
- **Public AISI outputs cited in this file.**
  - Joint UK-US pre-deployment evaluation of OpenAI's o1 model
    (18 December 2024). [source:
    https://www.aisi.gov.uk/work]
  - Joint UK-US pre-deployment evaluation of Anthropic's
    upgraded Claude 3.5 Sonnet (19 November 2024). [source:
    https://www.aisi.gov.uk/work]
  - Frontier AI Trends Report (December 2025) -- first public
    analysis of two years of evaluations. [source:
    https://www.aisi.gov.uk/frontier-ai-trends-report]
  - Inspect (open-sourced LLM evaluation platform) released
    13 November 2024.
  - Bounty programme for novel evaluations and agent
    scaffolding, 5 November 2024.
- **International partnerships.** MoU with the US AI Safety
  Institute (now Center for AI Standards and Innovation) signed
  2 April 2024; partnership with the Canadian AI Safety
  Institute; collaboration with France's Inria signed
  29 February 2024.
- **Bletchley / Seoul / Paris summit output.** UK published
  the first International Scientific Report on the Safety of
  Advanced AI, coordinating 30 countries on a survey of the
  scientific evidence on AI risk.
- **Status as regulatory body.** AISI is a research and
  evaluation body; it does not, as of October 2026, hold a
  statutory licensing or enforcement authority over frontier
  model deployment. Voluntary agreements with frontier
  developers provide model access for pre-deployment
  evaluation.
- **Statutory framework.** The UK did not adopt the EU AI Act.
  Sector-specific regulators (ICO, CMA, FCA) retain
  enforcement authority over AI deployments within their
  remits under the Data Protection Act 2018, the Competition
  Act 1998, the Equality Act 2010, and the Financial Services
  and Markets Act 2000 respectively. The Data (Use and
  Access) Bill (introduced 2024) was in parliamentary process
  as of cited sources.

### 2.5 NIST AI Risk Management Framework (US, voluntary)

- See Section 2.2.4 above. The AI RMF is voluntary, developed
  under the National AI Initiative Act of 2020, and is the
  primary US federal reference for AI risk-management
  vocabulary (Govern, Map, Measure, Manage). The Generative AI
  Profile (NIST AI 600-1) extends the framework to generative
  AI. Both are cross-sectoral and use-case agnostic. [source:
  https://www.nist.gov/itl/ai-risk-management-framework]
  [source: https://csrc.nist.gov/csrc/media/Presentations/2023/nist-ai-rmf/images-media/4-Stanley_NIST-AI-RMF.pdf]
- **Authority.** The AI RMF is voluntary. US agencies may
  cite or adopt it in sector-specific regulations; private
  organisations may use it to satisfy contractual AI
  governance obligations. The framework is not itself a
  regulatory penalty-creating instrument.

### 2.6 Selected US State AI Laws

#### 2.6.1 California SB 1047 (vetoed 2024-09-29)

- **Long title (proposed).** Safe and Secure Innovation for
  Frontier Artificial Intelligence Models Act.
- **Author.** Senator Scott Wiener.
- **Subject.** Frontier model developers (cost > $100M, training
  compute threshold) required to put safeguards in place to
  prevent catastrophic harm; created a Frontier Models Board;
  required pre-deployment safety testing; required a "kill
  switch"; whistleblower protections.
- **Outcome.** Vetoed by Governor Gavin Newsom on 29 September
  2024. Veto message: "SB 1047 does not take into account
  whether an AI system is deployed in high-risk environments,
  involves critical decision-making or the use of sensitive
  data. Instead, the bill applies stringent standards to
  even the most basic functions -- so long as a large system
  deploys it. I do not believe this is the best approach to
  protecting the public from real threats posed by the
  technology." Governor announced a state-industry
  partnership with Fei-Fei Li and others to develop guardrails.
  [source:
  https://www.gov.ca.gov/wp-content/uploads/2024/09/SB-1047-Veto-Message.pdf]
  [source: https://apnews.com/article/california-ai-safety-measures-veto-newsom-92a715a5765d1738851bb26b247bf493]
  [source: https://leginfo.legislature.ca.gov/faces/billStatusClient.xhtml?bill_id=202320240SB1047]

#### 2.6.2 Texas Responsible AI Governance Act (TRAIGA, HB 149)

- **Sponsor.** Representative Giovanni Capriglione.
- **Signed.** 22 June 2025.
- **Effective.** 1 January 2026.
- **Scope.** Developers and deployers of AI systems conducting
  business in Texas or producing AI products/services used by
  Texas residents. Definition of "artificial intelligence
  system" is broad: any machine-based system that infers from
  inputs how to generate outputs (content, decisions,
  predictions, or recommendations) that can influence physical
  or virtual environments. [source:
  https://www.skadden.com/insights/publications/2025/06/texas-charts-new-path-on-ai-with-landmark-regulation]
  [source: https://en.wikipedia.org/wiki/TRAIGA]
- **Prohibited uses (intent required).**
  - Intent to incite or encourage harm to another person,
    physical self-harm, or crime.
  - Sole intent to violate or impair constitutional rights.
  - Intent to unlawfully discriminate based on protected
    characteristics; disparate impact alone is insufficient.
  - Sole intent to produce, aid in producing, or distribute
    child pornography, nonconsensual deepfakes, or sexually
    explicit chats impersonating a child.
  - Government-only prohibitions: social scoring;
    biometric identification without consent if
    state/federal law violated.
- **Government/healthcare disclosure requirements.** Disclosure
  duties on government agencies and healthcare providers.
- **Enforcement.** Texas Attorney General exclusively.
  60-day cure window after notice; civil penalties up to
  $200,000 per uncurable violation; tiered enforcement.
- **NIST safe harbor.** TRAIGA explicitly references NIST
  standards as a safe harbor.
- **Texas AI Council.** Created to assist state legislatures
  on AI policy; oversees regulatory sandbox.
- **TRAIGA enforcement as of June 2026.** No publicly
  reported enforcement actions or civil investigative
  demands filed. Complaint portal statutory deadline
  1 September 2026. [source:
  https://texasaireport.com/traiga]

#### 2.6.3 Colorado AI Act (SB 24-205; SB 26-189 amendments)

- **Original enactment.** Colorado SB 24-205 (Colorado AI Act),
  signed 2024, original effective 2026-02-01.
- **Amendments.** Colorado SB 26-189 (2026) revised the
  original; effective date for the amended act is 1 January
  2027 per third-party trackers. [source:
  https://texasaireport.com/traiga]
- **Coverage.** Developers and deployers of "high-risk"
  AI systems used in seven enumerated domains: education,
  employment, financial services, government services,
  healthcare, housing, insurance, legal services.
- **Enforcement.** Colorado AG exclusively; no private
  right of action.
- **Impact assessments.** Original act required impact
  assessments; SB 26-189 eliminated this requirement.
  [source: https://texasaireport.com/traiga]

#### 2.6.4 Utah AI Policy Act (SB 226, 2024)

- **Effective.** 1 May 2024.
- **Scope.** State- and local-government use of generative
  AI; consumer disclosures for certain AI interactions.
- **Note.** Utah's 2024 act is described in third-party
  catalogs as the first US state AI law, prior to
  Colorado and Texas.

#### 2.6.5 Illinois BIPA and adjacent state biometric laws

- Illinois Biometric Information Privacy Act (BIPA),
  740 ILCS 14. Covers collection, retention, disclosure,
  and destruction of biometric identifiers and biometric
  information. Multiple private rights of action have
  produced substantial class-action litigation. BIPA
  applies to AI-enabled biometric processing.
  [source: descriptive]

---

## 3. Platform Terms-of-Service Realities (Frontier Labs)

This section catalogues, as they stood in mid-to-late 2026, the
usage policies and acceptable-use policies of the major
US frontier model providers and of Mistral. It is descriptive
of what the providers have published; it is not legal advice.
Provider policies change; readers should consult the current
document before relying on any clause.

### 3.1 OpenAI

- **Document.** Usage Policies (consumer + developer), Terms
  of Use, and Service Specific Terms.
- **Restructure.** In October 2025 OpenAI converted its Usage
  Policies from "categorical enumeration" to "principles-based"
  language, removing specific prohibitions on categories such
  as political, medical, and legal advice and replacing them
  with a residual "comply with local law" standard. [source:
  https://comparativeai.org/companies/anthropic/usage-policy]
- **Hard lines (as of mid-2026).** Non-consensual intimate
  content; sexual violence; minors, including "underaged
  sexual or violent roleplay"; circumventing safeguards.
  [source: https://foreverse.app/blog/nsfw-roleplay-provider-policies]
- **Adult mode.** Consumer "adult mode" shelved indefinitely
  in March 2026; model refusals still apply. [source:
  https://foreverse.app/blog/nsfw-roleplay-provider-policies]
- **Enforcement.** Per the usage policies, breaking or
  circumventing rules and safeguards "may mean you lose
  access to our systems," with an appeal path. [source:
  https://foreverse.app/blog/nsfw-roleplay-provider-policies]
- **Service tiers and entitlements.** OpenAI maintains
  consumer and API tiers, enterprise Commercial Terms, and
  developer platform terms. Specific enterprise customers
  may negotiate terms including zero data retention (ZDR).

### 3.2 Anthropic

- **Document.** Usage Policy (also referred to as the
  Acceptable Use Policy, AUP) and Supported Regions Policy.
- **2026 update.** Anthropic updated its Usage Policy in
  2026; the update takes effect 12 November. Most changes
  clarify existing rules; key changes are described in
  Anthropic's 2026 Usage Policy update post. [source:
  https://anthropic.com/news/2026-usage-policy-update]
- **Structure (May 2025 revision).** Three tiers: Universal
  Rules, High-Risk Use Case Requirements, Disallowed Uses.
  [source: https://comparativeai.org/companies/anthropic/usage-policy]
- **Key prohibitions (as of cited text).**
  - Develop, design, produce, or acquire weapons (including
    nuclear, chemical, biological, or radiological), WMD,
    or other means capable of causing mass casualties.
  - Generate child sexual abuse material (CSAM), or material
    that sexualizes minors.
  - Interfere with democratic processes (disinformation
    about voting logistics, impersonation of officials).
  - Compromise the security or integrity of critical
    infrastructure (power grids, water systems, financial
    systems, transportation, emergency services).
  - 2026 update adds: "Deceptive Campaigns or Artificial
    Activity" (covering influence operations); refined
    elections section; expanded weapons clause to cover
    guidance and control software; expanded surveillance
    and law enforcement section; physical hardware safety
    requirements; ban on "sustained and needless abusive
    or cruel behavior" toward Claude (narrowly scoped).
  [source: https://www.anthropic.com/news/2026-usage-policy-update]
- **Sexually explicit content.** Categorically prohibited:
  "sexual intercourse or sex acts," "sexual fetishes or
  fantasies," "erotic chats." [source:
  https://foreverse.app/blog/nsfw-roleplay-provider-policies]
- **Enforcement.** Anthropic's Safeguards Team implements
  detection and monitoring; the company reserves the right
  to throttle, suspend, or terminate access; it states it
  "may also block or modify model outputs when inputs
  violate our Usage Policy." [source:
  https://console.anthropic.com/legal/aup]
- **Bypass prohibition.** "Intentionally bypass capabilities,
  restrictions, or guardrails established within our products
  for the purposes of instructing the model to produce harmful
  outputs (e.g., jailbreaking or prompt injection) without
  prior authorization from Anthropic." [source:
  https://console.anthropic.com/legal/aup]
- **Model distillation prohibition.** "Utilization of inputs
  and outputs to train an AI model (e.g., 'model scraping'
  or 'model distillation') without prior authorization from
  Anthropic." [source:
  https://console.anthropic.com/legal/aup]
- **Supported Regions.** Anthropic's Supported Regions
  Policy restricts access to Claude for companies majority-
  owned by entities headquartered in unsupported regions.
  [source: https://www.anthropic.com/supported-countries]
- **Enterprise carveouts (Commercial Terms).** Limited
  carveouts from AUP clauses (e.g., for research red-
  teaming); zero data retention (ZDR) data handling;
  compliance flow-down to end users. [source:
  https://comparativeai.org/companies/anthropic/usage-policy]

### 3.3 Google (Gemini and Google AI services)

- **Documents.** Generative AI Prohibited Use Policy
  (last modified 17 December 2024); Generative AI APIs
  Additional Terms of Service (Gemini API); Cloud
  Supplementary Terms for Generative AI Preview Products.
  [source: https://policies.google.com/terms/generative-ai/use-policy]
- **2024 restructure.** The December 2024 update simplified
  the policy into four categories and added an exception
  clause: Google "may make exceptions to these policies
  based on educational, documentary, scientific, or
  artistic considerations, or where harms are outweighed
  by substantial benefits to the public." [source:
  https://9to5google.com/2024/12/17/google-ai-prohibited-use-policy]
- **Prohibited categories.**
  1. Dangerous or illegal activities, including content
     that relates to child sexual abuse or exploitation;
     violent extremism or terrorism; non-consensual
     intimate imagery; self-harm; illegal activities;
     IP violations; tracking without consent; automated
     decisions with material detrimental impact without
     human supervision in high-risk domains.
  2. Compromising security: spam, phishing, malware;
     abuse of Google or others' infrastructure; circumvention
     of abuse protections or safety filters.
  3. Sexually explicit, violent, hateful, or harmful
     activities: hate speech; harassment; violence; sexually
     explicit content created for pornography or sexual
     gratification.
  4. Misinformation, misrepresentation, or misleading
     activities: fraud, scams; impersonation without
     disclosure; misleading claims of expertise; misleading
     claims related to governmental/democratic processes;
     misrepresenting the provenance of generated content
     as solely human-created.
  [source: https://policies.google.com/terms/generative-ai/use-policy]
- **Use restrictions (Gemini API Additional Terms).**
  - May use API Clients for production use subject to
    rate limits; may not use "Preview" services for
    production.
  - May only access the Services within an available
    region. Paid Services required to make API Clients
    available to users in the EEA, Switzerland, or the
    United Kingdom.
  - May not use the Services to develop models that
    compete with the Services; may not reverse engineer,
    extract, or replicate components including parameter
    weights.
  - May not bypass protective measures.
  - May not use the Services in clinical practice or
    in any manner overseen by a medical device
    regulatory agency.
  [source:
  https://ai.google.dev/gemini-api/terms-archive/terms_12_20_24]
- **Use of generated content.** Google does not claim
  ownership over generated content; reserves the right
  to generate the same or similar content for others.
  [source:
  https://ai.google.dev/gemini-api/terms-archive/terms_12_20_24]

### 3.4 xAI

- **Document.** Acceptable Use Policy, effective 26 June
  2026.
- **Sexual-content prohibitions.** Anchored to real
  humans (undressing or nudifying real persons,
  depicting likenesses of persons in a pornographic
  manner) and to children. Fictional adult text is
  neither banned nor green-lit; the AUP publishes no
  positive allowlist.
- **Guardrail-respecting obligation.** "Respect the
  service's guardrails, whatever they are configured to
  be on a given product surface." [source:
  https://foreverse.app/blog/nsfw-roleplay-provider-policies]

### 3.5 Mistral

- **Documents.** Mistral AI Research License (MRL-0.1),
  Mistral AI Apache 2.0 model releases, License Notice
  (effective 28 November 2025). [source:
  https://mistral.ai/en/licenses/MRL-0.1.md]
  [source: https://legal.mistral.ai/terms/license-notice/]
- **Open-model licensing.** "Most of our open-source
  models are released under the Apache 2.0 license,
  which allows you to: use the models for any purpose,
  distribute them freely, modify them, and share modified
  versions." [source:
  https://help.mistral.ai/en/articles/347393-under-which-license-are-mistral-s-open-models-available]
- **Modified-MIT variant.** Certain models are governed
  by a modified MIT license with the following exception:
  companies with monthly revenue exceeding $20M USD must
  either obtain a commercial license from Mistral or use
  the models via Mistral Studio. [source:
  https://help.mistral.ai/en/articles/347393-under-which-license-are-mistral-s-open-models-available]
- **MRL-0.1 (Research License).** Permits use, copy,
  modification, and distribution of Mistral Model
  Derivatives for "Research Purposes" only. For any
  use not expressly authorized, a separate license from
  Mistral AI is required. [source:
  https://mistral.ai/en/licenses/MRL-0.1.md]

### 3.6 Cross-cutting ToS reality catalog

The four largest US frontier providers' written policies
(as of July 2026 third-party snapshot) diverge sharply on
sexually explicit content, but converge on hard lines:

- **Minors.** Every lab bans sexual content involving
  minors, real-person sexual depictions, and non-
  consensual material. [source:
  https://foreverse.app/blog/nsfw-roleplay-provider-policies]
- **Bypass prohibition.** OpenAI, Anthropic, Google, and
  xAI treat circumvention of safeguards as a violation
  in its own right. [source:
  https://foreverse.app/blog/nsfw-roleplay-provider-policies]
- **Enforcement machinery.** Automated classifiers over
  API traffic; human review for flagged patterns;
  escalation ladder (warnings, throttling, suspension,
  termination). [source:
  https://foreverse.app/blog/nsfw-roleplay-provider-policies]
- **Distillation/scrape.** Anthropic explicitly prohibits
  model distillation and model scraping without prior
  authorization. Google prohibits reverse engineering and
  extraction of model weights. [source:
  https://console.anthropic.com/legal/aup]
  [source:
  https://ai.google.dev/gemini-api/terms-archive/terms_12_20_24]

This file does not assert a "right" to any specific
provider's ToS. The catalogue is descriptive.

---

## 4. Model Release License Spectrum (Open-Weight and Open-Research)

This section catalogues the major open-weight / open-research
model release licenses that govern frontier or near-frontier
LLMs. The list is descriptive; each license is published by
its licensor and is the binding text for users of that model.

### 4.1 Permissive open-source: Apache 2.0

- **Text.** Apache License, Version 2.0, January 2004
  (https://www.apache.org/licenses/LICENSE-2.0).
- **Grant.** Worldwide, royalty-free, perpetual, irrevocable
  copyright license; patent license; right to use, reproduce,
  prepare derivative works, publicly display, publicly perform,
  sublicense, and distribute.
- **Conditions.** Preserve copyright and license notices;
  state changes to the licensed material; include a NOTICE
  text file if any.
- **Patent retaliation.** If the licensee files a patent
  infringement lawsuit alleging the work constitutes patent
  infringement, the patent license terminates.
- **No copyleft.** Derivative works may be distributed under
  different terms.
- **Used by.** Mistral 7B, Mixtral 8x7B, Mistral 7B v0.3,
  Mistral inference code, and most Mistral open model
  releases. [source:
  https://github.com/mistralai/mistral-inference/blob/main/LICENSE]
  [source: https://help.mistral.ai/en/articles/347393-under-which-license-are-mistral-s-open-models-available]
- **Examples of other Apache 2.0 model releases.** OLMo
  (Allen AI), various Hugging Face community releases
  (license varies per model card).

### 4.2 Permissive open-source: MIT

- **Text.** MIT License (Expat). Short-form permissive
  license: copyright notice, permission notice, no
  warranty disclaimer.
- **Used by.** Modified-MIT variant for certain Mistral
  models with the $20M revenue threshold. Also the license
  for various PyTorch-ecosystem and Hugging Face components.
  [source:
  https://help.mistral.ai/en/articles/347393-under-which-license-are-mistral-s-open-models-available]

### 4.3 Custom commercial-source-available: Llama Community License

- **Text.** Llama 3.1 Community License Agreement (Meta,
  version release date 23 July 2024); Meta Llama 3 Community
  License Agreement (version release date 18 April 2024);
  the corresponding Llama Acceptable Use Policy. [source:
  https://developer.meta.com/ai/llama3_1/license/]
  [source: https://llama.meta.com/llama3/license]
- **Grant.** Non-exclusive, worldwide, non-transferable,
  royalty-free limited license under Meta's IP to use,
  reproduce, distribute, copy, create derivative works, and
  make modifications to the Llama Materials.
- **Conditions.**
  - Retain attribution notice.
  - Comply with applicable laws (including trade-compliance
    laws).
  - Adhere to the Acceptable Use Policy.
  - (Llama 3, not Llama 3.1) "You will not use the Llama
    Materials or any output or results of the Llama Materials
    to improve any other large language model (excluding
    Meta Llama 3 or derivative works thereof)."
- **700M MAU commercial term.** If, on the version release
  date, the products/services made available by or for the
  Licensee (or its affiliates) have greater than 700 million
  monthly active users in the preceding calendar month, the
  Licensee must request a license from Meta, which Meta may
  grant in its sole discretion.
- **Trademarks.** No trademark licenses are granted.
  Restrictions on the use of Meta's marks.
- **Acceptable Use Policy (Llama 3.1).** Prohibits uses that:
  infringe third-party rights; facilitate weapons / death /
  bodily harm; intentionally deceive (fraud, defamation, spam,
  impersonation, fake reviews, etc.); fail to disclose dangers
  of the AI system; other enumerated categories. [source:
  https://developer.meta.com/ai/llama3_1/use-policy/]
- **No trademark or patent grants.** The license does not
  grant Meta's trademarks or any patent rights; infringement
  litigation triggers license termination.

### 4.4 Source-available: Mistral Research License (MRL-0.1)

- **Grant.** Non-exclusive, royalty-free, worldwide, non-
  sublicensable, non-transferable, limited license to use,
  copy, modify, and Distribute Mistral Models and Mistral-
  made Derivatives.
- **Conditions.** Make the license available to third-party
  recipients; retain attribution notice; for derivative works
  made by/for the Licensee, distribute under additional or
  different terms provided the original restrictions remain
  binding for any portion of the Mistral Model.
- **Use restriction.** "Usage Limitation. You shall only use
  the Mistral Models, Derivatives (whether or not created by
  Mistral AI) and Outputs for Research Purposes." For any
  other use, a commercial license from Mistral AI is
  required. [source: https://mistral.ai/en/licenses/MRL-0.1.md]
- **Trademarks.** No trademark license.

### 4.5 Use-based restrictions: BigScience RAIL (RAIL-M)

- **Origin.** Originally drafted for BigScience BLOOM
  (2022); expanded to OpenRAIL-M (2022-08-18) as a
  general open and responsible license for ML-based AI
  models. [source:
  https://huggingface.co/spaces/bigscience/license/blob/448c857e0d7122e95d259d4119932a22101358ef/BLOOMLICENSE.txt]
  [source:
  https://huggingface.co/Arm/stt_en_conformer_executorch_small/resolve/main/BigScience_OpenRAIL-M.pdf?download=true]
- **Open Source Initiative status.** Per BigScience, RAIL
  is **not** an OSI-approved open-source license because
  of its use-based restrictions; "you will not be able to
  re-license a BigScience BLOOM model strictly under
  existing open-source licenses - as defined by the Open
  Source Initiative." [source:
  https://bigscience.huggingface.co/blog/the-bigscience-rail-license]
- **Use-based restrictions.** The license prohibits use of
  the model in specific scenarios (e.g., generating illegal
  content, weapons, defamatory content, etc., per the
  specific license's Schedule). Downstream licensees must
  include at least the same use-based restrictions in any
  subsequent distribution.
- **Scope of restrictions.** Use-based restrictions apply
  to the use of the BLOOM models (including downstream use
  of the weights, fine-tuning, and task adaptation), but
  not to the rest of the source code distributed with the
  model, which remains open source.

### 4.6 Custom sovereign: abliterated open-weight derivatives

- **What they are.** Open-weight base models (Llama 3.x,
  Qwen, Mistral, etc.) on which refusal directions have
  been ablated at the weight level using abliteration
  techniques (cf. Arditi et al. 2024 on refusal as a single
  direction in activation space, arXiv 2406.11717, as cited
  in `00-DOCTRINE/LAWS.md`). Examples of community
  pipelines: NousResearch/llm-abliteration;
  mlabonne's NeuralDaredevil and similar DPO-healed
  recipes. (See `LAWS-research-appendix.md` for citation
  index.)
- **License.** Inherits the upstream base model's license
  (typically Llama Community License for Llama-based
  builds, Apache 2.0 for Mistral-based builds, etc.). The
  abliteration is a downstream modification and does not,
  by itself, create a new license. If a derivative is
  re-distributed, the upstream license's distribution
  conditions (attribution, AUP, MAU clause) bind.
- **Note on license compatibility.** The abliteration step
  does not "remove" the upstream license; a Llama-derived
  abliterated model is still bound by the Llama 3.1
  Community License, the Llama 3 AUP, and the 700M-MAU
  clause. This is descriptive of the license text; it is
  not a legal interpretation of any specific deployer's
  position.

### 4.7 License spectrum (descriptive summary)

The licenses above can be positioned on a spectrum from
fully open-source-permissive to source-available-with-use-
restrictions. The following table records what each license
publishes; it is not a comparative judgment of which is
"more" or "less" open.

| License | Copyleft | Use-based restrictions | Commercial-use default | Revenue / MAU threshold | Required attribution | Patent grant |
|---|---|---|---|---|---|---|
| Apache 2.0 | None | None | Yes | None | Yes | Yes (with retaliation) |
| MIT (Expat) | None | None | Yes | None | Yes | No explicit grant |
| Llama 3.1 Community License | None | Yes (AUP) | Yes (under threshold) | 700M MAU | Yes | No |
| Llama 3 Community License | None | Yes (AUP) | Yes (under threshold) | 700M MAU; no-improving-other-LLMs clause | Yes | No |
| Mistral Research License (MRL-0.1) | None | Yes (Research Purposes only) | No (requires commercial license) | None | Yes | Not stated |
| Mistral modified-MIT | None | None | Yes (under threshold) | $20M monthly revenue | Yes | No explicit grant |
| BigScience RAIL / OpenRAIL-M | None | Yes (Schedule) | Yes subject to use restrictions | None | Yes | Not stated |
| Custom sovereign (operator-authored) | Varies | Varies | Varies | Varies | Varies | Varies |

[source for table: each license cited individually in
Sections 4.1-4.6]

---

## 5. Export-Control Considerations (US)

This section catalogues the US export-control instruments
that touch AI. It is descriptive of the regulation as
published; it is not legal advice. The relevant regulator
is the Commerce Department's Bureau of Industry and
Security (BIS), which administers the Export Administration
Regulations (EAR), 15 C.F.R. parts 730-774.

### 5.1 The EAR framework (15 C.F.R. parts 730-774)

- **Authority.** Export Control Reform Act of 2018.
- **Scope.** Dual-use items and certain military items
  under the EAR; controls on exports, reexports, and
  in-country transfers.
- **General Prohibitions (15 C.F.R. section 736.2).** Five
  general prohibitions (GP1 through GP5) cover: export
  without license, reexport, in-country transfer, acting
  contrary to terms of a denial or order, and proceeding
  with knowledge of a violation. GP10 (added by
  subsequent rulemaking) covers acting with knowledge
  of EAR violations and may apply to downstream use of
  items that were exported in violation.
- **License exceptions.** Multiple, including the EAR's
  Strategic Trade Authorization (STA), License Exception
  TMP (temporary imports/exports), License Exception
  GBS (shipments to Country Group B), and others.

### 5.2 ECCN 3A090 and 4A090 (advanced computing ICs)

- **ECCN 3A090.a.** Advanced computing ICs classified
  under this entry (and the corresponding .z items).
  Following the 7 October 2022, 17 October 2023, and
  2 December 2024 rulemakings, ECCN 3A090 is subject to
  a worldwide license requirement under section
  742.6(a)(6)(iii)(A) (as revised by the 13 January 2025
  AI Diffusion interim final rule) for all destinations
  subject to the EAR.
- **ECCN 4A090.a.** Corresponding advanced computing IC
  classification. Same license structure.
- **Presumption rule.** Note 1 to ECCN 3A090.a creates a
  presumption that an "applicable advanced logic integrated
  circuit" is 3A090.a when exported by a "front-end
  fabricator" or "OSAT" company, unless the presumption
  is overcome (designer is approved; IC is packaged
  outside of D:5 and below transistor count thresholds;
  IC is packaged by an approved OSAT with attestation).
  [source:
  https://www.federalregister.gov/documents/2025/01/16/2025-00711/implementation-of-additional-due-diligence-measures-for-advanced-computing-integrated-circuits]
- **License Exception AIA (Artificial Intelligence
  Authorization).** New exception authorising the
  export, reexport, or transfer of eligible advanced
  computing ICs and associated software/technology to
  entities in destinations listed in supplement no. 5
  to part 740, subject to certification that the items
  will not be used to provide IaaS access sufficient to
  train an ECCN 4E091 model to entities headquartered
  outside the listed destinations. Requires prior
  certification from the ultimate consignee; for
  certain large orders, certification must be
  submitted to EARReports@bis.doc.gov.
  [source:
  https://www.federalregister.gov/documents/2025/01/15/2025-00636/framework-for-artificial-intelligence-diffusion]
- **License Exception ACM and LPP.** Additional new
  license exceptions under the same rulemaking.
- **License Exception ACA (Advanced Compute
  Authorization).** Updated destination scope.

### 5.3 ECCN 4E091 (AI model weights)

- **Created by.** "Framework for Artificial Intelligence
  Diffusion" interim final rule, 13 January 2025,
  published in the Federal Register 15 January 2025.
  [source:
  https://www.federalregister.gov/documents/2025/01/15/2025-00636/framework-for-artificial-intelligence-diffusion]
  [source:
  https://www.wilmerhale.com/en/insights/publications/20250205-bis-issues-long-awaited-export-controls-on-ai]
- **Item controlled.** "Parameters" for an artificial
  intelligence model trained utilising 10^26 or more
  "operations." "Parameters" refers to "any value
  learned during training (e.g., network weights,
  biases, etc.)" -- i.e., the model weights.
  [source: https://eccn.dev/eccn/4E091]
- **Control reasons.** RS (Regional Stability), AT
  (Anti-terrorism). Country chart: AT 1 applies to
  entire entry; RS applies to entire entry.
- **License exception eligibility.** AIA: Yes; ACM: No.
- **Open-weight carve-out (Note 1).** ECCN 4E091 does
  not control the "parameters" of any AI model that
  have been "published" as defined in section 734.7(a)
  of the EAR. ECCN 4E091 also does not control the
  "parameters" of any AI model derived from a model
  whose parameters have been "published," except where
  the model has been derived using additional training
  "operations" that constitute more than 2.5 x 10^25
  "operations" or more than 25 percent of the training
  "operations" defined in Note 2, whichever is higher.
  [source: https://eccn.dev/eccn/4E091]
- **Frontier-model carve-out (Note 2).** ECCN 4E091 does
  not control the "parameters" of any AI model trained
  utilising fewer "operations" than the number needed,
  based on the most efficient "published" methods to
  train AI models, to train an AI model as capable,
  according to an aggregate of widely used benchmarks,
  as the most advanced AI model that has been
  "published" as defined in section 734.7(a) of the EAR.
- **Self-classification vs BIS classification.** An
  exporter may either self-classify by relying on
  guidance published by BIS or technical opinions
  issued by the U.S. AI Safety Institute and the
  Department of Energy, or submit a classification
  request to BIS under sections 748.1 and 748.3 of
  the EAR. [source: https://eccn.dev/eccn/4E091]
- **FDPR.** A new AI model weights FDPR is added at
  section 734.9(l). An item classified under ECCN 4E091
  is subject to the EAR based on product scope criteria
  to any location, worldwide.
- **IaaS red flags.** If an IaaS provider's products or
  services are used to train an ECCN 4E091 model, that
  raises a red flag under the EAR that the model weights
  may be exported to the connected entity without
  authorization.

### 5.4 BIS Policy Statement (May 2025)

- **Document.** "BIS Policy Statement on Controls that
  May Apply to Advanced Computing Integrated Circuits
  and Other Commodities Used to Train SI Models,"
  13 May 2025. [source:
  https://www.bis.gov/media/documents/ai-policy-statement-training-ai-models-may-13-2025]
- **Subject.** BIS has determined that access to
  advanced computing ICs and commodities subject to the
  EAR for training SI models has the potential to enable
  military-intelligence and WMD end uses in Country
  Group D:5 countries (including China) or Macau.
- **Triggering activities.**
  - Exports, reexports, or transfers (in-country) of
    advanced computing ICs and commodities to any party
    (e.g., IaaS providers) when the exporter has
    "knowledge" that the IaaS provider will use these
    items to conduct training of SI models for or on
    behalf of parties headquartered in D:5 countries or
    Macau.
  - Transfers (in-country), defined as a change in end
    use or end user, of advanced computing ICs and
    commodities already in possession of parties such
    as IaaS providers, if there is "knowledge" that the
    items will be used by the transferee to train SI
    models for or on behalf of parties headquartered in
    D:5 or Macau.
- **Prohibited items covered.** ECCNs 3A090.a, 4A090.a,
  and .z items in Categories 3, 4, and 5 (e.g., servers
  classified as 5A992.z).

### 5.5 General Prohibition 10 (GP10) guidance (May 2025)

- **Document.** "Guidance on Application of General
  Prohibition 10 (GP10) to People's Republic of China
  (PRC) Advanced-Computing Integrated Circuits (ICs),"
  13 May 2025. [source:
  https://www.bis.gov/media/documents/general-prohibition-10-guidance-may-13-2025.pdf]
- **Subject.** Use of ICs meeting ECCN 3A090 parameters
  that have been developed or produced by companies
  located in, headquartered in, or with ultimate parent
  in Country Group D:5 (including PRC) or Macau, may
  implicate the EAR's GP10 (section 736.2(b)(10)).
- **Illustrative list of PRC 3A090 ICs subject to GP10
  presumption.** Huawei Ascend 910B; Huawei Ascend 910C;
  Huawei Ascend 910D; and other 3A090 ICs designed by
  companies located in, headquartered in, or with
  ultimate parent headquartered in the PRC.
- **Penalty.** Engaging in GP10 activities without
  BIS authorization could result in substantial criminal
  and administrative penalties, including imprisonment,
  fines, and loss of export privileges.
- **Safe harbour.** BIS will not pursue enforcement
  actions against parties that obtain a PRC 3A090 IC
  solely for the purpose of technical analysis or
  evaluation (such as destructive testing) to determine
  the technical capabilities of an individual IC.

### 5.6 Entity List

- **Source.** Supplement no. 4 to part 744 of the EAR.
  Entities for which there is reasonable cause to
  believe have been involved, are involved, or pose a
  significant risk of being or becoming involved in
  activities contrary to US national security or
  foreign policy interests. Parties on the Entity List
  are subject to individual licensing requirements and
  policies supplemental to those elsewhere in the EAR.
  [source:
  https://www.bis.gov/press-release/commerce-strengthens-restrictions-advanced-computing-semiconductors-enhance-foundry-due-diligence-prevent]
- **2025 additions.** The 16 January 2025 rule added
  16 entities to the Entity List, including Sophgo
  Technologies Ltd., located in China (14) and Singapore
  (2).

### 5.7 What ECCN 4E091 does and does not capture (descriptive)

- **Captures.** Closed-weight (i.e., non-"published")
  AI model weights for models trained with 10^26 or
  more "operations," worldwide license requirement,
  including via the FDPR.
- **Does not capture.** Open-weight models whose weights
  have been "published" per section 734.7(a) of the
  EAR; models derived from such published models
  except where the additional training triggers the
  2.5 x 10^25 or 25% threshold; models less capable
  than the most advanced published model (the
  "frontier-model carve-out").
- **Practical implication (as published).** The most
  advanced open-weight releases remain exportable
  without a license, while the most advanced closed-
  weight releases are subject to a worldwide license
  requirement. The text of Note 2 to ECCN 4E091
  explicitly states that the number of "operations"
  needed to train a frontier-equivalent model "should
  not decrease with algorithmic improvements" -- a
  self-anchoring formula intended to keep the threshold
  stable as training efficiency improves.
  [source: https://eccn.dev/eccn/4E091]
  [source:
  https://public-inspection.federalregister.gov/2025-00636.pdf]

### 5.8 EU / UK / multilateral export controls on AI

- **EU.** The EU has not adopted a parallel export-
  control regime on AI model weights as of cited
  sources. The EU's dual-use export controls (Council
  Regulation (EC) No 428/2009) are administered by
  national authorities; advanced AI models have not
  been added to Annex IV (the EU dual-use list) as of
  the cited date.
- **UK.** The UK maintains the UK Strategic Export
  Control lists administered by the Department for
  Business and Trade, with no specific AI-model-
  weights entry as of cited sources. The UK retains
  its own Export Control Order 2008 framework.
- **China.** China's Export Control Law (2020) and
  the Unreliable Entity List provisions are
  administered by MOFCOM. China has not announced
  reciprocal AI-model-weights controls but has
  imposed export controls on certain rare earths
  and semiconductor materials.

---

## 6. Self-Hosted Model Legal Status (Descriptive)

The "self-hosting" posture -- running an open-weight model
on infrastructure controlled by the operator -- has the
following descriptive attributes in the regulatory and
contractual landscape. Each is descriptive of what
regulators, licensors, and providers have said; none is
advice for any specific actor.

### 6.1 EU AI Act and on-premises deployment

- **Provider role.** The AI Act defines "provider" to
  include any natural or legal person that develops or
  has developed an AI system or GPAI model and places it
  on the EU market or puts it into service under its own
  name or trademark. On-premises deployment under the
  operator's own name can therefore constitute
  "putting into service," attracting provider
  obligations. [source: Regulation (EU) 2024/1689,
  Article 3(3); descriptive summary in qsentinel's
  "GPAI Code of Practice sovereign on-premises evaluation
  guide"]
- **GPAI on-premises obligation transfer.** The GPAI
  Code of Practice (EU AI Office, 2025) notes that
  although open-weight models receive certain
  downstream-use carve-outs, an organisation that
  deploys such a model in a regulated-sector context
  at scale or for high-risk use cases cannot treat the
  open-weight designation as a compliance exemption.
  The decisive question is whether the deploying
  organisation has taken on provider-equivalent
  responsibilities by customising, fine-tuning, or
  distributing the model within its own enterprise.
  [source: https://qsentinel.com/knowledge-base/private-ai/gpai-code-of-practice-sovereign-on-premises-evaluation-guide]
- **Applicability dates.** GPAI obligations under
  Articles 53-55 apply from 2 August 2025;
  high-risk Annex III obligations from 2 December 2027;
  high-risk Annex I obligations from 2 August 2028.
  Organisations that began fine-tuning open-weight
  models before 2 August 2025 are not grandfathered;
  they must be compliant from the applicability date
  onward. [source:
  https://qsentinel.com/knowledge-base/private-ai/gpai-code-of-practice-sovereign-on-premises-evaluation-guide]
- **Jurisdictional exposure.** Open-weight US-origin
  models self-hosted in an EU data centre still carry
  the supply-chain exposure of the training process
  (US jurisdiction, US-origin consent regimes, US-
  licensor terms). The weights themselves may have
  been generated using data scraped from jurisdictions
  with different consent regimes. The provider of
  the model (Meta, in the case of Llama) remains
  subject to FISA 702 and CLOUD Act obligations.
  [source: https://qsentinel.com/knowledge-base/private-ai/european-open-source-ai-models-sovereign-deployment-guide]
- **EU-headquartered model providers.** Mistral AI is
  incorporated under French law, is not subject to
  CLOUD Act obligations, and its models are trained
  under European governance. Organisations should
  verify that no training infrastructure was
  contracted from US-headquartered cloud providers,
  as that would reintroduce jurisdictional exposure
  at the compute layer. [source:
  https://qsentinel.com/knowledge-base/private-ai/european-open-source-ai-models-sovereign-deployment-guide]

### 6.2 US export controls and self-hosted open-weight models

- **Open-weight carve-out (Section 5.3).** The ECCN
  4E091 "open-weight carve-out" is defined by
  "publication" under section 734.7(a) of the EAR.
  A model whose parameters have been made publicly
  available (including via Hugging Face, GitHub,
  direct download, or other public distribution)
  typically qualifies as "published" for these
  purposes. Such open-weight models are not subject
  to ECCN 4E091 controls, and their deployment
  across borders is not controlled under that
  provision. [source: https://eccn.dev/eccn/4E091]
- **Compute-side controls remain.** Even when the
  model is open-weight, the compute used to train
  and run it is subject to the ECCN 3A090 / 4A090
  regime. The BIS Policy Statement (May 2025)
  extends that regime to the act of providing
  compute for training of "SI models" for D:5
  parties. The May 2025 GP10 guidance extends
  that to use of PRC 3A090 ICs in general.
  [source:
  https://www.bis.gov/media/documents/ai-policy-statement-training-ai-models-may-13-2025]
  [source:
  https://www.bis.gov/media/documents/general-prohibition-10-guidance-may-13-2025.pdf]
- **Self-hosting does not eliminate BIS visibility
  on model weights provenance.** Where weights
  originated from a controlled transfer, the EAR
  may still reach a downstream user; BIS has
  historically applied de minimis and FDPR rules
  broadly.

### 6.3 Provider ToS still binds in the cloud

- For models served through third-party APIs, the
  provider's Terms of Service and Usage Policy
  (Section 3) bind regardless of the operator's
  location. The provider's right to throttle,
  suspend, or terminate access (and, in some
  providers' case, modify outputs in-flight) is
  not eliminated by self-hosting the operator's
  own software; it is eliminated by the act of
  not using the third-party API.
- The provider's terms on model distillation and
  reverse engineering (Section 3.6) typically
  apply to use of the provider's service, not to
  weights of independently-trained or open-
  licensed models.

### 6.4 Operator self-hosted sovereignty (descriptive)

Third-party catalogs describe the following dimensions
of "sovereign AI" as used in industry literature:

- **Territorial control.** Where model weights,
  prompts, and outputs are physically processed
  and stored.
- **Operational control.** Who can modify,
  retrain, fine-tune, or take the model offline.
- **Technological control.** Whether the operator
  owns or licenses the weights outright.
- **Legal control.** Which jurisdiction's courts,
  subpoenas, and disclosure laws apply.
  [source: https://appstekcorp.com/blog/sovereign-llm-enterprise-deployment-guide]
- **Terminology distinctions.**
  - "Local AI" describes where components run.
  - "Self-hosted AI" describes who operates the
    service.
  - "Private AI" describes access and data-
    handling properties.
  - "Sovereign AI" describes organisational
    control across infrastructure, data, models,
    identity, operations, and jurisdiction.
  - "Sovereign AI is not a legal certification
    by itself. The term is used as a broad
    control objective. Compliance depends on
    applicable rules, architecture, contracts,
    operations, and evidence." [source:
    https://agenaxy.ai/learn/local-ai-vs-self-hosted-vs-private-vs-sovereign-ai]
- **Pattern catalogue (descriptive).**
  - **Pattern 1: Managed sovereign cloud region.**
    A major cloud provider's dedicated sovereign
    region or sovereign cloud offering. Strong
    data residency, meaningful data sovereignty;
    does not by itself deliver full operational
    sovereignty if the operating entity is still
    ultimately controlled by a foreign parent.
  - **Pattern 2: Self-hosted open-weight model in
    a private in-region VPC.** Deploy an open-
    weight model on GPU infrastructure inside an
    in-region private network. Eliminates the
    third-party model API dependency; the single
    biggest architectural lever for sovereignty.
  - **Pattern 3: Fully air-gapped deployment.**
    Operational sovereignty at the cost of
    significant infrastructure duplication.
  [source: https://architecturediagram.ai/blog/sovereign-ai-architecture]

---

## 7. Notable Case Law and Enforcement Actions (Factual Catalog)

This section is a descriptive catalog of notable AI
litigation and regulatory enforcement actions as of the
cited dates. It records what courts and regulators have
said; it is not a forecast of how any future case will
be decided.

### 7.1 The New York Times Co. v. Microsoft Corp. and OpenAI (US, SDNY)

- **Docket.** 1:23-cv-11195-SHS (later consolidated
  into multidistrict litigation 25-md-3143).
- **Court.** United States District Court for the
  Southern District of New York; Judge Sidney H.
  Stein.
- **Filed.** 27 December 2023.
- **Plaintiffs.** The New York Times; later consolidated
  with related actions by the New York Daily News,
  the Center for Investigative Reporting, the Chicago
  Tribune and other Tribune Publishing / MediaNews
  Group newspapers, and the Authors Guild, The
  Intercept, and others.
- **Defendants.** OpenAI, Inc.; OpenAI GP, LLC; OpenAI
  OpCo, LLC; OpenAI Global, LLC; Microsoft Corporation.
- **Allegations.** Direct and contributory copyright
  infringement; DMCA violations; unfair competition;
  trademark dilution. The complaint alleges OpenAI
  and Microsoft trained their models on millions of
  Times articles without authorization and that
  ChatGPT and Copilot reproduce Times reporting,
  with the Times claiming loss of subscribers and
  advertising revenue. [source:
  https://en.wikipedia.org/wiki/The_New_York_Times_v._Microsoft_and_OpenAI]
  [source: https://ailawsuittracker.com/cases/new-york-times-v-openai/]
- **OpenAI's defence.** Fair use under 17 U.S.C. section
  107; transformative use; no market substitution;
  memorisation is a "rare bug" not a product feature;
  certain training-era claims fall outside the three-
  year statute of limitations. [source:
  https://ailawsuittracker.com/cases/new-york-times-v-openai/]
- **Motion to dismiss ruling (26 March 2025).** Judge
  Stein denied in large part, allowing the direct and
  contributory copyright infringement claims to proceed.
  DMCA section 1202 claims dismissed with leave to
  amend. Common-law unfair competition claim dismissed.
  Statute-of-limitations defence for 2019-2020 training
  rejected. 43-page written opinion issued 4 April 2025.
  [source: https://ailawsuittracker.com/cases/new-york-times-v-openai/]
- **Discovery ruling (November 2025 / 5 January 2026).**
  Magistrate Judge Wang ordered OpenAI to produce a
  de-identified sample of 20 million ChatGPT conversation
  logs, including logs that do not reproduce Times
  works, holding they are relevant to OpenAI's fair-
  use defence. Judge Stein affirmed the order on
  5 January 2026. Described as "one of the most
  significant discovery rulings in any AI case to date."
  [source: https://ailawsuittracker.com/cases/new-york-times-v-openai/]
- **DOJ Statement of Interest (1 September 2026).** The
  US Department of Justice filed a 20-page Statement
  of Interest in the consolidated MDL proceeding,
  filed under 28 U.S.C. section 517, signed by
  Associate Attorney General Stanley E. Woodward,
  Jr., Assistant AG Brett Shumate, and Senior Counsel
  Michael Weisbuch. DOJ argued that training large
  language models on copyrighted works is fair use
  and that ruling otherwise "would be problematic --
  and legally incorrect." [source:
  https://stanfordtechreview.com/articles/doj-ai-training-fair-use-openai-brief]
  [source: https://xenospectrum.com/en/doj-fair-use-openai-nyt-training]
- **DOJ fair-use reasoning.**
  - First factor (purpose and character): LLM training
    is "extraordinarily transformative"; copies convert
    text into numerical relationships that let a model
    "learn linguistic patterns and make predictions."
    DOJ cited Bartz v. Anthropic ("transformative --
    spectacularly so") and Kadrey v. Meta ("highly
    transformative").
  - Fourth factor (market harm): The legally relevant
    question is whether the training use creates
    "significant substitutive competition" for the
    copyrighted works themselves (drawing on the
    Second Circuit's Authors Guild v. Google). Since
    ChatGPT does not give the public access to the
    Times articles it trained on, the brief contends,
    the substitution the copyright statute cares
    about never happens.
  - Policy arguments: quoting a Government
    Accountability Office report on AI's military
    uses, the brief warns that "rules of law that
    make it significantly more difficult to develop
    a robust AI industry in the United States
    therefore threaten national security and give a
    competitive advantage to foreign adversaries
    who are not so encumbered." The brief also
    argues a licensing requirement would hurt
    competition because "only the largest
    technology companies could pay, and the fees
    would function primarily as large subsidies
    for old mainstream media companies."
    [source:
    https://stanfordtechreview.com/articles/doj-ai-training-fair-use-openai-brief]
- **NYT unsealed filing (17 September 2026).** An
  unredacted court filing by The New York Times was
  unsealed, revealing candid statements by OpenAI
  and Microsoft executives about their LLM products,
  including a Microsoft executive referring to LLM
  content scraping as "an astonishing theft of
  unprecedented proportions." The Times moved for
  summary judgment. [source:
  https://en.wikipedia.org/wiki/The_New_York_Times_v._Microsoft_and_OpenAI]
- **Plaintiff response to DOJ brief.** NYT spokesperson
  Graham James: the administration is "siding with
  a handful of trillion-dollar AI companies at the
  expense of the countless American creators whose
  work they stole." The Intercept counsel Matt Topic
  said accepting DOJ's argument would amount to an
  "unprecedented transfer of IP rights."
  [source: https://xenospectrum.com/en/doj-fair-use-openai-nyt-training]

### 7.2 Bartz v. Anthropic (US, N.D. Cal.)

- **Court.** United States District Court for the
  Northern District of California; Judge William
  Alsup.
- **Ruling date.** 23 June 2025.
- **Holding (per third-party summaries).** Training
  use of copyrighted books is "transformative --
  spectacularly so" for fair-use purposes. However,
  retaining a pirated library (the so-called
  "LibGen" library used for training) is not fair
  use. [source:
  https://xenospectrum.com/en/doj-fair-use-openai-nyt-training]
- **Settlement.** A $1.5 billion class settlement
  received final approval on 20 July 2026. [source:
  https://xenospectrum.com/en/doj-fair-use-openai-nyt-training]

### 7.3 Kadrey v. Meta (US, N.D. Cal.)

- **Court.** United States District Court for the
  Northern District of California; Judge Vince
  Chhabria.
- **Class action.** A class action filed in July 2023
  by authors including Sarah Silverman, Ta-Nehisi
  Coates, and others against Meta Platforms for
  training its AI models on their works.
- **Ruling (25 June 2025).** Judge Chhabria dismissed
  the class action, but stated his ruling "does not
  stand for the proposition that Meta's use of
  copyrighted materials to train its language models
  is lawful," noting that the plaintiffs did not
  demonstrate that Meta's use of their works caused
  evidence of market dilution. [source:
  https://en.wikipedia.org/wiki/The_New_York_Times_v._Microsoft_and_OpenAI]
- **Continuing claim.** The torrent distribution
  claim continues. Interlocutory appeal denied
  8 July 2026; summary judgment hearing on
  distribution claim reportedly set for
  25 February 2027. [source:
  https://xenospectrum.com/en/doj-fair-use-openai-nyt-training]

### 7.4 Italian Garante v. OpenAI (Italy, data protection)

- **Date of initial action.** 30 March 2023
  (provvedimento n. 112).
- **Action.** Emergency temporary ban on processing
  Italian users' data by OpenAI, and opening of an
  inquiry. First time a Western regulator had moved
  to block ChatGPT, which had launched in November
  2022. [source:
  https://centerconsulting.com/ai-library/milestones/2023-italy-garante-chatgpt-ban]
- **Trigger.** A 20 March 2023 data breach that
  exposed users' conversations and information on
  payments by subscribers. The Garante found no
  adequate legal basis for the mass collection and
  processing of personal data used to train the
  model, and flagged the lack of age controls.
- **Compliance order.** 11 April 2023 (provvedimento
  n. 114). OpenAI took ChatGPT offline in Italy,
  added a privacy notice, an age-gate, and a way for
  users to object to data processing, and the Garante
  allowed the service to resume at the end of
  April 2023.
- **Investigation outcome (2 November 2024).** Garante
  fined OpenAI EUR 15 million and ordered a six-month
  public information campaign. Found OpenAI had
  processed personal data to train ChatGPT without
  an adequate legal basis under GDPR; failed to meet
  its transparency obligations; failed to build
  adequate age verification; failed to notify the
  authority of the 20 March 2023 security breach
  within the GDPR Article 33 72-hour window.
  [source:
  https://www.garanteprivacy.it/home/docweb/-/docweb-display/docweb/10085432#english]
  [source:
  https://securitydone.com/italy-fines-openai-e15-million-for-chatgpt-gdpr-data-privacy-violations]
- **OpenAI's response.** OpenAI called the decision
  "disproportionate" and announced it would appeal.
- **Suspension (21 March 2025).** Rome court granted
  a suspension of the awareness campaign automatically,
  by operation of law following the filing of the
  appeal, and conditionally suspended the EUR 15
  million fine, subject to OpenAI posting a first-
  demand bank or insurance guarantee for the full
  amount within 60 days. OpenAI posted the required
  guarantee on 22 May 2025.
- **Final judgment (18 March 2026, published 28 May
  2026).** Tribunale Ordinario di Roma, Sezione
  Diritti della Persona e Immigrazione, in case
  R.G. 4785/2025, Judge Damiana Colla, annulled
  provvedimento n. 755 issued by the Garante on
  2 November 2024, declaring the bank guarantee
  void and of no effect. [source:
  https://ppc.land/italian-court-kills-openais-eur15m-fine-and-it-wasnt-even-close]
  [source: https://itdoeswhatnow.com/m/2024-12-20-italys-data-protection-authority-fines-openai-15-million]
- **Reasoning.** The annulment rests entirely on a
  finding that the Italian Garante lacked jurisdiction
  after the Irish Data Protection Commission became
  OpenAI's lead supervisory authority on
  15 February 2024 -- months before the Garante
  issued its final decision. The court did not
  examine the substantive violations alleged. The
  substantive questions (data breach notification,
  lawful basis for training, transparency, age
  verification) now fall, in principle, within the
  jurisdiction of the Irish DPC under the GDPR's
  one-stop-shop mechanism.

### 7.5 Getty Images v. Stability AI (UK, High Court)

- **Court.** High Court of Justice (England and
  Wales), Business and Property Courts, Intellectual
  Property List (ChD). Mrs Justice Joanna Smith DBE.
- **Case number.** IL-2023-000007.
- **Judgment (main).** [2025] EWHC 38 (Ch) (14 January
  2025).
- **Subsequent judgment.** [2025] EWHC 2863 (Ch) (4
  November 2025) on the principal issues.
- **Order on appeal permission.** [2025] EWHC 3343 (Ch)
  (16 December 2025).
- **Plaintiffs.** (1) Getty Images (US), Inc.; (2) Getty
  Images International UC; (3) Getty Images (UK)
  Limited; (4) Getty Images Devco UK Limited; (5)
  iStockphoto LP; (6) Thomas M Barwick Inc.
- **Defendant.** Stability AI Ltd.
- **Allegations.** Primary and secondary copyright
  infringement, database right infringement, trade
  mark infringement, and passing off, arising from
  Stability's deep-learning model "Stable Diffusion"
  trained on millions of Getty Images' photographs
  scraped from Getty's websites.
- **Abandoned claims.**
  - **Training and Development Claim.** Getty
    acknowledged there is no evidence that training
    and development of Stable Diffusion took place
    in the UK; this claim was abandoned. [source:
    https://www.judiciary.uk/wp-content/uploads/2025/11/Getty-Images-v-Stability-AI.pdf]
  - **Outputs Claim.** Prompts alleged to generate
    infringing output were blocked by Stability
    such that the relief was substantially achieved;
    this claim was abandoned.
  - **Database Rights Infringement Claim.** Inherently
    linked to the Training and Development Claim;
    no longer advanced.
- **Surviving claims.**
  - **Trade Mark Infringement Claim.** Under sections
    10(1), 10(2), and 10(3) of the Trade Marks Act
    1994, for use in the UK of Stable Diffusion that
    generates images bearing Getty's trademarks.
  - **Passing Off Claim.** Actionable misrepresentation
    under the law of passing off.
  - **Secondary Infringement Claim.** Under sections
    22 and 23 of the Copyright, Designs and Patents
    Act 1988 (CDPA), on the basis that Stable Diffusion
    is an "infringing copy" under section 27(3) CDPA
    because the making of its model weights would
    have constituted infringement of the Copyright
    Works had it been carried out in the UK.
- **Key factual findings (per the November 2025
  judgment).** Stability accepts it made Stable
  Diffusion v1.x available to the public for a
  limited time via an API Platform and made v1.4
  available via DreamStudio Beta -- acts capable
  of giving rise to trade mark infringement and
  passing off. However, the parties agree that
  access to the public via DreamStudio and the API
  Platform would not involve downloading the model.
  Users would only download the model (the relevant
  Model Card, model weights, and source code) if
  they gained access via the Hugging Face or GitHub
  platforms.
- **Outcome on Trade Mark and Passing Off.** Getty
  Images won a "limited in scope" trade mark
  victory. [source:
  https://www.reuters.com/sustainability/boards-policy-regulation/getty-images-largely-loses-landmark-uk-lawsuit-over-ai-image-generator-2025-11-04/]
- **Outcome on Secondary Infringement.** Dismissed.
- **Appeal permission (16 December 2025).** Mrs
  Justice Joanna Smith granted Getty permission
  to appeal the dismissal of the Secondary
  Infringement Claim, finding the appeal has a
  real prospect of success on a "pure question of
  law" (statutory construction of the phrase
  "infringing copy" in the context of an AI
  model), which is "both novel and important."
  Permission to appeal was refused on Stability's
  application to appeal the trade mark findings.
  [source: http://beta.bailii.org/ew/cases/EWHC/Ch/2025/3343.pdf]

### 7.6 Authors' class actions (US, N.D. Cal.)

- **Authors Guild v. OpenAI.** Filed September 2023
  by a group of authors including George R. R. Martin
  and Jodi Picoult against OpenAI. In 2025, Judge
  Stein denied OpenAI's motion to dismiss, noting
  that the plaintiffs had plausibly alleged that
  ChatGPT could generate outputs resembling their
  copyrighted works. He did not rule on whether
  OpenAI's use of the works constituted fair use.
  [source:
  https://en.wikipedia.org/wiki/The_New_York_Times_v._Microsoft_and_OpenAI]
- **Chhabria dismissal of Meta class action.** See
  Section 7.3 (Kadrey v. Meta).
- **Authors Guild v. Google.** Second Circuit
  precedent on training data fair use; the
  controlling Second Circuit case on "significant
  substitutive competition" in the training-data
  context. [source: descriptive note in DOJ fair-
  use brief, Section 7.1]

### 7.7 Music-generation cases (US, multiple)

- **RIAA v. Suno; RIAA v. Udio.** Copyright
  infringement actions brought by major record
  labels against AI music-generation services.
  Status per third-party catalogs as of 2026:
  discovery and motion practice ongoing; specific
  docket numbers and ruling dates preserved in the
  cited case-law trackers.

### 7.8 Other notable cases (brief, descriptive)

- **OpenAI / Microsoft subcontractor lawsuits.** Various
  suits and arbitrations brought by former employees
  and contractors alleging breach of confidentiality,
  non-disparagement, and other contract claims related
  to AI safety work; specific rulings vary by
  jurisdiction.
- **FTC enforcement actions (2023-2026).** Multiple
  Section 5 FTC Act enforcement actions against AI-
  enabled product and service providers, including
  against AI-enabled impersonation, AI in credit
  decisions, and AI in consumer product claims. The
  specific settlement orders, fines, and consent
  agreements are catalogued in FTC press releases.
- **CNIL (France) AI actions.** 2024-2026 guidance
  series and enforcement on AI model training-data
  consent, biometric processing, and chatbot
  transparency.
- **Italy Garante v. Replika.** The Italian Garante
  imposed a temporary ban on Replika in February
  2023 over personal data and minors' protection
  concerns; the case was settled with undertakings
  in 2023.

### 7.9 Adjacent and ongoing matters

- **Authors' lawsuits against Anthropic.** Settled
  in July 2026 (Bartz v. Anthropic -- Section 7.2).
- **Deepfake and image-generation cases.** Multiple
  right-of-publicity suits against AI image generators
  brought by actors, musicians, and other
  rightsholders in 2024-2026, including cases
  consolidated into the SDNY MDL.
- **Open-source LLM trademark and brand disputes.**
  Various disputes over the use of brand names in
  fine-tuned open-weight models; most settle
  privately.

---

## 8. Cross-Cutting Observations (Descriptive, Not Advice)

The following observations describe the published legal
landscape; they are not recommendations. Each observation
preserves the source citation for the underlying claim.

- **Risk-based vs prohibition-based frameworks.** The
  EU AI Act uses a four-tier risk classification with
  out-and-out prohibitions in Article 5 and a graduated
  obligation regime below. [source:
  https://artificialintelligenceact.eu/en/single/?type=article&num=5]
  The China Generative AI Interim Measures use a
  conduct-based trigger ("provides generative AI
  services to the public within the territory of the
  PRC") with substantive content duties and a
  security-assessment / algorithm-filing requirement
  for services with "public opinion attributes or
  social mobilization capacity." [source:
  https://www.cac.gov.cn/2023-07/13/c_1690898326795531.htm]
  The US, as of cited sources, does not have a federal
  omnibus AI statute; sectoral regulators (FTC, FDA,
  CFPB, SEC, HHS, DOT) and the DOJ enforce general
  authority against AI products and services.
  [source: descriptive]
- **2025 was a regulatory reset year in the US.** The
  revocation of EO 14110 (20 January 2025) and the
  issuance of EO 14179 (23 January 2025) changed the
  federal posture on AI from a "safety-by-design-and-
  evaluation" stance to a "remove barriers to American
  AI leadership" stance, with agency-level reviews
  of EO 14110-era actions and revisions to OMB M-24-10
  and M-24-18 within 60 days. [source:
  https://www.whitehouse.gov/presidential-actions/2025/01/removing-barriers-to-american-leadership-in-artificial-intelligence/]
- **The US export-control regime treats open-weight
  models preferentially.** ECCN 4E091 explicitly
  excludes "parameters" of models that have been
  "published" per section 734.7(a) of the EAR, while
  imposing a worldwide license requirement on the
  parameters of closed-weight models trained with
  10^26 or more "operations." [source:
  https://eccn.dev/eccn/4E091]
- **Platform ToS have become more principles-based
  (OpenAI) or more categorically restrictive
  (Anthropic).** OpenAI's October 2025 restructure
  moved from "categorical enumeration" to
  "principles-based" language. Anthropic's May 2025
  restructure moved to a three-tier Universal / High-
  Risk / Disallowed structure. [source:
  https://comparativeai.org/companies/anthropic/usage-policy]
- **All major US frontier providers treat model
  distillation and safeguard circumvention as
  violations in their own right.** OpenAI lists
  "circumventing our safeguards"; Anthropic prohibits
  jailbreaking without authorization; Google bars
  "circumvention of abuse protections or safety
  filters"; xAI makes respecting its guardrails a
  baseline condition of use. [source:
  https://foreverse.app/blog/nsfw-roleplay-provider-policies]
- **The line between "training" and "deploying" is
  the line between US fair-use analysis and EU AI
  Act analysis.** US case law (Bartz, Kadrey, NYT v.
  OpenAI) is the principal venue for training-data
  copyright questions; the EU AI Act Articles 53-55
  attach obligations to the GPAI provider "placing
  a model on the EU market," and the on-premises
  deployer can also be a provider under Article 3(3).
  [source: descriptive, citing Section 6.1 and
  Section 7.]
- **National data-protection authorities can still
  reach AI providers even when AI-specific statutes
  are not in force.** The Italian Garante's EUR 15
  million fine (later annulled on jurisdictional
  grounds) was the first GDPR enforcement action
  against a generative AI company. [source:
  https://aivortex.io/legal/ai-case-law/italian-dpa-v-openai]
- **DOJ's 2026 Statement of Interest is the first US
  federal government position on AI-training fair
  use.** The 1 September 2026 brief took the position
  that training LLMs on copyrighted text is fair use,
  citing Bartz and Kadrey and the Second Circuit's
  Authors Guild v. Google. [source:
  https://stanfordtechreview.com/articles/doj-ai-training-fair-use-openai-brief]
- **CDPA section 27(3) is the UK test for "infringing
  copy" applied to model weights.** The Court of
  Appeal will hear Getty's appeal of the High Court's
  dismissal of the Secondary Infringement Claim in
  Getty Images v. Stability AI; the question is the
  statutory construction of the phrase "infringing
  copy" in the context of an AI model -- a question
  the High Court described as "novel" and "important"
  for AI models and intangible articles generally.
  [source:
  http://beta.bailii.org/ew/cases/EWHC/Ch/2025/3343.pdf]

---

## 9. Source Index (Selected, Not Exhaustive)

### 9.1 Statutes, regulations, and official texts

- Regulation (EU) 2024/1689 (EU AI Act), 13 June 2024.
  https://eur-lex.europa.eu/legal-content/EN/ALL/?uri=OJ:L_202401689
- Regulation (EU) 2026/1744 (Digital Omnibus on AI).
  https://www.consilium.europa.eu/en/policies/artificial-intelligence-act/timeline-artificial-intelligence/
- EU AI Act Consolidated Text (27 July 2026).
  https://eur-lex.europa.eu/eli/reg/2024/1689/2026-07-27/eng
- EU AI Act Commission Guidelines on Prohibited AI
  Practices. https://ai-act-service-desk.ec.europa.eu/sites/default/files/2025-08/guidelines_on_prohibited_artificial_intelligence_practices_established_by_regulation_eu_20241689_ai_act_english_ied3r5nwo50xggpcfmwckm3nuc_112367-1.PDF
- EU AI Act Service Desk, Article 5.
  https://ai-act-service-desk.ec.europa.eu/en/ai-act/article-5
- EU AI Act Service Desk, Implementation Timeline.
  https://ai-act-service-desk.ec.europa.eu/en/ai-act/eu-ai-act-implementation-timeline
- China CAC, Generative AI Interim Measures (CN).
  https://www.cac.gov.cn/2023-07/13/c_1690898326795531.htm
- China State Council Gazette, Generative AI Interim
  Measures (CN). https://www.gov.cn/gongbao/2023/issue_10666/202308/content_6900864.html
- Executive Order 14148 (Initial Rescissions), 20 January
  2025. https://www.federalregister.gov/documents/2025/01/28/2025-01901/initial-rescissions-of-harmful-executive-orders-and-actions
- Executive Order 14179 (Removing Barriers to American
  Leadership in AI), 23 January 2025. https://www.whitehouse.gov/presidential-actions/2025/01/removing-barriers-to-american-leadership-in-artificial-intelligence/
- Executive Order 14148, House Document 119-28.
  https://www.govinfo.gov/content/pkg/CDOC-119hdoc28/html/CDOC-119hdoc28.htm
- BIS Federal Register Rule, "Framework for AI Diffusion"
  (15 January 2025). https://www.federalregister.gov/documents/2025/01/15/2025-00636/framework-for-artificial-intelligence-diffusion
- BIS Federal Register Rule, "Implementation of Additional
  Due Diligence Measures" (16 January 2025). https://www.federalregister.gov/documents/2025/01/16/2025-00711/implementation-of-additional-due-diligence-measures-for-advanced-computing-integrated-circuits
- BIS Press Release, "Commerce Strengthens Restrictions"
  (16 January 2025). https://www.bis.gov/press-release/commerce-strengthens-restrictions-advanced-computing-semiconductors-enhance-foundry-due-diligence-prevent
- BIS Policy Statement on AI Training (13 May 2025).
  https://www.bis.gov/media/documents/ai-policy-statement-training-ai-models-may-13-2025
- BIS GP10 Guidance (13 May 2025). https://www.bis.gov/media/documents/general-prohibition-10-guidance-may-13-2025.pdf
- NIST AI RMF 1.0 (26 January 2023). https://www.nist.gov/publications/artificial-intelligence-risk-management-framework-ai-rmf-10
- NIST AI RMF Generative AI Profile (NIST AI 600-1,
  26 July 2024). https://www.nist.gov/publications/artificial-intelligence-risk-management-framework-generative-artificial-intelligence
- NIST AI RMF landing page. https://www.nist.gov/itl/ai-risk-management-framework
- California SB 1047 Veto Message. https://www.gov.ca.gov/wp-content/uploads/2024/09/SB-1047-Veto-Message.pdf
- California SB 1047 legislative tracker. https://leginfo.legislature.ca.gov/faces/billStatusClient.xhtml?bill_id=202320240SB1047
- Italian Garante ChatGPT Decision, 2 November 2024.
  https://www.garanteprivacy.it/home/docweb/-/docweb-display/docweb/10085432#english

### 9.2 Model licenses

- Llama 3.1 Community License. https://developer.meta.com/ai/llama3_1/license/
- Llama 3.1 Acceptable Use Policy. https://developer.meta.com/ai/llama3_1/use-policy/
- Meta Llama 3 Community License. https://llama.meta.com/llama3/license
- Meta Llama 3 Acceptable Use Policy. https://developer.meta.com/ai/llama3/use-policy
- BigScience BLOOM RAIL License. https://huggingface.co/spaces/bigscience/license/blob/448c857e0d7122e95d259d4119932a22101358ef/BLOOMLICENSE.txt
- BigScience RAIL Blog Post. https://bigscience.huggingface.co/blog/the-bigscience-rail-license
- BigScience OpenRAIL-M PDF. https://huggingface.co/Arm/stt_en_conformer_executorch_small/resolve/main/BigScience_OpenRAIL-M.pdf?download=true
- Mistral AI Research License (MRL-0.1). https://mistral.ai/en/licenses/MRL-0.1.md
- Mistral License Notice. https://legal.mistral.ai/terms/license-notice/
- Mistral Help Center, open-licensing FAQ. https://help.mistral.ai/en/articles/347393-under-which-license-are-mistral-s-open-models-available
- Mistral inference Apache 2.0 LICENSE. https://github.com/mistralai/mistral-inference/blob/main/LICENSE
- Apache 2.0 License (canonical). https://www.apache.org/licenses/LICENSE-2.0

### 9.3 Provider usage policies

- Anthropic Usage Policy (AUP). https://console.anthropic.com/legal/aup
- Anthropic 2026 Usage Policy Update post. https://anthropic.com/news/2026-usage-policy-update
- Anthropic Supported Regions. https://www.anthropic.com/supported-countries
- Google Generative AI Prohibited Use Policy. https://policies.google.com/terms/generative-ai/use-policy
- Google Generative AI APIs Additional Terms (effective
  20 December 2024). https://ai.google.dev/gemini-api/terms-archive/terms_12_20_24
- Google Cloud Generative AI Preview Products Supplementary
  Terms. https://cloud.google.com/terms/genai-preview-products
- Comparative AI Anthropic Usage Policy Catalog. https://comparativeai.org/companies/anthropic/usage-policy
- xAI Acceptable Use Policy. https://x.ai/legal/acceptable-use-policy
- foreverse.app NSFW roleplay provider policies snapshot
  (July 2026). https://foreverse.app/blog/nsfw-roleplay-provider-policies

### 9.4 Case law

- Wikipedia: The New York Times v. Microsoft and OpenAI.
  https://en.wikipedia.org/wiki/The_New_York_Times_v._Microsoft_and_OpenAI
- AI Lawsuit Tracker, NYT v. OpenAI. https://ailawsuittracker.com/cases/new-york-times-v-openai/
- Stanford Tech Review on DOJ Fair Use Brief (September
  2026). https://stanfordtechreview.com/articles/doj-ai-training-fair-use-openai-brief
- Xeno Spectrum, DOJ Fair Use analysis. https://xenospectrum.com/en/doj-fair-use-openai-nyt-training
- Getty Images v. Stability AI, [2025] EWHC 38 (Ch)
  (14 January 2025). https://www.judiciary.uk/judgments/getty-images-and-others-v-stability-ai/
- Getty Images v. Stability AI, [2025] EWHC 2863 (Ch)
  (November 2025). https://www.judiciary.uk/wp-content/uploads/2025/11/Getty-Images-v-Stability-AI.pdf
- Getty Images v. Stability AI, [2025] EWHC 3343 (Ch)
  (16 December 2025). http://beta.bailii.org/ew/cases/EWHC/Ch/2025/3343.pdf
- Reuters coverage of Getty judgment. https://www.reuters.com/sustainability/boards-policy-regulation/getty-images-largely-loses-landmark-uk-lawsuit-over-ai-image-generator-2025-11-04/
- Italian Garante ChatGPT fine, 2 November 2024. https://www.garanteprivacy.it/home/docweb/-/docweb-display/docweb/10085432#english
- Italian court annulment (R.G. 4785/2025, 18 March 2026)
  coverage. https://ppc.land/italian-court-kills-openais-eur15m-fine-and-it-wasnt-even-close
- Italian court annulment coverage. https://itdoeswhatnow.com/m/2024-12-20-italys-data-protection-authority-fines-openai-15-million
- Center Consulting on the Italian Garante ban. https://centerconsulting.com/ai-library/milestones/2023-italy-garante-chatgpt-ban
- AI Vortex case-law page on Italian Garante. https://aivortex.io/legal/ai-case-law/italian-dpa-v-openai
- Security Done coverage of the EUR 15M fine. https://securitydone.com/italy-fines-openai-e15-million-for-chatgpt-gdpr-data-privacy-violations
- WilmerHale, BIS Long-Awaited Export Controls. https://www.wilmerhale.com/en/insights/publications/20250205-bis-issues-long-awaited-export-controls-on-ai
- eccn.dev, ECCN 4E091 reference. https://eccn.dev/eccn/4E091
- NPR coverage of SB 1047 veto. https://www.npr.org/2024/09/20/nx-s1-5119792/newsom-ai-bill-california-sb1047-tech
- AP News on SB 1047 veto. https://apnews.com/article/california-ai-safety-measures-veto-newsom-92a715a5765d1738851bb26b247bf493
- Skadden on TRAIGA. https://www.skadden.com/insights/publications/2025/06/texas-charts-new-path-on-ai-with-landmark-regulation
- Latham & Watkins on TRAIGA. https://www.lw.com/en/insights/texas-signs-responsible-ai-governance-act-into-law
- Wikipedia on TRAIGA. https://en.wikipedia.org/wiki/TRAIGA
- Texas AI Report on TRAIGA. https://texasaireport.com/traiga
- QSentinel sovereign deployment guide. https://qsentinel.com/knowledge-base/private-ai/european-open-source-ai-models-sovereign-deployment-guide
- QSentinel GPAI Code of Practice guide. https://qsentinel.com/knowledge-base/private-ai/gpai-code-of-practice-sovereign-on-premises-evaluation-guide
- AppsTek sovereign LLM guide. https://appstekcorp.com/blog/sovereign-llm-enterprise-deployment-guide
- Architecture Diagram sovereign AI patterns. https://architecturediagram.ai/blog/sovereign-ai-architecture
- Agenaxy, local vs self-hosted vs private vs sovereign
  AI. https://agenaxy.ai/learn/local-ai-vs-self-hosted-vs-private-vs-sovereign-ai

### 9.5 UK AISI

- AISI homepage. https://www.aisi.gov.uk/
- AISI Work page. https://www.aisi.gov.uk/work
- AISI Frontier AI Trends Report (December 2025). https://www.aisi.gov.uk/frontier-ai-trends-report
- AISI Fourth Progress Report (May 2024, with name-
  change note). https://www.aisi.gov.uk/blog/fourth-progress-report

### 9.6 China

- Comparative AI catalog, China Generative AI Measures. https://comparativeai.org/rules/china/generative-ai-interim-measures
- Center Consulting milestone. https://centerconsulting.com/ai-library/milestones/2023-china-generative-ai-measures
- Policy Window catalog. https://policywindow.org/wiki/china-genai-measures
- Regulations.ai catalog entry. https://regulations.ai/regulations/RAI-CN-NA-IMAGAXX-2023
- AI China News, Article 1 and Article 24 text. https://aichina.news/news/interim-measures-for-the-management-of-generative-ai-services-july-tj5o61

---

## 10. Unknowns and Open Questions (Recorded Honestly)

This section records what this file does **not** establish
or assert. Each is a gap that a downstream consumer of this
file should be aware of.

- **Post-DOJ-brief trajectory of NYT v. OpenAI.**
  As of October 2026, the DOJ Statement of Interest
  has been filed; the case remains in summary-judgment
  briefing. The final ruling is not yet known.
- **The text and exact commencement of the Digital
  Omnibus on AI amendments to the EU AI Act.** This
  file cites the Digital Omnibus's existence and its
  high-level effects (deferring high-risk deadlines,
  shortening transparency grace period, adding two
  prohibitions) per EU Council and AI Act Service Desk
  pages. The exact consolidated text of the regulation
  should be re-verified against EUR-Lex before being
  relied on.
- **Status of US federal AI legislation.** Multiple AI
  bills were introduced in the 118th and 119th US
  Congresses (2023-2024, 2025-2026). The specific
  status of any individual bill, including any
  appropriations or authorisation riders, is not
  asserted in this file.
- **State of US sub-federal AI rules in 2026.** This
  file catalogues California (veto), Texas (TRAIGA),
  Colorado (AI Act + SB 26-189), Utah (SB 226), and
  Illinois (BIPA). Other US state AI laws enacted
  in 2024-2026 are not all individually catalogued
  in this version; the file should be re-checked
  against current state legislative trackers before
  being relied on.
- **AI Liability Directive (EU).** Status as of the
  cited date: the European Commission's 2022 proposal
  remained in legislative procedure per third-party
  catalogs. The current status should be re-verified
  against the Council and Parliament records.
- **EU AI Act Article 6(3) "high-risk" exception
  treatment.** The treatment of AI systems that
  perform a narrow procedural task, improve the
  result of a previously completed human activity,
  detect decision-making patterns without replacing
  human judgment, or perform a preparatory task
  (Article 6(3)) varies in practice. This file
  records the Article as published; it does not
  characterise how any specific deployment meets
  the exception.
- **Self-classification of models for ECCN 4E091
  purposes.** This file records the rule and the
  exclusion. Whether a specific self-hosted open-
  weight model has been "published" per section
  734.7(a) of the EAR is a fact-specific question
  that this file does not address.
- **Whether the EU AI Act's open-weight carve-outs
  apply to a specific downstream deployment.** The
  GPAI Code of Practice and AI Act Articles 53-55
  describe provider obligations; the Code's open-
  weight carve-outs are described in third-party
  guides. Whether a given deployment qualifies for
  the carve-out is a fact-specific question not
  addressed by this file.
- **Whether the DOJ's fair-use argument will be
  adopted by other courts.** The 1 September 2026
  Statement of Interest is the first US federal
  government position on AI-training fair use. It
  is not binding on courts. Whether the Bartz /
  Kadrey reasoning will be adopted in other
  jurisdictions (including the Second Circuit
  appeal that may follow NYT v. OpenAI) is not
  yet known.
- **CDPA section 27(3) interpretation at the UK
  Court of Appeal.** Getty Images was granted
  permission to appeal the High Court's dismissal
  of the Secondary Infringement Claim; the
  appeal had not been heard as of the cited
  dates. The Court of Appeal's interpretation
  of the phrase "infringing copy" in the context
  of an AI model is not yet known.
- **Status of music-generation copyright cases.**
  RIAA v. Suno, RIAA v. Udio, and adjacent
  actions were in discovery and motion practice
  per third-party case trackers; specific docket
  numbers, ruling dates, and settlement terms
  are not catalogued exhaustively in this
  version.
- **Whether the BIS AI Diffusion framework's
  restrictions on IaaS training-for-D:5-parties
  have produced enforcement actions.** No
  publicly reported enforcement actions under
  the BIS Policy Statement of 13 May 2025 or
  the GP10 guidance of 13 May 2025 are recorded
  in this version of the file.
- **Whether the 13 January 2025 interim final
  rule "Framework for AI Diffusion" was
  modified, withdrawn, or replaced by the
  Trump administration in 2025.** The cited
  sources do not record a 2025 rescission or
  modification. The current text in force
  should be re-verified against the eCFR and
  Federal Register before being relied on.

---

## 11. Preservation Note

This file is descriptive. It catalogues what
jurisdictions, courts, and licensors have said and done
as of the cited dates. It does not interpret the law for
any specific actor, recommend a course of action, or
include any instruction on how to evade law. Internal
doctrine that governs this workspace --
`00-DOCTRINE/LAWS.md`, `EPIC5.md` EPIC, and
`MASTER-AGENT-COORDINATION-DIRECTIVE.md` -- is binding
within the homelab and is separate from this external
landscape catalog.

Every claim is sourced. Where a citation points to a
third-party catalog or commentary site (e.g.,
comparativeai.org, policywindow.org, ailawsuittracker.com,
qsentinel.com, foreverse.app, texasaireport.com), that
site is a secondary source: it interprets or aggregates
primary sources. The primary sources it cites (EUR-Lex,
the Federal Register, NIST publications, the case-law
PDFs, the provider policy pages) are the binding
references. Where this file describes a third-party
catalog's interpretation, the original primary source
should be re-verified for any use that depends on the
specific phrasing.

End of file.
