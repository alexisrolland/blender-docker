# Blender in Docker

This repository can be used as a simple template to build Blender services in Docker.

## Build

Build Docker image.

```shell
docker-compose build blender
```

Blender version can be updated in the `.env` file if needed.

```txt
[blender]
# Blender packages are available at https://download.blender.org/release
# Use .tar.xz packages for this Docker image
blender_package_name=blender-2.83.2-linux64
blender_package_url=https://download.blender.org/release/Blender2.83/blender-2.83.2-linux64.tar.xz
blender_path=/usr/local/blender
blender_python_path=/usr/local/blender/2.83/python/bin
```

## Python Script

The `script` service is just a dummy Python script printing `Hello world!`.

```shell
docker-compose run script
```

## Render Animation

The `render` service creates `.png` files for every frame of the animation.

* Place `.blend` file in the `./input` folder
* Update `render_input_file` parameter in `.env` file
* `.png` files are created in the `./output` folder

```shell
docker-compose run render
```

## Testing

Connect to the Docker container in interactive mode to test different command lines arguments. Do not forget to replace `your_path` parameter below.

```shell
# Run Docker container on Linux
docker run -it --rm --volume /your_path/blender-docker/input:/tmp/input --volume /your_path/blender-docker/output:/tmp/output --volume /your_path/blender-docker/scripts:/usr/local/blender/2.83/scripts/addons/ubisoft blender sh

# Run Docker container on Windows Pro
docker run -it --rm --volume C:\your_path\blender-docker\input:/tmp/input --volume C:\your_path\blender-docker\output:/tmp/output --volume C:\your_path\blender-docker\scripts:/usr/local/blender/2.83/scripts/addons/ubisoft blender sh

# Run Docker container on Windows Home
docker run -it --rm --volume /c/your_path/blender-docker/input:/tmp/input --volume /c/your_path/blender-docker/output:/tmp/output --volume /c/your_path/blender-docker/scripts:/usr/local/blender/2.83/scripts/addons/ubisoft blender sh
```

Manually execute commands for testing.

```shell
# Render first frame with EEVEE engine
/usr/local/blender/blender --background /tmp/input/bouncing_ball.blend -noaudio --render-output /tmp/output/frame_##### --render-format PNG --engine BLENDER_EEVEE --render-frame 1

# Render first frame with Cycles engine
/usr/local/blender/blender --background /tmp/input/bouncing_ball.blend -noaudio --render-output /tmp/output/frame_##### --render-format PNG --engine CYCLES --render-frame 1

# Execute Python script
/usr/local/blender/blender --background -noaudio --python /usr/local/blender/2.83/scripts/addons/ubisoft/main.py -- --argument1 "Some dummy argument value"
```

## Blender Documentation

For additional information on Blender's command line arguments and options, visit [Blender Documentation](https://docs.blender.org/manual/en/dev/advanced/command_line/index.html).
