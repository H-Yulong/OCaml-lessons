FROM ocaml/opam:ubuntu-20.04-opam

RUN sudo apt-get update && sudo apt-get install -y python3-pip libgmp-dev perl pkg-config libcairo2-dev libzmq3-dev m4
RUN pip3 install jupyter

ENV PATH=$PATH:/home/opam/.local/bin
RUN opam init --yes
RUN opam switch create 4.14.1
RUN opam install -y jupyter
RUN opam exec -- ocaml-jupyter-opam-genspec
RUN jupyter kernelspec install --name ocaml-jupyter "$(opam config var share)/jupyter" --user

RUN mkdir /home/opam/full
RUN mkdir /home/opam/empty
ADD 01_List_basic.ipynb /home/opam/full/
ADD 02_List_advanced.ipynb /home/opam/full/
ADD 03_Trees_and_calculator.ipynb /home/opam/full/
ADD 04_2D_grid.ipynb /home/opam/full/
ADD 05_Finite_state_automata.ipynb /home/opam/full/
ADD 06_Markov_chains.ipynb /home/opam/full/
ADD 07_Language_interpreter.ipynb /home/opam/full/
ADD 08_Sequence.ipynb /home/opam/full/

ADD empty/01_List_basic.ipynb /home/opam/empty/
ADD empty/02_List_advanced.ipynb /home/opam/empty/
ADD empty/03_Trees_and_calculator.ipynb /home/opam/empty/
ADD empty/04_2D_grid.ipynb /home/opam/empty/
ADD empty/05_Finite_state_automata.ipynb /home/opam/empty/
ADD empty/06_Markov_chains.ipynb /home/opam/empty/
ADD empty/07_Language_interpreter.ipynb /home/opam/empty/
ADD empty/08_Sequence.ipynb /home/opam/empty

RUN yes | jupyter kernelspec uninstall python3 
