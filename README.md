# Dotfiles for Raspberry-Pi <img src="https://github.com/user-attachments/assets/b4e79bbf-6e49-467d-8cd5-1a58dff61267" height="24">

This repository contains my dotfiles and configuration scripts for various machines and operating systems.

## Toolset

A common set of tools is used on this branch and all its children.

### Terminal

- <img src="https://github.com/user-attachments/assets/7c86fdc5-9a02-4c85-aadb-c343b51df1d6" height="14"> **[Git](https://github.com/git/git)**: The ubiquitous version control system.
- <img src="https://ohmyz.sh/img/ohmyzsh-logo-ansi.png" height="10"> **[Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh)**: A framework for managing and customizing Zsh.
- <img src="https://github.com/user-attachments/assets/611d18a0-797b-498a-a990-6bcdd56a0a0f" height="14"> **[Tmux](https://github.com/tmux/tmux)**: A terminal multiplexer.
- <img src="https://github.com/user-attachments/assets/ed991fd4-d15d-4403-a14a-e0469ec44038" height="14"> **[Vim](https://github.com/vim/vim)**: A configurable text editor for the terminal.
- <img src="https://github.com/user-attachments/assets/74b8cc33-f5b7-4ebb-a9ef-90077da00495" height="12"> **[Zsh (Z Shell)](https://github.com/zsh-users/zsh)**: A replacement shell for Bash.

### Databases
- <img src="https://github.com/user-attachments/assets/c28aeed8-b033-4ff4-aec2-6efa60349f22" height="14"> **[Postgresql](https://github.com/postgres/postgres)**: An advanced object-relational database management system extended of SQL.

### Languages

- <img src="https://github.com/user-attachments/assets/56f3887c-b170-486e-959b-21249778d387" height="14"> **[Node.js](https://github.com/nodejs/node)**: A JavaScript runtime environment.
- **[nvm (Node Version Manager)](https://github.com/nvm-sh/nvm)**: A version manager for Node.js.
- <img src="https://github.com/user-attachments/assets/486e6c72-a528-4d40-b9d2-ea94aa3c5aa6" height="14"> **[Ruby](https://github.com/ruby/ruby)**: A server-oriented programming language.
- **[Rbenv](https://github.com/rbenv/rbenv)**: A version manager for Ruby.

## Installation

This guide outlines the steps to set up your Raspberry Pi.

### Raspberry Pi OS Lite
#### Installation
You'll need a usable machine in order to install Rapsberry Pi OS on your Raspberry Pi

- [Download](https://www.raspberrypi.com/software/) Raspberry Pi Imager
- Insert a microSD card in your machine
- Open Raspberry Pi Imager, select your device, select Raspberry Pi OS Lite (64-bit) as the Operating System and select your microSD card then click `Next`
- Click on `Edit Settings` and configure the following settings:
  - Set username and password (`General`)
  - Configure wireless LAN (`General`)
  - Set locale settings (`General`)
  - Enable SSH -> "Use password authentication" (`Services`)
- Click `Save`
- Click `Yes` to start writting on microSD card


#### First Boot
Once the imaging process is complete, safely eject the micro SD card and insert it into your Raspberry Pi then boot your decice.
Allow the Raspberry Pi to complete its initial setup and any automatic restarts. This may take a few minutes.
Once the process is finished, you should be greeted with a login prompt in the terminal.
Enter the `username` and `password` you specified in the installation settings

#### Check locale
Raspberry Pi OS ships with `en_UK.UTF-8` as the default locale.
To change the locale to `en_US.UTF-8` first open the `/etc/local.gen` file, comment the `en_UK.UTF-8` locale and uncomment the `en_US.UTF-8` locale
```bash
sudo nano /etc/local.gen
```

This will open the `local.gen` file with the `nano` editor.
To find the `en_UK.UTF-8`
- Press `CTRL` + `w`
- Type `en_UK.UTF-8`
- Press `Enter`
- Prepend this line with a `#` to comment it.

To find the `en_US.UTF-8`
- Press `CTRL` + `w`
- Type `en_US.UTF-8`
- Press `Enter`
- Remove the `#` to uncomment the line.

Exit the editor with `CTRL`+ `x` and save the changes with `y`

Once outside the nano editor, generate the new locale with this command
```bash
sudo locale-gen
```

And reboot the device
```bash
sudo reboot
```

Once the device has rebooted, verify the changes by running this command
```bash
locale
```

You should see `en_US.UTF-8` for everything.

#### Connecting via SSH
To connect to your Raspberry Pi from another computer on the same network using SSH, open a terminal in your Raspberry Pi device and run the following command to get your local IPV4 address
```bash
hostname -I
```

On your other machine, open a terminal and run the following command
```bash
ssh <your raspberry pi username>@<your raspberry pi IPV4 address>
```

You'll be prompted to enter the Rapsberry Pi device's password and once done you'll be connected to your Raspberry Pi device.

### Command Line Tools
#### Git, Zsh and more
Open your Ubuntu terminal.
Update your package list and install the following packages
```bash
sudo apt update
```
```bash
sudo apt install -y curl git tmux unzip vim zsh
```

#### Oh-My-Zsh
In your Ubuntu terminal, install Oh-My-Zsh
```bash
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

If prompted "Do you want to change your default shell to zsh?", confirm.
Your terminal prompt should change, indicating Oh-My-Zsh is active.

#### GitHub CLI
Still in your Ubuntu terminal, install the GitHub CLI:
```zsh
sudo apt remove -y gitsome # Removes gitsome if it was installed, to prevent conflicts
```
```zsh
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
```
```zsh
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
```
```zsh
sudo apt update
```
```zsh
sudo apt install -y gh
```

Then verify the installation
```zsh
gh --version
```

This should display the installed version of the GitHub CLI.

Authenticate the GitHub CLI with your GitHub account by running
```zsh
gh auth login -s 'user:email'
```

Follow the interactive prompts
- "Where do you use Github?": **Github.com**
- "What is your preferred protocol for Git operations?":  **SSH**.
- "Generate a new SSH key to add to your GitHub account?": **Y**.
- "Enter a passphrase for your new SSH key (Optional)": Leave blank
- "Title for your SSH key". Name it whatever

*There is no browser on this device yet so how to sign in to github ?*

Verify your login status
```zsh
gh auth status
```

This should confirm you are logged in to Github with your username.

### Dotfiles
Create a directory for your code projects and clone your dotfiles repository using the branch linux-wsl.
The repository will be cloned into a folder named dotfiles:
```zsh
mkdir -p ~/code/ && cd ~/code
```
```zsh
gh repo clone wJoenn/dotfiles
```

Navigate into your cloned dotfiles directory and run the installer for WSL
```zsh
cd ~/code/dotfiles
```
```zsh
git checkout linux-raspberry-pi
```
```zsh
zsh install.sh
```

To add your credentials to git run the following commands
```zsh
git config --global user.email <enter email address here>
```
```zsh
git config --global user.name <enter full name here>
```

Finally, reset your terminal session to apply all changes:
```zsh
exec zsh
```

### Ruby
#### Rbenv
First, clean up any existing Ruby version manager installations to prevent conflicts:
```zsh
rvm implode && sudo rm -rf ~/.rvm # It's okay if this command says 'rvm: command not found'
```
```zsh
rm -rf ~/.rbenv
```

Install build dependencies for Ruby
```zsh
sudo apt install -y build-essential tklib zlib1g-dev libssl-dev libffi-dev libxml2 libxml2-dev libxslt1-dev libreadline-dev libyaml-dev
```

Clone rbenv and the ruby-build plugin:
```zsh
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
```
```zsh
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
```

Reload your shell to add rbenv to the path
```zsh
exec zsh
```

#### Ruby
Get the latest Ruby version and install it (this process can take 5-10 minutes)
```zsh
LATEST_RUBY_VERSION=$(rbenv install -l | grep -v - | tail -1)
```
```zsh
rbenv install $LATEST_RUBY_VERSION
```

Set this version as your global default
```zsh
rbenv global $LATEST_RUBY_VERSION
```

Reload your shell again and verify the Ruby version:
```zsh
exec zsh
```
```zsh
ruby -v
```

### Node.js
#### nvm
Install nvm (Node Version Manager)
```zsh
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | zsh
```

Reload your shell for nvm to be available
```zsh
exec zsh
```

Verify nvm installation
```zsh
nvm -v
```

This should output the nvm version number.

#### Node.js
Install the latest Node version
```zsh
nvm install node
```

Verify Node.js installation
```zsh
node -v
```

Clear the nvm cache:
```zsh
nvm cache clear
```

### PostgreSQL
Install PostgreSQL and its dependencies
```zsh
sudo apt install -y postgresql postgresql-contrib libpq-dev build-essential
```

Start the PostgreSQL service
```zsh
sudo /etc/init.d/postgresql start
```

Create a PostgreSQL role for your current Ubuntu user with superuser privileges
```zsh
sudo -u postgres psql --command "CREATE ROLE \"`whoami`\" LOGIN createdb superuser;"
```

Configure PostgreSQL to start automatically when you open a terminal. This involves adding a sudoers rule and an entry to your .zshrc:
```zsh
sudo echo "`whoami` ALL=NOPASSWD:/etc/init.d/postgresql start" | sudo tee /etc/sudoers.d/postgresql
```
```zsh
sudo chmod 440 /etc/sudoers.d/postgresql
```

Open a new Ubuntu terminal or run
```zsh
exec zsh
```

You should see a message indicating that the PostgreSQL service is starting like `* Starting PostgreSQL ... database server`.
