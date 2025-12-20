# docker-file
use build.sh

# docker command
- docker run -it -d --platform linux/amd64 --name jdk17 registry.cn-hangzhou.aliyuncs.com/z_q/jdk17:latest
- docker exec -it b2456fdff194 bash
- docker tag docker.1ms.run/library/debian:latest registry.cn-hangzhou.aliyuncs.com/z_q/debian:13
- docker push registry.cn-hangzhou.aliyuncs.com/z_q/debian:13
```
# 首先，创建一个用于存放日志的宿主机目录
sudo mkdir -p /var/log/myapp

# 运行容器，并将宿主机的日志目录挂载到容器日志的“父目录”
# 注意：这里挂载的是容器内部日志文件所在目录的上一级
docker run -d \
  --name my-java-app \
  -v /var/log/myapp:/var/lib/docker/containers \
  your-java-image:tag
```