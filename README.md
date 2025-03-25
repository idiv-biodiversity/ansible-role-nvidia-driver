Ansible Role: NVIDIA Driver
===========================

An Ansible role that installs the NVIDIA driver.

Table of Contents
-----------------

<!-- toc -->

- [Requirements](#requirements)
- [Role Variables](#role-variables)
- [Dependencies](#dependencies)
- [Example Playbook](#example-playbook)
  * [Top-Level Playbook](#top-level-playbook)
  * [Role Dependency](#role-dependency)
- [License](#license)
- [Author Information](#author-information)

<!-- tocstop -->

Requirements
------------

- Ansible 2.9

Role Variables
--------------

Whether or not to install the driver:

```yml
nvidia_driver_install: yes
```

NVIDIA driver type, possible other value is **tesla**:

```yml
nvidia_driver_version: 'XFree86'
```

NVIDIA driver version:

```yml
nvidia_driver_version: '387.22'
```

The download directory to which the driver installation package will be
downloaded:

```yml
nvidia_driver_download_dir: '/var/cache/nvidia'
```

Whether to install the `persistenced` service:

```yml
nvidia_driver_persistenced: no
```

Dependencies
------------

```yml
---

# requirements.yml

collections:

  - name: community.general
    version: X.Y.Z

roles:

  - name: idiv_biodiversity.nvidia_driver
    src: https://github.com/idiv-biodiversity/ansible-role-nvidia-driver
    version: vX.Y.Z

...
```

Example Playbook
----------------

### Top-Level Playbook

Write a top-level playbook:

```yml
---

- name: compute nodes
  hosts: compute
  roles:
    - role: idiv_biodiversity.nvidia_driver
      tags:
        - nvidia-driver

...
```

### Role Dependency

Define the role dependency in `meta/main.yml`:

```yml
---

dependencies:

  - role: idiv_biodiversity.nvidia_driver
    tags:
      - nvidia-driver

...
```

License
-------

MIT

Author Information
------------------

This role was created in 2017 by [Christian Krause][author] aka [wookietreiber
at GitHub][wookietreiber], HPC cluster systems administrator at the [German
Centre for Integrative Biodiversity Research (iDiv)][idiv].


[author]: https://www.idiv.de/staff/christian-krause/
[idiv]: https://www.idiv.de/
[wookietreiber]: https://github.com/wookietreiber
