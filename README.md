# pi1-docker: The Environment For All Lectures at PI1

In the following, we briefly introduce you to Docker. For specifics to
[PI2](#4-pi2) , [ML/DL](#5-mldl), and [LSDM](#6-large-scale-data-management-lsdm), click on the respective
link.

## Table of contents

1. [Installation](#1-installation)
2. [Setup](#2-setup)
3. [Usage](#3-usage)
4. [PI2](#4-pi2)
5. [ML/DL](#5-mldl)
6. [LSDM](#6-large-scale-data-management-lsdm)

## 1. Installation

Before starting the local development environment, you need to install Docker.
If you have no prior experience with Docker, please refer to the introductory
material available on the [official Docker
website](https://docs.docker.com/get-started/docker-overview/).

### Docker Installation - Windows

To use Docker on Windows install the Docker Desktop. We encourage you to use the
WSL2 (Windows Subsystem for Linux) as backend. You can find the download link
and corresponding installation instructions
[here](https://docs.docker.com/desktop/install/windows-install/).

#### Troubleshooting WSL

Docker in the WSL can use up too many resources. We therefore recommend to adjust
the resources allocated to WSL using the WSL Settings App (see [here](https://devblogs.microsoft.com/commandline/whats-new-in-the-windows-subsystem-for-linux-in-may-2024/#wsl-settings-gui-application-coming-soon)).

#### Starting the Docker Engine

On Windows you always need to start Docker before usage. Open Docker Desktop
and click the Docker icon in the bottom left corner to start the engine. You
can also configure Docker to start at system startup automatically.

### Docker Installation - Mac

To use Docker on Mac install the Docker Desktop. You can find the download link
and corresponding installation instructions
[here](https://docs.docker.com/desktop/install/mac-install/).

### Docker Installation - Linux
On Linux you have multiple installation options.

#### Installation using apt

You can install docker using apt (preferred in Debian/Ubuntu). Please follow the
official instuctions given
[here](https://docs.docker.com/engine/install/ubuntu/).

#### Installation using convenience script

Alternatively, Docker provides a useful convenience script to install the engine
with the following commands.

```sh
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh ./get-docker.sh
```

For more information see
[here](https://docs.docker.com/engine/install/ubuntu/#install-using-the-convenience-script).

#### Installation using Snap

Alternatively, you can install docker using a single command on Ubuntu using
Snap. Note: the version provided by snap can be an older one. We recommend using
the convenience script instead.

```sh
sudo snap install docker
```

## 2. Setup

### Clone This Repository

Clone this repository and go into the root directory of the repository by typing
the following commands in a terminal:

```sh
git clone https://github.com/uma-pi1/pi1-docker
cd pi1-docker
```

Alternatively, you can click on the "Code" button on the top right of this page
and click "Download ZIP". Then you need to decompress the ZIP file into a new
folder.

### Build Docker Containers

With an installed Docker environment and a started engine you can now run the
Docker containers.

**Note:** The first time you are running the commands below will take some time
depending on your notebook and internet connection. So feel free to grab
some coffee. It will only take that long the first time you run this command. 
All following start-ups should be quick.

This will build all containers:

```sh
docker compose up --build --no-start
```

### Handling Repository Updates 

If the `pi1-docker` repository is updated during the term, run

```sh
git pull
docker compose up --build --no-start
```

in the `pi1-docker` folder.

## 3. Usage

### Start-up

For the PI2, the ML or the DL lecture, you usually want to use only the `pi1_main` container. 
You can start only this container (in the background) using:

```sh
docker compose up -d pi1_main
```

Alternatively start all containers (including mySQL, MongoDB etc.) in the background using:

```sh
docker compose up -d
```

#### Windows File Permission Fix

**Note for Windows users: it might be that you do not have write access in the
`shared` folder.** In that case, first run the provided script `prepare_host.sh`. 
For this, open a linux shell, turn the script into an executable, then run it:

```sh
chmod +x prepare_host.sh  # makes the script executable
./prepare_host.sh  # runs the script
```

Then run:

 ```sh
 docker compose up --build -d
 ```

### Shutdown

The container will run until you stop it by executing:

```sh
docker compose down
```

You can remove the volumes created by Docker (e.g., for mySQL and MongoDB) by
using

```sh
docker compose down -v
```

instead. You will **lose all files** in those volumes.

### Transfer Files Between Host and Container

All files placed in the `shared` folder located in the root directory of this
repository on your host machine will directly appear in your container in the
`shared` folder and vice versa.

### Using JupyterLab

Open a browser and enter [http://localhost:8889](http://localhost:8889) to open
JupyterLab. You have the option to open a terminal or notebooks for multiple
different languages.

**If you see a prompt asking you for a token or password type `pi1`.**

#### JupyText

In our lectures, we are making use of
[JupyText](https://jupytext.readthedocs.io/en/latest/index.html), a tool to
synchronize plain Python files with Jupyter notebooks. In this Docker container,
JupyText is already installed. This means that you are able to open and edit
plain Python files as a notebook. You will notice that upon saving your edits, a
notebook file (with `ipynb` file extension) will be created. 

Changes in either file (`py` or `ipynb`) will be synchronized to its counterpart. 
This means that you can edit any JuypText file *simultaneously* in your IDE and 
in JupyterLab.

**Note:** If Python files are _not_ opened as a notebook directly, right-click 
the file, click "Open With", then select "Notebook".

### Run Programs in A Container

You can run programs using the terminal in JupyterLab. But you can also do it
non-interactively or interactively from the shell.

#### Non-Interactively

**List Running Containers**: List the running containers to get the container 
ID or name:

```sh
docker ps
```

 **Execute a Command**: Run your command in a container:

```sh 
docker exec -it <container_name> <command>
```

For example, to run a Python script inside `pi1-main`:

```sh
docker exec -it pi1-main python3 shared/myprogram.py
```

#### Interactively

Attach to the container's interactive shell using the `docker exec` command with
bash.

**Open a shell inside a container**: Use the `docker exec` command to open a
container's shell.

 ```sh
 docker exec -it <container_name> /bin/bash
 ```

**Execute programs**: Once you are inside the container's shell, you can
execute programs as you would in a regular terminal.

 For example, to compile and run a `C` program:

 ```sh
 gcc -o myprogram myprogram.c
 ./myprogram
 ```

Close the shell again: `Ctrl + D`

### Misc

The default user name in JupyterLab and the pi1-main notebook is `jovyan`. For
more information see
[here](https://jupyter-docker-stacks.readthedocs.io/en/latest/using/faq.html#who-is-jovyan).

> Jovyan is often a special term used to describe members of the Jupyter community. 
> It is also used as the user ID in the Jupyter Docker stacks or referenced in conversations.

## 4. PI2

For the lecture Praktische Informatik II (PI2), the Docker environment contains:
- `clang`
- `nasm`
- `Java`
- `Python`
- JupyterLab with `Java` and `C` kernels

## 5. ML/DL

For the lectures "Machine Learning (ML)" and "Deep Learning (DL)", the Docker environment contains:

- JupyterLab with Python kernel
- Relevant Python packages including `matplotlib`, `pandas`, `NumPy`, `PyTorch`, and `TensorBoard`

## 6. Large-Scale Data Management (LSDM)

The `docker-compose.yaml` file defines several containers for the Large-Scale Data Management (LSDM) lecture:

- MySQL
- phpMyAdmin
- JupyterLab with Python, Java, and Scala kernels (each with Apache Spark
  support)
- MongoDB
- Mongo-Express

The following table summarizes the most important information:

| Service           | Container Name        | Access                    | Credentials                   | Data Persistence               | Notes                                                                                 |
|-------------------|------------------|---------------------------|-------------------------------|--------------------------------|---------------------------------------------------------------------------------------|
| **JupyterLab**    | `pi1-main`       | `http://localhost:8889`   | password/token = `pi1`        | Host `./shared` → `/home/jovyan/shared` | Python, (Java) & Scala kernels with Spark support, Spark UIs on ports `4040`–`4049`   |
| **MySQL**         | `mysqldb`        | TCP → `localhost:3306`    | user/secret, root/root        | Named volume `mysql-data`      | Default database: `db`| 
| **phpMyAdmin**    | `phpmyadmin`     | `http://localhost:8081`   | (use MySQL creds)             | —                              | — |
| **MongoDB**       | `mongodb`        | TCP → `localhost:27017`   | root/root                     | Named volume `mongo-data`      | Default database: `db`                                                               |
| **Mongo-Express** | `mongo-express`  | `http://localhost:8082`   | basic auth: root/root         | —                              | — |

**Note:** A separate repository is available for Apache Hadoop: [docker-hadoop](https://github.com/simon-forb/docker-hadoop/).