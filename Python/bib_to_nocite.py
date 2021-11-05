# Autor: gustavovital
# Data:27/10/2021
#
# Arquivo .bib para \nocite{}

import re

# with open("D:\\Just for Fun\\Python\\refs.bib", encoding="utf8") as f:
#     lines = f.readlines()
#
# entries = []
# for entry, name in enumerate(lines):
#     if "@" in name:
#         entries.append(name)
#
# for name in range(len(entries)):
#
#     entries[name] = re.sub(r'^.*?{', '', entries[name])
#     entries[name] = entries[name].split(",", 1)[0]
#
# nocite = ',\n'.join(entries)
# print("\\nocite{" + nocite + "}")

# Code with input for the user
bibfile = input("Select your .bib file")

with open(bibfile, encoding="utf8") as f:
    lines = f.readlines()

entries = []
for entry, name in enumerate(lines):
    if "@" in name:
        entries.append(name)
    
for name in range(len(entries)):

    entries[name] = re.sub(r'^.*?{', '', entries[name])
    entries[name] = entries[name].split(",", 1)[0]

nocite = ',\n'.join(entries)
print("\\nocite{" + nocite + "}")