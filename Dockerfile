#FROM python:3.8-slim-buster
#
#WORKDIR /EmotionRec
#
#COPY requirements.txt requirements.txt
#
#RUN pip install -r requirements.txt
#
#COPY . .
#
#CMD [ "python3", "./app.py"]


FROM continuumio/miniconda3

WORKDIR /app

# Create the environment:
#COPY environment.yml .
RUN conda env create -f environment.yml

# Make RUN commands use the new environment:
SHELL ["conda", "run", "-n", "myenv", "/bin/bash", "-c"]

# Make sure the environment is activated:
RUN echo "Make sure flask is installed:"
RUN python -c "import flask"

# The code to run when container is started:
COPY run.py .
ENTRYPOINT ["conda", "run", "--no-capture-output", "-n", "myenv", "python", "run.py"]