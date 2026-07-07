#
# Rocky Linux 10 (aarch64 / Apple Silicon, Parallels)
#
# Build with:
#   packer build -var-file=rocky10.pkrvars.hcl .
#
# iso_url tracks the "latest" Rocky 10 DVD, and iso_checksum reads the published
# CHECKSUM file, so this keeps working across Rocky 10 point releases.

os_name    = "rocky"
os_version = "10"
arch       = "aarch64"
kickstart  = "el10/ks.cfg"

iso_url      = "https://download.rockylinux.org/pub/rocky/10/isos/aarch64/Rocky-10-latest-aarch64-dvd.iso"
iso_checksum = "file:https://download.rockylinux.org/pub/rocky/10/isos/aarch64/CHECKSUM"

parallels_tools_flavor = "lin-arm"
