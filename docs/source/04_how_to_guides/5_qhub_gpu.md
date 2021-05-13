# GPUs on QHub

Having access to  GPUs is of prime importance for speeding up many computations
by several orders of magnitude. QHub provides a way to achieve that, we will go
through achieving that for each Cloud provider.

## Google Cloud Platform

### Pre-requisites

By default the quota to spin up GPUs on GCP is 0. Make sure you have requested
GCP Support to increase quota of allowed GPUs for your billing account to be the
number of GPUs you need access to.

Here are the steps you need to follow to get GPUs working with GCP:


#### 1. Add NVIDIA libraries to PATH in the JupyterLab docker image.

Add the following in `image/Dockerfile.jupyterlab`

```bash
# ========== GPU Paths ============
ENV PATH=/usr/local/nvidia/bin:$PATH
ENV LD_LIBRARY_PATH=/usr/local/nvidia/lib64
```

#### 2. Add GPU node group in `qhub-config.yml` file

Add a node group for GPU instance in the `node_groups` section of `google_cloud_platform` section,
and under the `guest_accelerators` section add the name of the GPU. A comprehensive list of GPU
types can be found in at the Official GCP docs here: https://cloud.google.com/compute/docs/gpus

An example of getting GPUs on GCP:

```yml
google_cloud_platform:
  project: project-name
  region: us-central1
  zone: us-central1-c
  availability_zones:
  - us-central1-c
  kubernetes_version: 1.18.16-gke.502
  node_groups:
    # ....
    gpu-tesla-t4:
      instance: "n1-standard-8"     # 8 vCPUs, 30 GB: Skylake, Broadwell, Haswell, Sandy Bridge, and Ivy Bridge
      min_nodes: 0
      max_nodes: 5
      guest_accelerators:
        - name: nvidia-tesla-k80    # 12 GB GDDR5: Nividia Tesla K80
          count: 1

```

## DigitalOcean

DigitalOcean does not support GPUs at the time of writing this.
