# zsh-eddie

A collection of ZSH utility functions, aliases, and configurations for various developer tools. This plugin provides convenient shortcuts and helpers for daily development tasks.

## Installation

### Manual Installation

```bash
# Clone the repository into your Oh My Zsh custom plugins directory
git clone https://github.com/yourusername/zsh-eddie.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-eddie

# Add the plugin to your .zshrc file
plugins=(... zsh-eddie)
```

### Using Plugin Management

If you use a plugin manager like [zplug](https://github.com/zplug/zplug):

```bash
zplug "yourusername/zsh-eddie"
```

## Features

### Age Encryption

Functions for working with [age](https://github.com/FiloSottile/age) encryption:

- `age_enc <file>` - Encrypt a file using your age key
- `age_dec <file>` - Decrypt a file using your age key

### Aider AI Coding Assistant

- `aid` - Shorthand for running aider with common flags
- `get_or_apikey` - Fetch OpenRouter API key from BitWarden

### Docker Utilities

- `ghcr_login` - Login to GitHub Container Registry

### Kubernetes Helpers

- `k` - Alias for kubectl with TLS verification skipped
- `argocdbaseinst` - Install ArgoCD with Helm
- `argocdpasswd` - Get the ArgoCD initial admin password
- `argocdpf` - Port forward ArgoCD server
- `kube_awstest_sa <serviceaccount> <namespace>` - Test AWS access with a service account
- `kube_run_sa <image> <namespace> <serviceaccount>` - Run a pod with specific service account
- `kube_install <version>` - Install specific kubectl version

### File Listing

- `ls` - Improved listing using [lsd](https://github.com/lsd-rs/lsd)
- `l` - Detailed listing with hidden files

### Micromamba Environment Management

- `mm`, `mmu`, `mmsu`, `mma`, `mmd`, `mmls` - Micromamba shortcuts
- `mmc <prefix> <package=version>` - Create a new environment
- `mmrm <environment>` - Delete an environment
- `pipup` - Update pip packages from requirements files
- `npmup` - Update all global npm packages

### Nerd Fonts Management

- `nf_list` - List available Nerd Fonts for download
- `nf_install <fontname>` - Install a Nerd Font

### Package Manager Aliases

OS-specific package manager shortcuts (automatically detected):
- For openSUSE Tumbleweed: `z`, `zup`
- For Fedora: `d`, `dup`

### General Utilities

- `zsheddie edit` - Open the plugin in your editor
- `zsheddie update` - Update the plugin from git
- `zsheddie cd` - Navigate to the plugin directory
- `convert_time <HH:MM> <Timezone>` - Convert time between timezones
- `update_bun` - Install or update Bun runtime
- `update_ohmyzsh` - Update Oh My Zsh and its plugins

### WSL-specific Settings

Automatically sets browser when running in WSL2 environment.

## Configuration

Create a private.zsh file in the plugin directory for personal environment variables and tokens (this file is ignored by git).

Example:
```zsh
AWS_PROFILE="YourProfile"; export AWS_PROFILE
GHCR_TOKEN="your-token-here"; export GHCR_TOKEN
```

## Development

To contribute to this plugin:

```bash
# Clone the repository
git clone https://github.com/yourusername/zsh-eddie.git

# Make changes and test them
# Submit a pull request
```

## License

This project is open source and available under the [GNU General Public License v3.0](LICENSE).