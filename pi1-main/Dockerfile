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
RUN apt-get -qy install vim git openjdk-17-jdk gcc clang nasm \
	netcat-traditional libcairo2-dev pkg-config libgirepository1.0-dev \
	libgirepository-2.0-dev gcc libcairo2-dev pkg-config python3-dev \
	gir1.2-gtk-4.0 texlive-extra-utils

#make sure folder permissions work under mac
RUN chown -R jovyan /home/jovyan

# Install Jupyter kernels
USER jovyan
WORKDIR /home/jovyan
RUN mkdir /home/jovyan/local
RUN fix-permissions "${CONDA_DIR}" \
	&& fix-permissions "/home/jovyan" \
	&& fix-permissions "/home/jovyan/local"

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


# Install Python packages
RUN pip3 install --no-cache-dir ipywidgets ipympl 'apache-beam[gcp]' \
	mysql-connector-python pyarrow pandas pymongo jupytext nodejs \
	PyGObject pycairo pkgconfig psutil black cairocffi graphviz \
	importmagic matplotlib numpy pandas \
	pyparsing python-crfsuite python-mnist mnist1d scikit-learn \
	scikit-optimize scipy sortedcontainers tabulate nbgitpuller torch \
	torchvision torchaudio torchviz torchtext lightning \
	tensorboard --extra-index-url https://download.pytorch.org/whl/cpu

# JupyText Config
RUN jupytext-config set-default-viewer python

# Setup shared directory
RUN mkdir /home/jovyan/shared

# Fix any problematic folder permissions and start Jupyterlab in home directory
USER root
RUN chown -R jovyan /home/jovyan
USER jovyan
WORKDIR /home/jovyan/shared
EXPOSE 8888
