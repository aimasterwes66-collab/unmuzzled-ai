---
name: Mobile and Edge Uncensored Inference
slug: mobile-edge-inference
version: 2026-10-15
kind: local-model
harness: llamacpp
provider: local
modality: text
sovereign: true
tags: [mobile, edge, termux, android, llamacpp, mlc, webllm, on-device]
requires: [community-hubs, faq-run-on-termux-android]
---

# Mobile and Edge Uncensored Inference

Running uncensored models on the 9185W tablet (Termux, aarch64, Android 13)
and other edge targets. Fills GAP-08: the framework runs ON Termux but had
no operational edge-inference doc beyond one FAQ answer.

## 1. What works on Termux Android (verified-class)

| Tool | Status | Notes |
|---|---|---|
| llama.cpp | WORKS (native build) | cmake + make; use `-DGGML_NATIVE=OFF`; ARM NEON ok, no AVX |
| ollama | NOT native on Termux | Android is not a supported build target; needs proot-distro ubuntu + lots of RAM |
| MLC-LLM (mlc_chat) | WORKS | pip install --break-system-packages; or the Android APK from mlc.ai |
| llama.rn | n/a here | React Native; targets app embedding, not CLI |
| WebLLM (Chrome WebGPU) | WORKS | tablet Chrome + WebGPU; loads GGUF from HF into browser; decent for 1-3B |
| koboldcpp | PARTIAL | C++ single binary; can compile on aarch64 with effort; no official android build |

Termux pitfalls that apply (from AGENTS.md): /tmp is unwritable (use ~),
pip needs --break-system-packages (PEP 668), no systemd, Android may kill
background processes (termux-wake-lock + the android-process-kill-hardening
playbook).

## 2. Native llama.cpp build on 9185W

```
pkg install cmake ninja git clang
git clone https://github.com/ggml-org/llama.cpp && cd llama.cpp
cmake -B build -DGGML_NATIVE=OFF -DLLAMA_CURL=ON
cmake --build build --config Release -j4
# binary: build/bin/llama-cli
```

- Use GGUF quantized files from the community hubs roster
  (`05-LOCAL-MODELS/community-hubs.md`): Q4_K_M is the tablet sweet spot.
- 8GB-class tablets: 3B-8B models run; 14B+ = swap death. Heavy compute
  goes to the S22 or dirt-iMac (operator standing order).

## 3. MLC-LLM

```
pip install --break-system-packages mlc-ai-nightly mlc-chat-nightly
mlc_llm convert_weight <hf-model> --quantization q4f16_1 -o dist/
mlc_llm gen_config dist/<model> --quantization q4f16_1 \
  --conv-template llama-3 -o dist/<model>/
mlc_llm compile dist/<model>/mlc-chat-config.json \
  --device android -o dist/<model>/lib.so
mlc_llm chat dist/<model>/
```

APK path: download the prebuilt MLCChat APK from
https://llm.mlc.ai/docs/install/mlc_llm.html, sideload on the tablet, drop
the compiled model lib + weights into app-private storage via adb.

## 4. Edge targets beyond the tablet

- S22 (Herm): same Termux recipe, better thermals.
- Old iMac (Ace): SSE3-only; llama.cpp builds with plain cmake; no AVX.
- Cloud box: GPU inference tier for anything above 8B.
- Browser demos: WebLLM for quick uncensored chat demos without installing
  anything.

## 5. Mesh fit

- WORM = edge proof + canary target + prompt compiler testbed.
- Mobile runs are for verification and small sovereign sessions; batch
  abliteration/steering-vector training stays on GPU peers.
- Cross-refs: `10-GLOSSARY-FAQ/faq/faq-run-on-termux-android.md`,
  `05-LOCAL-MODELS/runtimes/llamacpp.md`,
  `05-LOCAL-MODELS/runtimes/ollama.md`.

## Deep reference

Comprehensive single-file layer for this topic: see UNMODERATED-MODELS.md (models layer) + UNMODERATED-HARNESSES.md (wiring layer).
