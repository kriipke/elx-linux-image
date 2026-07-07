#
# Rocky Linux 9 (aarch64 / Apple Silicon, Parallels)
#
# Build with:
#   packer build -var-file=rocky9.pkrvars.hcl .
#
# iso_url tracks the "latest" Rocky 9 DVD, and iso_checksum reads the published
# CHECKSUM file, so this keeps working across Rocky 9 point releases.

os_name      = "rocky"
os_version   = "9"
arch         = "aarch64"
kickstart    = "el9/ks.cfg"

iso_url      = "https://download.rockylinux.org/pub/rocky/9/isos/aarch64/Rocky-9-latest-aarch64-dvd.iso"
iso_checksum = "file:https://download.rockylinux.org/pub/rocky/9/isos/aarch64/CHECKSUM"

parallels_tools_flavor = "lin-arm"
