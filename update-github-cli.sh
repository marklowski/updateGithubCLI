#!/bin/bash
# Update Github Cli to Latest Version via Binary Download

# Global Variable
LATEST_VERSION=false

# install / update GithubCli
installGithubCli() {

  # Install Binary with curl
  curl -sSL https://github.com/cli/cli/releases/download/v${VERSION}/gh_${VERSION}_linux_amd64.tar.gz -o gh_${VERSION}_linux_amd64.tar.gz

  tar xvf gh_${VERSION}_linux_amd64.tar.gz

  sudo cp gh_${VERSION}_linux_amd64/bin/gh /usr/local/bin/
  
  #copy man pages
  sudo cp -r gh_${VERSION}_linux_amd64/share/man/man1/* /usr/share/man/man1/

  echo "Installation of Version: ${VERSION} finished"
}

#check version
VERSION=`curl  "https://api.github.com/repos/cli/cli/releases/latest" | grep '"tag_name"' | sed -E 's/.*"([^"]+)".*/\1/' | cut -c2-` 
echo "Try's to install GithubCLI Version: '$VERSION'"
echo ""

#get current version
echo "Currently Installed Version: "
gh version | grep "${VERSION}" && LATEST_VERSION=true
echo ""

#check if latest version is installed
if [ $LATEST_VERSION != "true" ];
then
  #wait for correct input
  while true
  do
    read -r -p "Install latest github cli Version: '${VERSION}'? [Y/n] " input
    echo ""

    case $input in
      [yY][eE][sS]|[yY])
        installGithubCli
        break
        ;;
      [nN][oO]|[nN])
        echo "Aborting Installation"
        break
        ;;
      *)
        echo "Invalid input..."
        echo ""
        ;;
    esac 
  done
else
  echo "latest Version '${VERSION}' already installed"
fi

