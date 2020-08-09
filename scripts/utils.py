import bpy
import logging
import os

# Load default logging configuration
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(name)s - %(levelname)s - %(message)s')
log = logging.getLogger(__name__)


def delete_cube():
    """Delete cube created by default."""

    # bpy.data.objects.remove(bpy.data.objects['Cube'], do_unlink=True)
    if 'Cube' in bpy.data.meshes:
        mesh = bpy.data.meshes["Cube"]
        log.info('Remove default Cube mesh')
        bpy.data.meshes.remove(mesh)
