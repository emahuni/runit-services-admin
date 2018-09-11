# Runit Services Admin

Manage programs you want to run as services on your Unix machine. You can create, start, stop, activate, deactivate, drop a service. You can also set it for auto/manual start and list all installed services. This package was mainly meant to easily administer termux services, but I decided to make it run on any Unix platform that has runit installed.

## Requirements
- Runit program http://www.smarden.org/runit/
- Bash

### Optional
- npm for installation
- git for installation

## Installation

There are two ways to install this package through NPM or using git cloning and running install script. Basically it copies the binaries that you need to run the commands into your `/bin` directory.

#### Using NPM

```sh
npm i -g runit-services-admin
```

This assumes that you have NPM installed, which is installed when you install NodeJs. You can also use Yarn to do the same thing.

#### Using Git

```sh
git clone https://github.com/emahuni/runit-services-admin.git
cd runit-services-admin
sudo ./install
```

This obviously assumes that you have Git installed.

##### 2nd and half way

If you have neither Git nor NPM installed you can do the Git part manually.

- visit 'www.github.com/emahuni/runit-services-admin'
- click on download and this will download the repository as a zip file
- extract the contents of the zip file
- on the terminal do:
   ```sh
cd path/to/where/you/extracted/the/zip/file
sudo ./install
	 ```

That will install the package binaries as explained before.

### Environment
Put environment variable SVDIR in your `~/.bash_profile` file. It points to the services directory: `export SVDIR=$HOME/.sv`. You can use any other directory you want, this is the default.

#### Startup

For the services to automatically startup when you start your terminal or your system add line `svdrun` into your `~/.bash_profile` file.
It will run all active services installed in your $SVDIR directory, therefore this line should be below the above environment setup.


## Uninstalling

Uninstalling is simple

#### Using NPM

```sh
npm un -g runit-services-admin
```

#### Using Git

If you don't have the files you cloned ealier you will have to clone them again then run

```sh
sudo ./uninstall
```

see above where cloning or zip download was done. Do the same for either method under Git, but just replace `sudo ./install` with `sudo ./uninstall`.

### Startup

Remove the lines you inserted into your `~/.bash_profile` file.


## Usage

The package provides the following commands that you can easily manage your services with; type `command --help` for more info about each command.

* **svcreate** *- service create*: creates a service for your program, script etc
* **svdrun** - *services directory/daemon run*: runs all active services in the SVDIR directory and optionally monitor (daemon mode) any new services.
* **svdstop** - *services directory/daemon stop*: stops running services daemon and exit all running services
* **svrun** - *service run*: runs a specific service
* **svstop** - *service stop*: exits a specific service
* **svdrop** - *service drop*: deletes a specific service; optionally backs it up before deletion
* **svact** - *service activate*: activates an inactive service, so that it is runnable
* **svdeact** - *service deactivate*: deactivates an active service, so that it is not runnable
* **svlist** - *services list*: lists all installed services and their modes and statuses
* **svwdown** - *service wants down*: sets a service to go down (stop) on startup, use `sv u service-name` to start running it manually.
* **svwup** - *service wants up*: sets a service to go up (run) on startup

### Example:

```sh
svcreate docs 'http-server /mnt/storage/docs/ -p 8080'
```

- The above example creates a service in `~/.sv` that runs the NodeJs package `http-server`, that is instructed to serve html files in `/mnt/storage/docs/` on `port 8080`.
- If `svdrun -m` is set up in `~/.bash_profile` then the service will begin running immdiately and on startup.
- Else you can use `svrun docs` to begin running the service when required.
- You can use the other commands to manage the service as simple as `svdrop docs` to delete the service.


In addition to the above-mentioned commands you can use the runit `sv` command to control and query installed active services eg: `sv s docs` to see the above-example service status. see `sv --help` for more info. http://www.smarden.org/runit/


## Author

Emmanuel Mahuni

## Github

https://github.com/emahuni/

## License

Emmanuel Mahuni (c) 2018 MIT