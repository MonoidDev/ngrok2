[![Build
status](https://travis-ci.org/traefix/ngrok2.svg)](https://travis-ci.org/traefix/ngrok2)

# ngrok - Introspected tunnels to localhost
### ”I want to expose a local server behind a NAT or firewall to the internet.”
![](https://ngrok.com/static/img/overview.png)

## What is ngrok2?
ngrok2 is a reverse proxy that creates a secure tunnel from a public endpoint to a locally running web service.
ngrok captures and analyzes all traffic over the tunnel for later inspection and replay.

## ngrok2

ngrok2 is a fork of [ngrok 1.x](https://github.com/inconshreveable/ngrok) and the focus of all current development effort.

**NOTE** I like [ngrok 1.x](https://github.com/inconshreveable/ngrok) project but it is no longer developed, supported or maintained by its author, so I fork the project 
to be a new repository to continue develop.

## What is ngrok2 useful for?
- Temporarily sharing a website that is only running on your development machine
- Demoing an app at a hackathon without deploying
- Developing any services which consume webhooks (HTTP callbacks) by allowing you to replay those requests
- Debugging and understanding any web service by inspecting the HTTP traffic
- Running networked services on machines that are firewalled off from the internet
