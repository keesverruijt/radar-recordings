# Furuno DRS4W ("1st Watch" WiFi radar)

Captures of a Furuno **DRS4W** wireless radome, contributed by `marcelrv` in
[mayara-server issue #48](https://github.com/MarineYachtRadar/mayara-server/issues/48).

| File | What it is |
|---|---|
| `drs4w-1.pcap.gz` | Short capture taken **on the Pi** (mayara ↔ radar traffic only) |
| `radar3.pcap.gz`, `radar4.pcap.gz` | Longer transmit captures; `radar4` sweeps the range all the way out and back in |
| `radar6.pcap.gz` | Captured from the **iOS/TZ app**: standby→transmit, range zoom, gain sweep |

Replay (see the repo root README):

```
gunzip -k furuno/drs4w/radar4.pcap.gz
tcpreplay -q -T select -l 0 -i lo furuno/drs4w/radar4.pcap
```

## Network

The DRS4W broadcasts (it is its own WiFi AP; client on `172.31.3.x`):

| Dst | Port | Contents |
|---|---|---|
| `172.31.255.255` | 10024 | Echo spokes (variable length, RLE-compressed) |
| `172.31.255.255` | 10500 | 16-byte keep-alive (all zero in these captures) |
| `172.31.255.255` | 10010 | Device-id announce from the app, ASCII `RD003017` |

(`239.2.1.1:2053` JSON in some files is unrelated SignalK traffic on the same LAN.)

## Echo spoke header (`:10024`)

Offsets into the UDP payload, little-endian:

```
off  bytes        meaning
 0   02           packet type (constant)
 1   nn           spoke counter (increments per spoke)
 2   00 01        constant
 4   00 00 00 00  constant
 8   nn           azimuth-ish (varies as the antenna rotates)
 9   10           constant
10   ae 79        constant magic
12   nn           >>> RANGE INDEX <<<  (0..13)
13   00
14   f0 nn        constant-ish
16.. ...          a few more header bytes, then echo samples (~byte 21+)
```

### Range = index, not metres

Byte **[12]** is the range **index**. Across these captures it spans **0–12**
(`radar4` shows a clean zoom-out/in: `0 1 2 3 4 5 6 7 8 7 6 5 4 3 2 1`).
The radar never transmits a distance in metres — the index→metre mapping is a
client-side table (14 ranges, 1/8 NM … 24 NM), the same approach the MFD
firmware uses internally.

### Echo samples: 6-bit, 252-level, bottom-heavy

After the header the spoke carries RLE-compressed samples. Each real sample is
a byte that is a **multiple of 4** — a **6-bit intensity (level 0–63) shifted
left by 2**, so the on-screen value runs `0x00 … 0xfc` (0 … **252**): the
"252-level palette". Bytes that are *not* multiples of 4 (`0xfe`, `0x05`, …) are
compression control tokens, not samples.

The intensity distribution is strongly **bottom-heavy**: ~97–98 % of samples
fall in the lowest quarter of the scale, and of the non-zero returns ~62–66 %
sit in the bottom eighth. A display therefore needs an aggressive gamma curve
(an ~18th-root) to spread the low echoes into visible levels.
