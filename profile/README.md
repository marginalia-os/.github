![Marginalia](assets/banner-2.png)

# Marginalia

Marginalia is an e-ink firmware and package ecosystem for reader devices.

The project starts with Xteink X3/X4 support and builds toward a small RT-Thread-style model: the base firmware stays
focused, while themes, modules, tools, and reader-native apps ship as installable packages.

Browse the live package catalog at [marginalia-hub.vercel.app](https://marginalia-hub.vercel.app).

Core repositories:

- [`marginalia-firmware`](https://github.com/marginalia-os/marginalia-firmware): firmware fork and package runtime
- [`marginalia-sdk`](https://github.com/marginalia-os/marginalia-sdk): package manifest schema, tooling, and developer SDK
- [`marginalia-registry`](https://github.com/marginalia-os/marginalia-registry): metadata-only package registry
- [`marginalia-hub`](https://github.com/marginalia-os/marginalia-hub): package discovery and publishing hub
- [`marginalia-examples`](https://github.com/marginalia-os/marginalia-examples): reference packages
- [`marginalia-simulator`](https://github.com/marginalia-os/marginalia-simulator): desktop simulator for firmware development
