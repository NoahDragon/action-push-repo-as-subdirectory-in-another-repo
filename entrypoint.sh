#!/bin/bash

set -e  # if a command fails it stops the execution
set -u  # script fails if trying to access to an undefined variable

DEST_REPO="$1"
DEST_BRANCH="$2"
DEST_FOLDER="$3"
COMMIT_MESSAGE="$4"
EXCLUDES="$5"

REPO_DIR=$(mktemp -d)
CLONE_DIR="$REPO_DIR/$DEST_FOLDER"
TMP_DIR=$(mktemp -d)

echo "Cloning destination git repository"
# Setup git
git config --global user.email "noahdragon-actions-push-repo-as-subdirectories@example.org"
git config --global user.name "actions-push-repo-as-subdirectories"
git clone --single-branch --branch "$DEST_BRANCH" "https://$API_TOKEN_GITHUB@github.com/$DEST_REPO.git" "$REPO_DIR"

echo "Check if destinate folder exists, if not create new one"
mkdir -p $CLONE_DIR
ls -la "$CLONE_DIR"

echo "Store exclude files/folders into a temp folder"
IFS=';'; read -a strarr <<< "$EXCLUDES"
for val in "${strarr[@]}";
do
  echo "$val"
  [[ -e "$CLONE_DIR"/"$val" || -d "$CLONE_DIR"/"$val" ]] && cp -rf "$CLONE_DIR"/"$val" "$TMP_DIR"
done
ls -la "$TMP_DIR"

echo "Cleaning destination repository of old files"
# Copy files into the git and deletes all git
find "$CLONE_DIR" | grep -v "^$CLONE_DIR/\.git" | grep -v "^$CLONE_DIR$" | xargs rm -rf # delete all files (to handle deletions)
ls -la "$CLONE_DIR"

echo "Copying contents to git repo"
cp -r "$GITHUB_WORKSPACE"/* "$CLONE_DIR"
ls -la "$CLONE_DIR"

echo "Copying back the excluded files/folders, may overwrite the existing ones."
for val in "${strarr[@]}";
do
  echo "$val"
  [[ -e "$TMP_DIR"/"$val" || -d "$TMP_DIR"/"$val" ]] && cp -rf "$TMP_DIR"/"$val" "$CLONE_DIR"
done
ls -la "$CLONE_DIR"

echo "Adding git commit"
cd "$REPO_DIR"
ls -la
ORIGIN_COMMIT="https://github.com/$GITHUB_REPOSITORY/commit/$GITHUB_SHA"
COMMIT_MESSAGE="${COMMIT_MESSAGE/ORIGIN_COMMIT/$ORIGIN_COMMIT}"

git add .
git status

# git diff-index : to avoid doing the git commit failing if there are no changes to be commit
git diff-index --quiet HEAD || git commit --message "$COMMIT_MESSAGE"

echo "Pushing git commit"
# --set-upstream: sets de branch when pushing to a branch that does not exist
git push origin --set-upstream "$DEST_BRANCH"

