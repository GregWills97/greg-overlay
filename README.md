# Gregory Williams Gentoo Overlay
This is my Gentoo overlay with ebuilds that either are not in the official repository, or some of my own software that I maintain.

## Installation
### Using Portage
Create a file named `/etc/portage/repos.conf/greg-overlay.conf` with this text:

	[greg-overlay]
	auto-sync = yes
	location = /var/db/repos/greg-overlay
	sync-type = git
	sync-uri = https://github.com/GregWills97/greg-overlay.git

### Eselect Repository
If you haven't installed the eselect repository tool, emerge it with this command:

	root # emerge -av app-eselect/eselect-repository

Then to add this overlay run:

	root # eselect repository add greg-overlay git https://github.com/GregWills97/greg-overlay.git

### Layman
First if you haven't, install layman with this command:

	root # USE="git sync-plugin-portage" emerge -av layman

Then install the repository with:

	root # layman -o https://raw.github.com/GregWills97/greg-overlay/main/repositories.xml -f -a greg-overlay

## Configuration
To use packages from my overlay that are contained in the official repo, add the package atom to a file in `/etc/portage/package.mask`. For example:

	root # echo "x11-misc/dmenu::gentoo" >> /etc/portage/package.mask/greg-overlay
	root # echo "x11-wm/dwm::gentoo" >> /etc/portage/package.mask/greg-overlay
