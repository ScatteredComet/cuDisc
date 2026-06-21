Unfortunately, I already have ROCm installed, so I do not know the exact ROCm deps.

# CUDA Instructions
```
cmake -B build_cuda && cmake --build build_cuda -j$(nproc)
```
Idk the rest of the steps as I have not tested this branch on CUDA.

# AMD Instructions
Alter the ROCm path in build_amd.sh (its currently set to `ROCM_PATH:-/opt/rocm-7.1.1`). Then, to hipify (using hipify-perl) and build the hipified files:
```
./build_amd.sh
```
(I think this should recognise your HIP/AMD setup automatically)

If the cmake commands in `./build_amd.sh` fail, fix the issue and run:
```
cmake -B build_hip/build -S . -DUSE_HIP=ON -DROCM_PATH=/opt/rocm-7.1.1 -DHIP_SRC_DIR="${PWD}/build_hip" && cmake --build build_hip/build --parallel $(nproc)
```