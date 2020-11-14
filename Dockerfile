FROM node:12-slim

LABEL repository="https://github.com/NoahDragon/action-push-repo-as-subdirectory-in-another-repo"
LABEL homepage="https://github.com/NoahDragon/action-push-repo-as-subdirectory-in-another-repo"
LABEL maintainer="Abner Chou <hi@abnerchou.me>"

LABEL com.github.actions.name="Push Repo as Subdirectory"
LABEL com.github.actions.description="Github action to push a branch under a repo as a subdirectory in another repo."
LABEL com.github.actions.icon="git-pull-request"
LABEL com.github.actions.color="blue"

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git && \
    apt-get install -y jq

COPY "entrypoint.sh" "/entrypoint.sh"
ENTRYPOINT ["/entrypoint.sh"]
