# Environment Variable Clean-Up using BFG Repo-Cleaner

Accidentally committing environment variables to a public GitHub repository can expose sensitive information, potentially leading to security vulnerabilities. Recently, I faced this situation and successfully managed to remove the exposed environment variables from my Git history. This README will guide you through my journey and provide a step-by-step solution for cleaning up your repository using BFG Repo-Cleaner.

## My Journey

After accidentally committing my `.env` file to GitHub, I removed it from the repository using `git rm --cached .env`. Although this action removed the file from the latest commit, the sensitive information remained in the commit history, which triggered an alert from GitGuardian.

Searching for a solution, I found BFG Repo-Cleaner, a powerful tool designed to help clean up Git repository history efficiently. Initially, I struggled with some commands, particularly `--replace-text`. After reading through the issue discussions on the BFG Repo-Cleaner GitHub page (issue #154), I understood the correct usage and was able to proceed successfully.

To make it easier for others facing similar issues, I created this repository with a detailed guide on using BFG Repo-Cleaner to remove sensitive data from Git history.

## Steps to Remove Sensitive Data from Git History

Follow these steps to clean your Git repository and remove sensitive information using BFG Repo-Cleaner.

### Prerequisites

- Ensure you have Java installed on your system.
- Download BFG Repo-Cleaner from [here](https://rtyley.github.io/bfg-repo-cleaner/) or directly from my repo.

### Step-by-Step Guide

1. **Clone Your Repository:**

   Clone a fresh copy of your repository to ensure you have the latest version and to avoid making changes to your local working directory.
   ```sh
   git clone --mirror https://github.com/yourusername/your-repo.git
   cd your-repo.git
   ```

2. **Run BFG to Remove Sensitive Data:**

   Use BFG to clean your repository. Replace `'.env'` with your file or string pattern.
   ```sh
   java -jar bfg.jar --delete-files '.env'
   ```

   If you need to replace specific text patterns (e.g., API keys or passwords), use:
   ```sh
   java -jar bfg.jar --replace-text replacements.txt
   ```
   Create a `replacements.txt` file with the format:
   ```
   PASSWORD=****
   API_KEY=****
   ```

3. **Cleanup Git History:**

   After running BFG, you need to perform a cleanup and force push the changes to your repository.
   ```sh
   git reflog expire --expire=now --all && git gc --prune=now --aggressive
   git push --force
   ```

4. **Verify and Secure:**

   Ensure that the sensitive data has been removed from the Git history by checking your repository. Inform your team about the changes and ensure everyone updates their local repositories.

### Additional Resources

- [BFG Repo-Cleaner Documentation](https://rtyley.github.io/bfg-repo-cleaner/)
- [GitGuardian](https://www.gitguardian.com/)

## Conclusion

Accidentally committing sensitive information is a common mistake, but tools like BFG Repo-Cleaner make it easier to rectify. By following the steps outlined in this guide, you can effectively clean your Git history and secure your repository. If you encounter issues, refer to the BFG Repo-Cleaner documentation or the relevant GitHub issues for further assistance.

Feel free to contribute to this repository or raise any issues you encounter during the process. Let's help each other maintain secure and clean Git repositories!
