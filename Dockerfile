FROM alpine:3.12

LABEL repository="https://github.com/NoahDragon/action-push-repo-as-subdirectory-in-another-repo"
LABEL homepage="https://github.com/NoahDragon/action-push-repo-as-subdirectory-in-another-repo"
LABEL maintainer="Abner Chou <hi@abnerchou.me>"

LABEL com.github.actions.name="Push Repo as Subdirectory"
LABEL com.github.actions.description="Github action to push a branch under a repo as a subdirectory in another repo."
LABEL com.github.actions.icon="git-pull-request"
LABEL com.github.actions.color="blue"

RUN apk add --no-cache git

COPY "entrypoint.sh" "/entrypoint.sh"

ENTRYPOINT ["/entrypoint.sh"]
