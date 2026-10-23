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
