# This is where common definitions go

#cuda setup
CUDA_DIR   = /usr/local/cuda/

#Thrust 1.7.1 or higher
THRUST_DIR = /usr/local/cuda/include/

# dedisp setup
DEDISP_DIR = /home/psr/dedisp

GCC       = gcc
GXX       = g++
AR        = ar
NVCC      = $(CUDA_DIR)/bin/nvcc
SHELL     = /bin/bash
UCFLAGS   = -DUSE_NVTX
