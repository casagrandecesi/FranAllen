from pathlib import Path
import os

MB100 = 100 * 1024 * 1024

print("Files bigger than 100M:\n")
files = list(Path(".").rglob("*"))
for file in files:
    stats = os.stat(file)
    if stats.st_size > MB100:
        print(f"{file} {stats.st_size // 1024 // 1024} MiB")
