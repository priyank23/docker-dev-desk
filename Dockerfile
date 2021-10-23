FROM ubuntu

# OS specific commands
RUN apt-get update -y

# Basic tools
RUN apt-get install curl -y
RUN apt-get install stow -y
RUN apt-get install tree -y

# Git
RUN apt-get install git -y
RUN git config --global user.email "287mdsahil@gmail.com"
RUN git config --global user.name "Md Sahil"

# Shell prompt customization
RUN curl -fsSL https://starship.rs/install.sh | bash -s -- -y
RUN echo 'eval "$(starship init bash)"' >> /root/.bashrc

# Install neovim
RUN apt-get install neovim -y


# Setup dotfiles using stow
WORKDIR /root
RUN git clone https://github.com/287mdsahil/dotfiles.git
WORKDIR /root/dotfiles
RUN git checkout stow_integ
RUN stow neovim


# Final command
WORKDIR /root
CMD /bin/bash
