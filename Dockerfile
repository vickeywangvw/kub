# Start with a Linux micro-container to keep the image tiny
# FROM alpine:3.7
FROM python:3.8

# Document who is responsible for this image
MAINTAINER Xiaoxuan Wang "xw2098@nyu.edu"

# Install just the Python runtime (no dev)
# RUN apk add --no-cache \
#     python \
#     py-pip \
#     ca-certificates
RUN apt-get update \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

# Expose any ports the app is expecting in the environment
ENV PORT 1234
EXPOSE $PORT

# Set up a working folder and install the pre-reqs
WORKDIR /app
ADD mnist/requirements.txt /app
RUN pip install -r requirements.txt
# RUN pip install --upgrade pip \
    # && pip install torch==1.4.0+cpu torchvision==0.5.0+cpu -f https://download.pytorch.org/whl/torch_stable.html

# Add the code as the last Docker layer because it changes the most
ADD mnist/main.py  /app/main.py

# Run the service
CMD [ "python", "main.py" ]

