# fmask-docker

Fmask 5 docker.

## Dependencies

- Docker

## Installation

1. Run

    from the root of this repository download [Fmask 5.0.1 package](https://uconn-my.sharepoint.com/:u:/g/personal/shi_qiu_uconn_edu/EeW6nd-YLFdLtP33BCM9A5YBahNJdBU4M7wXoI07mjJSzA?e=u92kry).
    Than, build the image:
   ```bash
   $ docker build -t bdc/fmask:5.0.1 .
   ```

## Usage

To process a Sentinel-2 scene (e.g. `S2A_MSIL1C_20250104T125311_N0511_R052_T24MYT_20250104T143016.SAFE`) run

```bash
$ docker run --rm \
    -v /path/to/input/:/mnt/input:rw \
    -v /path/to/output:/mnt/output:rw \
    bdc/fmask:5.0.1 \
    --imagepath /mnt/input/path/to/S2A_MSIL1C_20250104T125311_N0511_R052_T24MYT_20250104T143016.SAFE \
    --output /mnt/output \
    --model UPL \
    --dcloud 0
```
Results are written on the input .SAFE if --output is not informed.

## Acknowledgements

Copyright from Fmask 5 code are held by [GERSL](https://github.com/GERSL/Fmask).
