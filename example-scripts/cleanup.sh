#!/bin/sh
# Script to clone a repository and run BFG Repo-Cleaner

REPO_URL="https://github.com/yourusername/your-repo.git"
FILE_PATTERN=".env"

# Clone the repository
git clone --mirror $REPO_URL
cd your-repo.git

# Run BFG Repo-Cleaner
java -jar ../bfg.jar --delete-files $FILE_PATTERN

# Cleanup git history
git reflog expire --expire=now --all && git gc --prune=now --aggressive
git push --force
