Shell script for fetching galleries from rajce.idnes.cz

Dependencies: `coreutils`, `curl`, `wget`

```
Usage:
  Single gallery: ./rajce-downloader.sh <gallery_url> [folder_name]
  Batch mode:     ./rajce-downloader.sh -f <file>
```

When running in batch mode, the program reads URLs from an external file, which should be a plain text file containing one full URL per line.
