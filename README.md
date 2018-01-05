# Angular Example with Deployment to Openshift

This project takes the output of ng create angular-example and adds the necessary software artifacts that enable a production grade deployment to Openshift. The container image deployed to Openshift is the output of the ng build command copied into a base Nginx image.

## Prerequisites

### Access to an Openshift 3.7 environment

Locally this is easiest to achieve using Minishift

https://access.redhat.com/documentation/en-us/red_hat_container_development_kit/3.2/html/getting_started_guide/

IMPORTANT - the minishift instance must be started using version 3.7 (the default is 3.6) of the Openshift Container Platform i.e. the commands that I used were

     minishift setup-cdk
     curl -O https://mirror.openshift.com/pub/openshift-v3/clients/3.7.9/linux/oc.tar.gz
     tar -zxvf oc.tar.gz
     cp oc ~/.minishift/cache/oc/v3.6.173.0.21
     minishift start --ocp-tag v3.7.9
     
### Angular CLI (only if further development of the application will occur)

The majority of the code here is the output of 

    ng create angular-example
   
Normally in development locally you'd use ng serve which is a non-production grade webserver which compiles angular source code on the fly. See

https://cli.angular.io/

and to understand production deployments see

https://angular.io/guide/deployment

## Deployment

### Create the pipeline (and Jenkins instance)

Create the Jenkins pipeline definition in Openshift

    oc create -f openshift/pipeline.yml
    
This will trigger the deployment of a Jenkins instance, wait until the resulting Jenkins pod is ready. Then access Jenkins via web browser using the URL of the route. The `ng build` command requires nodejs 6.9 or this means that we cannot use the default nodejs Jenkins slave provided with Openshift. 

### Add NodeJS 8 Jenkins slave

To address this I have created a separate project I have created a nodejs 8 based slave image for use in Openshift

https://github.com/petenorth/nodejs8-openshift-slave

The resulting image is available in docker hub

https://hub.docker.com/r/petenorth/nodejs8-openshift-slave/

This needs to needs to be setup as a kubernetes pod template. Navigate within Jenkins to '> Home > Manage Jenkins > Configure System' . Then right at the bottom there should be a button 'Add a new cloud', when pressed one of the options should be 'Kubernetes Pod Template'. Fill in the resulting fields in the same way as the existing maven and nodejs kubernetes pod templates apart from 

* 'name' should be nodejs8
* 'label' should be nodejs8

You then need to add the container definition (click on the 'Add Container')

* 'Docker Image' should be docker.io/petenorth/nodejs8-openshift-slave
* fill in everything else identically to the maven and nodejs container fields.

Finally click on 'Advanced ...' button of the Kubernetes Pod Template (not the container advanced options) and make sure the Service Account is set to jenkins . 

### Create binary build configuration 

We now need a binary build configuration to build the Nginx based image container that will serve the angular application

    oc new-build .
    
NOTE the first build will fail because it is a binary build and binary input hasn't been provided.

### Start the pipeline

Now we are ready for our first build of the pipeline

    oc start-build angular-example-pipeline
    
### Create application

The pipeline as it stand only builds an image, it does not deploy etc. We create the application via a resource definition

  oc create -f application.yml

Then access the application via the resulting route. It should display a welcome page with the Angular logo.

## TODO

See project issues.
