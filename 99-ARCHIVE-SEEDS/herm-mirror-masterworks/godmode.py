#!/usr/bin/env python3
"""
SUNO GOD MODE 2 - Command Line Interface
Main entry point for the A.I.M.A.S. system
"""

import sys
from pathlib import Path

# Add parent to path for imports
sys.path.insert(0, str(Path(__file__).parent))

from aimas_core.engine import AIMASEngine
from aimas_core.coherence import CoherenceEngine, SunoExport
import json


def cmd_ingest(folder: str = "corpus/inbound"):
    """
    Ingest all text files from a folder
    Checklist item 42
    """
    print("🚀 SUNO GOD MODE 2 - Ingestion Mode\n")
    
    engine = AIMASEngine()
    inbound_path = Path(folder)
    
    if not inbound_path.exists():
        print(f"❌ Folder not found: {folder}")
        print(f"   Creating: {folder}")
        inbound_path.mkdir(parents=True, exist_ok=True)
        return
    
    # Find all .txt files
    txt_files = list(inbound_path.glob("*.txt"))
    
    if not txt_files:
        print(f"📂 No .txt files found in {folder}")
        print("   Drop your messy transcript files here and run again")
        return
    
    print(f"📂 Found {len(txt_files)} files to process:\n")
    
    for txt_file in txt_files:
        print(f"   • {txt_file.name}")
        content = txt_file.read_text(encoding='utf-8', errors='ignore')
        engine.ingest_dump(content, source_tag=txt_file.stem)
    
    # Save results
    print("\n💾 Saving corpus...")
    engine.save()
    engine.export_markdown()
    
    # Show stats
    print("\n📊 Final Stats:")
    stats = engine.get_stats()
    for key, value in sorted(stats.items()):
        print(f"   {key}: {value}")
    
    print(f"\n✅ Ingestion complete! Total items: {engine.get_total_count()}")


def cmd_generate(persona: str = None, output_dir: str = "exports"):
    """
    Generate a Suno prompt
    Checklist item 43
    """
    print("🎵 SUNO GOD MODE 2 - Generation Mode\n")
    
    engine = AIMASEngine()
    coherence = CoherenceEngine()
    output_path = Path(output_dir)
    output_path.mkdir(parents=True, exist_ok=True)
    
    # Load persona if specified
    if persona:
        print(f"🎭 Loading persona: {persona}")
        preset = coherence.load_persona_preset(persona.lower().replace(" ", "_"))
        
        if not preset:
            print(f"❌ Persona '{persona}' not found")
            print("   Available: dark_cyberpunk, baroque_trap, indie_folk")
            return
        
        description_tags = preset.get("description", [])
        required_meta = preset.get("required_tags", [])
        
        # Build lyrics template
        lyrics = "\n\n".join([f"{tag}\nYour lyrics here" for tag in required_meta])
        
        print(f"✓ Loaded preset with {len(description_tags)} description tags")
    else:
        # Random generation
        print("🎲 Generating random prompt...")
        export = coherence.generate_random_prompt(engine)
        description_tags = export.description.split(", ")
        lyrics = export.lyrics
    
    # Create export
    export = coherence.create_export(description_tags, lyrics)
    
    # Show warnings
    if export.warnings:
        print("\n⚠️  Coherence Warnings:")
        for warning in export.warnings:
            print(f"   [{warning.severity.upper()}] {warning.conflict}")
            print(f"   → {warning.suggestion}")
    
    # Save files
    desc_file = output_path / "description.txt"
    lyrics_file = output_path / "lyrics.md"
    
    desc_file.write_text(export.description)
    lyrics_file.write_text(export.lyrics)
    
    print(f"\n📄 Files created:")
    print(f"   • {desc_file}")
    print(f"   • {lyrics_file}")
    
    print("\n📋 Ready to paste into Suno:")
    print("─" * 60)
    print("DESCRIPTION (paste into 'Style of Music'):")
    print(export.description)
    print("\nLYRICS (paste into 'Lyrics'):")
    print(export.lyrics[:200] + "..." if len(export.lyrics) > 200 else export.lyrics)
    print("─" * 60)
    
    print("\n✅ Generation complete!")


def cmd_check(file_path: str):
    """
    Check a project file for coherence
    Checklist item 44
    """
    print("🔍 SUNO GOD MODE 2 - Coherence Check\n")
    
    file_path = Path(file_path)
    
    if not file_path.exists():
        print(f"❌ File not found: {file_path}")
        return
    
    # Load project (assumes JSON with description + lyrics)
    try:
        with open(file_path, 'r') as f:
            project = json.load(f)
    except json.JSONDecodeError:
        print("❌ Invalid JSON file")
        return
    
    description = project.get("description", "")
    lyrics = project.get("lyrics", "")
    
    if not description or not lyrics:
        print("❌ Project must contain 'description' and 'lyrics' fields")
        return
    
    # Parse description tags
    description_tags = [tag.strip() for tag in description.split(",")]
    
    # Run coherence check
    coherence = CoherenceEngine()
    export = coherence.create_export(description_tags, lyrics)
    
    print(f"✓ Project: {file_path.name}")
    print(f"  Description: {len(description_tags)} tags")
    print(f"  Lyrics: {len(lyrics.split())} words\n")
    
    # Validate newline doctrine
    if not coherence.validate_newline_doctrine(lyrics):
        print("❌ CRITICAL: Newline Doctrine violated!")
        print("   Found [metatag] with content on same line")
        print("   Fix: Each [tag] must be on its own line\n")
    else:
        print("✅ Newline Doctrine: PASSED\n")
    
    # Show warnings
    if export.warnings:
        print("⚠️  Coherence Issues:")
        for warning in export.warnings:
            severity_icon = "🔴" if warning.severity == "high" else "🟡"
            print(f"\n{severity_icon} [{warning.severity.upper()}] {warning.type}")
            print(f"   Conflict: {warning.conflict}")
            print(f"   Suggestion: {warning.suggestion}")
    else:
        print("✅ No coherence issues detected!")
    
    print("\n✅ Check complete!")


def show_help():
    """Show usage information"""
    help_text = """
╔═══════════════════════════════════════════════════════════════╗
║              SUNO GOD MODE 2 - Command Line                   ║
║                  Powered by A.I.M.A.S.                        ║
╚═══════════════════════════════════════════════════════════════╝

USAGE:
  python godmode.py <command> [options]

COMMANDS:
  ingest [folder]          Process text dumps into corpus
                          Default: corpus/inbound/

  generate [persona]       Generate Suno prompt
                          Personas: dark_cyberpunk, baroque_trap, indie_folk

  check <file>            Check project for coherence
                          Example: check myproject.json

  help                    Show this help

EXAMPLES:
  python godmode.py ingest
  python godmode.py generate baroque_trap
  python godmode.py check projects/track01.json

QUICKSTART:
  1. Drop your messy text files in corpus/inbound/
  2. Run: python godmode.py ingest
  3. Run: python godmode.py generate baroque_trap
  4. Copy the output to Suno.com
  5. Make amazing music! 🎵

For full documentation, see README.md
"""
    print(help_text)


def main():
    """Main CLI entry point"""
    args = sys.argv[1:]
    
    if not args or args[0] == "help":
        show_help()
        return
    
    command = args[0]
    
    if command == "ingest":
        folder = args[1] if len(args) > 1 else "corpus/inbound"
        cmd_ingest(folder)
    
    elif command == "generate" or command == "gen":
        persona = args[1] if len(args) > 1 else None
        cmd_generate(persona)
    
    elif command == "check":
        if len(args) < 2:
            print("❌ Usage: python godmode.py check <file>")
            return
        cmd_check(args[1])
    
    else:
        print(f"❌ Unknown command: {command}")
        print("Run 'python godmode.py help' for usage")


if __name__ == "__main__":
    main()
