FROM archlinux:latest

# Environment to skip yay's interactive prompts
ENV YAY_USE_NOCONFIRM=1

# Update system and install core tools
RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm sudo git base-devel \
    p7zip npm nodejs rust cargo imagemagick icoutils

# Add user 'claude' with sudo privileges
RUN useradd -m -G wheel -s /bin/bash claude && \
    echo '%wheel ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

# Switch to user 'claude'
USER claude
WORKDIR /home/claude

# Install yay (AUR helper)
RUN git clone https://aur.archlinux.org/yay.git && \
    cd yay && \
    makepkg -si --noconfirm && \
    cd .. && rm -rf yay

# Clone and build claude-desktop-native from AUR
RUN git clone https://github.com/jkoelker/claude-desktop-native.git && \
    cd claude-desktop-native && \
    makepkg -si --noconfirm

# Default command
CMD ["/usr/bin/claude-desktop-native", "--no-sandbox"]