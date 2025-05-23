# pi1-docker: The Environment For All Lectures at PI1

In the following, we briefly introduce you to Docker. For specifics to
[PI2](#4-pi2) , [ML/DL](#5-mldl), and [LSDM](#6-lsdm), click on the respective
link.

## Table of contents

1. [Installation](#1-installation)
2. [Setup](#2-setup)
3. [Usage](#3-usage)
4. [PI2](#4-pi2)
5. [ML/DL](#5-mldl)
<!-- 6. [LSDM](#6-lsdm) -->

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

On Windows you always need to start Docker first manually. Open Docker Desktop
and click the little Docker icon in the bottom left corner to start the engine.

### Docker Installation - Mac

To use Docker on Mac install the Docker Desktop. You can find the download link
and corresponding installation instructions
[here](https://docs.docker.com/desktop/install/mac-install/).

### Docker Installation - Linux
On Linux you have multiple installation options.

#### Installation using Apt
You can install docker using apt (preferred in Debian/Ubuntu). Please follow the
official instuctions given
[here](https://docs.docker.com/engine/install/ubuntu/).

#### Installation using convenience script
Alternatively, Docker provides a useful convenience script to install the engine
with the following commands.

```
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh ./get-docker.sh
```

For more information see
[here](https://docs.docker.com/engine/install/ubuntu/#install-using-the-convenience-script).

#### Installation using Snap
Alternatively, you can install docker using a single command on Ubuntu using
Snap. Note: the version provided by snap can be an older one. We recommend using
the convenience script instead.

```
sudo snap install docker
```

## 2. Setup

### Clone This Repository
Clone this repository and go into the root directory of the repository by typing
the following commands in a terminal:

```
git clone https://github.com/uma-pi1/pi1-docker
cd pi1-docker
```

Alternatively, you can click on the "Code" button on the top right of this page
and click "Download ZIP". Then you need to decompress the ZIP file into a new
folder.

### Build/Start Docker Containers

With an installed Docker environment and a started engine you can now run the
Docker containers.

**Note: The first time you are running the commands below will take some time
depending on your notebook and internet connection.** **So feel free to grab
some coffee.**

**It will only take that long the first time you run this command. All following
start-ups should be quick.**

This will run all provided containers:
```
docker compose up -d
```

You usually want to use the pi1\_main container only. Start this using
```
docker compose up -d pi1-main
```

**Note for Windows users: it might be that you do not have write access in the
`shared/` folder.** In that case, first run `prepare_host.sh`. For this, open a
linux shell, turn the script into an executable, then run it.

```sh
chmod +x prepare_host.sh
./prepare_host.sh
```

Then run `docker compose up --build`. 

### Handling Repository Updates 

If the pi1-docker repository was updated during the term, run
```
git pull
docker compose up --build -d
```
in the pi1-docker folder.


## 3. Usage

Use the Docker Desktop GUI or run the following command in the root folder of
the repository to start the main container:

```
docker compose up -d pi1-main
```

The container will run until you stop it using the GUI or
```
docker compose down
```

<!-- Notice that Docker is running in the terminal you started it from, as long -->
<!-- as the process it is running hasn't finished working yet. In case of the Jupyter -->
<!-- notebook server, the answer to when it will *finish* executing is: never, unless -->
<!-- you shut it down. To attach to a container, you thus have to open a second -->
<!-- terminal to not interrupt the processes running in the first. -->

### Transfer Files Between Host and Container

All files placed in the folder `./shared` located in the root directory of this
repository on your host machine will directly appear in your container in the
folder `shared`. And vice versa, of course.

### Using JupyterLab

Open a browser and enter [http://localhost:8889](http://localhost:8889) to open
JupyterLab. You have the option to open a terminal or notebooks for multiple
different languages.

**If you see a prompt asking you for a token or password type `pi1`.**

#### JupyText

In our lectures, we are making use of
[Jupytext](https://jupytext.readthedocs.io/en/latest/index.html), a tool to
synchronize plain Python files with Jupyter notebooks. In this Docker container,
Jupytext is already installed. This means that you are able to open and edit
plain Python files as a notebook. You will notice that upon saving your edits, a
notebook file (with `ipynb` file extension) will be created. Changes in either
file (`py` or `ipynb`) will be synchronized to the other one.

**Note:** If Python files are _not_ opened as a notebook directly, right-click the file, click "Open With", then select "Notebook".

### Run Programs in A Container

You can run programs using the terminal in JupyterLab. But you can also do it
non-interactively or interactively from the shell.

#### Non-Interactively
1. **List Running Containers**: If you don't know the exact container name, list
   the running containers to get the container ID or name.

    ```sh
    docker ps
    ```

2. **Execute a Command**: Run your command via the container

    ```
    sh docker exec -it <container_name> <command>
    ```

    For example, to run a Python script inside `pi1-main`:
    ```sh
    docker exec -it pi1-main python3 shared/myprogram.py
    ```

#### Interactively

Attach to the container's interactive shell using the `docker exec` command with
bash.

1. **Attach to the Shell**: Use the `docker exec` command to attach to the
   container's shell.

    ```sh
    docker exec -it <container_name> /bin/bash
    ```

2. **Execute programs**: Once you are inside the container's shell, you can
   execute programs as you would in a regular terminal.

    For example, to compile and run a C program:
    ```sh
    gcc -o myprogram myprogram.c
    ./myprogram
    ```
3. Close the shell again: Ctrl+D.

### Misc

The default user name in JupyterLab and the pi1-main notebook is `jovyan`. For
more information see
[here](https://jupyter-docker-stacks.readthedocs.io/en/latest/using/faq.html#who-is-jovyan).

*""Jovyan is often a special term used to describe members of the Jupyter community. It is also used as the user ID in the Jupyter Docker stacks or referenced in conversations."*

## 4. PI2

For the lecture Praktische Informatik II (PI2), the Docker environment contains:
- clang
- nasm
- Java
- Python
- JupyterLab with Java and C kernels

## 5. ML/DL

For the lectures "Machine Learning (ML)" and "Deep Learning (DL)", the Docker environement contains:
- JupyterLab with Python kernel
- Relevant Python packages including matplotlib, pandas, NumPy, PyTorch, and TensorBoard

<!-- ## 6. LSDM 
This is a docker environment for the exercises of the course "Large-Scale Data Management (LSDM)".  This environment contains:
- MySQL database
- phpMyAdmin
- JupyterLab with Python, Java, and Scala kernels (each with Spark support) as well as Beam
- MongoDB
- ~~Hadoop~~ (currently commented out)

This environment is based on [this repository](https://github.com/big-data-europe/docker-hadoop).

## 6.1 phpMyAdmin
With a successful setup you should be able to access phpMyAdmin here:

[http://localhost:8081](http://localhost:8081)

## 6.2 MySQL
From your local machine you can connect to the database via `localhost:3308` or via `mysqldb:3306`.

username: root

password: root

Note: The connection port differs as we use port forwarding to connect from the local machine (`localhost:3308`) directly to the container (`mysqldb:3306`). I.e., the database is hosted on port 3306 in the container but port 3308 in your local machine. This is done because port 3306 might already be in use on your machine.


## 6.3. MongoDB
You can connect to the database on `mongodb://root:root@mongodb:27017/`.

## 6.4 PySpark Notebook
You can access JupyterLab on

[http://localhost:8889](http://localhost:8889)

**If you see a prompt asking you for a token or password, type `pi1`.**

Here you can run any Python/Java/Scala code you want. But most importantly you can use Spark and connect to the HDFS.

For example, in Python:
```python
import pyspark
from pyspark.sql import SparkSession

spark = SparkSession.builder.master("local").appName("hdfs_test").getOrCreate()

hello_world_rdd = spark.sparkContext.textFile("hdfs://namenode:9000/helloWorld/hello.txt")

hello_world_rdd.collect()
```
### Accessing the DB from the PySpark Notebook
You can access the database via the container name `mysqldb:3306` or via `your_ip_address:3306`.
The connection via localhost does not work here, as the notebook is hosted in a separate container.

## 6.5 Hadoop

**N.B.:** Hadoop's dependencies are commented out in the `docker-compose.yml` file. Hence, you need to uncomment
the respective lines in the file and reinitialize the containers before being able to use Hadoop as described below.

You can copy files to the namenode via
```
docker cp <filename> namenode:<path on namenode>
```

You can access the namenode via
```
docker exec -it namenode /bin/bash
```

On the namenode you can create a new directory on the hdfs via
```
hadoop fs -mkdir <folder name>
```

You can put a local file onto the hdfs via
```
hadoop fs -put <file name> <path on hdfs>
```

You can run a jar file via 

```
hadoop jar <jar file>
```


### Hadoop UI
You can access the Hadoop UI on

[http://localhost:9870](http://localhost:9870) -->


