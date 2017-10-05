FROM jupyter/base-notebook:latest

ENV deps "curl python3-pip git libtinfo-dev libzmq3-dev libcairo2-dev libpango1.0-dev libmagic-dev libblas-dev liblapack-dev"
ENV PATH=$PATH:$HOME/.local/bin

WORKDIR /app

USER root:root
RUN  apt-get update \
	&& apt-get install --yes $deps\
	&& chmod -R 755 /app\
	&& chown -R jovyan:users /app\
	&& (curl -sSL https://get.haskellstack.org/ | sh)

USER jovyan:users
RUN git clone https://github.com/gibiansky/IHaskell\
	&& cd IHaskell\
	&& stack install --install-ghc cabal-install\
	&& stack init --solver\
	&& stack install gtk2hs-buildtools\
	&& stack install --fast\
	&& ihaskell install --stack

CMD ["stack", "exec", "jupyter", "--", "notebook"]
EXPOSE 8888
