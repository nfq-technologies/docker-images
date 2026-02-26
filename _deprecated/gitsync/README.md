## intro

This image is intended for git repository one way sync. It makes target
repository a mirror of source repository, including branches and tags.

__Make sure that target service allows force pushing to all branches.__

__Also note that any changes in target repository will be lost__

## supported env vars


### NFQ_SOURCE_REPO (required)

Repository URL to clone changes from


### NFQ_TARGET_REPO (required)

Repository URL to push changes to


### NFQ_SECRET_SOURCE_KEY (optional)

SSH private key prodived as string. Used in all git source repo operations


### NFQ_SECRET_DESTINATION_KEY (optional)

SSH private key prodived as string. Used in all git destination repo operations

