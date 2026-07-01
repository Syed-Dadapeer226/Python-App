# Python Flask Application with Docker, AWS CodePipeline, CodeBuild & CodeDeploy

---

<p align="center">

  <img src="https://img.shields.io/badge/Python-3.14-3776AB?style=for-the-badge&logo=python&logoColor=white"/>

  <img src="https://img.shields.io/badge/Flask-Web_Framework-000000?style=for-the-badge&logo=flask&logoColor=white"/>

  <img src="https://img.shields.io/badge/Docker-Containerization-2496ED?style=for-the-badge&logo=docker&logoColor=white"/>

  <img src="https://img.shields.io/badge/GitHub-Repository-181717?style=for-the-badge&logo=github&logoColor=white"/>

  <img src="https://img.shields.io/badge/AWS-CodePipeline-FF9900?style=for-the-badge&logo=amazonaws&logoColor=white"/>

  <img src="https://img.shields.io/badge/AWS-CodeBuild-FF9900?style=for-the-badge&logo=amazonaws&logoColor=white"/>

  <img src="https://img.shields.io/badge/AWS-CodeDeploy-FF9900?style=for-the-badge&logo=amazonaws&logoColor=white"/>

  <img src="https://img.shields.io/badge/Amazon-EC2-FF9900?style=for-the-badge&logo=amazonec2&logoColor=white"/>

  <img src="https://img.shields.io/badge/AWS-Systems_Manager-FF9900?style=for-the-badge&logo=amazonaws&logoColor=white"/>

  <img src="https://img.shields.io/badge/Docker-Hub-2496ED?style=for-the-badge&logo=docker&logoColor=white"/>

  <img src="https://img.shields.io/badge/Linux-Bash-FCC624?style=for-the-badge&logo=linux&logoColor=black"/>

  <img src="https://img.shields.io/badge/CI/CD-Automated-blueviolet?style=for-the-badge&logo=githubactions&logoColor=white"/>

</p>

---

A simple Flask web application containerized with Docker and deployed automatically to an Amazon EC2 instance using a complete AWS CI/CD pipeline.

---

## Project Architecture

```text
Developer
    │
    ▼
GitHub Repository
    │
    ▼
AWS CodePipeline
    │
    ├─────────────── Source Stage
    │
    ▼
AWS CodeBuild
    │
    ├── Install Dependencies
    ├── Build Docker Image
    ├── Tag Docker Image
    ├── Login to Docker Hub
    └── Push Docker Image
    │
    ▼
Docker Hub
    │
    ▼
AWS CodeDeploy
    │
    ├── Stop Existing Container
    ├── Pull Latest Docker Image
    └── Start New Container
    │
    ▼
Amazon EC2
    │
    ▼
Flask Application
```

---

## ⚡️ Project Structure

```text
Python-App/
│
├── scripts/
│   ├── start_container.sh
│   └── stop_container.sh
│
├── templates/
│   └── index.html
│
├── app.py
├── Dockerfile
├── requirements.txt
├── buildspec.yml
├── appspec.yml
├── README.md
└── LICENSE
```

---

## 📌 Technology Stack

- Python 3.14
- Flask
- Docker
- GitHub
- AWS CodePipeline
- AWS CodeBuild
- AWS CodeDeploy
- Amazon EC2
- Docker Hub
- AWS Systems Manager Parameter Store

---

## Application Endpoints

| Endpoint | Description |
|----------|-------------|
| `/` | Loads the home page |
| `/health` | Returns application health status |

Example

```json
{
  "status": "online",
  "framework": "Flask",
  "language": "Python"
}
```

---

### Step 1 - Clone Repository

- Clone the project from GitHub.

```bash
git clone https://github.com/Syed-Dadapeer226/Python-App.git
```

- Navigate to the project directory.

```bash
cd Python-App
```

---

### ⚙️ Step 2 - Install Prerequisites

Install the following software.

- [Python 3.14+](https://www.python.org/downloads/)
- [Git](https://git-scm.com/install/)
- [Docker Desktop](https://www.docker.com/products/docker-desktop/) / [Docker Engine](https://docs.docker.com/engine/install/)
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) (Optional)

---

### Step 3 - Create Virtual Environment

- ### Linux / macOS

```bash
python3 -m venv venv
source venv/bin/activate
```

- ### Windows

```cmd
python -m venv venv

venv\Scripts\activate
```

---

### ⬇️ Step 4 - Install Dependencies

```bash
pip install -r requirements.txt
```

---

### ⌛️ Step 5 - Run the Flask Application

```bash
python app.py
```

- The application starts on

```
http://localhost:5000
```

---

### ✅ Step 6 - Verify the Application

Open your browser.

- Home Page

```
http://localhost:5000
```

- Health Check

```
http://localhost:5000/health
```

Expected response

```json
{
  "status": "online",
  "framework": "Flask",
  "language": "Python"
}
```

---

### Step 7 - Build Docker Image

- Build the Docker image.

```bash
docker build -t python-app .
```

- Verify the image.

```bash
docker images
```

---

### Step 8 - Run Docker Container

```bash
docker run -d --name python-app-container -p 5000:5000 python-app
```

- Verify running containers.

```bash
docker ps
```

- Open

```
http://localhost:5000
```

---

### Step 9 - Stop Docker Container

```bash
docker ps
```

```bash
docker stop <container-id>
```

---

## 💻 Docker Commands

### Build

```bash
docker build -t python-app .
```

### Run

```bash
docker run -d --name python-app-container -p 5000:5000 python-app
```

### Running Containers

```bash
docker ps
```

### Stop

```bash
docker stop <container-id>
```

### Remove Container

```bash
docker rm <container-id>
```

### Remove Image

```bash
docker rmi python-app
```

---

## ⛭ Step 10 - Configure Docker Hub

Create a Docker Hub repository.

Example

```
username/python-app
```

- Login

```bash
docker login
```

- Push manually (optional)

```bash
docker tag python-app username/python-app:latest

docker push username/python-app:latest
```

---

## ☁️ Step 11 - Configure AWS Systems Manager Parameter Store

Store Docker Hub credentials securely.

| Parameter | Purpose |
|------------|---------|
| `/Python-App/Docker-Credentials/Username` | Docker Hub Username |
| `/Python-App/Docker-Credentials/Password` | Docker Hub Password |

These credentials are retrieved by AWS CodeBuild during the build process.

---

## 🏗️ Step 12 - Configure AWS CodeBuild

The project includes **buildspec.yml**.

During execution, CodeBuild performs the following:

- Downloads source code
- Creates Docker image tag
- Logs in to Docker Hub
- Builds Docker image
- Pushes image to Docker Hub
- Publishes build artifacts

Generated image format

```
dockerhub-user/python-app:<commit-id>-b<build-number>
```

Example

```
john/python-app:8c91fd2-b12
```

---

## 📥 Step 13 - Configure AWS CodeDeploy

Deployment is managed using **appspec.yml**.

### ApplicationStop

Runs

```
scripts/stop_container.sh
```

Actions

- Stops existing Docker containers

---

### ApplicationStart

Runs

```
scripts/start_container.sh
```

Actions

- Retrieves the latest Docker image tag
- Pulls latest image
- Starts Docker container
- Maps port 5000

---

## 🌟 Step 14 - Configure AWS CodePipeline

AWS CodePipeline automates the entire deployment.

Pipeline Stages

| Stage | AWS Service | Description |
|--------|-------------|-------------|
| Source | GitHub | Downloads latest source code |
| Build | AWS CodeBuild | Builds Docker image and pushes to Docker Hub |
| Deploy | AWS CodeDeploy | Deploys latest Docker image to EC2 |

---

## 📋 Step 15 - CI/CD Workflow

Whenever code is pushed to GitHub:

```text
Git Push

      │

      ▼

GitHub Repository

      │

      ▼

AWS CodePipeline

      │

      ▼

Source Stage

      │

      ▼

AWS CodeBuild

      │
      ├── Install Dependencies
      ├── Build Docker Image
      ├── Generate Image Tag
      ├── Login to Docker Hub
      └── Push Docker Image

      │

      ▼

Docker Hub

      │

      ▼

AWS CodeDeploy

      │
      ├── Stop Existing Container
      ├── Pull Latest Docker Image
      └── Start New Container

      │

      ▼

Amazon EC2

      │

      ▼

Application Available
```

---

## 🪜 Step 16 - Deployment Process

The deployment executes in the following order:

1. Developer pushes code to GitHub.
2. CodePipeline detects the new commit.
3. Source code is downloaded.
4. CodeBuild reads `buildspec.yml`.
5. Docker image is built.
6. Docker image is tagged.
7. Docker image is pushed to Docker Hub.
8. CodeDeploy downloads the application revision.
9. CodeDeploy reads `appspec.yml`.
10. `stop_container.sh` stops the running container.
11. `start_container.sh` pulls the latest Docker image.
12. A new container starts.
13. The Flask application becomes available.

---

## 👨‍💻 Step 17 - Access the Application

- Local

```
http://localhost:5000
```

- EC2

```
http://<EC2-Public-IP>:5000
```

- Health Check

```
http://<EC2-Public-IP>:5000/health
```

---

## IAM Roles Required

Create IAM roles for:

- AWS CodePipeline
- AWS CodeBuild
- AWS CodeDeploy
- Amazon EC2

Grant permissions for:

- Amazon S3
- CodeBuild
- CodeDeploy
- CodePipeline
- Systems Manager Parameter Store
- CloudWatch Logs
- Docker Hub access

---

## ⚠️ Troubleshooting

### Docker Image Not Found

```bash
docker login
```

Verify repository name and credentials.

---

### Port Already in Use

```bash
docker ps
```

or

```bash
lsof -i :5000
```

---

### Missing Python Packages

```bash
pip install -r requirements.txt
```

---

### Container Exits Immediately

```bash
docker logs <container-id>
```

---

## ✨ Future Enhancements

- Gunicorn for production
- Nginx Reverse Proxy
- HTTPS with SSL/TLS
- Docker Compose
- Amazon Elastic Container Registry (ECR)
- Amazon ECS
- Kubernetes (Amazon EKS)
- GitHub Actions
- Unit Testing
- Integration Testing
- CloudWatch Monitoring
- Auto Scaling
- Blue/Green Deployment

---

## 📄 License

This project is licensed under the Apache License 2.0.

---

Python • Flask • Docker • AWS DevOps • CI/CD
