set -ex

(cd util && ./test)
(cd libkd && ./test)
(cd solver && ./test)
(cd plot && ./test)
make install INSTALL_DIR=~/an
export PYTHONPATH=${PYTHONPATH}:~/an/lib/python
export PYTHON=python3
(cd /tmp && $PYTHON -c "import astrometry.libkd.spherematch")
export PATH=${PATH}:~/an/bin
build-astrometry-index -d 3 -o index-9918.fits -P 18 -S mag -B 0.1 -s 0 -r 1 -I 9918 -M -i demo/tycho2-mag6.fits
echo -e 'add_path .\ninparallel\nindex index-9918.fits' > 99.cfg
solve-field --config 99.cfg demo/apod4.jpg  --continue
tablist demo/apod4.match
listhead demo/apod4.wcs
(cd /tmp && $PYTHON -c "import astrometry.util.util; print(dir(astrometry.util.util))")
