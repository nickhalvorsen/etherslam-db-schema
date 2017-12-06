#!/bin/bash

sudo -u etherslam pg_dump --schema-only etherslam > etherslam.pgsql
