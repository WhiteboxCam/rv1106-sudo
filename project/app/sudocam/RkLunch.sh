#!/bin/sh

rcS()
{
        for i in /oem/usr/etc/init.d/S??* ;do

                # Ignore dangling symlinks (if any).
                [ ! -f "$i" ] && continue

                case "$i" in
                        *.sh)
                                # Source shell script for speed.
                                (
                                        trap - INT QUIT TSTP
                                        set start
                                        . $i
                                )
                                ;;
                        *)
                                # No sh extension, so fork subprocess.
                                $i start
                                ;;
                esac
        done
}

check_linker()
{
        [ ! -L "$2" ] && ln -sf $1 $2
}
network_init() {
        ethaddr1=$(ifconfig -a | grep "eth.*HWaddr" | awk '{print $5}')

        if [ -f /data/ethaddr.txt ]; then
                ethaddr2=$(cat /data/ethaddr.txt)
                if [ $ethaddr1 == $ethaddr2 ]; then
                        echo "eth HWaddr cfg ok"
                else
                        ifconfig eth0 down
                        ifconfig eth0 hw ether $ethaddr2
                fi
        else
                echo $ethaddr1 >/data/ethaddr.txt
        fi
        ifconfig eth0 up && udhcpc -i eth0 >/dev/null 2>&1
}


post_chk()
{
        #TODO: ensure /userdata mount done
        cnt=0
        while [ $cnt -lt 30 ];
        do
                cnt=$(( cnt + 1 ))
                if mount | grep -w userdata; then
                        break
                fi
                sleep .1
        done

        # if ko exist, install ko first
        default_ko_dir=/ko
        if [ -f "/oem/usr/ko/insmod_ko.sh" ];then
                default_ko_dir=/oem/usr/ko
        fi
        if [ -f "$default_ko_dir/insmod_ko.sh" ];then
                cd $default_ko_dir && sh insmod_ko.sh && cd -
        fi

        # make busybox depmod happy
        modules_path="/lib/modules/$(uname -r)"
        if [ ! -d "/lib/modules" ]; then
                mkdir -p "/lib/modules"
        fi
        # create symlink if modules path does not exist
        if [ ! -e "$modules_path" ]; then
                ln -s "$default_ko_dir" "$modules_path"
        fi

        network_init &




        # dropbear.sh &
        chmod +x /userdata/sudocam/bin/sudocam_app
        /userdata/sudocam/bin/sudocam_app > /userdata/sudocam/last.log 2>&1 &

}

rcS

ulimit -c unlimited
echo "/data/core-%p-%e" > /proc/sys/kernel/core_pattern
# echo 0 > /sys/devices/platform/rkcif-mipi-lvds/is_use_dummybuf

echo 1 > /proc/sys/vm/overcommit_memory

post_chk &