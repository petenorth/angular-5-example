# Steps to set up s2i based build

* `sudo docker pull registry.access.redhat.com/rhscl/nodejs-8-rhel7`
* `sudo docker pull registry.access.redhat.com/rhscl/nginx-112-rhel7`
* `oc new-build registry.access.redhat.com/rhscl/nodejs-8-rhel7~https://github.com/petenorth/angular-5-example.git --name='angular-5-example-s2i'`
* `oc create imagestreamtag nginx-112-rhel7:latest --from-image=registry.access.redhat.com/rhscl/nginx-112-rhel7`
