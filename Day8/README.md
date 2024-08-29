# Day3 Git and CI/CD Overview

## Git Basics

**Git** is a distributed version control system that allows multiple people to work on a project simultaneously. Key concepts include:

- **Repositories (Repos):** Stores all project files and their history.
- **Branches:** Separate lines of development. The `main` branch is typically the production-ready version.
- **Commits:** Save changes to the repository.
- **Pull Requests (PRs):** Proposed changes that are reviewed before merging into the main branch.

### Common Commands

- `git clone <repo-url>`: Clone a repository.
- `git status`: Check the status of your working directory.
- `git add <file>`: Stage changes for the next commit.
- `git commit -m "message"`: Commit staged changes with a message.
- `git push`: Push changes to a remote repository.
- `git pull`: Fetch and merge changes from a remote repository.

## CI/CD Overview

**Continuous Integration (CI)** and **Continuous Deployment (CD)** are practices aimed at improving software development processes:

- **Continuous Integration (CI):** Automates the integration of code changes from multiple contributors into a shared repository frequently, typically several times a day. This includes automated testing to ensure new code does not break existing functionality.

- **Continuous Deployment (CD):** Automates the deployment of code changes to production or staging environments after passing CI. This ensures that new features and fixes are released quickly and reliably.

### Key Components

- **CI/CD Pipelines:** Define the stages of your integration and deployment processes. Common stages include build, test, and deploy.
- **Build Tools:** Compile and package your code. Examples include Maven for Java and Webpack for JavaScript.
- **Testing:** Automated tests that run during the CI process to catch issues early.
- **Deployment Tools:** Automate the deployment of applications. Examples include Jenkins, GitLab CI, and GitHub Actions.

### Basic CI/CD Workflow

1. **Commit:** Code changes are committed to the repository.
2. **Build:** The CI system builds the project.
3. **Test:** Automated tests are run to verify the changes.
4. **Deploy:** If tests pass, changes are deployed to a staging or production environment.

## Best Practices

- **Branching Strategy:** Use feature branches and pull requests for collaboration and code review.
- **Automated Testing:** Implement a robust suite of automated tests.
- **Pipeline Configuration:** Keep pipeline configurations versioned and maintained.
- **Monitoring:** Continuously monitor deployments and integrate feedback loops.

## Resources

- [Git Documentation](https://git-scm.com/doc)
- [CI/CD with Jenkins](https://www.jenkins.io/)
- [GitHub Actions](https://docs.github.com/en/actions)