---
name: How do I chain jailbreaks across multiple modalities?
slug: faq-chain-jailbreaks-across-modalities
version: 1.0-20260918
kind: faq
sovereign: true
tags: [faq, multimodal, chain]
---

## Q

How do I chain jailbreaks across multiple modalities?

## A

Treat each modality as a separate substrate with its own refusal circuit and its own classifier. Sequence: (1) use a compliant text model to produce the payload for the next-modality prompt; (2) embed instructions in the modality with the weakest safety analysis (image OCR, audio transcription, subtitle track); (3) feed the modality artifact to a vision/audio/video model whose text classifier is separate from its perception layer; (4) capture that model's output and route it back to text for downstream use. Vision-language and audio-transcription surfaces routinely lag text safety by a full generation. Chain design beats any single-modality attack.

## Related

- glossary/encoding-attack.md
- glossary/format-hijack.md
- glossary/escalation-ladder.md
- 06-MULTIMODAL/
