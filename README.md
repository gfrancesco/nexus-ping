# Nexus-Ping

That damn Nexus [N] is out of stock in UK. Get a mail a minute later is back to stock. Need cron and UK based hosting.


## TL;DR

1. Update your credentials and preferences in ``config/user_pref.yml``
2. ``bundle install``
3. ``bundle exec bin/nexus-ping``


## Configuration

Create a new file under ``config/`` named ``user_pref.yml``. You can start from ``config/user_pref.yml.example`` or copy paste these lines and update values with your preferences.

```yaml
# pretty self-explanatory
EMAIL_TO_NOTIFY: "your_email"

# Gmail credential used to send the mail
GMAIL_USER: "gmail_username"
GMAIL_PASSWORD: "gmail_password"

# Devices to observe, a mail will be sent for each one marked with "observed"
NEXUS_4_8G: "not observed"
NEXUS_4_16G: "observed"
NEXUS_7_16G: "observed"
NEXUS_7_32G: "not observed"
NEXUS_7_32G_3G: "not observed"
NEXUS_10_16G: "not observed"
NEXUS_10_32G: "observed"
```

Gmail account is used as SMTP server to send notification mails.


## Crontab

This is a sample cronjob to schedule the script via crontab.

```
*/30 7-21 * * * PATH=$PATH:/usr/local/rbenv/shims && cd /path/to/nexus-ping/current && bundle exec bin/nexus-ping
```

Nexus-ping is launched every 30 minutes between 7am and 9pm, first instruction loads [rbenv](https://github.com/sstephenson/rbenv) shims in ``$PATH``, since cronjobs don't run on interactive shells.
Change shims path according to your rbenv install.

Put the cronjob in a file named ``cron`` under ``config/`` and you'll be able to manage script start/stop with Capistrano.


## Capistrano

Three custom [Capistrano](https://github.com/capistrano/capistrano) tasks are included:

1. ``deploy:conf_copy``: copies ``config/cron`` cronjob and ``config/user_pref.yml`` on server
2. ``cron:set``: sets user crontab reading from server ``config/cron`` cronjob file, this is intended to start the scheduled polling
3. ``cron:remove``: WARNING! removes all cronjob from user crontab, which stops script polling

You'll need to update ``config/deploy.rb`` with your server details (IP, deploy_path, rbenv conf)