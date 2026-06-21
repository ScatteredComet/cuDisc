#!/bin/bash
set -euo pipefail

ROCM_PATH="${ROCM_PATH:-/opt/rocm-7.1.1}"
HIP_DIR="build_hip"

echo "  Hipifying sources into ${HIP_DIR}/"
rm -rf "${HIP_DIR}"

find src/ headers/ \( -name "*.cu" -o -name "*.cpp" -o -name "*.h" \) | while read -r F; do
    OUT="${HIP_DIR}/${F}"
    mkdir -p "$(dirname "$OUT")"
    "${ROCM_PATH}/bin/hipify-perl" "$F" > "$OUT"
done

echo "  Configuring and building"
cmake -B "${HIP_DIR}/build" -S . \
    -DUSE_HIP=ON \
    -DROCM_PATH="${ROCM_PATH}" \
    -DHIP_SRC_DIR="${PWD}/${HIP_DIR}"

cmake --build "${HIP_DIR}/build" --parallel "$(nproc)"