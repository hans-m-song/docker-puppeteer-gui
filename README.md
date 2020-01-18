# Setup

## Linux

<!-- run `xauth.sh` to generate xauthority for docker -->
`xhost +local` to allow local connections (and docker) to access display (don't forget to run `xhost -local` to disallow connections again)
`docker-compose up puppeteer`

## MacOS

`brew cask install xquartz`
`brew install socat`
`socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\"`
`DISPLAY=$(ifconfig en0 | grep inet | awk '{print $2}'):0`
`docker-compose up puppeteer`