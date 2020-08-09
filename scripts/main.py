import argparse
import bpy
import logging
import os
import sys

# Add current file path to Python path
path = os.path.dirname(bpy.data.filepath)
if not path in sys.path:
    sys.path.append(path)

# Import custom modules
import utils

# Load default logging configuration
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(name)s - %(levelname)s - %(message)s')
log = logging.getLogger(__name__)


if __name__ == "__main__":
    # Get arguments passed after "--"
    # All of which are ignored by Blender so script may receive its own arguments
    argv = sys.argv
    argv = argv[argv.index('--') + 1:]

    parser = argparse.ArgumentParser(description='Entry point to execute script in Blender.')
    parser.add_argument('-arg1', '--argument1', dest='argument1', type=str, required=False, help='First argument.')
    arguments = parser.parse_args(argv)

    # Delete cube created by default
    utils.delete_cube()

    log.info(f'Hello world!')
    arg1 = arguments.argument1
    log.info(f'This is argument1: {arg1}')