# Changelog

### 0.12.8-wip.1
- :arrow_up: Bumped and updated usage of zazo-tools gem
- :arrow_up: Updated wercker build configuration

### 0.12.8
- :arrow_up: Refactored `VerifiedAfterNthNotification` metrics (by 5 times more effective)

### 0.12.7
- :hammer: Fixed batch size for `VerifiedAfterNthNotification` metric

### 0.12.6
- :hammer: Fixed `VerifiedAfterNthNotification` metric finally

### 0.12.5
- :up: Add gems for productive development
- :hammer: Fixed `VerifiedAfterNthNotification` metric
- :hammer: Fixed wercker build configuration

### 0.12.4
- :hammer: Fixed environment variables cron config

### 0.12.3
- :arrow_up: Updated `zazo_tools` library
- :hammer: Fixed application link for sms messages

### 0.12.2
- :bulb: Added Zazo::Tools::Logger for logging
- :bulb: Added newrelic TraceWrapper for cron workers
- :arrow_up: Updated newrelic configuration 
- :arrow_up: Updated Dockerfile to use updated base image

### 0.12.1
- :hammer: Fixed docker image

### 0.12.0
- :bulb: Added pagination for messages
- :hammer: Fixed queries to get only recent users

### 0.11.1
- :hammer: Added missed env vars to cron

### 0.11.0
- :bulb: Use DataProvider instead of Statistics/SqsWorker
- :hammer: Fixed docker image and wercker config

### 0.10.3
- :hammer: Fixed bug with localized templates
