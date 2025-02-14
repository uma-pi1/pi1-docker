FROM quay.io/jupyter/pyspark-notebook@sha256:999213c55c952aa484128cd0297746703323d4fdfa70fbf66c0922937b3ad45b
# equivalent to:
#
# FROM quay.io/jupyter/pyspark-notebook:spark-3.5.3
#
# on Oct 21, 2024

# Install system-wide packages
USER root
RUN apt-get update

# General
RUN apt-get -y install vim git openjdk-17-jdk gcc
# PI2
RUN apt-get -y install clang nasm
# LSDM
RUN apt-get -y install netcat-traditional
# ML/DL
RUN sudo apt -y install libcairo2-dev pkg-config libgirepository1.0-dev

# Install Jupyter kernels
USER jovyan
WORKDIR /home/jovyan
RUN fix-permissions "${CONDA_DIR}" && fix-permissions "/home/jovyan"

# Install Scala kernel
RUN pip install --no-cache-dir spylon-kernel
RUN python -m spylon_kernel install --user
RUN sed -i 's/"display_name": *"spylon-kernel"/"display_name": "Scala (spylon)"/' /home/jovyan/.local/share/jupyter/kernels/spylon-kernel/kernel.json

# Install Java kernel
WORKDIR /home/jovyan/local
RUN wget https://github.com/padreati/rapaio-jupyter-kernel/releases/download/2.2.0/rapaio-jupyter-kernel-2.2.0.jar
RUN java -jar rapaio-jupyter-kernel-2.2.0.jar -i -auto
RUN sed -i '4i \
    "--add-exports",\
    "java.base/sun.nio.ch=ALL-UNNAMED",' /home/jovyan/.local/share/jupyter/kernels/rapaio-jupyter-kernel/kernel.json
RUN sed -i 's/"RJK_CLASSPATH": *""/"RJK_CLASSPATH": "\/usr\/local\/spark\/jars\/*"/' /home/jovyan/.local/share/jupyter/kernels/rapaio-jupyter-kernel/kernel.json

# Install C kernel
RUN pip install --no-cache-dir jupyter-c-kernel
RUN install_c_kernel --user

# Install lab extensions
# RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager
RUN pip install --no-cache-dir ipywidgets
# RUN jupyter labextension install jupyter-matplotlib
RUN pip install --no-cache-dir ipympl

# Install Python packages
# LSDM
RUN pip install --no-cache-dir 'apache-beam[gcp]' mysql-connector-python pyarrow pandas pymongo

# ML/DL
RUN pip install --no-cache-dir pkgconfig psutil black cairocffi graphviz importmagic matplotlib numpy pandas PyGObject pyparsing python-crfsuite python-mnist pystan scikit-learn scikit-optimize scipy sortedcontainers tabulate nbgitpuller
RUN pip3 install --no-cache-dir torch torchvision torchaudio torchviz --extra-index-url https://download.pytorch.org/whl/cpu
RUN pip install --no-cache-dir torchtext lightning tensorboard
RUN pip install --no-cache-dir nodejs

# Setup shared directory
RUN mkdir /home/jovyan/shared

# Fix any problematic folder permissions and start Jupyterlab in home directory
USER root
RUN chown -R jovyan /home/jovyan
USER jovyan
WORKDIR /home/jovyan/shared
EXPOSE 8888
