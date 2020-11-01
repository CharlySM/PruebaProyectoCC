# Explaining

This documentation explaining like the project was initilized and how the set-up was started.

# Installing GitHub

At first, it has been installed gitbash in local environment.

![Instalation](https://github.com/CharlySM/Proyecto_CC-20-21/blob/main/doc/img/installedGitbash.PNG)

## SSH Key creation
Then it is configured the local environment of gitbash with the pair public key and has been uploaded the public key to github.
Before we generate the public key from gitbash terminal, then we copy the public key in settings option -> SSH and GPG Keys option.
In next image we can see the ssh public key created.

![SSHPublicKey](https://github.com/CharlySM/Proyecto_CC-20-21/blob/main/doc/img/sshKey.PNG)

## Email and name assingment to appear in commits.
The email, username and avatar are configured to appear in commits.
They were added with command:
```
git config --global user.email email@example.com
git config --global user.name username
```
It is added the pull rebase too with the option:
```
git --global pull.rebase true
```

## Modify profile to appear the avatar, complete name and university.

This data were modified in Entornos Virtules subject in Computer science degree in University of Granada.

## Activating two factor-authentication.

At first we go to settings option -> two factor-authentication.

![twoFactor](https://github.com/CharlySM/Proyecto_CC-20-21/blob/main/doc/img/twoFactor.PNG)

When it is activated is show this.

![Activate](https://github.com/CharlySM/Proyecto_CC-20-21/blob/main/doc/img/activateTwo.PNG)
