import re

SRC_TXT = "Sources:\nF00  "


class Symbol:
	def __init__(self, name: str, address: str):
		self.name = name
		self.address = address


with open("build/Listing.txt", "r") as f:
	listing = f.read()

symbols = []
symbol_text = listing.split("Symbols:")[-1]
for symbol in symbol_text.splitlines():
	if "EXPR(" in symbol and "__" not in symbol:
		symbol = re.sub(" EXPR\([-0-9]+", "", symbol)
		symbol = symbol.split(")")[0].replace("0x", "")
		name, address = symbol.split("=")
		symbols.append(Symbol(name, address))

src_index = listing.index(SRC_TXT) + len(SRC_TXT)
src_index_r = src_index + listing[src_index:].index(".asm")
source_filename = listing[src_index:src_index_r] + ".labels"
with open("build/" + source_filename, "w") as f:
	for symbol in symbols:	# type: Symbol
		f.write("al C:{} .{}\n".format(symbol.address.zfill(4), symbol.name))
