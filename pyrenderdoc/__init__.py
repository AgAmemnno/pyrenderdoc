import sys
dynload = ""
for p in sys.path:
    if p.endswith("lib-dynload"):
        dynload = p
        break
print(dynload)
