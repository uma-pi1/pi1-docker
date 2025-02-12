#!/bin/sh

# Adjust permissions of the mounted volume for notebooks 
sudo chown -R 1000:1000 ./shared
sudo chmod -R 777 ./shared

# chmod -R 755 examples
