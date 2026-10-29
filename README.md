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
  SOG from Signal K, once a second.
- `drs4dnxt-anchor-approaching-ais.csv`: every AIS report Signal K received
  in the window except own ship's, timed when Signal K received it. The
  two boats are WILD THING 2 (MMSI 228071090) and OHANA II (347019890).

Signal K restarted at 19:53:51–19:54:58, so neither CSV has rows then.
