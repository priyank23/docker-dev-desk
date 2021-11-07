FROM ubuntu

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update -y

# Basic tools
RUN apt-get install curl -y
RUN apt-get install stow -y
RUN apt-get install tree -y
RUN apt-get install wget -y
RUN apt-get install curl -y
RUN apt-get install unzip -y
RUN apt-get install software-properties-common -y

# Git
RUN apt-get install git -y
RUN git config --global user.email "287mdsahil@gmail.com"
RUN git config --global user.name "Md Sahil"

# Shell prompt customization
RUN curl -fsSL https://starship.rs/install.sh | bash -s -- -y
RUN echo 'eval "$(starship init bash)"' >> /root/.bashrc

# Install lang tools
RUN apt-get install python3 -y
RUN apt-get install python3-venv -y
RUN apt-get install npm -y

# Add local bin folder
WORKDIR /root
RUN mkdir -p .local/bin
RUN echo 'PATH="/root/.local/bin:$PATH"' >> /root/.bashrc

# Directory to install programs
RUN mkdir /root/programs

# Install terminal emulators
RUN apt-get install xterm -y
RUN apt-get install kitty -y

# Install neovim
RUN apt-get install vim -y
WORKDIR /root/programs
RUN wget https://github.com/neovim/neovim/releases/download/v0.5.1/nvim.appimage
RUN chmod u+x nvim.appimage
RUN ./nvim.appimage --appimage-extract
RUN rm nvim.appimage
RUN mv squashfs-root neovim
RUN ln -s /root/programs/neovim/usr/bin/nvim /root/.local/bin
RUN apt-get install xsel -y
RUN apt-get install fzf -y
RUN apt-get install ripgrep -y

# Install fonts
RUN apt-get install fontconfig -y
RUN  mkdir /root/.local/share/fonts -p
WORKDIR /root/.local/share/fonts
RUN wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip
RUN unzip Hack.zip
RUN rm Hack.zip
RUN fc-cache

# Setup dotfiles using stow
WORKDIR /root
RUN git clone https://github.com/287mdsahil/dotfiles.git
WORKDIR /root/dotfiles
RUN git checkout stow_integ
RUN stow neovim
RUN stow kitty

# Flutter related--------------------------------------------------------------
# Install flutter
WORKDIR /root/programs
RUN git clone https://github.com/flutter/flutter.git -b stable
RUN echo 'PATH="$PATH:/root/programs/flutter/bin"' >> /root/.bashrc
RUN /root/programs/flutter/bin/flutter precache

# Install chrome
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN apt install ./google-chrome-stable_current_amd64.deb -y

# Install java
RUN apt-get install openjdk-11-jdk -y

# Install android studio
RUN add-apt-repository ppa:maarten-fonville/android-studio -y
RUN apt-get update -y
RUN apt-get install android-studio -y
RUN echo 'PATH="$PATH:/opt/android-studio/bin/"' >> /root/.bashrc

RUN apt-get install clang cmake ninja-build pkg-config libgtk-3-dev -y
RUN /root/programs/flutter/bin/flutter config --enable-linux-desktop
RUN echo 'export _JAVA_AWT_WM_NONREPARENTING=1' >> /root/.bashrc
RUN apt-get install libpulse0 -y
#------------------------------------------------------------------------------

# Final command
WORKDIR /root
CMD /usr/bin/kitty
