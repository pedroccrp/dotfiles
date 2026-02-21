#!/usr/bin/env python3

import os
import sys


def titleize(text: str) -> str:
    return " ".join(word.capitalize() for word in text.split())


def main() -> int:
    paths = [line.strip() for line in sys.stdin if line.strip()]
    for path in paths:
        folder = os.path.basename(os.path.dirname(path))
        name = os.path.splitext(os.path.basename(path))[0]
        name = name.replace("-", " ").replace("_", " ")
        label = f"{titleize(name)} ({titleize(folder)})"
        print(label)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
