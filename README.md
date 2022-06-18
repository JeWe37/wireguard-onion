# Wireguard-Onion

This repository provides a `docker-compose.yml` running three docker-Wireguard servers(you will need to port forward UDP ports 51820, 51821 and 51822).

These are used by the `onion.sh` script to configure three Wireguard interfaces, each in its own namespace, that use each other as their routes to the internet.

This is a proof of concept for client-side-only onion routing with Wireguard. For details of the original idea see [this Reddit post][https://www.reddit.com/r/WireGuard/comments/vepuft/wireguard_onion_routing/].
