#
# Input variables for the elx image build.
#
# Defaults target the most recent Rocky Linux release (aarch64, Parallels).
# Override any of these on the command line (-var 'name=value') or, more
# conveniently, with a var-file (-var-file=rocky10.pkrvars.hcl).
#

variable "os_name" {
  type        = string
  default     = "rocky"
  description = "Short OS identifier used in the image/VM name, e.g. 'rocky'."
}

variable "os_version" {
  type        = string
  default     = "10"
  description = "Enterprise Linux major version used in the image/VM name, e.g. '10' or '9'."
}

variable "arch" {
  type        = string
  default     = "aarch64"
  description = "Target architecture. One of 'aarch64' or 'x86_64'."
}

variable "iso_url" {
  type        = string
  default     = "https://download.rockylinux.org/pub/rocky/10/isos/aarch64/Rocky-10-latest-aarch64-dvd.iso"
  description = <<-EOT
    URL (https:// or file:) of the installation ISO. The default tracks the
    current Rocky Linux 10 DVD for aarch64. The DVD image is used (rather than
    minimal) so the Kickstart 'cdrom' install source has AppStream available.
  EOT
}

variable "iso_checksum" {
  type        = string
  default     = "file:https://download.rockylinux.org/pub/rocky/10/isos/aarch64/CHECKSUM"
  description = <<-EOT
    ISO checksum. Using 'file:<url-to-CHECKSUM>' lets Packer read the published
    checksum file and match it to the ISO filename automatically, so this keeps
    working across Rocky point releases without editing a hard-coded hash.
  EOT
}

variable "kickstart" {
  type        = string
  default     = "el10/ks.cfg"
  description = "Kickstart file to serve, relative to the http/ directory (e.g. 'el10/ks.cfg' or 'el9/ks.cfg')."
}

variable "ssh_username" {
  type        = string
  default     = "ansible"
  description = "User Packer connects as over SSH. Must exist in the Kickstart file with passwordless sudo."
}

variable "ssh_password" {
  type        = string
  default     = "ansible"
  description = "Password for the SSH build user (matches the Kickstart file)."
}

variable "parallels_tools_flavor" {
  type        = string
  default     = "lin-arm"
  description = "Parallels Tools flavor: 'lin-arm' for aarch64, 'lin' for x86_64."
}

variable "documentation_url" {
  type        = string
  default     = "https://github.com/kriipke/elx-linux-image"
  description = "Written into /etc/os-release as DOCUMENTATION_URL."
}
