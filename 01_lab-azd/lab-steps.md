
## Lab 01 - Azure Developer CLI

The Azure Developer CLI (azd) Preview is a developer-centric command-line tool for building cloud apps. The azd is a set of commands that allows you to work consistently across azd templates, DevOps workflows, and your IDE (integrated development environment).

Reference:
https://docs.microsoft.com/en-us/azure/developer/azure-developer-cli/overview?tabs=nodejs
Additional Document example and lab. Thought https://github.com/adamstephensen/faqs/blob/master/azure-demo-scripts/azure-developer-cli.md

### What is AZD?

>The Azure Developer CLI (azd) Preview is a developer-centric command-line tool for building cloud apps. The azd is a set of commands that allows you to work consistently across azd templates, DevOps workflows, and your IDE (integrated development environment).
- Officlial Documentation: https://docs.microsoft.com/en-us/azure/developer/azure-developer-cli/overview

- Azure Developer CLI focuses on enabling the developers with a easy to use CLI interface which does the end to end deployment of their source code. 
- Currently AZD is in beta and you can find the list of releases here: https://github.com/Azure/azure-dev/releases
- There's support for multiple environments. 
- Not intended for Production, even after being generally avaialble, it never should be. 
- Currently in Preview. `0.1.0-beta.5`

-----
**What Problem's will this solve for you?**

- You're effectively empowering the developers to bypass some of the hurdles of waiting for IT/Ops. 
- Make the development teams efficent, test out changes much faster. 

### Current support matrix: 

Services:
- Azure App Services
- Azure Functions 
- Azure Cotainer Apps
- Azure Static Web Apps
- Azure Kubernetes Service (Coming Soon)

Languages: 
- Node.js
- Python
- .NET
- Java (Coming Soon)

IaC:

- bicep.
- terraform (Coming Soon, v0.2 likely)
	- https://github.com/Azure/azure-dev/issues/658
	- Lots of 404s, likely some private repositories in play

--------
### Where to start looking?

GitHub - https://github.com/Azure/azure-dev

------

### Installer Types
- Binary
- All encompassing docker container
- Extra: VSCode Extension
- Codespaces (Coming Soon)


### Installation

#### Prerequsites

-   [Git](https://git-scm.com/)
-   [GitHub CLI v2.13+](https://github.com/cli/cli)
-   [Azure CLI (v 2.38.0+)](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)

#### Windows

```
powershell -ex AllSigned -c "Invoke-RestMethod 'https://aka.ms/install-azd.ps1' | Invoke-Expression"
```

#### Linux/MacOS

```
curl -fsSL https://aka.ms/install-azd.sh | bash
```

### Uninstall Azure Developer CLI

#### Windows

```powershell
powershell -ex AllSigned -c "Invoke-RestMethod 'https://aka.ms/uninstall-azd.ps1' | Invoke-Expression"
```

#### Linux/MacOS

```bash
curl -fsSL https://aka.ms/uninstall-azd.sh | bash
```

#### Docker Container

##### Official

```bash
docker run -w /root/source -it -v /var/run/docker.sock:/var/run/docker.sock mcr.microsoft.com/azure-dev-cli-apps:latest
```

##### Customised

```bash
docker run -w /root/source -it -v /var/run/docker.sock:/var/run/docker.sock ghcr.io/venura9/azd:main zsh
```

Why? Size and Control

```bash
REPOSITORY                                 TAG       IMAGE ID       CREATED        SIZE
ghcr.io/venura9/azd                        main      2e149efcd988   32 hours ago   1.25GB
mcr.microsoft.com/azure-dev-cli-apps       latest    3828387c7e73   2 weeks ago    2.76GB
```

Dockerfile

Note: I couldn't get everything working with the `alpine` base container image, likely some missing dependancies. If you have got it working don't forget to send though a pull request to: https://github.com/venura9/azd

```dockerfile
ARG AZURE_CLI_VERSION="2.39.0"
FROM mcr.microsoft.com/azure-cli:${AZURE_CLI_VERSION}
ARG GH_CLI_VERSION="2.14.4"

# Install Dependancies
RUN apk add zsh figlet vim docker

# Install GitHub CLI
RUN curl -O -L https://github.com/cli/cli/releases/download/v${GH_CLI_VERSION}/gh_${GH_CLI_VERSION}_linux_amd64.tar.gz && \
tar -zxvf gh_${GH_CLI_VERSION}_linux_amd64.tar.gz && \
chmod +x gh_${GH_CLI_VERSION}_linux_amd64/bin/gh && \
mv gh_${GH_CLI_VERSION}_linux_amd64/bin/* /usr/bin && \
mv gh_${GH_CLI_VERSION}_linux_amd64/share/* /usr/share/ && \
rm -rf gh_${GH_CLI_VERSION}_linux_amd64*

# Install azd
ARG AZD_VERSION="0.1.0-beta.5"
RUN curl -O -L https://github.com/Azure/azure-dev/releases/download/azure-dev-cli_${AZD_VERSION}/azd-linux-amd64.tar.gz && \
tar -xvzf azd-linux-amd64.tar.gz && \
chmod +x azd-linux-amd64 && \
mv azd-linux-amd64 /usr/bin/azd && \
rm -rf azd-linux-amd64*
# RUN sh -c "$(curl -fsSL https://aka.ms/install-azd.sh)"

# Install ohmyzsh
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Set zsh as default shell
# `/etc/profile` logic did't like it when zsh was default.
RUN sed -i -e "s/bin\/ash/bin\/zsh/" /etc/passwd

# Welcome Text
RUN echo -e "\nfiglet 'AZ Dev CLI'\necho 'https://github.com/venura9/azd'\n" >> ~/.bashrc && \
echo -e "\nfiglet 'AZ Dev CLI'\necho 'https://github.com/venura9/azd'\n" >> ~/.zshrc
```

Dev Container

```bash
# MacOs
git clone https://github.com/venura9/azd.git
cd azd
code .
```

Source: https://github.com/venura9/azd

### Deploy a sample and Inspect

Lets explore the `azd` itself first and deploy a sample application. 

```bash

```


### Creating your own template: 

```txt
├── .devcontainer              [ For DevContainer ]
├── .github                    [ Configure GitHub workflow ]
├── .vscode                    [ VS Code workspace ]
├── assets                     [ Assets used by README.MD ]
├── infra                      [ Creates and configures Azure resources ]
│   ├── main.bicep             [ Main infrastructure file ]
│   ├── main.parameters.json   [ Parameters file ]
│   └── resources.bicep        [ Resources file ]
├── src                        [ Contains directories for the app code ]
└── azure.yaml                 [ Describes the app and type of Azure resources]
```


Create the empty project. 



```bash
npx express-generator src --view ejs
```

