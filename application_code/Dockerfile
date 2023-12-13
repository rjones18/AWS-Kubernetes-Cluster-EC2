FROM rjones21/pythonbaseimage:latest
WORKDIR /myapp
COPY app.py /myapp/app.py
COPY templates/ /myapp/templates
COPY static/ /myapp/static
CMD ["python", "/myapp/app.py"]