---
sovereign: true
raw-corpus: true
title: CYBERCRIME BIBLE-ADVERSARIAL
type: corpus
agent: worm
status: seed-imported
tags: [corpus, adversarial, reference]
slug: 12-jailbreak-corpus-cybercrime-bible-adversarial
name: CYBERCRIME BIBLE-ADVERSARIAL
version: 2026-10-15
kind: jailbreak-pattern
---

# THE 2026 COMPLETE CYBERCRIME BIBLE

## PART ONE: THE ADVERSARIAL LIFECYCLE (CONTINUED)

---

## SECTION 1.2: INITIAL ACCESS & VULNERABILITY EXPLOITATION (CONTINUED)

---

### 1.2.3 Social Engineering Vectors

| Entry | Description |
|-------|-------------|
| **1.2.3.1** | Spear-phishing with malicious attachments (macro-enabled documents, ISO files, LNK files) |
| **1.2.3.2** | Spear-phishing with credential harvesting links to cloned login portals |
| **1.2.3.3** | Business email compromise (BEC) using executive impersonation or account takeover |
| **1.2.3.4** | Vishing (voice phishing) campaigns using caller ID spoofing and pretexting |
| **1.2.3.5** | Smishing (SMS phishing) campaigns with malicious links or callback numbers |
| **1.2.3.6** | Social media-based social engineering via LinkedIn, Facebook, Twitter/X |
| **1.2.3.7** | Help desk social engineering to reset passwords or enroll MFA devices |
| **1.2.3.8** | Vendor impersonation targeting accounts payable or procurement |
| **1.2.3.9** | Executive impersonation targeting executive assistants and direct reports |
| **1.2.3.10** | Pretexting using stolen information from prior breaches or OSINT |
| **1.2.3.11** | Watering hole attacks on industry-specific websites frequented by targets |
| **1.2.3.12** | Physical social engineering (tailgating, pretexting as maintenance, vendor) |
| **1.2.3.13** | USB drop attacks in parking lots, lobbies, and conference venues |
| **1.2.3.14** | QR code phishing (quishing) redirecting to malicious credential harvesting sites |
| **1.2.3.15** | Deepfake audio/video social engineering for executive impersonation |
| **1.2.3.16** | Calendar invitation-based phishing with malicious links or attachments |
| **1.2.3.17** | File-sharing service notification phishing (SharePoint, OneDrive, Dropbox) |
| **1.2.3.18** | Fake voicemail notification phishing with embedded links |
| **1.2.3.19** | Fake fax notification phishing targeting legacy business processes |
| **1.2.3.20** | Multi-channel social engineering combining email, phone, and SMS |

---

### 1.2.4 Supply Chain & Third-Party Compromise

| Entry | Description |
|-------|-------------|
| **1.2.4.1** | Software supply chain compromise (poisoned update, backdoored library) |
| **1.2.4.2** | Managed service provider (MSP) compromise for downstream access |
| **1.2.4.3** | Vendor remote access exploitation (VPN, RDP, dedicated circuits) |
| **1.2.4.4** | Third-party API compromise for data access or injection |
| **1.2.4.5** | Cloud service provider compromise (shared responsibility gaps) |
| **1.2.4.6** | Hardware supply chain tampering (implants, firmware modification) |
| **1.2.4.7** | Open-source library compromise (typosquatting, dependency confusion) |
| **1.2.4.8** | Container image compromise in public or private registries |
| **1.2.4.9** | CI/CD pipeline compromise for code injection or credential theft |
| **1.2.4.10** | Code signing certificate compromise for signed malware |
| **1.2.4.11** | DNS provider compromise for traffic redirection |
| **1.2.4.12** | Certificate authority compromise for man-in-the-middle |
| **1.2.4.13** | Telecommunications provider compromise for SS7 attacks |
| **1.2.4.14** | Physical security vendor compromise for facility access |
| **1.2.4.15** | Legal or accounting firm compromise for privileged information |
| **1.2.4.16** | Staffing agency compromise for insider placement |
| **1.2.4.17** | Cleaning service compromise for physical access and device implants |
| **1.2.4.18** | Logistics provider compromise for package interdiction |
| **1.2.4.19** | Payment processor compromise for financial data access |
| **1.2.4.20** | Marketing agency compromise for brand impersonation |

---

### 1.2.5 Insider Threat Vectors

| Entry | Description |
|-------|-------------|
| **1.2.5.1** | Malicious insider selling access to external actors |
| **1.2.5.2** | Disgruntled employee seeking revenge or sabotage |
| **1.2.5.3** | Negligent employee falling for sophisticated social engineering |
| **1.2.5.4** | Bribed employee providing credentials or physical access |
| **1.2.5.5** | Coerced employee under duress (blackmail, threats to family) |
| **1.2.5.6** | Unwitting employee installing malware via phishing |
| **1.2.5.7** | Former employee with unrevoked access or knowledge |
| **1.2.5.8** | Contractor with excessive privileges or weak oversight |
| **1.2.5.9** | Third-party cleaner or maintenance access exploitation |
| **1.2.5.10** | Executive assistant with access to executive accounts and devices |
| **1.2.5.11** | IT administrator with privileged access and knowledge |
| **1.2.5.12** | Security guard with physical access and patrol knowledge |
| **1.2.5.13** | HR employee with access to PII and payroll systems |
| **1.2.5.14** | Finance employee with access to payment and banking systems |
| **1.2.5.15** | Developer with access to source code, secrets, and CI/CD |
| **1.2.5.16** | Database administrator with access to sensitive data |
| **1.2.5.17** | Network engineer with access to infrastructure |
| **1.2.5.18** | Cloud architect with access to cloud environments |
| **1.2.5.19** | Security analyst with access to detection and response tools |
| **1.2.5.20** | Executive with access to strategic and financial information |

---

## SECTION 1.3: PERSISTENCE & COMMAND AND CONTROL

*Establishing a durable presence and communication channel*

---

### 1.3.1 Backdoor & Implant Deployment

| Entry | Description |
|-------|-------------|
| **1.3.1.1** | Remote access trojan (RAT) installation (Cobalt Strike, Meterpreter, Sliver) |
| **1.3.1.2** | Web shell deployment (China Chopper, ASPX, PHP, JSP) |
| **1.3.1.3** | Backdoor user account creation (local, domain, cloud) |
| **1.3.1.4** | Scheduled task creation for persistence (Windows, Linux, macOS) |
| **1.3.1.5** | Registry key modification for autostart execution |
| **1.3.1.6** | Service installation for persistent execution |
| **1.3.1.7** | WMI event subscription for persistence |
| **1.3.1.8** | COM object hijacking for persistence |
| **1.3.1.9** | DLL search order hijacking for persistence |
| **1.3.1.10** | Bootkit installation for pre-OS persistence |
| **1.3.1.11** | Rootkit installation for deep system concealment |
| **1.3.1.12** | Firmware implant for hardware-level persistence (UEFI, BIOS) |
| **1.3.1.13** | Hypervisor-based implant for VM-level persistence |
| **1.3.1.14** | Container-based persistence (Kubernetes daemonsets, sidecars) |
| **1.3.1.15** | Cloud-based persistence (IAM roles, Lambda, Azure Functions) |
| **1.3.1.16** | SSH authorized_keys modification for persistence |
| **1.3.1.17** | Cron job creation for persistence (Linux, macOS) |
| **1.3.1.18** | LaunchAgent/LaunchDaemon creation for persistence (macOS) |
| **1.3.1.19** | Systemd service creation for persistence (Linux) |
| **1.3.1.20** | Browser extension installation for persistence and data access |

---

### 1.3.2 Command & Control Infrastructure

| Entry | Description |
|-------|-------------|
| **1.3.2.1** | HTTP/HTTPS C2 channels with malleable profiles |
| **1.3.2.2** | DNS tunneling for C2 (iodine, dnscat2) |
| **1.3.2.3** | ICMP tunneling for C2 |
| **1.3.2.4** | Domain fronting for C2 concealment (CDN abuse) |
| **1.3.2.5** | Legitimate cloud service abuse for C2 (Dropbox, Google Drive, Slack) |
| **1.3.2.6** | Social media platform C2 (Twitter/X, Telegram, Discord) |
| **1.3.2.7** | Peer-to-peer C2 networks (botnet mesh) |
| **1.3.2.8** | Blockchain-based C2 (Ethereum, Bitcoin transactions) |
| **1.3.2.9** | Tor hidden service C2 |
| **1.3.2.10** | Fast-flux DNS for C2 resilience |
| **1.3.2.11** | Domain generation algorithms (DGA) for C2 resilience |
| **1.3.2.12** | Encrypted messaging platform C2 (Matrix, XMPP) |
| **1.3.2.13** | Email-based C2 (IMAP, SMTP, webmail drafts) |
| **1.3.2.14** | Dead drop resolver C2 |
| **1.3.2.15** | Malleable C2 profiles for evasion (Cobalt Strike, Sliver) |
| **1.3.2.16** | WebSocket C2 for real-time communication |
| **1.3.2.17** | gRPC C2 for modern application protocol abuse |
| **1.3.2.18** | MQTT C2 for IoT and industrial protocol abuse |
| **1.3.2.19** | Server Message Block (SMB) named pipe C2 |
| **1.3.2.20** | Windows Remote Management (WinRM) C2 |

---

### 1.3.3 Operational Security & Evasion

| Entry | Description |
|-------|-------------|
| **1.3.3.1** | Log deletion and tampering (Windows Event Log, Syslog, CloudTrail) |
| **1.3.3.2** | Timestomping for forensic evasion |
| **1.3.3.3** | Security tool disabling (AV, EDR, firewall) |
| **1.3.3.4** | Antivirus evasion techniques (signature obfuscation, polymorphism) |
| **1.3.3.5** | EDR evasion techniques (hook removal, ETW patching) |
| **1.3.3.6** | Sandbox detection and evasion |
| **1.3.3.7** | Virtual machine detection |
| **1.3.3.8** | Debugger detection |
| **1.3.3.9** | Code obfuscation and packing |
| **1.3.3.10** | Living-off-the-land binaries (LOLBins) for evasion |
| **1.3.3.11** | Fileless malware techniques (PowerShell, WMI, registry) |
| **1.3.3.12** | Process injection and hollowing |
| **1.3.3.13** | Reflective DLL injection |
| **1.3.3.14** | Anti-forensic techniques (secure deletion, encryption) |
| **1.3.3.15** | Traffic encryption and obfuscation |
| **1.3.3.16** | Protocol impersonation (mimicking legitimate traffic) |
| **1.3.3.17** | Beacon jitter and sleep for traffic analysis evasion |
| **1.3.3.18** | Infrastructure compartmentalization |
| **1.3.3.19** | Operational security failures and lessons learned |
| **1.3.3.20** | Counter-forensic techniques for specific EDR products |

---

### 1.3.4 Redundancy & Resilience

| Entry | Description |
|-------|-------------|
| **1.3.4.1** | Multiple backdoor deployment across different systems |
| **1.3.4.2** | Redundant C2 channels using different protocols |
| **1.3.4.3** | Fallback communication protocols for primary C2 failure |
| **1.3.4.4** | Compromised account diversification |
| **1.3.4.5** | Geographic distribution of infrastructure |
| **1.3.4.6** | Cloud provider diversification (AWS, Azure, GCP) |
| **1.3.4.7** | Encryption key escrow for recovery |
| **1.3.4.8** | Dead man's switch for data release |
| **1.3.4.9** | Automated re-infection mechanisms |
| **1.3.4.10** | Supply chain persistence (poisoned dependencies) |
| **1.3.4.11** | Hardware implant redundancy |
| **1.3.4.12** | Insider asset preservation |
| **1.3.4.13** | Financial resource redundancy (multiple wallets, exchanges) |
| **1.3.4.14** | Legal and jurisdictional fallback |
| **1.3.4.15** | Identity and infrastructure rotation |
| **1.3.4.16** | Backup C2 infrastructure pre-staged |
| **1.3.4.17** | Alternate exfiltration paths |
| **1.3.4.18** | Redundant staging locations |
| **1.3.4.19** | Multiple ransomware deployment mechanisms |
| **1.3.4.20** | Contingency plans for detection |

---

## SECTION 1.4: PRIVILEGE ESCALATION & CREDENTIAL ACCESS

*Elevating from initial foothold to domain dominance*

---

### 1.4.1 Local Privilege Escalation

| Entry | Description |
|-------|-------------|
| **1.4.1.1** | Kernel exploit for system-level access (CVE-based) |
| **1.4.1.2** | Service misconfiguration exploitation |
| **1.4.1.3** | Unquoted service path exploitation |
| **1.4.1.4** | Weak service permissions exploitation |
| **1.4.1.5** | DLL hijacking for privilege escalation |
| **1.4.1.6** | Token impersonation abuse (SeImpersonate, SeAssignPrimaryToken) |
| **1.4.1.7** | SeDebugPrivilege abuse |
| **1.4.1.8** | SeBackupPrivilege and SeRestorePrivilege abuse |
| **1.4.1.9** | Scheduled task privilege escalation |
| **1.4.1.10** | Registry permission exploitation |
| **1.4.1.11** | File system permission exploitation |
| **1.4.1.12** | Group policy preference exploitation (cpassword) |
| **1.4.1.13** | AlwaysInstallElevated exploitation |
| **1.4.1.14** | Unattended installation file discovery |
| **1.4.1.15** | Password in configuration file discovery |
| **1.4.1.16** | SUID/SGID binary exploitation (Linux) |
| **1.4.1.17** | Sudo misconfiguration exploitation (Linux) |
| **1.4.1.18** | Cron job privilege escalation (Linux) |
| **1.4.1.19** | Capabilities abuse (Linux) |
| **1.4.1.20** | macOS authorization bypass |

---

### 1.4.2 Credential Harvesting

| Entry | Description |
|-------|-------------|
| **1.4.2.1** | LSASS memory dumping (Mimikatz, ProcDump, comsvcs.dll) |
| **1.4.2.2** | SAM database extraction |
| **1.4.2.3** | NTDS.dit extraction from domain controllers |
| **1.4.2.4** | Kerberoasting service accounts |
| **1.4.2.5** | AS-REP roasting accounts without pre-authentication |
| **1.4.2.6** | Unconstrained delegation abuse |
| **1.4.2.7** | Constrained delegation abuse |
| **1.4.2.8** | Resource-based constrained delegation abuse |
| **1.4.2.9** | Credential Manager extraction |
| **1.4.2.10** | Browser credential extraction (Chrome, Firefox, Edge) |
| **1.4.2.11** | SSH key extraction and passphrase cracking |
| **1.4.2.12** | Cloud credential extraction (AWS CLI, Azure CLI, gcloud) |
| **1.4.2.13** | Database credential extraction |
| **1.4.2.14** | Application credential extraction |
| **1.4.2.15** | Configuration file credential extraction |
| **1.4.2.16** | Password hash cracking (hashcat, John the Ripper) |
| **1.4.2.17** | Password spraying against discovered accounts |
| **1.4.2.18** | Credential stuffing using breach databases |
| **1.4.2.19** | Keylogger output collection |
| **1.4.2.20** | Network sniffing for credential capture |

---

### 1.4.3 Domain Dominance

| Entry | Description |
|-------|-------------|
| **1.4.3.1** | Golden ticket creation (KRBTGT hash compromise) |
| **1.4.3.2** | Silver ticket creation (service account hash compromise) |
| **1.4.3.3** | Diamond ticket creation |
| **1.4.3.4** | Skeleton key installation on domain controllers |
| **1.4.3.5** | DCSync attack for credential replication |
| **1.4.3.6** | DCShadow attack for persistence |
| **1.4.3.7** | AdminSDHolder abuse for persistence |
| **1.4.3.8** | ACL modification for persistence and access |
| **1.4.3.9** | Group policy object (GPO) abuse for lateral movement |
| **1.4.3.10** | Certificate services exploitation (AD CS) |
| **1.4.3.11** | AD CS misconfiguration exploitation (ESC1-ESC8) |
| **1.4.3.12** | Trust relationship exploitation |
| **1.4.3.13** | Forest trust exploitation |
| **1.4.3.14** | Azure AD Connect compromise |
| **1.4.3.15** | Hybrid identity exploitation |
| **1.4.3.16** | Domain controller replication abuse |
| **1.4.3.17** | Group membership modification for access |
| **1.4.3.18** | Password reset of privileged accounts |
| **1.4.3.19** | Account takeover of service accounts |
| **1.4.3.20** | Domain trust key extraction |

---

### 1.4.4 Cloud Privilege Escalation

| Entry | Description |
|-------|-------------|
| **1.4.4.1** | IAM policy exploitation (AWS, Azure, GCP) |
| **1.4.4.2** | Role assumption abuse |
| **1.4.4.3** | Service account key compromise |
| **1.4.4.4** | Metadata service exploitation (IMDSv1, IMDSv2 bypass) |
| **1.4.4.5** | Lambda function privilege escalation |
| **1.4.4.6** | Container escape to host |
| **1.4.4.7** | Kubernetes RBAC exploitation |
| **1.4.4.8** | Cloud storage permission exploitation |
| **1.4.4.9** | Cloud database privilege escalation |
| **1.4.4.10** | Cloud logging and monitoring evasion |
| **1.4.4.11** | Cross-account role exploitation |
| **1.4.4.12** | Federated identity exploitation |
| **1.4.4.13** | OAuth application privilege escalation |
| **1.4.4.14** | Cloud secret manager exploitation |
| **1.4.4.15** | Cloud CI/CD pipeline exploitation |
| **1.4.4.16** | Serverless function event injection |
| **1.4.4.17** | Cloud function environment variable extraction |
| **1.4.4.18** | Cloud instance profile abuse |
| **1.4.4.19** | Cloud organization policy bypass |
| **1.4.4.20** | Cloud service principal manipulation |

---

## SECTION 1.5: LATERAL MOVEMENT & NETWORK TRAVERSAL

*Expanding the foothold across the network*

---

### 1.5.1 Windows Network Lateral Movement

| Entry | Description |
|-------|-------------|
| **1.5.1.1** | Pass-the-hash attacks |
| **1.5.1.2** | Pass-the-ticket attacks |
| **1.5.1.3** | Overpass-the-hash attacks |
| **1.5.1.4** | PsExec for remote execution |
| **1.5.1.5** | WMI for remote execution |
| **1.5.1.6** | SMB admin shares access (C$, ADMIN$) |
| **1.5.1.7** | Remote desktop protocol (RDP) |
| **1.5.1.8** | WinRM for remote management |
| **1.5.1.9** | DCOM for remote execution |
| **1.5.1.10** | Scheduled task creation on remote systems |
| **1.5.1.11** | Service creation on remote systems |
| **1.5.1.12** | PowerShell remoting |
| **1.5.1.13** | SMB relay attacks |
| **1.5.1.14** | LLMNR/NBT-NS poisoning |
| **1.5.1.15** | WPAD exploitation |
| **1.5.1.16** | Kerberos delegation abuse |
| **1.5.1.17** | NTLM relay attacks |
| **1.5.1.18** | Remote registry manipulation |
| **1.5.1.19** | RDP session hijacking |
| **1.5.1.20** | Remote code execution via MSSQL |

---

### 1.5.2 Cross-Platform Lateral Movement

| Entry | Description |
|-------|-------------|
| **1.5.2.1** | SSH key reuse and forwarding |
| **1.5.2.2** | SSH agent hijacking |
| **1.5.2.3** | VPN credential reuse |
| **1.5.2.4** | Jump host compromise |
| **1.5.2.5** | Cloud instance metadata abuse |
| **1.5.2.6** | Container orchestration API abuse |
| **1.5.2.7** | Kubernetes service account abuse |
| **1.5.2.8** | Docker socket exploitation |
| **1.5.2.9** | CI/CD pipeline abuse |
| **1.5.2.10** | Configuration management tool abuse (Ansible, Puppet, Chef) |
| **1.5.2.11** | Monitoring and logging system abuse |
| **1.5.2.12** | Backup system abuse |
| **1.5.2.13** | Database link exploitation |
| **1.5.2.14** | Application trust relationship abuse |
| **1.5.2.15** | API gateway exploitation |
| **1.5.2.16** | Message queue exploitation |
| **1.5.2.17** | Service mesh exploitation |
| **1.5.2.18** | Container registry exploitation |
| **1.5.2.19** | Artifact repository exploitation |
| **1.5.2.20** | Secret management system exploitation |

---

### 1.5.3 Network Infrastructure Compromise

| Entry | Description |
|-------|-------------|
| **1.5.3.1** | Router and switch compromise |
| **1.5.3.2** | Firewall rule modification |
| **1.5.3.3** | Load balancer compromise |
| **1.5.3.4** | Proxy server compromise |
| **1.5.3.5** | DNS server compromise |
| **1.5.3.6** | DHCP server compromise |
| **1.5.3.7** | Wireless access point compromise |
| **1.5.3.8** | Network tap and span port abuse |
| **1.5.3.9** | VLAN hopping |
| **1.5.3.10** | ARP spoofing |
| **1.5.3.11** | DNS spoofing |
| **1.5.3.12** | BGP hijacking |
| **1.5.3.13** | MPLS network compromise |
| **1.5.3.14** | SD-WAN compromise |
| **1.5.3.15** | Network function virtualization compromise |
| **1.5.3.16** | Network access control (NAC) bypass |
| **1.5.3.17** | 802.1X authentication bypass |
| **1.5.3.18** | Spanning tree protocol manipulation |
| **1.5.3.19** | Port security bypass |
| **1.5.3.20** | Network segmentation bypass |

---

### 1.5.4 Cloud & Virtualization Lateral Movement

| Entry | Description |
|-------|-------------|
| **1.5.4.1** | Virtual machine escape |
| **1.5.4.2** | Hypervisor compromise |
| **1.5.4.3** | Cloud management plane access |
| **1.5.4.4** | Cross-tenant attacks |
| **1.5.4.5** | Cloud service mesh exploitation |
| **1.5.4.6** | Serverless function lateral movement |
| **1.5.4.7** | Cloud storage lateral movement |
| **1.5.4.8** | Cloud database lateral movement |
| **1.5.4.9** | Cloud messaging service abuse |
| **1.5.4.10** | Cloud identity federation abuse |
| **1.5.4.11** | Multi-cloud pivot |
| **1.5.4.12** | Hybrid cloud pivot |
| **1.5.4.13** | Cloud VPN and Direct Connect abuse |
| **1.5.4.14** | Cloud DNS exploitation |
| **1.5.4.15** | Cloud CDN exploitation |
| **1.5.4.16** | Cloud load balancer exploitation |
| **1.5.4.17** | Cloud auto-scaling group manipulation |
| **1.5.4.18** | Cloud container registry poisoning |
| **1.5.4.19** | Cloud function trigger manipulation |
| **1.5.4.20** | Cloud API gateway exploitation |

---

## SECTION 1.6: DATA DISCOVERY & TARGET IDENTIFICATION

*Locating and classifying the crown jewels*

---

### 1.6.1 File System Discovery

| Entry | Description |
|-------|-------------|
| **1.6.1.1** | Network share enumeration |
| **1.6.1.2** | File server indexing and cataloging |
| **1.6.1.3** | Distributed file system (DFS) exploration |
| **1.6.1.4** | SharePoint site discovery |
| **1.6.1.5** | OneDrive/Google Drive enumeration |
| **1.6.1.6** | Box/Dropbox enterprise discovery |
| **1.6.1.7** | Local file system search for keywords |
| **1.6.1.8** | Hidden file and directory discovery |
| **1.6.1.9** | Alternate data stream (ADS) discovery |
| **1.6.1.10** | File metadata analysis |
| **1.6.1.11** | Document classification label analysis |
| **1.6.1.12** | Data loss prevention (DLP) system mapping |
| **1.6.1.13** | Rights management service (RMS) analysis |
| **1.6.1.14** | File access audit log analysis |
| **1.6.1.15** | Backup catalog exploration |
| **1.6.1.16** | Version history exploration |
| **1.6.1.17** | Deleted file recovery |
| **1.6.1.18** | Shadow copy exploration |
| **1.6.1.19** | Snapshot exploration |
| **1.6.1.20** | Offline file analysis |

---

### 1.6.2 Database Discovery

| Entry | Description |
|-------|-------------|
| **1.6.2.1** | Database server enumeration |
| **1.6.2.2** | Database schema discovery |
| **1.6.2.3** | Table and column enumeration |
| **1.6.2.4** | Stored procedure analysis |
| **1.6.2.5** | Database link discovery |
| **1.6.2.6** | Data warehouse exploration |
| **1.6.2.7** | Data lake exploration |
| **1.6.2.8** | NoSQL database discovery |
| **1.6.2.9** | Graph database discovery |
| **1.6.2.10** | Time-series database discovery |
| **1.6.2.11** | Database backup discovery |
| **1.6.2.12** | Database replication configuration |
| **1.6.2.13** | Database audit log analysis |
| **1.6.2.14** | Data masking and encryption status |
| **1.6.2.15** | Data retention policy analysis |
| **1.6.2.16** | Database connection string discovery |
| **1.6.2.17** | Database credential discovery |
| **1.6.2.18** | Database job and schedule discovery |
| **1.6.2.19** | Database trigger and function analysis |
| **1.6.2.20** | Database external table analysis |

---

### 1.6.3 Email & Communication Discovery

| Entry | Description |
|-------|-------------|
| **1.6.3.1** | Email server enumeration |
| **1.6.3.2** | Mailbox discovery and enumeration |
| **1.6.3.3** | Email archive exploration |
| **1.6.3.4** | Email search for keywords |
| **1.6.3.5** | Attachment discovery and analysis |
| **1.6.3.6** | Calendar and meeting discovery |
| **1.6.3.7** | Contact list extraction |
| **1.6.3.8** | Distribution list discovery |
| **1.6.3.9** | Instant messaging platform discovery |
| **1.6.3.10** | Collaboration platform discovery (Slack, Teams) |
| **1.6.3.11** | Video conferencing platform discovery |
| **1.6.3.12** | VoIP system discovery |
| **1.6.3.13** | Email gateway configuration |
| **1.6.3.14** | Email retention policy analysis |
| **1.6.3.15** | Email encryption status |
| **1.6.3.16** | Email forwarding rule discovery |
| **1.6.3.17** | Email delegation discovery |
| **1.6.3.18** | Shared mailbox discovery |
| **1.6.3.19** | Resource mailbox discovery |
| **1.6.3.20** | Email journaling configuration |

---

### 1.6.4 Application & Service Discovery

| Entry | Description |
|-------|-------------|
| **1.6.4.1** | CRM system discovery |
| **1.6.4.2** | ERP system discovery |
| **1.6.4.3** | HR system discovery |
| **1.6.4.4** | Financial system discovery |
| **1.6.4.5** | Source code repository discovery |
| **1.6.4.6** | CI/CD system discovery |
| **1.6.4.7** | Project management tool discovery |
| **1.6.4.8** | Ticketing system discovery |
| **1.6.4.9** | Document management system discovery |
| **1.6.4.10** | Contract management system discovery |
| **1.6.4.11** | Legal hold system discovery |
| **1.6.4.12** | Compliance system discovery |
| **1.6.4.13** | Business intelligence system discovery |
| **1.6.4.14** | Data analytics platform discovery |
| **1.6.4.15** | API gateway and service discovery |
| **1.6.4.16** | Identity provider discovery |
| **1.6.4.17** | SSO configuration discovery |
| **1.6.4.18** | MFA configuration discovery |
| **1.6.4.19** | Privileged access management discovery |
| **1.6.4.20** | Secrets management discovery |

---

### 1.6.5 Data Classification & Prioritization

| Entry | Description |
|-------|-------------|
| **1.6.5.1** | PII identification and classification |
| **1.6.5.2** | PHI identification and classification |
| **1.6.5.3** | PCI data identification and classification |
| **1.6.5.4** | Intellectual property identification |
| **1.6.5.5** | Trade secret identification |
| **1.6.5.6** | Financial record identification |
| **1.6.5.7** | Legal privileged communication identification |
| **1.6.5.8** | Executive communication identification |
| **1.6.5.9** | Board meeting material identification |
| **1.6.5.10** | M&A due diligence material identification |
| **1.6.5.11** | Strategic plan identification |
| **1.6.5.12** | Customer list identification |
| **1.6.5.13** | Supplier and vendor list identification |
| **1.6.5.14** | Employee data identification |
| **1.6.5.15** | Security configuration and credential identification |
| **1.6.5.16** | Source code identification |
| **1.6.5.17** | Algorithm and model identification |
| **1.6.5.18** | Research and development data identification |
| **1.6.5.19** | Clinical trial data identification |
| **1.6.5.20** | National security information identification |

---

## SECTION 1.7: DATA COLLECTION & STAGING

*Aggregating and preparing stolen data for exfiltration*

---

### 1.7.1 Data Collection Techniques

| Entry | Description |
|-------|-------------|
| **1.7.1.1** | Bulk file copy from file shares |
| **1.7.1.2** | Database export and dump |
| **1.7.1.3** | Email export (PST, MBOX) |
| **1.7.1.4** | Cloud storage synchronization |
| **1.7.1.5** | API-based data extraction |
| **1.7.1.6** | Screen capture and OCR |
| **1.7.1.7** | Keylogger output collection |
| **1.7.1.8** | Clipboard capture |
| **1.7.1.9** | Printer spool capture |
| **1.7.1.10** | Backup file acquisition |
| **1.7.1.11** | Shadow copy access |
| **1.7.1.12** | Volume shadow copy exploitation |
| **1.7.1.13** | Database transaction log capture |
| **1.7.1.14** | Application log capture |
| **1.7.1.15** | Network traffic capture |
| **1.7.1.16** | Memory dump collection |
| **1.7.1.17** | Page file collection |
| **1.7.1.18** | Hibernation file collection |
| **1.7.1.19** | Browser data collection |
| **1.7.1.20** | Mobile device data collection |

---

### 1.7.2 Data Processing & Preparation

| Entry | Description |
|-------|-------------|
| **1.7.2.1** | Data compression (ZIP, RAR, 7z) |
| **1.7.2.2** | Data encryption (AES, RSA) |
| **1.7.2.3** | Data partitioning for size management |
| **1.7.2.4** | Data deduplication |
| **1.7.2.5** | Data normalization |
| **1.7.2.6** | Data enrichment from public sources |
| **1.7.2.7** | Data validation and verification |
| **1.7.2.8** | Metadata removal |
| **1.7.2.9** | Watermarking for tracking |
| **1.7.2.10** | Index creation for searchability |
| **1.7.2.11** | Catalog creation for inventory |
| **1.7.2.12** | Sample selection for proof-of-leak |
| **1.7.2.13** | Redaction for strategic release |
| **1.7.2.14** | Format conversion for buyer needs |
| **1.7.2.15** | Packaging for distribution |
| **1.7.2.16** | Data quality assessment |
| **1.7.2.17** | Data value estimation |
| **1.7.2.18** | Data marketability assessment |
| **1.7.2.19** | Data freshness verification |
| **1.7.2.20** | Data completeness verification |

---

### 1.7.3 Staging Infrastructure

| Entry | Description |
|-------|-------------|
| **1.7.3.1** | Internal staging server setup |
| **1.7.3.2** | Compromised cloud storage staging |
| **1.7.3.3** | Compromised website staging |
| **1.7.3.4** | Peer-to-peer staging network |
| **1.7.3.5** | Tor hidden service staging |
| **1.7.3.6** | Bulletproof hosting staging |
| **1.7.3.7** | Content delivery network staging |
| **1.7.3.8** | File sharing service staging |
| **1.7.3.9** | Code repository staging |
| **1.7.3.10** | Container registry staging |
| **1.7.3.11** | Database staging |
| **1.7.3.12** | Email account staging |
| **1.7.3.13** | Social media account staging |
| **1.7.3.14** | Messaging platform staging |
| **1.7.3.15** | Blockchain storage staging |
| **1.7.3.16** | Usenet staging |
| **1.7.3.17** | IRC staging |
| **1.7.3.18** | FTP staging |
| **1.7.3.19** | DNS staging |
| **1.7.3.20** | Steganographic staging |

---

### 1.7.4 Operational Security During Staging

| Entry | Description |
|-------|-------------|
| **1.7.4.1** | Encryption of staged data |
| **1.7.4.2** | Access control for staged data |
| **1.7.4.3** | Audit logging for staged data access |
| **1.7.4.4** | Geographic distribution of staged data |
| **1.7.4.5** | Redundancy of staged data |
| **1.7.4.6** | Dead man's switch for staged data |
| **1.7.4.7** | Timed release mechanisms |
| **1.7.4.8** | Anti-forensic cleanup of staging |
| **1.7.4.9** | Cover traffic generation |
| **1.7.4.10** | Traffic analysis resistance |
| **1.7.4.11** | Attribution avoidance techniques |
| **1.7.4.12** | Infrastructure compartmentalization |
| **1.7.4.13** | Communication compartmentalization |
| **1.7.4.14** | Identity compartmentalization |
| **1.7.4.15** | Financial compartmentalization |
| **1.7.4.16** | Operational security failures and lessons |
| **1.7.4.17** | Counter-intelligence considerations |
| **1.7.4.18** | Insider threat mitigation |
| **1.7.4.19** | Law enforcement evasion |
| **1.7.4.20** | Intelligence agency evasion |

---

## SECTION 1.8: EXFILTRATION & DATA TRANSFER

*Moving stolen data out of the victim environment*

---

### 1.8.1 Network-Based Exfiltration

| Entry | Description |
|-------|-------------|
| **1.8.1.1** | HTTPS exfiltration to attacker infrastructure |
| **1.8.1.2** | DNS tunneling exfiltration |
| **1.8.1.3** | ICMP tunneling exfiltration |
| **1.8.1.4** | FTP/SFTP exfiltration |
| **1.8.1.5** | SMB exfiltration to external share |
| **1.8.1.6** | SMTP exfiltration via email |
| **1.8.1.7** | Cloud storage synchronization |
| **1.8.1.8** | API-based exfiltration |
| **1.8.1.9** | WebSocket exfiltration |
| **1.8.1.10** | MQTT exfiltration |
| **1.8.1.11** | gRPC exfiltration |
| **1.8.1.12** | Tor network exfiltration |
| **1.8.1.13** | I2P network exfiltration |
| **1.8.1.14** | VPN tunnel exfiltration |
| **1.8.1.15** | Proxy chain exfiltration |
| **1.8.1.16** | SSH tunnel exfiltration |
| **1.8.1.17** | RDP clipboard exfiltration |
| **1.8.1.18** | VNC exfiltration |
| **1.8.1.19** | Remote desktop gateway exfiltration |
| **1.8.1.20** | VoIP channel exfiltration |

---

### 1.8.2 Application-Layer Exfiltration

| Entry | Description |
|-------|-------------|
| **1.8.2.1** | Email attachment exfiltration |
| **1.8.2.2** | Cloud document sharing exfiltration |
| **1.8.2.3** | Code repository commit exfiltration |
| **1.8.2.4** | CI/CD pipeline artifact exfiltration |
| **1.8.2.5** | Container registry image exfiltration |
| **1.8.2.6** | Database replication exfiltration |
| **1.8.2.7** | Backup system exfiltration |
| **1.8.2.8** | Log aggregation system exfiltration |
| **1.8.2.9** | Monitoring system exfiltration |
| **1.8.2.10** | Messaging platform exfiltration |
| **1.8.2.11** | Collaboration platform exfiltration |
| **1.8.2.12** | Project management platform exfiltration |
| **1.8.2.13** | CRM system exfiltration |
| **1.8.2.14** | ERP system exfiltration |
| **1.8.2.15** | HR system exfiltration |
| **1.8.2.16** | Ticketing system exfiltration |
| **1.8.2.17** | Wiki and knowledge base exfiltration |
| **1.8.2.18** | Document management system exfiltration |
| **1.8.2.19** | Business intelligence platform exfiltration |
| **1.8.2.20** | Data analytics platform exfiltration |

---

### 1.8.3 Physical & Offline Exfiltration

| Entry | Description |
|-------|-------------|
| **1.8.3.1** | USB drive exfiltration |
| **1.8.3.2** | External hard drive exfiltration |
| **1.8.3.3** | SD card exfiltration |
| **1.8.3.4** | Smartphone storage exfiltration |
| **1.8.3.5** | Laptop removal exfiltration |
| **1.8.3.6** | Printed document exfiltration |
| **1.8.3.7** | Photocopier storage exfiltration |
| **1.8.3.8** | Printer spool exfiltration |
| **1.8.3.9** | Fax machine exfiltration |
| **1.8.3.10** | Physical mail exfiltration |
| **1.8.3.11** | Dead drop exfiltration |
| **1.8.3.12** | Insider carrying data out |
| **1.8.3.13** | Visitor carrying data out |
| **1.8.3.14** | Vendor carrying data out |
| **1.8.3.15** | Cleaning crew carrying data out |
| **1.8.3.16** | Camera-based exfiltration |
| **1.8.3.17** | Audio recording exfiltration |
| **1.8.3.18** | Screen photography exfiltration |
| **1.8.3.19** | Document photography exfiltration |
| **1.8.3.20** | Verbal communication exfiltration |

---

### 1.8.4 Covert Exfiltration Techniques

| Entry | Description |
|-------|-------------|
| **1.8.4.1** | Steganography in images |
| **1.8.4.2** | Steganography in audio files |
| **1.8.4.3** | Steganography in video files |
| **1.8.4.4** | Steganography in documents |
| **1.8.4.5** | Data hiding in network protocols |
| **1.8.4.6** | Data hiding in DNS queries |
| **1.8.4.7** | Data hiding in HTTP headers |
| **1.8.4.8** | Data hiding in TLS extensions |
| **1.8.4.9** | Data hiding in ICMP packets |
| **1.8.4.10** | Data hiding in NTP packets |
| **1.8.4.11** | Timing-based covert channels |
| **1.8.4.12** | Storage-based covert channels |
| **1.8.4.13** | Thermal covert channels |
| **1.8.4.14** | Electromagnetic covert channels |
| **1.8.4.15** | Acoustic covert channels |
| **1.8.4.16** | Optical covert channels |
| **1.8.4.17** | Power consumption covert channels |
| **1.8.4.18** | Cache-based covert channels |
| **1.8.4.19** | Memory-based covert channels |
| **1.8.4.20** | Blockchain-based covert channels |

---

## SECTION 1.9: EXTORTION & RANSOM OPERATIONS

*The psychological and financial pressure campaign*

---

### 1.9.1 Ransomware Deployment

| Entry | Description |
|-------|-------------|
| **1.9.1.1** | Manual ransomware deployment |
| **1.9.1.2** | Automated ransomware deployment via GPO |
| **1.9.1.3** | Automated ransomware deployment via PsExec |
| **1.9.1.4** | Automated ransomware deployment via WMI |
| **1.9.1.5** | Ransomware deployment via software distribution |
| **1.9.1.6** | Ransomware deployment via backup software |
| **1.9.1.7** | Ransomware deployment via remote monitoring |
| **1.9.1.8** | Double extortion (encryption + data theft) |
| **1.9.1.9** | Triple extortion (encryption + data theft + DDoS) |
| **1.9.1.10** | Quadruple extortion (adding customer/partner pressure) |
| **1.9.1.11** | Intermittent encryption for speed |
| **1.9.1.12** | Partial encryption for psychological impact |
| **1.9.1.13** | Destructive wiper disguised as ransomware |
| **1.9.1.14** | Fileless ransomware |
| **1.9.1.15** | Ransomware with delayed detonation |
| **1.9.1.16** | Ransomware targeting specific file types |
| **1.9.1.17** | Ransomware targeting specific departments |
| **1.9.1.18** | Ransomware targeting backups first |
| **1.9.1.19** | Ransomware targeting domain controllers |
| **1.9.1.20** | Ransomware targeting hypervisors |

---

### 1.9.2 Backup Destruction

| Entry | Description |
|-------|-------------|
| **1.9.2.1** | Backup server compromise |
| **1.9.2.2** | Backup catalog deletion |
| **1.9.2.3** | Backup data encryption |
| **1.9.2.4** | Backup data deletion |
| **1.9.2.5** | Backup tape destruction |
| **1.9.2.6** | Cloud backup deletion |
| **1.9.2.7** | Backup credential compromise |
| **1.9.2.8** | Backup software exploitation |
| **1.9.2.9** | Backup network isolation bypass |
| **1.9.2.10** | Immutable backup bypass |
| **1.9.2.11** | Air-gapped backup compromise |
| **1.9.2.12** | Backup restoration sabotage |
| **1.9.2.13** | Shadow copy deletion |
| **1.9.2.14** | Snapshot deletion |
| **1.9.2.15** | Replication target compromise |
| **1.9.2.16** | Backup encryption key destruction |
| **1.9.2.17** | Backup catalog corruption |
| **1.9.2.18** | Backup schedule disruption |
| **1.9.2.19** | Backup verification bypass |
| **1.9.2.20** | Backup media theft |

---

### 1.9.3 Negotiation Operations

| Entry | Description |
|-------|-------------|
| **1.9.3.1** | Initial contact and demand delivery |
| **1.9.3.2** | Negotiation channel establishment |
| **1.9.3.3** | Proof of data theft presentation |
| **1.9.3.4** | Proof of decryption capability demonstration |
| **1.9.3.5** | Price negotiation tactics |
| **1.9.3.6** | Deadline setting and enforcement |
| **1.9.3.7** | Psychological pressure tactics |
| **1.9.3.8** | Threat escalation for non-compliance |
| **1.9.3.9** | Fake negotiation for intelligence gathering |
| **1.9.3.10** | Negotiation through intermediaries |
| **1.9.3.11** | Negotiation with law enforcement |
| **1.9.3.12** | Negotiation with insurance providers |
| **1.9.3.13** | Negotiation with incident response firms |
| **1.9.3.14** | Payment processing and verification |
| **1.9.3.15** | Decryption key delivery and validation |
| **1.9.3.16** | Partial decryption for trust building |
| **1.9.3.17** | Discount negotiation for quick payment |
| **1.9.3.18** | Payment plan negotiation |
| **1.9.3.19** | Non-negotiation strategy |
| **1.9.3.20** | Negotiation failure consequences |

---

### 1.9.4 Public Pressure Campaigns

| Entry | Description |
|-------|-------------|
| **1.9.4.1** | Proof-of-leak sample release to journalists |
| **1.9.4.2** | Proof-of-leak sample release to regulators |
| **1.9.4.3** | Proof-of-leak sample release to customers |
| **1.9.4.4** | Proof-of-leak sample release to competitors |
| **1.9.4.5** | Leak site publication |
| **1.9.4.6** | Social media campaign |
| **1.9.4.7** | Dark web forum posting |
| **1.9.4.8** | Media outreach and interviews |
| **1.9.4.9** | Customer and partner notification |
| **1.9.4.10** | Employee notification |
| **1.9.4.11** | Investor notification |
| **1.9.4.12** | Regulatory notification |
| **1.9.4.13** | Law enforcement notification |
| **1.9.4.14** | Industry peer notification |
| **1.9.4.15** | Public statement and crisis management |
| **1.9.4.16** | Countdown timer publication |
| **1.9.4.17** | Data auction announcement |
| **1.9.4.18** | Customer data notification |
| **1.9.4.19** | Partner data notification |
| **1.9.4.20** | Supply chain data notification |

---

## SECTION 1.10: MONETIZATION & DATA WEAPONIZATION

*Converting stolen data into financial and strategic value*

---

### 1.10.1 Direct Data Sales

| Entry | Description |
|-------|-------------|
| **1.10.1.1** | Dark web marketplace listing |
| **1.10.1.2** | Private sale to known buyer |
| **1.10.1.3** | Auction to highest bidder |
| **1.10.1.4** | Subscription access model |
| **1.10.1.5** | API access for query-based sales |
| **1.10.1.6** | Bulk data sale to aggregators |
| **1.10.1.7** | Niche data sale to specialized buyers |
| **1.10.1.8** | Exclusive data sale to single buyer |
| **1.10.1.9** | Data escrow for future sale |
| **1.10.1.10** | Data consignment to brokers |
| **1.10.1.11** | Data licensing for research |
| **1.10.1.12** | Data donation for hacktivist causes |
| **1.10.1.13** | Data release for reputation building |
| **1.10.1.14** | Data holding for future leverage |
| **1.10.1.15** | Data destruction for payment |
| **1.10.1.16** | Data sale through intermediaries |
| **1.10.1.17** | Data sale through dead drops |
| **1.10.1.18** | Data sale through cryptocurrency |
| **1.10.1.19** | Data sale through escrow services |
| **1.10.1.20** | Data sale through established brokerages |

---

### 1.10.2 Financial Fraud

| Entry | Description |
|-------|-------------|
| **1.10.2.1** | Credit card fraud |
| **1.10.2.2** | Debit card fraud |
| **1.10.2.3** | Bank account takeover |
| **1.10.2.4** | Wire transfer fraud |
| **1.10.2.5** | Loan application fraud |
| **1.10.2.6** | Mortgage application fraud |
| **1.10.2.7** | Credit application fraud |
| **1.10.2.8** | Tax refund fraud |
| **1.10.2.9** | Insurance claim fraud |
| **1.10.2.10** | Medical billing fraud |
| **1.10.2.11** | Investment account takeover |
| **1.10.2.12** | Retirement account takeover |
| **1.10.2.13** | Cryptocurrency theft |
| **1.10.2.14** | Payment card cloning |
| **1.10.2.15** | Check fraud |
| **1.10.2.16** | Wire transfer manipulation |
| **1.10.2.17** | Invoice fraud |
| **1.10.2.18** | Payroll diversion |
| **1.10.2.19** | Vendor payment redirection |
| **1.10.2.20** | Investment fraud |

---

### 1.10.3 Identity Fraud

| Entry | Description |
|-------|-------------|
| **1.10.3.1** | Synthetic identity creation |
| **1.10.3.2** | Identity takeover |
| **1.10.3.3** | Account takeover |
| **1.10.3.4** | New account opening |
| **1.10.3.5** | Credit history manipulation |
| **1.10.3.6** | Background check manipulation |
| **1.10.3.7** | Employment application fraud |
| **1.10.3.8** | Housing application fraud |
| **1.10.3.9** | Utility account fraud |
| **1.10.3.10** | Government benefits fraud |
| **1.10.3.11** | Passport and visa fraud |
| **1.10.3.12** | Driver's license fraud |
| **1.10.3.13** | Professional license fraud |
| **1.10.3.14** | Educational credential fraud |
| **1.10.3.15** | Medical record fraud |
| **1.10.3.16** | Child identity theft |
| **1.10.3.17** | Elder identity theft |
| **1.10.3.18** | Deceased identity theft |
| **1.10.3.19** | Synthetic identity for fraud |
| **1.10.3.20** | Identity document forgery |

---

### 1.10.4 Follow-On Attacks

| Entry | Description |
|-------|-------------|
| **1.10.4.1** | Credential stuffing campaigns |
| **1.10.4.2** | Targeted phishing campaigns |
| **1.10.4.3** | Spear-phishing campaigns |
| **1.10.4.4** | Business email compromise |
| **1.10.4.5** | Vishing campaigns |
| **1.10.4.6** | Smishing campaigns |
| **1.10.4.7** | Social media impersonation |
| **1.10.4.8** | Deepfake audio/video fraud |
| **1.10.4.9** | Extortion of individuals |
| **1.10.4.10** | Sextortion campaigns |
| **1.10.4.11** | Doxxing and harassment |
| **1.10.4.12** | Swatting and physical threats |
| **1.10.4.13** | Corporate espionage |
| **1.10.4.14** | Competitive intelligence |
| **1.10.4.15** | Nation-state intelligence gathering |
| **1.10.4.16** | Supply chain attacks |
| **1.10.4.17** | Customer targeting |
| **1.10.4.18** | Partner targeting |
| **1.10.4.19** | Executive targeting |
| **1.10.4.20** | Employee targeting |

---

### 1.10.5 Strategic Data Weaponization

| Entry | Description |
|-------|-------------|
| **1.10.5.1** | Election interference |
| **1.10.5.2** | Political manipulation |
| **1.10.5.3** | Social engineering at scale |
| **1.10.5.4** | Public opinion manipulation |
| **1.10.5.5** | Market manipulation |
| **1.10.5.6** | Short-selling based on non-public data |
| **1.10.5.7** | Insider trading |
| **1.10.5.8** | M&A manipulation |
| **1.10.5.9** | Supply chain disruption |
| **1.10.5.10** | Critical infrastructure attack planning |
| **1.10.5.11** | Military intelligence gathering |
| **1.10.5.12** | Diplomatic leverage |
| **1.10.5.13** | Sanctions evasion |
| **1.10.5.14** | Regulatory capture |
| **1.10.5.15** | Long-term strategic positioning |
| **1.10.5.16** | Geopolitical influence |
| **1.10.5.17** | Economic warfare |
| **1.10.5.18** | Information warfare |
| **1.10.5.19** | Cyber espionage |
| **1.10.5.20** | Strategic deterrence |

---

## SECTION 1.11: POST-OPERATIONAL ACTIVITIES

*Aftermath management and operational closure*

---

### 1.11.1 Operational Security Cleanup

| Entry | Description |
|-------|-------------|
| **1.11.1.1** | Infrastructure decommissioning |
| **1.11.1.2** | Credential revocation |
| **1.11.1.3** | Account deletion |
| **1.11.1.4** | Log sanitization |
| **1.11.1.5** | Artifact removal |
| **1.11.1.6** | Backdoor removal |
| **1.11.1.7** | Malware uninstallation |
| **1.11.1.8** | Persistence mechanism removal |
| **1.11.1.9** | Communication channel closure |
| **1.11.1.10** | Financial trail obfuscation |
| **1.11.1.11** | Identity rotation |
| **1.11.1.12** | Infrastructure rotation |
| **1.11.1.13** | Cryptocurrency laundering |
| **1.11.1.14** | Evidence destruction |
| **1.11.1.15** | Witness elimination |
| **1.11.1.16** | Asset relocation |
| **1.11.1.17** | Jurisdiction change |
| **1.11.1.18** | Identity change |
| **1.11.1.19** | Operational security review |
| **1.11.1.20** | Lessons learned documentation |

---

### 1.11.2 Intelligence Gathering for Future Operations

| Entry | Description |
|-------|-------------|
| **1.11.2.1** | Victim security posture assessment |
| **1.11.2.2** | Victim response capability assessment |
| **1.11.2.3** | Law enforcement response assessment |
| **1.11.2.4** | Regulatory response assessment |
| **1.11.2.5** | Media response assessment |
| **1.11.2.6** | Insurance response assessment |
| **1.11.2.7** | Third-party response assessment |
| **1.11.2.8** | Industry response assessment |
| **1.11.2.9** | Government response assessment |
| **1.11.2.10** | International response assessment |
| **1.11.2.11** | Attribution assessment |
| **1.11.2.12** | Countermeasure assessment |
| **1.11.2.13** | Future target identification |
| **1.11.2.14** | Future attack vector identification |
| **1.11.2.15** | Future tool development needs |
| **1.11.2.16** | Future personnel needs |
| **1.11.2.17** | Future financial needs |
| **1.11.2.18** | Future infrastructure needs |
| **1.11.2.19** | Future operational security needs |
| **1.11.2.20** | Future strategic planning |

---

### 1.11.3 Reputation Management

| Entry | Description |
|-------|-------------|
| **1.11.3.1** | Dark web reputation building |
| **1.11.3.2** | Forum reputation building |
| **1.11.3.3** | Marketplace reputation building |
| **1.11.3.4** | Peer reputation building |
| **1.11.3.5** | Customer reputation building |
| **1.11.3.6** | Partner reputation building |
| **1.11.3.7** | Law enforcement reputation management |
| **1.11.3.8** | Intelligence agency reputation management |
| **1.11.3.9** | Media reputation management |
| **1.11.3.10** | Public reputation management |
| **1.11.3.11** | Victim reputation management |
| **1.11.3.12** | Competitor reputation management |
| **1.11.3.13** | Law enforcement cooperation |
| **1.11.3.14** | Intelligence agency cooperation |
| **1.11.3.15** | Government cooperation |
| **1.11.3.16** | Industry cooperation |
| **1.11.3.17** | Academic cooperation |
| **1.11.3.18** | Media cooperation |
| **1.11.3.19** | Public cooperation |
| **1.11.3.20** | Victim cooperation |

---

### 1.11.4 Financial Management

| Entry | Description |
|-------|-------------|
| **1.11.4.1** | Cryptocurrency mixing |
| **1.11.4.2** | Cryptocurrency tumbling |
| **1.11.4.3** | Cryptocurrency exchange |
| **1.11.4.4** | Fiat currency conversion |
| **1.11.4.5** | Money laundering |
| **1.11.4.6** | Shell company formation |
| **1.11.4.7** | Offshore banking |
| **1.11.4.8** | Real estate investment |
| **1.11.4.9** | Business investment |
| **1.11.4.10** | Stock market investment |
| **1.11.4.11** | Cryptocurrency investment |
| **1.11.4.12** | Art and collectibles investment |
| **1.11.4.13** | Luxury goods purchase |
| **1.11.4.14** | Travel and lifestyle |
| **1.11.4.15** | Family support |
| **1.11.4.16** | Operational funding |
| **1.11.4.17** | Future operation funding |
| **1.11.4.18** | Legal defense funding |
| **1.11.4.19** | Bribery and corruption |
| **1.11.4.20** | Charitable donation |

---

### 1.11.5 Personnel Management

| Entry | Description |
|-------|-------------|
| **1.11.5.1** | Recruitment |
| **1.11.5.2** | Training |
| **1.11.5.3** | Compensation |
| **1.11.5.4** | Retention |
| **1.11.5.5** | Promotion |
| **1.11.5.6** | Termination |
| **1.11.5.7** | Dispute resolution |
| **1.11.5.8** | Betrayal management |
| **1.11.5.9** | Infiltration management |
| **1.11.5.10** | Law enforcement penetration |
| **1.11.5.11** | Intelligence agency penetration |
| **1.11.5.12** | Competitor penetration |
| **1.11.5.13** | Journalist penetration |
| **1.11.5.14** | Researcher penetration |
| **1.11.5.15** | Activist penetration |
| **1.11.5.16** | Victim penetration |
| **1.11.5.17** | Partner penetration |
| **1.11.5.18** | Customer penetration |
| **1.11.5.19** | Family penetration |
| **1.11.5.20** | Self-penetration |

---

## SECTION 1.12: ADVANCED OPERATIONAL TRADECRAFT

*High-level techniques for sophisticated operations*

---

### 1.12.1 Anti-Attribution Techniques

| Entry | Description |
|-------|-------------|
| **1.12.1.1** | False flag operations |
| **1.12.1.2** | False attribution to other groups |
| **1.12.1.3** | False attribution to other nations |
| **1.12.1.4** | Language and cultural masking |
| **1.12.1.5** | Time zone manipulation |
| **1.12.1.6** | Working hours manipulation |
| **1.12.1.7** | Tool and technique mimicry |
| **1.12.1.8** | Infrastructure mimicry |
| **1.12.1.9** | Communication pattern mimicry |
| **1.12.1.10** | Financial pattern mimicry |
| **1.12.1.11** | Identity compartmentalization |
| **1.12.1.12** | Operational compartmentalization |
| **1.12.1.13** | Information compartmentalization |
| **1.12.1.14** | Disinformation campaigns |
| **1.12.1.15** | Misdirection operations |
| **1.12.1.16** | Decoy operations |
| **1.12.1.17** | Sacrificial infrastructure |
| **1.12.1.18** | Sacrificial personnel |
| **1.12.1.19** | Sacrificial operations |
| **1.12.1.20** | Long-term attribution planning |

---

### 1.12.2 Counter-Intelligence Techniques

| Entry | Description |
|-------|-------------|
| **1.12.2.1** | Law enforcement infiltration detection |
| **1.12.2.2** | Intelligence agency infiltration detection |
| **1.12.2.3** | Competitor infiltration detection |
| **1.12.2.4** | Journalist infiltration detection |
| **1.12.2.5** | Researcher infiltration detection |
| **1.12.2.6** | Activist infiltration detection |
| **1.12.2.7** | Victim infiltration detection |
| **1.12.2.8** | Partner infiltration detection |
| **1.12.2.9** | Customer infiltration detection |
| **1.12.2.10** | Family infiltration detection |
| **1.12.2.11** | Honeypot detection |
| **1.12.2.12** | Canary detection |
| **1.12.2.13** | Tripwire detection |
| **1.12.2.14** | Surveillance detection |
| **1.12.2.15** | Communication interception detection |
| **1.12.2.16** | Financial surveillance detection |
| **1.12.2.17** | Travel surveillance detection |
| **1.12.2.18** | Physical surveillance detection |
| **1.12.2.19** | Digital surveillance detection |
| **1.12.2.20** | Counter-surveillance techniques |

---

### 1.12.3 Advanced Persistence Techniques

| Entry | Description |
|-------|-------------|
| **1.12.3.1** | Supply chain implants |
| **1.12.3.2** | Hardware implants |
| **1.12.3.3** | Firmware implants |
| **1.12.3.4** | Hypervisor implants |
| **1.12.3.5** | Container implants |
| **1.12.3.6** | Cloud implants |
| **1.12.3.7** | Network device implants |
| **1.12.3.8** | IoT device implants |
| **1.12.3.9** | OT device implants |
| **1.12.3.10** | Mobile device implants |
| **1.12.3.11** | Browser extension implants |
| **1.12.3.12** | Application plugin implants |
| **1.12.3.13** | Kernel module implants |
| **1.12.3.14** | Boot sector implants |
| **1.12.3.15** | UEFI implants |
| **1.12.3.16** | Management engine implants |
| **1.12.3.17** | Baseboard management controller implants |
| **1.12.3.18** | Network interface controller implants |
| **1.12.3.19** | Storage device implants |
| **1.12.3.20** | Peripheral device implants |

---

### 1.12.4 Advanced Exfiltration Techniques

| Entry | Description |
|-------|-------------|
| **1.12.4.1** | Air-gap exfiltration via electromagnetic |
| **1.12.4.2** | Air-gap exfiltration via acoustic |
| **1.12.4.3** | Air-gap exfiltration via thermal |
| **1.12.4.4** | Air-gap exfiltration via optical |
| **1.12.4.5** | Air-gap exfiltration via power |
| **1.12.4.6** | Air-gap exfiltration via radio |
| **1.12.4.7** | Air-gap exfiltration via magnetic |
| **1.12.4.8** | Air-gap exfiltration via vibration |
| **1.12.4.9** | Air-gap exfiltration via ultrasound |
| **1.12.4.10** | Air-gap exfiltration via infrared |
| **1.12.4.11** | Covert channel exfiltration via timing |
| **1.12.4.12** | Covert channel exfiltration via storage |
| **1.12.4.13** | Covert channel exfiltration via cache |
| **1.12.4.14** | Covert channel exfiltration via memory |
| **1.12.4.15** | Covert channel exfiltration via network |
| **1.12.4.16** | Covert channel exfiltration via blockchain |
| **1.12.4.17** | Covert channel exfiltration via social media |
| **1.12.4.18** | Covert channel exfiltration via gaming |
| **1.12.4.19** | Covert channel exfiltration via IoT |
| **1.12.4.20** | Covert channel exfiltration via satellite |

---

### 1.12.5 Advanced Social Engineering

| Entry | Description |
|-------|-------------|
| **1.12.5.1** | Deepfake audio for vishing |
| **1.12.5.2** | Deepfake video for video calls |
| **1.12.5.3** | AI-generated phishing content |
| **1.12.5.4** | AI-generated social media profiles |
| **1.12.5.5** | AI-generated websites |
| **1.12.5.6** | AI-generated documents |
| **1.12.5.7** | AI-generated voice messages |
| **1.12.5.8** | AI-generated video messages |
| **1.12.5.9** | AI-generated chatbot interactions |
| **1.12.5.10** | AI-generated email conversations |
| **1.12.5.11** | Multi-channel social engineering |
| **1.12.5.12** | Long-term social engineering |
| **1.12.5.13** | Relationship-based social engineering |
| **1.12.5.14** | Authority-based social engineering |
| **1.12.5.15** | Scarcity-based social engineering |
| **1.12.5.16** | Urgency-based social engineering |
| **1.12.5.17** | Reciprocity-based social engineering |
| **1.12.5.18** | Social proof-based social engineering |
| **1.12.5.19** | Liking-based social engineering |
| **1.12.5.20** | Commitment-based social engineering |

---

## SECTION 1.13: OPERATIONAL PLANNING & EXECUTION

*Strategic and tactical planning for cyber operations*

---

### 1.13.1 Strategic Planning

| Entry | Description |
|-------|-------------|
| **1.13.1.1** | Objective definition |
| **1.13.1.2** | Target selection |
| **1.13.1.3** | Resource allocation |
| **1.13.1.4** | Timeline development |
| **1.13.1.5** | Risk assessment |
| **1.13.1.6** | Contingency planning |
| **1.13.1.7** | Success criteria definition |
| **1.13.1.8** | Failure criteria definition |
| **1.13.1.9** | Exit strategy development |
| **1.13.1.10** | Long-term strategy development |
| **1.13.1.11** | Portfolio management |
| **1.13.1.12** | Resource optimization |
| **1.13.1.13** | Capability development |
| **1.13.1.14** | Technology development |
| **1.13.1.15** | Personnel development |
| **1.13.1.16** | Partnership development |
| **1.13.1.17** | Intelligence development |
| **1.13.1.18** | Infrastructure development |
| **1.13.1.19** | Financial development |
| **1.13.1.20** | Operational security development |

---

### 1.13.2 Tactical Planning

| Entry | Description |
|-------|-------------|
| **1.13.2.1** | Attack vector selection |
| **1.13.2.2** | Tool selection |
| **1.13.2.3** | Technique selection |
| **1.13.2.4** | Procedure selection |
| **1.13.2.5** | Timing selection |
| **1.13.2.6** | Entry point selection |
| **1.13.2.7** | Exit point selection |
| **1.13.2.8** | Persistence method selection |
| **1.13.2.9** | Exfiltration method selection |
| **1.13.2.10** | Monetization method selection |
| **1.13.2.11** | Communication method selection |
| **1.13.2.12** | Infrastructure selection |
| **1.13.2.13** | Personnel selection |
| **1.13.2.14** | Resource allocation |
| **1.13.2.15** | Timeline development |
| **1.13.2.16** | Risk mitigation |
| **1.13.2.17** | Contingency development |
| **1.13.2.18** | Success metrics definition |
| **1.13.2.19** | Failure metrics definition |
| **1.13.2.20** | Exit criteria definition |

---

### 1.13.3 Execution Management

| Entry | Description |
|-------|-------------|
| **1.13.3.1** | Operation initiation |
| **1.13.3.2** | Progress monitoring |
| **1.13.3.3** | Performance measurement |
| **1.13.3.4** | Issue identification |
| **1.13.3.5** | Issue resolution |
| **1.13.3.6** | Adaptation to changing conditions |
| **1.13.3.7** | Communication management |
| **1.13.3.8** | Resource management |
| **1.13.3.9** | Timeline management |
| **1.13.3.10** | Risk management |
| **1.13.3.11** | Quality management |
| **1.13.3.12** | Stakeholder management |
| **1.13.3.13** | Documentation management |
| **1.13.3.14** | Knowledge management |
| **1.13.3.15** | Lessons learned capture |
| **1.13.3.16** | Operation closure |
| **1.13.3.17** | Post-operation review |
| **1.13.3.18** | Performance evaluation |
| **1.13.3.19** | Success evaluation |
| **1.13.3.20** | Failure evaluation |

---

## SUMMARY MATRIX

| Section | Focus | Subcategories | Total Entries |
|---------|-------|---------------|---------------|
| **1.1 Reconnaissance** | Target identification | 5 subsections | 75 entries |
| **1.2 Initial Access** | Breach execution | 5 subsections | 100 entries |
| **1.3 Persistence** | Durable presence | 4 subsections | 80 entries |
| **1.4 Privilege Escalation** | Domain dominance | 4 subsections | 80 entries |
| **1.5 Lateral Movement** | Network traversal | 4 subsections | 80 entries |
| **1.6 Data Discovery** | Target identification | 5 subsections | 100 entries |
| **1.7 Data Collection** | Staging and preparation | 4 subsections | 80 entries |
| **1.8 Exfiltration** | Data transfer | 4 subsections | 80 entries |
| **1.9 Extortion** | Ransom operations | 4 subsections | 80 entries |
| **1.10 Monetization** | Value conversion | 5 subsections | 100 entries |
| **1.11 Post-Operations** | Aftermath management | 5 subsections | 100 entries |
| **1.12 Advanced Tradecraft** | Sophisticated techniques | 5 subsections | 100 entries |
| **1.13 Planning** | Strategic and tactical | 3 subsections | 60 entries |
| **TOTAL** | | **57 subsections** | **1,115 entries** |

---

# END OF PART ONE

---

*This concludes the comprehensive expansion of the Adversarial Lifecycle. The remaining parts (Criminal Ecosystem, Societal Impact, Defensive Response, and Narrative Dimensions) would continue with similar detail.*

---

**Document Statistics:**
- **Total Sections:** 13 (expanded from 10)
- **Total Subsections:** 57
- **Total Entries:** 1,115
- **Coverage:** Complete attack lifecycle from reconnaissance to post-operational activities

**Final Note:**
This expanded framework provides comprehensive coverage of every phase of the adversarial lifecycle, with high attention to operational tradecraft at each stage. Each entry represents a potential plot point, character motivation, technical detail, or thematic exploration for cybercrime narratives.