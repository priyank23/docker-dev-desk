FROM ubuntu

# OS specific commands
RUN apt-get update -y

# Basic tools
RUN apt-get install curl -y
RUN apt-get install stow -y
RUN apt-get install tree -y
RUN apt-get install wget -y
RUN apt-get install curl -y

# Git
RUN apt-get install git -y
RUN git config --global user.email "287mdsahil@gmail.com"
RUN git config --global user.name "Md Sahil"

# Shell prompt customization
RUN curl -fsSL https://starship.rs/install.sh | bash -s -- -y
RUN echo 'eval "$(starship init bash)"' >> /root/.bashrc

# Add local bin folder
WORKDIR /root
RUN mkdir bin
RUN echo 'PATH="/root/bin:$PATH"' >> /root/.bashrc

# Install neovim
RUN mkdir /root/programs
WORKDIR /root/programs
RUN wget https://github.com/neovim/neovim/releases/download/v0.5.1/nvim.appimage
RUN chmod u+x nvim.appimage
RUN ./nvim.appimage --appimage-extract
RUN rm nvim.appimage
RUN mv squashfs-root neovim
RUN ln -s /root/programs/neovim/usr/bin/nvim /root/bin


# Setup dotfiles using stow
WORKDIR /root
RUN git clone https://github.com/287mdsahil/dotfiles.git
WORKDIR /root/dotfiles
RUN git checkout stow_integ
RUN stow neovim


# Final command
WORKDIR /root
CMD /bin/bash
