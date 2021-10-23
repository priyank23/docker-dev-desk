FROM ubuntu

# OS specific commands
RUN apt-get update -y
RUN apt-get install curl -y

# Shell prompt customization
RUN curl -fsSL https://starship.rs/install.sh | bash -s -- -y
RUN echo 'eval "$(starship init bash)"' >> /root/.bashrc

# Install neovim
RUN apt-get install neovim -y


# Final command
CMD /bin/bash
