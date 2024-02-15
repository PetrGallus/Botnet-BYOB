#!/bin/sh
echo "WARNING: This script will install docker AND add it as an apt source."
echo ""
echo "If you do not want this, please press ctrl + C to cancel the script."
echo ""
echo "The script will start in 10 seconds."

sleep 10

echo "Running BYOB app setup..."

# Install Python3.10 if necessary
which python3.10 > /dev/null
status=$?

if test $status -ne 0
then
	echo "Installing Python 3.10..."
	apt-get install python3.10 -y

    # sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev libgdbm-dev libnss3-dev libedit-dev libc6-dev
    # wget https://www.python.org/ftp/python/3.6.15/Python-3.6.15.tgz
    # tar -xzf Python-3.6.15.tgz
    # cd Python-3.6.15
    # ./configure --enable-optimizations  -with-lto  --with-pydebug
    # make -j 8
    # sudo make altinstall

else
	echo "Confirmed Python is installed."
	
	# Installs Pip even if a Python installation is found because some users don't install pip
	
	# sudo apt install python3-pip

fi

# Install Docker if necessary
which docker > /dev/null
status=$?

if test $status -ne 0
then
	echo "Installing Docker..."
    

    # Add Docker's official GPG key:
    sudo apt-get update
    sudo apt-get install ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    # Add the repository to Apt sources:
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update

    
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

	# chmod +x get-docker.sh
	# ./get-docker.sh
	# sudo usermod -aG docker $USER
	# sudo chmod 666 /var/run/docker.sock
	
else
	echo "Confirmed Docker is installed."
	echo "If you run into issues generating a Windows payload, please uninstall docker and rerun this script"
fi

# Install Python packages
echo "Installing Python packages..."
python3.10 -m pip install CMake==3.18.4
python3.10 -m pip install -r requirements.txt

# Build Docker images
echo "Building Docker images - this will take a while, please be patient..."
cd docker-pyinstaller
docker build -f Dockerfile-py3-amd64 -t nix-amd64 .
docker build -f Dockerfile-py3-i386 -t nix-i386 .
docker build -f Dockerfile-py3-win32 -t win-x32 .

read -p "To use some Byob features, you must reboot your system. If this is not your first time running this script, please answer no. Reboot now? [Y/n]: " agreeTo
#Reboots system if user answers Yes
case $agreeTo in
    y|Y|yes|Yes|YES)
    echo "Rebooting..."
    sleep 1
    sudo reboot now
    exit
    ;;
#Runs app if user answers No
    n|N|no|No|NO)
    cd ..
    echo "Running C2 server with locally hosted web app GUI...";
    echo "Navigate to http://127.0.0.1:5000 and set up your user to get started.";
    python3.10 run.py
    exit
    ;;
esac
