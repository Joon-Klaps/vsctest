#! /usr/bin/env python3

import tensorflow as tf
import sys

def main():

    # List all available physical devices
    print("Physical devices:")
    print(tf.config.list_physical_devices())

    # List specifically GPU devices
    print("\nGPU devices:")
    print(tf.config.list_physical_devices('GPU'))

    # Get detailed device information
    print("\nDevice details:")
    for device in tf.config.list_physical_devices():
        print(device)

if __name__ == "__main__":
    sys.exit(main())
