packer {
  required_plugins {
    parallels = {
      version = ">= 1.0.3"
      source  = "github.com/hashicorp/parallels"
    }
  }
}

locals {
  build_directory = "${path.root}/../builds"
  http_directory  = "${path.root}/http"
  name            = "${var.os_name}${var.os_version}_${var.arch}"
}

source "parallels-iso" "elx" {
  boot_command = [
    "<up>",
    "e",
    "<down><down><end><wait>",
    "inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/${var.kickstart}",
    "<enter><wait><leftCtrlOn>x<leftCtrlOff>"
  ]
  boot_wait              = "5s"
  http_directory         = local.http_directory
  guest_os_type          = "rhel"
  iso_url                = var.iso_url
  iso_checksum           = var.iso_checksum
  parallels_tools_flavor = var.parallels_tools_flavor
  output_directory       = "${local.build_directory}/${local.name}"
  vm_name                = local.name
  shutdown_command       = "echo '${var.ssh_password}' | sudo -S shutdown -P now"
  ssh_password           = var.ssh_password
  ssh_username           = var.ssh_username
  ssh_timeout            = "900s"
}

build {
  sources = ["source.parallels-iso.elx"]

  provisioner "shell" {
    environment_vars = [
      "HOME_DIR=/root",
      "IMAGE_NAME='${local.name}'",
      "BUILD_ID='${local.name}'",
      "DOCUMENTATION_URL='${var.documentation_url}'",
    ]
    # Packer connects as an unprivileged build user; run each script as root.
    # {{ .Vars }} sets the environment_vars inline so they reach the script.
    execute_command   = "sudo sh -euxc '{{ .Vars }} {{ .Path }}'"
    expect_disconnect = true
    remote_folder     = "/tmp"
    scripts = [
      "${path.root}/scripts/motd.sh",
      "${path.root}/scripts/issue.sh",
      "${path.root}/scripts/metadata.sh",
      "${path.root}/scripts/networking.sh",
      "${path.root}/scripts/sshd.sh",
      "${path.root}/scripts/configure_vim.sh",
      "${path.root}/scripts/install_fzf.sh",
      "${path.root}/scripts/install_nnn.sh",
      "${path.root}/scripts/configure_zsh.sh",
      "${path.root}/scripts/configure_tmux.sh",
      "${path.root}/scripts/install_bat.sh",
      "${path.root}/scripts/install_croc.sh",
      "${path.root}/scripts/install_fd.sh",
      "${path.root}/scripts/install_lnav.sh",
      "${path.root}/scripts/install_rg.sh",
      "${path.root}/scripts/install_htop.sh",
      "${path.root}/scripts/install_z.sh",
      "${path.root}/scripts/cleanup.sh",
      "${path.root}/scripts/minimize.sh",
    ]
  }

}
