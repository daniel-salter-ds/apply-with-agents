#!/usr/bin/env python3
"""Report vertical fill per page for a built AltaCV resume.pdf.

Parses pdftex content streams and tracks cumulative Td text positions.
Geometry assumes resume.latex margins (1.25 cm top/bottom on A4).
"""

from __future__ import annotations

import re
import sys
import zlib
from pathlib import Path

PAGE_HEIGHT_PT = 841.89
MARGIN_CM = 1.25
MARGIN_PT = MARGIN_CM / 2.54 * 72
USABLE_HEIGHT_PT = PAGE_HEIGHT_PT - 2 * MARGIN_PT


def parse_baselines(stream: bytes) -> list[float]:
    text = stream.decode("latin1", errors="replace")
    baselines: list[float] = []
    cur_x = 0.0
    cur_y = 0.0
    for match in re.finditer(r"BT|ET|([-\d.]+)\s+([-\d.]+)\s+Td|T[Jj]", text):
        token = match.group(0)
        if token == "BT":
            cur_x = 0.0
            cur_y = 0.0
        elif "Td" in token:
            tx = float(match.group(1))
            ty = float(match.group(2))
            cur_x += tx
            cur_y += ty
            baselines.append(cur_y)
        elif token in ("Tj", "TJ"):
            baselines.append(cur_y)
    return baselines


def page_streams(pdf_bytes: bytes) -> list[list[float]]:
    streams: list[tuple[int, list[float]]] = []
    for match in re.finditer(
        br"stream\r?\n(.*?)\r?\nendstream", pdf_bytes, re.S
    ):
        raw = match.group(1)
        try:
            decoded = zlib.decompress(raw)
        except zlib.error:
            continue
        text_ops = decoded.count(b"TJ") + decoded.count(b"Tj")
        if text_ops < 5:
            continue
        baselines = parse_baselines(decoded)
        if baselines:
            streams.append((text_ops, baselines))
    streams.sort(key=lambda item: -item[0])
    return [baselines for _, baselines in streams]


def fill_stats(baselines: list[float]) -> dict[str, float]:
    low = min(baselines)
    high = max(baselines)
    empty_bottom = max(0.0, low - MARGIN_PT)
    empty_top = max(0.0, (PAGE_HEIGHT_PT - MARGIN_PT) - high)
    span = high - low
    return {
        "low": low,
        "high": high,
        "empty_bottom_pct": empty_bottom / USABLE_HEIGHT_PT * 100,
        "empty_top_pct": empty_top / USABLE_HEIGHT_PT * 100,
        "filled_pct": span / USABLE_HEIGHT_PT * 100,
    }


def main() -> int:
    if len(sys.argv) != 2:
        print(f"Usage: {sys.argv[0]} <role-directory>", file=sys.stderr)
        return 1

    role_dir = Path(sys.argv[1])
    pdf_path = role_dir / "resume.pdf"
    if not pdf_path.is_file():
        print(f"Missing {pdf_path} — build first.", file=sys.stderr)
        return 1

    pdf_bytes = pdf_path.read_bytes()
    pages = page_streams(pdf_bytes)
    if not pages:
        print("No text content streams found.", file=sys.stderr)
        return 1

    print(f"{pdf_path} — {len(pages)} page(s) of text\n")
    for index, baselines in enumerate(pages, start=1):
        stats = fill_stats(baselines)
        print(
            f"Page {index}: "
            f"filled {stats['filled_pct']:.0f}%  "
            f"(top gap {stats['empty_top_pct']:.0f}%, "
            f"bottom gap {stats['empty_bottom_pct']:.0f}%)"
        )

    last = fill_stats(pages[-1])
    if last["empty_bottom_pct"] > 5:
        print(
            f"\nNote: final page bottom gap ~{last['empty_bottom_pct']:.0f}% "
            f"(target ≤ 5%) — add JD-relevant bullets from master.md in small increments."
        )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
