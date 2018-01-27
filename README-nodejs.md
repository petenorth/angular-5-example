Angular 5 Example deployed to Webpack Dev Server 
================================================

The Angular CLI command `ng serve` is the entry point to running Angular 5 applications for most developers. Behind the scenes this
starts a Webpack Dev Server instance which is a nodejs web server application. 

It is not intended to be used in production environments:

* https://angular.io/guide/deployment#build-vs-serve
* https://github.com/angular/angular-cli/issues/5274

The purpose of this read me is to describe how to deploy the app to Openshift in way which matches how a developer runs their Angular 5 application.
This then will allow the reader to compare and contrast start up behaviour of the web server and the performance characteristics within the browser 
compared with the version of the applicaiton served from a Nginx web server.

Deployment
----------

To deploy this application via a nodejs 8 s2i image process use the following command

oc new-app . --docker-image=registry.access.redhat.com/rhscl/nodejs-8-rhel7  --name=angular-5-example-nodejs

Comparisons
-----------

* compilation of bundles
* polyfills compilation in browser
* bundle download size
