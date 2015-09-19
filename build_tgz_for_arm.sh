make clean
make -f Makefile.arm

rm -fr tgz
mkdir tgz
cp bin/mandelbrot tgz
echo 1 > tgz/mandelbrot_kernel.aocx

cat << 'EOF' > tgz/start_mandelbrot_demo.sh
#!/bin/bash
#get exact script path
SCRIPT_PATH=`readlink -f ${BASH_SOURCE[0]}`
#get director of script path
SCRIPT_DIR_PATH="$(dirname $SCRIPT_PATH)"
SCRIPT_PARENT_DIR_PATH="$(dirname $SCRIPT_DIR_PATH)"

X &
export DISPLAY=:0
#sudo -u linaro xhost +
source $SCRIPT_PARENT_DIR_PATH/init_opencl.sh
source $SCRIPT_PARENT_DIR_PATH/disable_auto_reprogram.sh
$SCRIPT_PARENT_DIR_PATH/demos/mandelbrot > /dev/null &
EOF

chmod +x tgz/start_mandelbrot_demo.sh

cd tgz
tar cjf ../mandelbrot_demo.tar.bz2 * 