# docker-file
use build.sh

# docker command
- docker run -it -d --platform linux/amd64 --name jdk17 registry.cn-hangzhou.aliyuncs.com/z_q/jdk17:latest
- docker exec -it b2456fdff194 bash