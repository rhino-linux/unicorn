exec xfwm4 --compositor=on & wmpid=$!

sleep 5
~/.config/unicorn-conf/unicorn-start.sh

wait $wmpid
