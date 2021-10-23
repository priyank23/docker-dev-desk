FROM ubuntu
RUN apt-get update -y
RUN apt-get install vim -y
RUN apt-get install curl -y
RUN curl -fsSL https://starship.rs/install.sh | bash -s -- -y
RUN echo 'eval "$(starship init bash)"' >> /root/.bashrc
CMD /bin/bash
