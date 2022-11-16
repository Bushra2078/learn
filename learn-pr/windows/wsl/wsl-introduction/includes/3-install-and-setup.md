WSL is included by default with Windows, but must be enabled before installing a Linux distribution. This unit will cover what you need to know about enabling WSL, installing Linux distributions, and setting up a Linux username and password.

> [!IMPORTANT]
> You must make sure that you're running Windows 11 or Windows 10 version 2004+ (Build 19041 and higher) to run the WSL install command.

## WSL install command

You can now install everything you need to run WSL by entering a single command, `wsl --install`, in an administrator PowerShell or Windows Command Prompt and then restarting your machine.

There are a few things to know about what this command accomplishes and the options that it provides.

You must make sure that you're running Windows 11 or Windows 10 version 2004+ (Build 19041 and higher) to run the WSL install command. [Check for updates](ms-settings:windowsupdate). If you're running an earlier build of Windows and cannot update, documentation on how to manually enable WSL and install a Linux distribution are linked in the resources at the end of this module.

The `wsl --install` command performs the following actions:

- Enables WSL and Virtual Machine Platform components that are included by default with Windows.
- Downloads the WSL package from the Microsoft Store, enabling updates and security fixes to be pushed as they become available.
- Downloads and installs the latest Linux kernel, setting WSL 2 as the default architecture.
- Downloads and installs the Ubuntu distribution of Linux.

To use the install command:

1. Open PowerShell or Windows Command Prompt in administrator mode by right-clicking and selecting "Run as administrator".

2. Enter the command: `wsl --install`

3. You will need to restart your machine following this installation process in order to begin using WSL.

## Install alternative Linux distributions

The `wsl --install` command installs the Ubuntu distribution of Linux by default. This can be changed to one of the other Linux distributions available in the Microsoft Store. You can also install additional Linux distributions after installing the default Ubuntu.

To see what distributions are currently available via the store, enter the command: `wsl --list --online`

To select an alternative to the default Ubuntu distribution, or to install additional distributions from the store, use the command: `wsl --install --distribution <Distribution Name>`

If a Linux distribution that you want to install is not available via the Microsoft Store, you can still install it by importing using a `.tar` file or `.appx` file. You can also build your own custom distribution. There are instructions on how to import or build a custom Linux distribution in the WSL documentation linked at the end of this module. For beginners, we recommend starting with the default Ubuntu distribution, which will also make it easier to follow along in the training.

> [!NOTE]
> For advanced-level WSL users, there are some additional options that can be set using flags on the `wsl --install` command. For business or enterprise users, there are options for creating a custom WSL image for distribution in your company. There is also the option to install WSL from a CDN rather than the Microsoft Store package if, for example, access to the store is blocked. As well as the option to enable the older WSL 1 architecture if you have a specific scenario that requires it. The `wsl --install` command is also supported on Windows Server 2019 (version 1709) or later, with options not to automatically launch the distribution after install or to enable WSL components without installing any distribution at all. See the documentation linked at the end of the module.

## Set up your Linux username and password

Once you've used WSL to install a Linux distribution and restarted your machine, the distribution will open and you will be asked to "Enter a new UNIX username", along with a password. There are a few things to note here:

- This username and password will be considered the Linux administrator, with the ability to run sudo (Super User Do) administrative commands.
- This user account is specific to each separate Linux distribution that you install and has no bearing on your Windows username. If you install more than one Linux distribution, each will have its own separate Linux user accounts and passwords. You will have to configure a new username and password every time you add a distribution, reinstall, or reset.
- The username and password will accept pretty much anything as valid, but some characters may cause trouble in various contexts. Punctuation like underscores are generally okay, but periods, slashes, or colons, such as `/:.` may cause trouble and you should definitely not begin your username with the `-` hyphen/minus character. We generally recommend to strip out unusual punctuation. You should also note that while entering the password, nothing will appear on the screen (this is normal and called "blind typing").
- If you need to change or reset your password, or if you forget the password for a Linux distribution that you've installed, see the WSL documentation linked at the end of this module.

Once you have entered a username and password, you can confirm the Linux distribution you have installed and it's version number using the command: `cat /etc/os-release`.

## Find and open your newly installed Linux distribution

You can now find the Linux distribution that you've installed using Windows search. It will be listed according to it's distribution name -- Ubuntu (for example).

Beginning in October 2022 with Windows 11 (version 22H2), Windows Terminal is the default command line host. So when you open your Linux distribution, you will see it open as a tab inside Windows Terminal. You can learn more about how to customize your Linux distribution's command line (BASH), including it's default startup behavior, starting directory, tab title, appearance (text size, font, colors, etc), by visiting the Windows Terminal documentation. A link will be provided at the end of this module.

Whenever a new WSL Linux distribution is installed, a new instance will be created for it inside the Windows Terminal that can be customized to your preferences.
