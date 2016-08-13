# Rasploy

### Deployment scripts

## Setting up

```
git clone https://github.com/ryskov/rasploy
sudo crontab -e
```
add the following cron job
```
* * * * * chmod +x [PATH_TO_RASPLOY]/scripts/run.sh && PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/games:/usr/games /bin/bash [PATH_TO_RASPLOY]/scripts/run.sh >> /var/log/rasploy.log
```
Remember to change the [PATH_TO_RASPLOY] to the path of where this repository was cloned. 

## Adding a new project

To add a new project, simply append the git-repo url to the `/etc/projecs` file.
```
echo "https://github.com/ryskov/testdeploy" >> /etc/projects
```
Now the project will be synced each minute, if any change is detected in the remote 'deploy' branch. 