# DevOps Task – CI/CD Pipeline with Jenkins & Docker

## 1. Project Overview

This project demonstrates a simple **CI/CD pipeline** for a sample Node.js application using **AWS EC2**, **Jenkins**, **Docker**, and **GitHub**. The pipeline automates the process of building, testing, containerizing, and deploying the application, following best DevOps practices.

**Key Features:**

* Automated CI/CD pipeline triggered by GitHub push.
* Containerized deployment using Docker.
* Docker images pushed to DockerHub registry.
* Deployed on **AWS EC2** instance.
* Clear documentation and architecture diagram.

---

## 2. Repository Structure

```
ci-cd-node-app/
│
├── .gitignore/                    # Node.js application source code
├── Dockerfile              # Docker configuration for application
├── Jenkinsfile             # Jenkins pipeline definition
├── README.md               # Project documentation
├── deployment-proof/       # Proof of deployment (screenshots or URL)
├── app.js/
│-- logoswayatt.png    # Architecture diagram
└── package-lock.json         # Challenges, tools, and improvements
└── package.json         # Challenges, tools, and improvements
```

---

## 3. Architecture Diagram

![Architecture Diagram](./docs/architecture.png)

**Description:**

1. Developers push code to GitHub repository (`main` or `dev` branch).
2. GitHub webhook triggers Jenkins pipeline automatically.
3. Jenkins performs the following stages:

   * **Build**: Installs dependencies and runs tests.
   * **Dockerize**: Builds Docker image.
   * **Push to Registry**: Pushes Docker image to DockerHub.
   * **Deploy**: Deploys the container to AWS EC2.

---

## 4. CI/CD Pipeline Flow

**Jenkins Pipeline Stages:**

| Stage                | Description                                                                        |
| -------------------- | ---------------------------------------------------------------------------------- |
| **Build**            | Installs Node.js dependencies using `npm install` and runs tests using `npm test`. |
| **Dockerize**        | Builds Docker image using `Dockerfile`.                                            |
| **Push to Registry** | Pushes Docker image to DockerHub.                                                  |
| **Deploy**           | Pulls the Docker image on EC2 and runs the container.                              |

**Pipeline Trigger:** GitHub webhook on push to `main` or `dev` branch.

---

## 5. Setup Instructions

**1. AWS EC2 Setup:**

```bash
# Update packages
sudo apt update && sudo apt upgrade -y

# Install Docker
sudo apt install docker.io -y
sudo systemctl enable docker
sudo systemctl start docker

# Add user to docker group
sudo usermod -aG docker $USER
```

**2. Jenkins Setup:**

* Install Jenkins on EC2.
* Create a pipeline job with the following Jenkinsfile


**3. GitHub Webhook Setup:**

* Go to repository settings → Webhooks → Add webhook.
* Set **Payload URL** to `http://13.51.164.233:8080/github-webhook/`.
* Content type: `application/json`.
* Trigger: **Just the push event**.

---

## 6. Deployment Proof

* Public URL: `http://13.51.164.233:3000/`
* Or see `deployment-proof/` folder for screenshots of:

  * Jenkins pipeline stages
  * Running Docker container
  * Application running in browser

---

## 7. Tools & Services Used

| Tool/Service | Purpose               |
| ------------ | --------------------- |
| AWS EC2      | Server for deployment |
| Jenkins      | CI/CD automation      |
| Docker       | Containerization      |
| DockerHub    | Docker image registry |
| GitHub       | Version control       |
| Node.js      | Sample application    |

---

## 8. Challenges & Solutions

* **Challenge:** Jenkins pipeline not triggering automatically.
  **Solution:** Configured GitHub webhook with correct URL and credentials.

* **Challenge:** Docker container failed on redeploy.
  **Solution:** Added `docker stop` and `docker rm` commands before running a new container.

* **Challenge:** Environment variable management.
  **Solution:** Used Jenkins credentials and `.env` file for sensitive data.

---

## 9. Possible Improvements

* Use **AWS ECS** or **EKS** for scalable deployment.
* Implement **Terraform** for Infrastructure as Code.
* Add **automated rollback** in Jenkins pipeline.
* Add **unit/integration tests** and code coverage reports.

