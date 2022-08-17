# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi


# Put your fun stuff here.
alias team='sudo systemctl start teamviewerd.service'
alias matrix='mplayer -vo caca'
alias clout='neofetch; echo The operating system that saved Europe.'
alias trim='sudo emerge --ask --depclean ; echo You removed the bloat but did you remove the curse?'
alias lol='sudo mount /var/tmp/portage && sudo emerge --sync && sudo layman -S && cd /var/lib/librewolf  && sudo /usr/bin/git pull && cd ~/ &&  sudo emerge --ask --verbose --update --deep --changed-use @world && sudo umount /var/tmp/portage &&  echo You are a diamond baby, and you are unbreakable.'
alias rip='youtube-dl --extract-audio --audio-format mp3'
alias wan='sudo emerge --ask --verbose'
alias bedo='sudo emerge --autounmask-write'
alias no='sudo emerge --deselect' 
alias sup='sudo rofi -show drun'
alias haha='sudo dispatch-conf'
alias 1temp='mount -t tmpfs tmpfs /var/tmp'
alias pre=' sudo mount /var/tmp/portage'
alias post='sudo umount /var/tmp/portage'
alias key='sudo nano /etc/portage/package.accept_keywords'
alias use='sudo nano /etc/portage/package.use'
alias main='sudo nano /etc/portage/make.conf'
alias kern='sudo genkernel --menuconfig --makeopts=-j17  all && sudo  grub-mkconfig -o /boot/grub/grub.cfg'
alias regrub='sudo  grub-mkconfig -o /boot/grub/grub.cfg'
alias new='pre && sudo emerge -avDN @world && post'
alias wtf='pre && sudo  emerge --update --autounmask-write  --newuse --deep --with-bdeps=y @world && post && echo wtf was that tho'
alias ref='cat .bashrc'
alias piler='sudo nano /etc/portage/package.env'
alias hot='nano ~/.config/sxhkd/sxhkdrc'
alias bashrc='nano ~/.bashrc'
alias ps3='git clone https://github.com/RPCS3/rpcs3.git &&  cd rpcs3 &&  git submodule update --init && cd .. && mkdir rpcs3_build && cd rpcs3_build &&  cmake ../rpcs3/ && make COMMON_FLAGS="-O2 -pipe" CFLAGS="-O2 -march=znver3  -pipe" jobs=-j17 && sudo make install'

# end Alias
# Path info
PATH=$HOME/.local/bin:$PATH
