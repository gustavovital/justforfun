import re

with open("D:\\Just for Fun\\Python\\ref.bib") as f:
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

# Code with input for the user
bibfile = input("Select your .bib file")

with open(bibfile) as f:
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

