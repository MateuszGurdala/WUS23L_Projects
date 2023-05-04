## Package Installation

### To install necessary packages (Azure CLI, Ansible, jq, yq):

```bash
sudo sh ./install_tools.sh
```

## Deployment

### To deploy infrastructure on Azure:

```bash
sudo sh ./exec.sh deploy azure <confing number>
```

### To deploy software using Ansible:

```bash
sudo sh ./exec.sh deploy ansible <confing number>
```
