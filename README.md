# BootStrap Virtual Machine (BSVM)
Quick and dirty scripts to make it easier to get a new VM up and running.

Use this command to automatically download your github public keys and add them to your `~/.ssh/authorized_hosts` file for password-less login via ssh.
```shell
curl -fsSL https://raw.githubusercontent.com/johnsynnott/bsvm/refs/heads/main/keys.sh | bash -s your_github_username
```
