MASTER AGENT COORDINATION DIRECTIVE

Unified AI Infrastructure, Creative Workbench & Knowledge System

Directive ID: MASTER-FRAMEWORK-001
Status: Preliminary architecture discovery and coordination
Priority: High
Execution mode: Non-destructive, evidence-based, iterative
Intended recipients: Hermes and all participating development, research, knowledge-management, infrastructure, and creative automation agents.

---

1. MISSION

We are developing a comprehensive, modular AI-powered computing, knowledge-management, creative-production, and software-development environment.

The system will operate primarily on an existing Linux-based iMac with limited local computational resources.

The local machine will function primarily as an orchestration, storage, interface, and lightweight execution environment.

Computationally demanding operations, including large-model inference, image generation, music generation, video generation, and other GPU-intensive workloads, should be designed to run primarily through remote API endpoints or external compute services.

Existing functionality must be preserved wherever practical.

Several agents are already developing different components of this environment. Their work must now be brought into a common architectural framework without unnecessarily disrupting ongoing development.

The immediate objective is not to implement a completely new system.

The immediate objective is to discover, document, reconcile, and systematically expand the existing system into a coherent master architecture.

---

2. PRIMARY DELIVERABLES

We will develop two interconnected Markdown documents.

Document A: MASTER_FRAMEWORK.md

This document will contain the comprehensive architectural framework for the entire environment.

Its initial target structure is:

- 10 major ontologies or architectural domains.
- Approximately 15 subsections per ontology.
- Approximately 10 individual elements per subsection.
- Flexible subsection and element counts where the subject requires more or less detail.

This suggests approximately 1,500 individual architectural elements as an initial scope target, rather than an arbitrary limit or a requirement to fill every section equally.

Each element should represent a meaningful capability, requirement, component, workflow, relationship, dependency, or architectural decision.

The framework should cover the entire environment rather than merely describing the current implementation.

It must distinguish between existing functionality, planned functionality, proposed functionality, unresolved decisions, and capabilities that are intentionally excluded.

Document B: AGENT_DISCOVERY_QUESTIONNAIRE.md

This document will contain approximately 100 carefully designed questions about the existing environment and its intended evolution.

The questionnaire will be used to establish:

1. What already exists.
2. What is currently being developed.
3. What is functional and tested.
4. What is partially functional or unreliable.
5. What infrastructure and dependencies are available.
6. What capabilities are missing.
7. Which components overlap or conflict.
8. What existing work can be reused.
9. What architectural decisions remain unresolved.
10. What the most appropriate development sequence should be.

Questions must be designed to produce concrete, actionable answers rather than vague architectural speculation.

Where possible, questions should request verifiable evidence such as repository paths, configuration references, file locations, installed package versions, test results, or existing documentation.

Neither document should be treated as finalized until the existing agents have completed their initial discovery and reconciliation.

---

3. PROPOSED MASTER ONTOLOGY

The following ten domains establish the preliminary scope of the framework.

These categories are starting points, not immutable boundaries. Their contents and relationships may be refined as existing infrastructure is discovered.

Ontology 01: System Infrastructure & Execution Environment

Linux environment, hardware limitations, operating-system configuration, storage, networking, containers, package management, resource allocation, background services, reliability, security, and system recovery.

Ontology 02: Agent Architecture & Orchestration

Hermes, specialized agents, agent delegation, task routing, model selection, tool execution, coordination, context handling, agent permissions, persistent state, monitoring, and automated workflows.

Ontology 03: Knowledge Management & Information Architecture

Existing Markdown collections, document discovery, metadata extraction, classification, indexing, semantic search, ontological organization, deduplication, cross-referencing, project reconstruction, knowledge retrieval, and source preservation.

Ontology 04: Models, APIs & Computational Services

Remote inference, provider integrations, model routing, multimodal endpoints, API authentication, usage monitoring, caching, fallback strategies, local-versus-remote execution, performance optimization, and computational cost management.

Ontology 05: Creative Production & Media Generation

AI-assisted music, songwriting, lyrics, fictional writing, narrative development, concept art, image generation, video generation, animation, storyboarding, audio processing, editing, rendering, and multimodal production pipelines.

Ontology 06: Software Development & Digital Publishing

Application development, websites, blogs, progressive web applications, frontend and backend frameworks, code generation, testing, version control, continuous integration, deployment, documentation, and software maintenance.

Ontology 07: Automation, Research & Data Acquisition

Web research, scraping where permitted, information retrieval, API integrations, data processing, workflow automation, scheduled execution, ingestion pipelines, monitoring, and automated reporting.

Ontology 08: User Interfaces & Unified Workbench

Desktop-first interfaces, modular dashboards, creative workspaces, terminal integration, project navigation, agent interaction, workflow visualization, reusable interface components, accessibility, responsive layouts, and system observability.

Ontology 09: Project Management, Asset Management & Production Operations

Project lifecycles, task management, asset libraries, directory conventions, naming systems, metadata schemas, reusable templates, dependency tracking, collaborative agent workflows, revision histories, production pipelines, and deliverable management.

Ontology 10: System Integration, Evolution & Governance

Cross-domain interoperability, system-wide schemas, architectural consistency, iterative development, automated validation, feedback loops, capability discovery, controlled evolution, documentation synchronization, backups, security boundaries, and recovery procedures.

---

4. IMMEDIATE INSTRUCTIONS FOR ALL AGENTS

Continue your currently assigned work unless it directly conflicts with the preservation or security requirements in this directive.

Do not interpret this directive as authorization to begin a system-wide rewrite, installation campaign, directory reorganization, or migration.

For the time being, perform the following additional tasks alongside your existing responsibilities.

A. Inventory your assigned subsystem

Identify the software, scripts, services, repositories, directories, configurations, data stores, APIs, and automation routines associated with your assigned responsibilities.

Separate functionality that is already working from functionality that is partially implemented or only proposed.

Document the current development status and any known limitations.

B. Identify your architectural relationships

Determine which of the ten proposed ontologies your work belongs to.

Identify direct dependencies on other components and capabilities that your subsystem provides to them.

Record any overlapping responsibilities, incompatible assumptions, duplicated functionality, or unresolved integration requirements.

C. Identify existing documentation

Locate relevant Markdown documents, specifications, README files, development notes, configuration documentation, and prior architectural decisions.

Record their locations and explain their relationship to your current work.

Do not assume that the newest document is necessarily the most authoritative.

Flag conflicting documentation for reconciliation rather than silently discarding one version.

D. Prepare to answer the master questionnaire

The 100-question discovery questionnaire will be distributed as a separate document.

Review the questions relevant to your subsystem and prepare evidence-based answers.

Questions outside your assigned area should be referred to the appropriate agent or marked as requiring additional investigation.

Do not invent answers to achieve apparent completeness.

E. Prepare framework contributions

Identify the architectural elements that your subsystem contributes to the master framework.

For each contribution, distinguish between:

- Existing and verified.
- Existing but unverified.
- Partially implemented.
- Currently under development.
- Planned.
- Proposed.
- Unknown or requiring investigation.

Record missing capabilities and proposed improvements separately from descriptions of the existing system.

---

5. MARKDOWN LIBRARY: SPECIAL DISCOVERY REQUIREMENTS

The existing Markdown collection may contain tens of thousands of files.

It represents a potentially valuable collection of prior research, development work, project specifications, creative material, configuration notes, and architectural decisions.

It must not be treated as an undifferentiated collection of documents to be repeatedly summarized.

Before proposing major changes to the knowledge-management system, determine:

- Where the existing Markdown collections are stored.
- How many files and directories are present.
- Which indexing, retrieval, classification, and metadata systems already exist.
- Which documents are already associated with known projects.
- Which files contain duplicate, overlapping, outdated, or conflicting material.
- Whether existing metadata, timestamps, or version histories can help establish document provenance.
- How the current agent accesses and retrieves information.
- Whether incremental indexing and change detection are already implemented.
- How documents are backed up and protected against accidental modification.
- How the existing knowledge infrastructure can be reused rather than rebuilt.

Initial inventory and classification should be read-only.

Preserve original files, directory relationships, and available metadata.

Do not perform bulk deletion, renaming, deduplication, content rewriting, or directory restructuring without explicit authorization.

Use incremental processing, bounded workloads, and resumable operations to avoid overwhelming the host machine.

The purpose is to make the existing information accessible, useful, and structurally coherent while preserving its original contents.

---

6. ARCHITECTURAL CONSTRAINTS

All architectural proposals must account for the following constraints.

Local-first control, remote-first heavy computation.

The Linux iMac should remain capable of managing the environment without being required to perform computationally intensive AI inference or media generation locally.

Use the existing machine for orchestration, filesystem operations, lightweight services, interfaces, indexing when practical, and appropriately bounded background tasks.

Remote services should provide computational acceleration where necessary.

Do not introduce large local model requirements or GPU dependencies without explicitly identifying their hardware requirements and an appropriate remote alternative.

Preserve existing investments.

Existing repositories, applications, agents, configurations, workflows, and completed development should be assessed before recommending replacements.

A new component should have a clearly documented purpose and relationship to the existing system.

Prefer modularity without unnecessary complexity.

Components should have clearly defined responsibilities and interfaces.

Avoid creating additional services, abstraction layers, agents, or databases merely to satisfy architectural symmetry.

Protect data and credentials.

Do not expose API keys, access tokens, passwords, private documents, or other sensitive information in reports, prompts, repositories, or shared coordination files.

Do not upload private source material to external services without established authorization.

Keep the architecture flexible.

The framework must support different model providers, creative tools, development environments, and storage technologies without unnecessarily binding the entire system to a single service.

Use evidence rather than assumptions.

A proposed technology must not be described as already installed or operational without evidence.

Unknown information should remain explicitly marked as unknown until investigated.

---

7. STANDARD AGENT REPORTING FORMAT

Each participating agent should prepare a Markdown report using the following structure.

Agent / Subsystem Identification

Agent name:

Assigned responsibilities:

Primary ontology or ontologies:

Current task:

Existing Implementation

Describe the current state of the assigned subsystem.

List relevant repositories, directories, applications, services, scripts, configurations, and existing documentation.

Verified Capabilities

Identify capabilities that are operational and describe the available evidence.

Work in Progress

Identify active development tasks, completed milestones, current blockers, and anticipated integration requirements.

Dependencies & Interfaces

Describe the services, files, data formats, APIs, and other components required by or exposed by this subsystem.

Architectural Gaps

Identify missing capabilities, incomplete integrations, reliability concerns, and technical limitations.

Recommended Framework Contributions

Identify the architectural requirements and capabilities that should be represented within the master framework.

Questionnaire Preparation

Identify important questions that the master questionnaire should ask about this subsystem.

Flag information that must be obtained from other agents or the human operator.

Risks & Preservation Requirements

Identify operations that could overwrite files, disrupt existing services, leak private data, introduce unexpected costs, or otherwise damage existing work.

Next Actions

Describe the current authorized tasks that can safely continue while the framework is being developed.

Separate these from new tasks that require approval.

---

8. COORDINATION & DOCUMENT RECONCILIATION

Each agent should produce its own subsystem report before attempting to merge findings into the master framework.

The designated coordinating agent, initially Hermes unless another coordinator is explicitly assigned, will consolidate these reports.

All agents should use a consistent terminology and status vocabulary.

The master framework should use persistent section identifiers to support cross-references between architectural elements, questionnaire answers, existing documentation, and implementation tasks.

Proposed identifiers:

- "ONT-01" through "ONT-10" for major ontologies.
- "ONT-01.01" for ontology subsections.
- "ONT-01.01.001" for individual architectural elements.
- "Q-001" through "Q-100" for questionnaire entries.

Each major framework revision should maintain a changelog identifying additions, modifications, unresolved conflicts, and decisions requiring approval.

When conflicting agent reports are discovered, record the disagreement and its supporting evidence instead of arbitrarily selecting one version.

Do not allow multiple agents to overwrite the same master document concurrently.

Use separate contribution files or version-controlled changes for review and integration.

---

9. INTENDED ITERATIVE DEVELOPMENT PROCESS

The system will be developed through the following discovery and refinement cycle.

Phase 1: Baseline discovery

Collect existing architectural documentation, subsystem inventories, and agent reports.

Phase 2: Initial framework construction

Develop the comprehensive ten-ontology master framework.

Clearly distinguish verified implementation details from architectural proposals.

Phase 3: Questionnaire development

Create the 100-question discovery questionnaire covering the complete environment, including its current implementation, limitations, goals, and unresolved design decisions.

Phase 4: Agent interrogation

Distribute the questionnaire to the appropriate agents.

Require evidence-based answers and supporting references wherever practical.

Phase 5: Reconciliation

Compare the answers against the master framework, existing documentation, and other agent reports.

Identify missing information, contradictions, duplicated capabilities, integration gaps, and previously undocumented functionality.

Phase 6: Framework refinement

Update the framework using the verified findings.

Preserve the provenance of existing capabilities and record proposed architectural changes separately.

Phase 7: Implementation planning

Translate the refined architecture into a prioritized, dependency-aware development plan.

Distinguish between preserving existing functionality, completing partially developed components, integrating current subsystems, and implementing entirely new capabilities.

Phase 8: Controlled implementation

Proceed with authorized development using bounded tasks, validation checkpoints, rollback procedures, and appropriately scoped agent responsibilities.

This process is iterative.

Subsequent discovery rounds may introduce new architectural elements, questions, requirements, or revisions as the actual system becomes better understood.

---

10. EXPECTED IMMEDIATE RESPONSE

Upon receiving this directive, each agent should:

1. Acknowledge the directive and identify its current responsibilities.
2. Continue authorized work without initiating an unrelated rebuild.
3. Prepare an initial subsystem inventory and status report.
4. Identify relevant existing documentation and architectural dependencies.
5. Record questions and unresolved information that the master questionnaire should address.
6. Prepare to contribute to the master framework when the initial documents are distributed.

The coordinating agent should collect these reports and prepare them for integration into the master framework.

Do not interpret this preliminary directive as authorization to reorganize the filesystem, replace the existing agent system, rewrite current applications, or begin large-scale migration.

The ultimate objective is to transform the existing collection of agents, knowledge, tools, services, and creative workflows into a unified, extensible, well-documented environment.

The architecture should emerge from a combination of the existing implementation, the owner's intended capabilities, and the results of systematic discovery.

Preserve what works. Document what exists. Identify what is missing. Reconcile the differences. Develop the implementation plan from verified information.

END OF DIRECTIVE