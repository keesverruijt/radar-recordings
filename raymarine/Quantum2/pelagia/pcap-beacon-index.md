# Pelagia Pcap Beacon Index

## Network Topology

| IP | Device |
|----|--------|
| 198.18.0.158 | Quantum2 radar |
| 198.18.3.182 | Axiom MFD |
| 10.22.7.3 | Second device (mirrors MFD beacons) |
| 192.168.232.1 | Axiom Plus 12 MFD (different network, no radar) |

## Files With Radar Identification Beacons (subtype 0x66)

| File | Beacon pkts | Radar ID | Notes |
|------|------------|----------|-------|
| pelagia-all-controls.pcap | 27342 | 2310 | Best file, longest capture, all controls exercised |
| raymarine1.pcap | 1982 | 154 | Good general capture |
| pelagia-radar-try-on-with-radar-on.pcap | 1849 | 78 | Radar power on sequence |
| pelagia-boot.pcap | 1729 | 106 | MFD boot sequence |
| pelagia-radar-off-then-on.pcap | 1528 | 82 | Radar power cycle |
| pelagia-reboot-radar.pcap | 1443 | 44 | Radar reboot |
| pelagia-boot-radar.pcap | 1278 | 28 | Radar boot |
| pelagia1.pcap | 1225 | 24 | Short capture |
| raymarine2.pcap | 338 | 26 | Short capture |

## Files Without Radar Beacons

| File | Beacon pkts | Reason |
|------|------------|--------|
| pelagia-radar-try-on-with-radar-off.pcap | 197 | Radar is physically off, MFD-only |
| pelagia-axiom-plus-12-1.pcapng | 425 | Different MFD (192.168.232.1), no radar on network |
| pelagia-axiom-plus-12-2.pcapng | 260 | Same — different MFD, no radar |

## Beacon Types Observed (from pelagia-all-controls.pcap)

### From radar (198.18.0.158)

| Size | Subtype | Count | Description |
|------|---------|-------|-------------|
| 70 | 0x66 | 1155 | Radar extended info ("QuantumRadar") |
| 70 | 0x4d | 1155 | W3 extended info ("Quantum_W3") |
| 56 | 0x66 | 1155 | Radar standard info |
| 56 | 0x4d | 1155 | W3 standard info |

### From MFD (198.18.3.182)

| Size | Subtype | Count | Description |
|------|---------|-------|-------------|
| 36 | type=0 | 2298 | MFD address beacon |
| 28 | type=0 | 2297 | MFD short address beacon |
| 40 | type=0 | 1148 | MFD medium address beacon |
| 70 | 0x8b | 976 | MFD extended info |
| 56 | 0x11 | 976 | MFD standard info |
| **126** | 0x8b | 172 | **MFD large extended info** (new size!) |

### From second device (10.22.7.3)

Same as MFD but with different counts — mirrors beacon traffic.

## Key Observations

- Radar always sends beacons in pairs: 56-byte + 70-byte, for both radar (0x66) and W3 (0x4d)
- MFD sends 5 different beacon sizes: 28, 36, 40, 56, 70, and 126 bytes
- The 126-byte beacon (subtype 0x8b) is a previously undocumented MFD-only extended format
- Link ID for radar: starts with `b468` prefix
- Link ID for MFD: `842e40dd`
- The "radar off" capture confirms: when radar is powered off, no 0x66/0x4d beacons appear
