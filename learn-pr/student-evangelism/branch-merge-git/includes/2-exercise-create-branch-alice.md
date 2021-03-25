Your developer friend Alice wants to add some CSS to style the cat photos on your website. Alice  wants to do this work in their own branch.

## Setup

Before you can assume the role of Alice, you must do some work to set up a bare repo for everyone to share, and then add some files.

Git is already installed for us in Azure Cloud Shell, so we can use Git in Cloud Shell to the right.

### Create a shared bare repo

1. Create a new directory named *Shared.git* to hold the bare repo:

    ```bash
    mkdir Shared.git
    cd Shared.git

    ```

1. Now, use the following command to create a bare repo in the shared directory:

    ```bash
    git init --bare

    ```

1. Set the name of the default branch for the new repo. To accomplish this step, you can change the `HEAD` branch to point at a different branch, in this case, the `main` branch:

    ```bash
    git symbolic-ref HEAD refs/heads/main

    ```

### Clone the shared repo for Alice and Bob

1. Move up one level from this directory and create directories for Alice and Bob to store their repos:

    ```bash
    cd ..
    mkdir Alice
    mkdir Bob

    ```

1. Clone the repo for Alice, and then configure it:

    ```bash
    cd Alice
    git clone ../Shared.git .
    git config user.name Alice
    git config user.email alice@contoso.com

    ```

1. Clone and configure the repo for Bob:

    ```bash
    cd ..
    cd Bob
    git clone ../Shared.git .
    git config user.name Bob
    git config user.email bob@contoso.com

    ```

### Add base files

As a final setup step, we'll add our base website files and push them to the shared repo. For these commands, we're still working in the *Bob* directory.

1. Create some files by using the Linux `touch` command, and then stage and commit them by using Git:

    ```bash
    touch index.html
    mkdir Assets
    touch Assets/site.css
    git add .
    git commit -m "Create empty index.html and site.css files"

    ```

1. Now, add some HTML to your file by using the Cloud Shell code editor. You can open the editor by using the `code` command. Open *index.html* in the online editor by typing `code index.html` at the terminal prompt:

    ```bash
    code index.html

    ```

1. Paste in this HTML code:

    ```html
    <!DOCTYPE html>
    <html>
      <head>
        <meta charset='UTF-8'>
        <title>Our Feline Friends</title>
        <link rel="stylesheet" href="CSS/site.css">
      </head>
      <body>
        <nav><a href="./index.html">home</a></nav>
        <h1>Our Feline Friends</h1>
        <p>Eventually we will put cat pictures here.</p>
        <footer><hr>Copyright (c) 2021 Contoso Cats</footer>
      </body>
    </html>
    ```

1. Save the file and close the editor. You can select the ellipsis "..." in the right corner of the editor, or use the accelerator key (Ctrl+S on Windows and Linux, Cmd+S on macOS).

1. Change to the *Assets* directory, and then open *site.css* in the editor:

    ```bash
    cd Assets
    code site.css

    ```

1. Add the following CSS to the file:

    ```css
    h1, h2, h3, h4, h5, h6 { font-family: sans-serif; }
    body { font-family: serif; background-color: #F0FFF8; }
    nav, footer { background-color: #C0D8DF; }
    ```

   Save the file and close the editor.

1. Go back to the *Bob* directory and commit again:

    ```bash
    cd ..
    git add .
    git commit -m "Add simple HTML and stylesheet"
    git push

    ```

1. Check the output. If you see a warning like this example, don't worry. This warning is just letting users know about a change to Git's default behaviors. 

    ```output
    warning: push.default is unset; its implicit value has changed in
    Git 2.0 from 'matching' to 'simple'. To squelch this message
    and maintain the traditional behavior, use:

      git config --global push.default matching

    To squelch this message and adopt the new behavior now, use:

      git config --global push.default simple

    When push.default is set to 'matching', git will push local branches
    to the remote branches that already exist with the same name.

    Since Git 2.0, Git defaults to the more conservative 'simple'
    behavior, which only pushes the current branch to the corresponding
    remote branch that 'git pull' uses to update the current branch.

    See 'git help config' and search for 'push.default' for further information.
    (the 'simple' mode was introduced in Git 1.7.11. Use the similar mode
    'current' instead of 'simple' if you sometimes use older versions of Git)
    ```

    If you'd like to make sure you don't see this warning again, you can run this command:

    ```bash
    git config --global push.default simple

    ```

1. Check the output for this indicator of success:

    ```output
    Counting objects: 12, done.
    Delta compression using up to 2 threads.
    Compressing objects: 100% (8/8), done.
    Writing objects: 100% (12/12), 1.07 KiB | 0 bytes/s, done.
    Total 12 (delta 1), reused 0 (delta 0)
    To ../Shared.git
     * [new branch]      main -> main
    ```

## Create a branch for Alice

Alice wants to create a topic branch named `add-style` to do their work in. Let's assume the role of Alice, and then create the branch and add some code to this branch.

1. Go back to the *Alice* directory. The first thing we must do is `git pull` to make sure our copy of the shared repo is up to date.

    ```bash
    cd ../Alice
    git pull

    ```

1. Check the output. You should see a success message that looks like this example:

    ```output
    remote: Counting objects: 8, done.
    remote: Compressing objects: 100% (5/5), done.
    remote: Total 8 (delta 0), reused 0 (delta 0)
    Unpacking objects: 100% (8/8), done.
    From /home/shana/Alice/../Shared
     * [new branch]      main     -> origin/main
    ```

1. Use the `git branch` command to create a branch named `add-style`. Then, use the `git checkout` command to switch to that branch (make it the *current branch*).

    ```bash
    git branch add-style
    git checkout add-style

    ```

1. In the *Alice/Assets* directory, open *site.css*. Add the following CSS class definition to the bottom of the file:

    ```css
    .cat { max-width: 40%; padding: 5 }
    ```

   Save the changes to the file and close the editor.

1. Commit the change:

    ```bash
    git commit -a -m "Add style for cat pictures"

    ```

1. At this point, Alice wants to make their style available to everyone else, so they switch back to `main` and do a pull in case anyone else has made changes:

    ```bash
    git checkout main
    git pull

    ```

1. The output says that the `main` branch is up to date (in other words, `main` on Alice's computer matches `main` in the shared repo). So, Alice merges the `add-style` branch into the `main` branch by using `git merge --ff-only` to perform a *fast-forward* merge. Then, Alice pushes `main` from their repo to the shared repo.

    ```bash
    git merge --ff-only add-style
    git push

    ```

In this case, a fast-forward merge wasn't strictly necessary because the `main` branch had no changes, and Git would have merged the changes anyway. But using the `--ff only` flag is a good practice because an `--ff-only` merge fails if `main` has changed.
