# Google Cloud Starter: App Engine Flexible Environment with custom runtime

This is a starter project for [Google Cloud App Engine Flexible Environment](https://cloud.google.com/appengine/docs/flexible) with [custom runtime](https://cloud.google.com/appengine/docs/flexible/custom-runtimes) based on nodejs maintained by the [Node.js Docker Team](https://github.com/nodejs/docker-node). It is implemented in JavaScript and provides a basic http service with [cors](https://github.com/expressjs/cors), linting, unit tests, system tests and logging.

## Prerequisites

1. Before you can start coding, make sure that [gcloud](https://cloud.google.com/sdk/docs/install) is installed.

1. This starter also requires [Node.js](https://nodejs.org/en/download/).

1. [Docker](https://docs.docker.com/get-docker/) is optional.

1. Fork this template project.

If you already have installed the prerequisites, then you're all set.

## Rename project, version and service

1. Open the file _package.json_ and modify the _name_ and _version_.

1. Edit _config.service_ in _package.json_ and _service_ in _app.yaml_ to change the service name.

1. Modify _engines.nodes_ in _package.json_ and replace all entries of _gcr.io/cloud-builders/npm:node-X.X.X_ in _cloudbuild.yaml_ with your required node version. Also update _runtime_ in _app.yaml_ accordingly.

1. Run `npm install` to apply the changes and update _package-lock.json_.

## Install and run locally

1. Install package and its dependencies:

        npm install

1. Run eslint:

        npm run lint

1. Run unit tests:

        npm test

1. Start local instance:

        npm start

1. Open browser and navigate to http://localhost:8080/ or http://localhost:8080/gcp to invoke the service.

Optional steps to build and run Docker image on local system:

1. Build Docker image with Cloud Build Local (requires Docker):

        npm run build:local

1. Run Docker image:

        docker -p 8080:8080 [IMAGE]

    **Note:** Replace `[IMAGE]` with name of the image. List images with `docker image ls`.

## Prepare deployment

1. [Billing](https://cloud.google.com/appengine/docs/standard/nodejs/console#billing) must be enabled.

1. Configure project for gcloud:

        gcloud config set project [PROJECT_ID]

    **Note:** Replace `[PROJECT_ID]` with the Google Cloud project id.

1. The build process depends on Cloud Build. Please enable the [Cloud Build API](https://console.cloud.google.com/marketplace/product/google/cloudbuild.googleapis.com).

1. The service account of Cloud Build requires access to _App Engine_ and _Service Accounts_. Open [Cloud Build Settings](https://console.cloud.google.com/cloud-build/settings/service-account) to set the required permissions. Please also follow the instructions of the additional steps and enable the [App Engine Admin API](https://console.cloud.google.com/apis/library/appengine.googleapis.com).

1. Enable [App Engine Flexible Environment](https://console.cloud.google.com/marketplace/product/google/appengineflex.googleapis.com).

1. Create an App Engine application

        gcloud app create

    **Note:** Choose an [App Engine location](https://cloud.google.com/appengine/docs/locations) based on our requirements.

## Deploy to Google Cloud

1. Submit a build to Cloud Build, which creates the Docker image and uploads it to the [Container Registry](https://console.cloud.google.com/gcr):

        npm run build

1. Deploy the application:

        npm run deploy

    Or you can deploy a promoted version to receive all traffic immediately:

        npm run deploy:promote

1. If required, start the deployed version:

        gcloud app versions start [VERSION_ID]

    **Note:** Replace `[VERSION_ID]` with the version of the service.

1. Run system test:

        export BASE_URL="[BASE_URL]"
        npm run test:system

    **Note:** Replace `[BASE_URL]` with the target url to the App Engine service, e.g. https://VERSION_ID-dot-SERVICE_ID-dot-PROJECT_ID.REGION_ID.r.appspot.com or https://PROJECT_ID.REGION_ID.r.appspot.com.

1. Configure traffic to a version:

        npm run split -- --splits='[VERSION_ID]=1'

    Or split the traffic across two (or more) versions:

        npm run split -- --splits='[VERSION_ID_1]=.5,[VERSION_ID_2]=.5'

    **Note:** Replace `[VERSION_ID]` or `[VERSION_ID_X]` with the version of the service. If you are unsure, than list your existing versions: `gcloud app versions list`. Also consider to [manage versions](https://console.cloud.google.com/appengine/versions) with Cloud Console.

1. Open service in browser: https://VERSION_ID-dot-SERVICE_ID-dot-PROJECT_ID.REGION_ID.r.appspot.com or https://PROJECT_ID.REGION_ID.r.appspot.com. Alternatively use the following command:

        gcloud app browse

## Build automation

Test, build and deploy the application as part of your automated pipeline:

        npm run cicd

## Logging

By default, _info_ level messages are logged. Add or modify the envrionment variable APP_LOG_LEVEL in app.yaml to change the logging level. The default logName is "projects/[PROJECT_ID]/logs/[PACKAGE_JSON_NAME]_log".
This starter uses [winston](https://github.com/winstonjs/winston) as logging library. Please read more about how to
write log entries and about all possible logging levels on the project website.

## Troubleshooting

1. If your run into issues during build or deployment , append _-- --verbosity debug_ to the command:

        npm run build -- --verbosity debug

1. Open the [Cloud Build history](https://console.cloud.google.com/cloud-build/builds) and view the logs of the failed builds.

1. Review Cloud Build service account permissions and assigned [roles that grant access to App Engine](https://cloud.google.com/appengine/docs/flexible/nodejs/roles).

## License
Distributed under the MIT License. See LICENSE for more information.
