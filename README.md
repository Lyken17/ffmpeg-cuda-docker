# FFmpeg-cuda-docker
This a a docker container to launch GPU accelerated FFmpeg.

Scripts partially referenced from 
* https://github.com/romansavrulin/ffmpeg-cuda-docker

## Build by your own

`docker build -t ffmpeg .`

Load from docker hub (ongoing).

## Run examples

```
docker run --rm -it --gpus all \
    -e NVIDIA_VISIBLE_DEVICES=all \
    -e NVIDIA_DRIVER_CAPABILITIES=compute,utility,video \
    --volume $PWD:/workspace \
    ffmpeg \
        -hwaccel_device 0 \
        -hwaccel cuvid \
        -i input.mp4 \
        -c:v hevc_nvenc \
        out.mp4 -y
```

```
sudo docker run --rm -it --gpus all \
    -e NVIDIA_VISIBLE_DEVICES=all \
    -e NVIDIA_DRIVER_CAPABILITIES=compute,utility,video \
    --volume $PWD:/workspace \
    # using gpu
    ffmpeg -hwaccel cuda -hwaccel_output_format cuda -i input.mp4 -c:v hevc_nvenc -b:v 5M output.mp4 -y
    
    # using cpu
    ffmpeg -i input.mp4 -c:a copy -c:v h264 -b:v 5M output.mp4 -y
 ```
