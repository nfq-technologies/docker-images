# nfqlt/gitleaks docker image

Used for scanning and submitting credentials found committed inside code.

Why was this created? Original docker image was missing necessary tools for processing output and submitting it, curl and jq are available in this image.


Source image: https://hub.docker.com/r/zricethezav/gitleaks
Soure dockerfile: https://github.com/gitleaks/gitleaks/blob/master/Dockerfile

