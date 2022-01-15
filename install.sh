#!/bin/bash

ReleaseID=$(lsb_release -i | awk '{print $3}')
VersionID=$(lsb_release -r | awk '{print $2}')
Supported=false

[[ "${ReleaseID}" == "Ubuntu" && "${VersionID}" =~ "18.04" ]] && Supported=true
[[ "${ReleaseID}" == "Ubuntu" && "${VersionID}" =~ "20.04" ]] && Supported=true

[[ "${ReleaseID}" == "Ubuntu" && "${VersionID}" =~ "21.10" ]] && Supported=true

[[ "${ReleaseID}" == "Debian" && "${VersionID}" == "10"    ]] && Supported=true
[[ "${ReleaseID}" == "Debian" && "${VersionID}" == "11"    ]] && Supported=true

[[ "${Supported}" == "false" ]] && echo "This distribution version is not supported. Aborting" && exit

git_install () {
    echo "Checking if git is installed..."
    if command -v curl > /dev/null; then
    echo "Detected git..."
    echo ""
  else
    echo "Installing git..."
    sudo apt install -q -y git
    if [ "$?" -ne "0" ]; then
      echo "Unable to install git! Please check your problem and then try again"
      echo "Installation aborted."
      exit
    fi
  fi
}

python_install () {
    echo "Checking if python3 is installed..."
    if command -v python3 > /dev/null; then
    echo "Detected python3..."
    echo ""
  else
    echo "Installing python3..."
    sudo apt install -q -y python3
    if [ "$?" -ne "0" ]; then
      echo "Unable to install python3! Please check your problem and then try again"
      echo "Installation aborted."
      exit
    fi
  fi
}

pip3_install () {
    echo "Checking if pip3 is installed..."
    if command -v pip3 > /dev/null; then
    echo "Detected pip3..."
    echo ""
  else
    echo "Installing pip3..."
    sudo apt install -q -y python3-pip
    if [ "$?" -ne "0" ]; then
      echo "Unable to install pip3! Please check your problem and then try again"
      echo "Installation aborted."
      exit
    fi
  fi
}

flask_install () {
    echo "Checking if pip is installed for installing flask..."
    if command -v pip3 > /dev/null; then
    echo "Detected pip..."
    echo ""
  else
    echo "Installing flask..."
    pip3 install flask pillow psutil
    if [ "$?" -ne "0" ]; then
      echo "Unable to install flask! Please check your problem and then try again"
      echo "Installation aborted."
      exit
    fi
  fi
}



secure_cloud_install () {
    cd ~
   if [ ! -d "~/SecureCloud" ]; then
       echo "SecureCloud Direcory already exists. Aborting."
       echo ""
    else
    git clone https://github.com/Strawberry-Software-Industries/SecureCloud
   fi

    cd SecureCloud
}



main () {
    git_install
    python_install
    pip3_install
    flask_install
    secure_cloud_install
    echo "################################################################################################"
    echo "SecureCloud was installed."
    echo "Please change your IP-Adress in the main.py File."
    echo "For Help visit https://github.com/Strawberry-Software-Industries/SecureCloud/blob/main/README.md"
}

main