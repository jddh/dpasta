A **dev-environment** approach for using the offical Drupal Docker images with both local and installed dependencies, and little tooling.

## Background
[Offical Drupal Docker](https://hub.docker.com/_/drupal/) (oDD) images aren't terribly popular. The consumer choice tends to be third party images or frameworks like Lando, all of which are fairly opinionated about root/non-root, bootstrapping, persistance. The oDD images make few assumptions, but they currently (Autumn 2023) also keep Drupal 7 in the mix, with a few older point releases kicking around.

The easiest way to persist an install using these images is to bind mount the entry points for contributed projects, namely `modules/`and `themes/`. But to do so potentially introduces complications with dependancies, because `vendors/` is typically not persisted.

And while one could just bind mount a whole local Drupal install, not only does a Drupal Docker image  become superflulous, but when it's time to upgrade, one must replace core themselves, or fight with Composer. Ideally we would use Docker images precisely so that we can upgrade core by grabbing a new image tag. And if we do so, it may be wise to use the composer.json that reflects the current installation (since we're not upgrading directly with Composer).

Another way of putting it: I like to use Docker to allow me use Composer without ever using `composer`.

So this module is for those who want to
- use oDD images
- manually add some modules
- install some modules/deps via Composer
- be able to upgrade Drupal using oDD images
- and so leave composer.json inside the image

## Installation
1. Specify what version tag of Drupal you wish to use in the `drupal` services `image:`
2. Change your `network:` values if you wish to use your own infrastructure
3. Create your DB volume before first run
4. Install your local modules and themes to `./modules` and `./themes `
5. For packages to be managed by Composer, `./install/packages.txt` is a return-separated list of packages, eg. `drupal/admin_toolbar:^3.4` (*why not JSON?* so that the containers don't require extra tools)
6. `docker compose up` and away you go
7. After initial installation, copy out your `settings.php` from the container and uncomment the last line of the `volumes:` for the `drupal` service to bind mount the settings file for future use

## Adding dependancies later
`composer install` is run after the container mounts, so adding to `./install/packages.txt` and `docker compose restart` will do the trick

## Options
If you would prefer to maintain your own composer.json, there are some comments avaiable in `./install/install.sh`