Watch image directory and create mirrored folder structure with minified image versions.

# Setup
- copy example_config.sh -> config.sh
- change SOURCE to directory that should be watched for image files
- change TARGET to directory that should countain the minified images
- setup cronjob to start the watchers at startup
  - add file /etc/cron.d/image_watcher
  - add the following line to the created file:
```
@reboot root bash -C PATH_TO_SCRIPT_FOLDER/register_listener.sh
``` 
