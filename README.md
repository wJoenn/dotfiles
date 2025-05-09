# Dotfiles for WSL <img src="https://github.com/user-attachments/assets/a578df6f-3618-4976-b7e3-601959613176" height="24">

This repository contains my dotfiles and configuration scripts for various machines and operating systems.

## Toolset

A common set of tools is used on this branch and all its children.

### Terminal

- <img src="https://github.com/user-attachments/assets/7c86fdc5-9a02-4c85-aadb-c343b51df1d6" height="14"> **[Git](https://github.com/git/git)**: The ubiquitous version control system.
- <img src="https://ohmyz.sh/img/ohmyzsh-logo-ansi.png" height="10"> **[Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh)**: A framework for managing and customizing Zsh.
- <img src="https://github.com/user-attachments/assets/ed991fd4-d15d-4403-a14a-e0469ec44038" height="14"> **[Vim](https://github.com/vim/vim)**: A configurable text editor for the terminal.
- <img src="https://github.com/user-attachments/assets/74b8cc33-f5b7-4ebb-a9ef-90077da00495" height="12"> **[Zsh (Z Shell)](https://github.com/zsh-users/zsh)**: A replacement shell for Bash.

### Databases
- <img src="https://github.com/user-attachments/assets/c28aeed8-b033-4ff4-aec2-6efa60349f22" height="14"> **[Postgresql](https://github.com/postgres/postgres)**: An advanced object-relational database management system extended of SQL.

### Languages

- <img src="https://github.com/user-attachments/assets/56f3887c-b170-486e-959b-21249778d387" height="14"> **[Node.js](https://github.com/nodejs/node)**: A JavaScript runtime environment.
- **[nvm (Node Version Manager)](https://github.com/nvm-sh/nvm)**: A version manager for Node.js.
- <img src="https://github.com/user-attachments/assets/486e6c72-a528-4d40-b9d2-ea94aa3c5aa6" height="14"> **[Ruby](https://github.com/ruby/ruby)**: A server-oriented programming language.
- **[Rbenv](https://github.com/rbenv/rbenv)**: A version manager for Ruby.

### Softwares

- <img src="https://github.com/user-attachments/assets/7062eb19-1997-4c92-9679-4ea71b5e3181" height="14"> **[VSCode](https://github.com/microsoft/vscode)**: A feature-rich source code editor.


## Installation

This guide outlines the steps to set up your Windows 10 machine for the Web Developer Bootcamp.

### Windows Version
Ensure your Windows 10 version is at least `2004`.
- Press `Windows` + `R`
- Type `winver`
- Press `Enter`
Verify the version.

### Virtualization
Ensure Virtualization is enabled in your system's BIOS/UEFI settings. To check its current status:
- Press `CTRL` + `SHIFT` + `ESC`
- Click on the `Performance` tab
- Click on `CPU`

Look for "Virtualization: Enabled".
If it's disabled, you'll need to enable it in your BIOS/UEFI settings.

### Windows Subsystem for Linux (WSL)
#### Installation
Open the Windows Command Prompt as administrator.
In the Command Prompt, run:
```powershell
wsl --install
```
After the command completes, restart your computer.

#### Ubuntu
Upon restarting, the Ubuntu installation will finalize. You will be prompted to:

- Choose a **username**
- Choose and confirm a **password**

#### Check WSL Version of Ubuntu
Open a new Command Prompt and run
```powershell
wsl -l -v
```
Ensure the `VERSION` for the Ubuntu WSL distribution is `2`.

#### Check Username
Open your Ubuntu terminal.
```powershell
wsl
```

Then run
```bash
whoami
```

This command should output the username you created during the Ubuntu setup.

#### Check Locale
In your Ubuntu terminal, check the system locale:
```bash
locale
```

If the output does not include `LANG=en_US.UTF-8`, run the following to generate the English locale:
```bash
sudo locale-gen en_US.UTF-8
```

### Visual Studio Code
#### Installation
[Download](https://code.visualstudio.com/download) Visual Studio Code for Windows.

Launch the installer and proceed with the installation.
Ensure the following options are selected during the setup process:
![](https://raw.githubusercontent.com/lewagon/setup/master/images/windows_vscode_installation.png)


#### Install the WSL extension
```bash
code --install-extension ms-vscode-remote.remote-wsl
```

After installation, open your current directory in VS Code from your Ubuntu terminal
```bash
code .
```

Verify that `WSL: Ubuntu` is displayed in the green remote indicator area in the bottom-left corner of the VS Code window.

#### Other extensions
Here are a few useful extensions for Vue and Ruby based development
```bash
code --install-extension formulahendry.auto-rename-tag
code --install-extension pkief.material-icon-theme
code --install-extension alefragnani.project-manager
code --install-extension dbaeumer.vscode-eslint
code --install-extension waderyan.gitblame
code --install-extension github.vscode-github-actions
code --install-extension shd101wyy.markdown-preview-enhanced
code --install-extension shopify.ruby-lsp
code --install-extension bradlc.vscode-tailwindcss
code --install-extension vue.volar
```

### Windows Terminal
Install Windows Terminal from the Microsoft Store

To set Ubuntu as the default terminal
- Launch the Windows Terminal application.
- Press `Ctrl` + `,` to open the Settings tab.
- In the `Startup` section, set the `Default profile` to `Ubuntu`
- Click `Save` at the bottom of the Startup settings.

Then let's update a few advanced settings in the JSON config file
- Click on `Open JSON file` button
- Find the profile object for Ubuntu (it will have an entry like `"name": "Ubuntu"`) and add the following line inside this object to make Ubuntu start in your WSL home directory
```json
"commandline": "wsl.exe ~",
```
- Find the `"defaultProfile"` setting and add the following line to disable the multi-line paste warning:
```json
"multiLinePasteWarning": false,
```
- Save the JSON file and close it.

The Windows Terminal will now open Ubuntu by default, starting in your home directory.
### Command Line Tools
#### Git, Zsh and more
Open your Ubuntu terminal.
Update your package list and install the following packages
```bash
sudo apt update
```
```bash
sudo apt install -y curl git unzip vim zsh
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
gh auth login -s 'user:email' -w
```

Follow the interactive prompts
- "What is your preferred protocol for Git operations?":  **SSH**.
- "Generate a new SSH key to add to your GitHub account?": **Y**.
- "Enter a passphrase for your new SSH key (Optional)": Leave blank
- "Title for your SSH key". Name it whatever

The CLI will output a one-time code, copy it then press Enter to open a browser window to GitHub.
Paste the code and authorize the GitHub CLI.
Once authorized in the browser, return to your terminal and press Enter to complete the authentication.

Verify your login status
```
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
git checkout linux-wsl
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
