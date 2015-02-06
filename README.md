# AwesomeWM Config Files #
This is a simple collection of AwesomeWM RC files I use for my desktop
environment. I'm generally working inside Emacs and web browsers, with
occasional use of gimp.

## Awesome Versions & OS ##
This configuration is used on both Debian Jesse/Sid and Ubuntu 14.4
(LTS).

  - Ubuntu 14.4: 3.4.15-1ubuntu1

## Terminal ##
The `terminal` is configured to `urxvtc`, which may not work out for
you. I use the following wrapper script to start the `urxvtd` instance
if it is not currently running:

	#!/bin/sh
	/usr/bin/urxvtc "$@"
	if [ $? -eq 2 ]; then
		/usr/bin/urxvtd -q -o -f
		/usr/bin/urxvtc "$@"
	fi

## Widgets ##
The only widget I've customized is the Volume Widget `volume.rc`. The
XF86AudioRaiseVolume, XF86AudioLowerVolume, and XF86AudioMute buttons
are tied to `amixer` and the `pulse` driver. The widget displays next
to the date widget with a red 'M' when muted. When unmuted, the volume
percentage is displayed in white with a colored background from blue
for quiet to red for loud.

 - Reference: https://awesome.naquadah.org/wiki/Volume_control_and_display
