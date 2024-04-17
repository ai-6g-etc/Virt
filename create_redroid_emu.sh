apt install linux-modules-extra-`uname -r`
modprobe binder_linux devices="binder,hwbinder,vndbinder"
modprobe ashmem_linux
docker run -itd --rm --privileged \
    --pull always \
    -v ~/data:/data \
    -p 5555:5555 \
    redroid/redroid:11.0.0-latest
### Explanation:
###   --pull always    -- use latest image
###   -v ~/data:/data  -- mount data partition
###   -p 5555:5555     -- expose adb port


## install adb https://developer.android.com/studio#downloads
apt install adb
adb connect localhost:5555
### NOTE: change localhost to IP if running redroid remotely

## view redroid screen
## install scrcpy https://github.com/Genymobile/scrcpy/blob/master/README.md#get-the-app
snap install scrcpy
scrcpy -s localhost:5555
### NOTE: change localhost to IP if running redroid remotely
###     typically running scrcpy on your local PC
#docker run -itd --rm --privileged \
#    --pull always \
#    -v ~/data:/data \
#    -p 5555:5555 \
#    redroid/redroid:11.0.0-latest \
#    androidboot.redroid_width=1080 \
#    androidboot.redroid_height=1920 \
#    androidboot.redroid_dpi=480 \

#curl -fsSL https://raw.githubusercontent.com/remote-android/redroid-doc/master/debug.sh | sudo bash -s -- [CONTAINER]



