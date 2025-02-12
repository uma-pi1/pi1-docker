FROM jupyter/minimal-notebook:notebook-6.4.12
# Inspect the Dockerfile at:
# https://github.com/jupyter/docker-stacks/tree/HEAD/minimal-notebook/Dockerfile
# C kernel Jupyter from: https://github.com/brendan-rius/jupyter-c-kernel

# install additional packages
USER root
RUN sudo apt update && apt -y install pkg-config libcairo2-dev gcc libgirepository1.0-dev git

# Add permanent mamba/pip/conda installs, data files, other user libs here

RUN pip3 install --no-cache-dir pkgconfig psutil black cairocffi graphviz importmagic matplotlib numpy pandas PyGObject pyparsing python-crfsuite python-mnist pystan scikit-learn scikit-optimize scipy sortedcontainers tabulate torch nbgitpuller
RUN pip3 install --no-cache-dir torch torchvision torchaudio torchviz --extra-index-url https://download.pytorch.org/whl/cpu
RUN pip install ipympl
RUN pip install nodejs
RUN pip install torchtext lightning tensorboard
RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager
RUN jupyter labextension install jupyter-matplotlib

# add C kernel to jupyter
WORKDIR /tmp

COPY ./ jupyter_c_kernel/

RUN pip install --no-cache-dir jupyter_c_kernel/
RUN cd jupyter_c_kernel && install_c_kernel --user

WORKDIR /home/$NB_USER/

EXPOSE 8888

USER jovyan 
