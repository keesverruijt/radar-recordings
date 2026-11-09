# radar-recordings

To replay under Linux:

```
gunzip -k navico/halo_and_0183.pcap.gz
tcpreplay -q -T select -l 0 -i lo navico/halo_and_0183.pcap
```

The corresponding command line for the [Mayara](https://github.com/keesverruijt/mayara) radar server to receive that would be

```
mayara -i lo --replay
```

## navico/halo/halo20plus-722*

A HALO20+ under way off Fiji, 2026-10-20 21:46–21:59 UTC, recorded by Stig
Dreyer for mayara-server issue #722 on the radar network and the NMEA 2000
bus on the same clock. Mayara's ARPA regression test replays it.

- `halo20plus-722.pcap.gz`: both halves of the posted capture, merged. The
  capture has no beacon, so a HALO beacon naming this radar (192.168.88.229,
  serial 130026820) is injected every 10 s, starting just before the first
  packet.
- `halo20plus-722-own-ship.csv`: own-ship position, COG and SOG from the
  NMEA 2000 bus (PGNs 129025/129029/129026).
- `halo20plus-722-ais.csv`: every AIS report in the window except own ship's
  (PGNs 129038/129039), re-timed to the second of each fix.

## furuno/moin/drs4dnxt-anchor-approaching*

A DRS4D-NXT (firmware 01.05) at anchor behind a reef off Fiji, 2026-10-29
19:35:19–19:55:44 UTC, while two catamarans motor in and anchor nearby,
both with AIS. Recorded on the Raspberry Pi that runs mayara, for
mayara-server issue #839. Mayara's ARPA regression test replays it.

- `drs4dnxt-anchor-approaching.pcap.gz`: everything to and from the radar
  (172.31.3.212), the NavNet broadcasts and the spoke multicast; 0 packets
  dropped. Range A at 1.5 NM with Target Analyzer on Target throughout,
  range B in standby. It starts with a mayara restart, so the beacon
  exchange is in it.
- `drs4dnxt-anchor-approaching-own-ship.csv`: own-ship position, COG and
  SOG from Signal K, once a second, 19:35:19–19:55:59 UTC. Signal K
  restarted during the capture, so it has no rows from 19:53:51 to
  19:54:58.
- `drs4dnxt-anchor-approaching-ais.csv`: every AIS report Signal K received
  except own ship's, timed when Signal K received it. It opens with the
  last report Signal K held for each vessel when the capture started (61
  rows, the oldest from 18:04:09), then runs to 19:55:53 UTC. Across the
  restart it has no rows from 19:53:45 to 19:54:35. The two boats are
  WILD THING 2 (MMSI 228071090) and OHANA II (347019890).

## furuno/moin/drs4dnxt-anchor-guard-zone*

The same DRS4D-NXT at the same anchorage, 2026-10-29 17:42:43–17:45:35 UTC,
with a guard zone all round, for mayara-server issues #848 and #849. No AIS
vessel within 6 km moved faster than 1 kn. Recorded on the Raspberry Pi
that runs mayara.

- `drs4dnxt-anchor-guard-zone.pcap.gz`: everything to and from the radar,
  the NavNet broadcasts and the spoke multicast; 0 packets dropped. Range A
  at 1.5 NM with Target Analyzer off, ARPA Max Speed Medium, Doppler Auto
  Track on and guard zone 1 all round from 300 to 2,500 m; range B in
  standby. It starts with a mayara restart, so the beacon exchange is in
  it, and ends at 17:45:35, a second before Target Analyzer went back on.
- `drs4dnxt-anchor-guard-zone-own-ship.csv`: own-ship position, COG and
  SOG from Signal K, once a second, 17:42:45–17:46:30 UTC.
- `drs4dnxt-anchor-guard-zone-ais.csv`: every AIS report Signal K held
  except own ship's, timed by the report's position timestamp, so it opens
  with reports from before the capture. KIAPA NUI (MMSI 367589460) lies
  141 m off and MMSI 368383510 383 m off; both report every three minutes.
