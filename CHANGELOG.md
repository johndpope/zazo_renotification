# Changelog

### next release
- :hammer: Fixed `VerifiedAfterNthNotification` metric

### v0.12.4
- :hammer: Fixed environment variables cron config

### v0.12.3
- :arrow_up: Updated `zazo_tools` library
- :hammer: Fixed application link for sms messages

### v0.12.2
- :bulb: Added Zazo::Tools::Logger for logging
- :bulb: Added newrelic TraceWrapper for cron workers
- :arrow_up: Updated newrelic configuration 
- :arrow_up: Updated Dockerfile to use updated base image

### v0.12.1
- :hammer: Fixed docker image

### v0.12.0
- :bulb: Added pagination for messages
- :hammer: Fixed queries to get only recent users

### v0.11.1
- :hammer: Added missed env vars to cron

### v0.11.0
- :bulb: Use DataProvider instead of Statistics/SqsWorker
- :hammer: Fixed docker image and wercker config

### v0.10.3
- :hammer: Fixed bug with localized templates
