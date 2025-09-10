# Jenkins LTS base image
FROM jenkins/jenkins:lts

USER root

# Install Python 3, pip, dev tools
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    python3 \
    python3-venv \
    python3-pip \
    python3-dev \
    build-essential \
    curl \
    wget \
    unzip \
    git \
    && rm -rf /var/lib/apt/lists/*

# Create virtual environment for Python packages
RUN python3 -m venv /opt/venv

# Upgrade pip, wheel, setuptools inside the venv
RUN /opt/venv/bin/pip install --upgrade pip wheel setuptools

# Install Robot Framework + Selenium + dependencies in the venv
RUN /opt/venv/bin/pip install --no-cache-dir \
    robotframework==7.0 \
    selenium==4.24.0 \
    robotframework-seleniumlibrary==6.3.0 \
    robotframework-pythonlibcore==4.3.0 \
    requests==2.32.3

# Add venv to PATH for convenience
ENV PATH="/opt/venv/bin:$PATH"

# Switch back to Jenkins user
USER jenkins
