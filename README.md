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

- Ansible 2.4+
- **RedHat**-based distribution

**Help Wanted:** Contributions for **Debian**-based distributions are highly welcome pull requests!

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

The download directory to which the driver installation package will be downloaded:

```yml
nvidia_driver_download_dir: '/var/cache/nvidia'
```

Whether or not to remove the `gcc` package after installation:

```yml
nvidia_driver_build_remove_gcc: no
```

Dependencies
------------

None.

Example Playbook
----------------

Add to `requirements.yml`:

```yml
---

- src: idiv-biodiversity.nvidia-driver

...
```

Download:

```console
$ ansible-galaxy install -r requirements.yml
```

### Top-Level Playbook

Write a top-level playbook:

```yml
---

- name: compute nodes
  hosts: compute
  roles:
    - role: idiv-biodiversity.nvidia-driver
      tags:
        - nvidia-driver

...
```

### Role Dependency

Define the role dependency in `meta/main.yml`:

```yml
---

dependencies:

  - role: idiv-biodiversity.nvidia-driver
    tags:
      - nvidia-driver

...
```

License
-------

MIT

Author Information
------------------

This role was created in 2017 by [Christian Krause][author] aka [wookietreiber at GitHub][wookietreiber], HPC cluster systems administrator at the [German Centre for Integrative Biodiversity Research (iDiv)][idiv].


[author]: https://www.idiv.de/groups_and_people/employees/details/eshow/krause-christian.html
[idiv]: https://www.idiv.de/
[wookietreiber]: https://github.com/wookietreiber
