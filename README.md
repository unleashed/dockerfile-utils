# dockerfile-utils - Util scripts for Dockerfiles

Currently the following tasks are supported:

## Git
* Cloning a git repository.
* Checking out the latest version by tag or a specific one.
* Keeping the repository and submodules updated.

## Rbenv
* Ensuring the proper ruby version with updated rubygems is available
* Adding bundler and installing dependencies for a project
* Actually running a Ruby app with the above solved

## Build
* Building autoconf-style sources
* Downloading and building from a git repo

## Apt
* Small wrapper to install deb packages non-interactively

# Building / Installing

You must generate a `configure` script to build this project, for which you will
need automake and autoconf.

```shell
./autogen.sh
./configure --prefix=${TARGET_PREFIX}
make install
```
# LICENSE

dockerfile-utils - Copyright (c) 2016 Alejandro Martinez Ruiz - alex at flawedcode org

See the accompanying `COPYING` file.

```
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
```