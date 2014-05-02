#
# jasongiedymin/ansible-ghost
#   docker build -t jasongiedymin/ansible-ghost .
#
# Requires:
# jasongiedymin/ansible-nodejs
#   https://github.com/AnsibleShipyard/ansible-nodejs
#
# Uses Playbooks:
#   JasonGiedymin.ark-nodejs
#

FROM jasongiedymin/ansible-nodejs
MAINTAINER ansibleshipyard

# Working dir
ENV WORKDIR /tmp/build/ansible-ghost
ENV NODE_ENV production

# ADD
ADD docker $WORKDIR/docker
ADD tasks $WORKDIR/tasks
ADD tests $WORKDIR/tests
#ADD vars $WORKDIR/vars
ADD templates $WORKDIR/templates
#ADD handlers $WORKDIR/handlers

# Here we continue to use add because
# there are a limited number of RUNs
# allowed.
ADD docker/inventory /etc/ansible/hosts
ADD docker/playbook.yml $WORKDIR/playbook.yml

# Execute
RUN ansible-galaxy install JasonGiedymin.ark-nodejs
RUN ansible-playbook $WORKDIR/playbook.yml -c local -vvvv

# TODO: in debug mode, leave. Prod, cleanup
# Cleanup
# RUN rm -R $WORKDIR

EXPOSE 2368

# By default the playbook uses an init.d but since docker doesn't
# the default will be safely ignored. Instead we rely on the
# docker CMD
CMD ["node", "/nodejs-apps/nodejs_app.js"]
