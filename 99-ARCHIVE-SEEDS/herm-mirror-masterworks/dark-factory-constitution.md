# dark-factory-constitution

**Category:** sovereign-infrastructure
**Source:** ~/vault/herm/30_projects/dark-factory/CONSTITUTION.md
**Atomicized:** 2026-06-10

## TL;DR
The immutable operating constitution for the recursive ingestion engine. Fabric AI (stateless text processing pipes) + OpenClaw/Hermes (stateful orchestration) fused into a self-compounding knowledge factory. Constants: z=10 (recursion depth), cl=10 (concurrency), ha=10 (heuristic aggression), sp=10 (sampling precision).

## Summary
- 4 constitutional articles covering sovereignty, research objectives, recursive scaling, and data sovereignty
- 10x4 Control Matrix: operational constants that bound the entire system
- Fabric patterns: map_collaborator_network, extract_technical_frameworks, evaluate_heuristic_relevance
- 4-phase ingestion lifecycle: target acquisition → metadata rip → batch processing → fabric handoff → recursive trigger
- Dark network mapping through audio transcript entities (catches what API scrapers miss)
- Dead branch detection (3 consecutive low scores = purge)
- Temporal delta-sync every 7 days for high-value channels
- Directly maps to RSI ontology D11 (Observatory) and the recursive-ingest skill

## Code / Snippet
```bash
# One-video pipeline
URL="https://youtube.com/watch?v=VIDEO_ID"
yt-dlp --write-auto-sub --skip-download -o "raw/%(id)s" "$URL"
cat "raw/$ID.en.vtt" | fabric -p extract_wisdom > "obsidian/$ID.md"
cat "raw/$ID.en.vtt" | fabric -p map_collaborator_network > "network/$ID.json"
cat "raw/$ID.en.vtt" | head -c 10% | fabric -p evaluate_heuristic_relevance
```

## On Wes's S22
- Constitution: ~/vault/herm/30_projects/dark-factory/CONSTITUTION.md (5.7KB)
- Fabric needed: `go install github.com/danielmiessler/fabric@latest`
- yt-dlp: pre-installed
- Worth-it call: **yes** — the recursive ingestion engine blueprint

## Related
- [[rsi-ontology-framework]]
- [[rsi-creative-toolkit]]
- [[recursive-ingest]]
- [[yt-dlp]]
- [[fabric]]
- [[pgvector]]
- [[obsidian]]
- [[sox]]

## Source
[source: ~/vault/herm/30_projects/dark-factory/CONSTITUTION.md]
[source: session 2026-06-10, Dark Factory constitution v1.0]
