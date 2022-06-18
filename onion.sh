#!/bin/bash
set -o xtrace
ip netns add layer_outer
ip netns add layer_middle
ip netns add layer_inner

ip link add wg0 type wireguard
ip link set wg0 netns layer_outer
ip -n layer_outer link add wg1 type wireguard
ip -n layer_outer link set wg1 netns layer_middle
ip -n layer_middle link add wg2 type wireguard
ip -n layer_middle link set wg2 netns layer_inner

ip -n layer_outer addr add 10.10.1.2 dev wg0
ip -n layer_middle addr add 10.10.2.2 dev wg1
ip -n layer_inner addr add 10.10.3.2 dev wg2

ip netns exec layer_outer wg setconf wg0 ./confs1/peer1/peer1.conf
ip netns exec layer_middle wg setconf wg1 ./confs2/peer1/peer1.conf
ip netns exec layer_inner wg setconf wg2 ./confs3/peer1/peer1.conf

ip -n layer_outer link set wg0 up
ip -n layer_outer route add default dev wg0
ip -n layer_middle link set wg1 up
ip -n layer_middle route add default dev wg1
ip -n layer_inner link set wg2 up
ip -n layer_inner route add default dev wg2

echo waiting...
read
ip netns del layer_inner
ip netns del layer_middle
ip netns del layer_outer
