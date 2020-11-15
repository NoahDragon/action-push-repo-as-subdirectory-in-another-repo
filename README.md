# Github Action - push a repo as a subdirectory in another repo.

This action is to add current repo as a subdirectory in another repo. 

## Example usage
```yaml
      - name: Pushes to another repository folder
        uses: NoahDragon/action-push-repo-as-subdirectory-in-another-repo@main
        env:
          API_TOKEN_GITHUB: ${{ secrets.API_TOKEN_GITHUB }}
        with:
          dest-repo: 'redwoodedu/tools'
          dest-folder: 'svc'
```

DEMO: https://github.com/NoahDragon/simple-video-cutter/blob/main/.github/workflows/push-to-ra-tools.yml

## Inputs

### dest-repo
The destination repository name, following the pattern "USERNAME/REPO_NAME".

### dest-branch [optional]
The branch name in destination repository. Default is main. If not exists, CI will error out.

### dest-folder
The folder name in destination repo. If not exists, will create a new one. Please make sure the folder name is correct, otherwise, all files under the folder will be overwritten.

### commit-message [optional]
The commit message to be used in the output repository. Optional and defaults to "Update from $REPOSITORY_URL@commit".

### API_TOKEN_GITHUB (env)
E.g.:
  `API_TOKEN_GITHUB: ${{ secrets.API_TOKEN_GITHUB }}`

Generate your personal token following the steps:
* Go to the Github Settings (on the right hand side on the profile picture)
* On the left hand side pane click on "Developer Settings"
* Click on "Personal Access Tokens" (also available at https://github.com/settings/tokens)
* Generate a new token, choose "Repo". Copy the token.

Then make the token available to the Github Action following the steps:
* Go to the Github page for the repository that you push from, click on "Settings"
* On the left hand side pane click on "Secrets"
* Click on "Add a new secret" and name it "API_TOKEN_GITHUB"
