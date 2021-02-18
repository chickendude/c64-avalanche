clear
mkdir -p build
vasm6502_oldstyle "main.asm" -cbm-prg -chklabels -nocase -L "build/Listing.txt" -Fbin -o "main.prg"
python tools/labels.py
c64debugger -symbols build/main.labels -pass
x64sc main.prg > /dev/null
