forked from RPi-Distro/pi-gen

# delta 5 raspberry pi images

Use the builds located on github

[releases](https://github.com/spuder/pi-gen/releases)

Or if you want to build your own image.

1. Install [Docker](https://www.docker.com/)
1. Install [cynwin](https://www.cygwin.com/) or [bash for windows](https://docs.microsoft.com/en-us/windows/wsl/install-win10)
1. start an apt cache to speed up builds `docker-compose up -d` then check the config file, if no apt cache specified run `echo 'APT_PROXY=http://172.17.0.1:3142' >> config`
1. run `./build-docker.sh` in a terminal
1. Wait 30 minutes, a new .img file will appear in your local directory

Once you have the .img file, use a tool like [etcher](https://etcher.io) to copy it to the SD card for the raspberry pi. 

Plugin a network cable to the raspberry pi and navigate to [http://delta5.local](https://delta5.local) (If that doesn't work make sure you have bonjour installed.(comes with itunes or install stand alone) )
Login with creds 'admin' and password 'delta5'

You can also ssh with creds 'pi' and password 'raspberry'
