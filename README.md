# Gregory Williams Gentoo Overlay
This is my Gentoo overlay with ebuilds that either are not in the official repository, or some of my own software I maintain.

## Installation
### Using Portage
Create a file under `/etc/portage/repos.conf/greg-overlay.conf` with this text:

	[greg-overlay]
	auto-sync = yes
	location = /var/db/repos/greg-overlay
	sync-type = git
	sync-uri = https://github.com/GregWills97/greg-overlay.git

### Eselect Repository
If you haven't install this tool with:

	emerge -av app-eselect/eselect-repository

Then to add this overlay run:

	eselect-repository add greg-overlay git https://github.com/GregWills97/greg-overlay.git

### Layman
First if you haven't, install layman using:

	USE="git sync-plugin-portage" emerge -av layman

Then install the repository with:

	layman -o https://raw.github.com/GregWills97/greg-overlay/main/repositories.xml -f -a greg-overlay

## Configuration
To use packages from my overlay that are contained in the official repo, add the package atom to a file in `/etc/portage/package.mask`. For example to use my version of dmenu, in file named `/etc/portage/package.mask/greg-overlay` add the dmenu atom name from the official repo:

	x11-wm/dmenu::gentoo
