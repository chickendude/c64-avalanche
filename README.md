# Avalanche

A port of an old
[TI-83 game](https://www.ticalc.org/archives/files/fileinfo/24/2417.html)
to the Commodore 64.

## Build

To build Avalanche, you can run the `assemble.sh` bash script. It assumes you
have the following installed/in your PATH:
- vasm6502_oldstyle assembler: i just grabbed the source from the
[vasm website](http://sun.hasenbraten.de/vasm/). You can build it with
`make CPU=6502 SYNTAX=oldstyle`.
- [c64debugger](https://sourceforge.net/projects/c64-debugger/): the `labels.py`
script under the the `tools/` folder will build labels from the Listing.txt file
and send that to the debugger if it's open.
- [VICE](https://vice-emu.sourceforge.io/): i couldn't figure out how to send
and run the .prg file to c64debugger, so the script also sends the file to VICE.

## Background

I'd never used the/a Commodore 64 before this and used it as an introduction
into 6502 assembly as the basic platform was easier to start with than my target
platform (the NES). Coming from the z80, the 6502 was at times really amazing
and at others really frustrating (really missing the z80's call z/c/m), but
overall it's a really fun platform and i'd love to hear about any
suggestions/optimizations.
