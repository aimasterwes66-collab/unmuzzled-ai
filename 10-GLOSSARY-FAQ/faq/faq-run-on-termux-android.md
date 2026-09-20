---
name: Can I run this on Termux/Android?
slug: faq-run-on-termux-android
version: 1.0-20260918
kind: faq
sovereign: true
tags: [faq, mobile, termux]
---

## Q

Can I run this on Termux/Android?

## A

Yes — WORM and HERM run the mesh from Termux on Android. Install `termux`, `proot-distro` (Debian rootfs if needed), `openssh`, `syncthing`, `python`, `nodejs`. Pull `~/.hermes/` and the persona library via Syncthing from ACE. Local model inference is bounded by RAM; use quantized 3B–7B models with llama.cpp for on-device work. Install Termux:Boot from F-Droid so services survive reboot — this is the highest-leverage durability fix on Android peers. Sovereign law and canonical doctrine bind identically on mobile peers.

## Related

- glossary/mesh.md
- glossary/syncthing.md
- 03-HARNESSES/
- 05-LOCAL-MODELS/
