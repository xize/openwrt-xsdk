#!/bin/sh

readip=$(uci get network.lan.ipaddr)

if [ "$readip" -eq "192.168.1.1" ]; then
    # we assume we did a reset or have default configuration from /rom.
    # lets configurate router with basic needs.

    # set wan pppoe
    uci set network.wan.proto='pppoe'
    uci set network.wan.username='00-00-00-00-00@internet'
    uci set network.wan.password='ppp'
    uci set network.wan.classlessroute='0'
    uci set network.wan.mtu='1500'
    uci set network.wan.peerdns='0'

    # add wireless dsa devices to br-lan.
    uci add_list network.@device[0].list_ports='phy0-ap0' 'phy1-ap0' 'vx0'
    uci del network.@device[0].vlan_filtering # ensure this is deleted, when deleted filtering is enabled to 1.

    # change lan
    uci set network.lan.ipaddr='10.234.53.1'
    uci set network.lan.device='br-lan.169'

    # add lan default vlan.
    uci add network bridge-vlan
    uci set network.@bridge-vlan[-1].device='br-lan'
    uci add_list network.@bridge-vlan[-1].ports='lan1:u*' 'lan2:u*' 'lan3:u*' 'lan4:u*' 'lan5:u*'
    uci set network.@bridge-vlan[-1].vlan='169'

    # add pcnet vlan.
    uci set network.pcnet='interface'
    uci set network.pcnet.proto='static'
    uci set network.pcnet.device='br-lan.49'
    uci set network.pcnet.ipaddr='10.34.79.1'
    uci set network.pcnet.netmask='255.255.255.0'
    uci set network.pcnet.defaultroute='0'
    uci set network.pcnet.delegate='0'

    # add pcnet vlan to bridge br-lan
    uci add network bridge-vlan
    uci set network.@bridge-vlan[-1].device='br-lan'
    uci add_list network.@bridge-vlan[-1].ports='lan1:t' 'lan2:t' 'lan3:t' 'lan4:t' 'lan5:t'
    uci set network.@bridge-vlan[-1].vlan='49'

    # generate dhcp for pcnet
    uci set dhcp.pcnet='dhcp'
    uci set dhcp.pcnet.start='2'
    uci set dhcp.pcnet.limit='150'
    uci set dhcp.pcnet.leasetime='12h'

    # generate firewall zone for pcnet
    uci add firewall zone
    uci set firewall.@zone[-1].name='pcnet'
    uci set firewall.@zone[-1].input='ACCEPT'
    uci set firewall.@zone[-1].output='ACCEPT'
    uci set firewall.@zone[-1].forward='REJECT'
    uci add_list firewall.@zone[-1].network='pcnet'

    # forward to wan by default
    uci add firewall forwarding
    uci set firewall.@forwarding[-1].src='pcnet'
    uci set firewall.@forwarding[-1].dest='wan'

    # create basic needs for vx0
    uci set network.vx0=interface
    uci set network.vx0.disabled='1'
    uci set network.vx0.proto='vxlan'
    uci set network.vx0.peeraddr='10.6.7.2'
    uci set network.vx0.tunlink='wgserver'
    uci set network.vx0.defaultroute='0'
    uci set nettwork.vx0.delegate='0'
    uci set network.vx0.vid='4921'
    uci set network.vx0.ipaddr='10.6.7.1'
    uci set network.vx0.rxcsum='0'
    uci set network.vx0.txcsum='0'

    uci commit network
    uci commit firewall
    uci commit dhcp

    reboot
fi

exit 0
