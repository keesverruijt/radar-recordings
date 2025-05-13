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
