FROM ocaml/opam:ubuntu-20.04-opam

RUN sudo apt-get update && sudo apt-get install -y python3-pip libgmp-dev perl pkg-config libcairo2-dev libzmq3-dev m4
RUN pip3 install jupyter

ENV PATH $PATH:/home/opam/.local/bin
RUN opam init --yes
RUN opam switch create 4.14.1
RUN opam install -y jupyter
RUN opam exec -- ocaml-jupyter-opam-genspec
RUN jupyter kernelspec install --name ocaml-jupyter "$(opam config var share)/jupyter" --user

RUN mkdir /home/opam/notebooks
ADD session1.ipynb /home/opam/notebooks/
ADD session1_empty.ipynb /home/opam/notebooks/
ADD session2.ipynb /home/opam/notebooks/
ADD session2_empty.ipynb /home/opam/notebooks/
ADD session3.ipynb /home/opam/notebooks/
ADD session3_empty.ipynb /home/opam/notebooks/

RUN yes | jupyter kernelspec uninstall python3 
