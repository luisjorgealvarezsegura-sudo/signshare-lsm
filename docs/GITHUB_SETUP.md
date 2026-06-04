# GitHub Setup Instructions

These instructions are for users who do not have Flutter installed locally.

## Create the Repository

1. Go to GitHub in your browser.
2. Click **New repository**.
3. Repository name: `signshare-lsm`.
4. Do not add a README, .gitignore, or license during creation.
5. Click **Create repository**.

## Upload the Files

1. Unzip `signshare_lsm_starter_github_actions.zip`.
2. Open the unzipped folder.
3. Select everything inside the folder.
4. Drag all selected files and folders into the GitHub upload page.
5. Confirm that `.github/workflows/android-build.yml` appears in the upload list.
6. Commit the files to the `main` branch.

## Run the Build

1. Click the **Actions** tab.
2. Select **Android Build**.
3. Click the latest run.
4. Wait until all steps are green.
5. Download the `signshare-lsm-debug-apk` artifact.
6. Unzip it and install `app-debug.apk` on your Android phone.

## If the Actions Tab Shows Nothing

Check that this file exists in the repository:

```text
.github/workflows/android-build.yml
```

If it is missing, create it manually in GitHub with this path:

```text
.github/workflows/android-build.yml
```

Then paste the workflow from this starter project.
