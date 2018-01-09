# Steps to set up s2i based build

Basically this uses a chained s2i image build (https://docs.openshift.com/container-platform/3.7/dev_guide/builds/advanced_build_operations.html#dev-guide-chaining-builds) . It initially creates a s2i build using the nodejs-8-rhel7 image with a custom assemble script which adds a ng build step. Then the resulting dist folder contents within this image are copied into (along with some config files) an nginx image.

* `sudo docker pull registry.access.redhat.com/rhscl/nodejs-8-rhel7`
* `sudo docker pull registry.access.redhat.com/rhscl/nginx-112-rhel7`
* `oc new-build registry.access.redhat.com/rhscl/nodejs-8-rhel7~https://github.com/petenorth/angular-5-example.git --name='angular-5-example-s2i'`
* `oc create imagestream angular-5-example-nginx`
* `oc create -f openshift/chained-s2i.yml`
