podman build -f containerfile.base -t build_base
podman build -f containerfile.quasar -t build_quasar
podman build -f containerfile.sming -t build_sming

