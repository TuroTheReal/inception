# INCEPTION

## Table of Contents
- [About](#about)
- [Installation](#installation)
- [Usage](#usage)
- [Key Concepts Learned](#key-concepts-learned)
- [Skills Developed](#skills-developed)
- [Project Overview](#project-overview)
- [Infrastructure Architecture](#infrastructure-architecture)
- [42 School Standards](#42-school-standards)

## About

This repository contains my implementation of the **Inception** project at 42 School.  
Inception is a comprehensive **system administration** and **DevOps** project that focuses on **containerization**, **infrastructure as code**,
and **service orchestration** using **Docker** and **Docker Compose**.  
The challenge is to create a complete web infrastructure from scratch using custom Docker images, without relying on pre-built images from Docker Hub.

This project demonstrates mastery of **modern DevOps practices**, **container orchestration**,
and **production-ready infrastructure deployment** - essential skills for modern software development and system administration roles.


## Installation

### Prerequisites
- **Docker Engine** (20.10+)
- **Docker Compose** (v2.0+)
- **Make** utility
- **Unix/Linux environment** (Virtual Machine recommended)
- **sudo/root privileges** for Docker operations

### Setup Instructions
```bash
# Clone the repository
git clone https://github.com/TuroTheReal/inception.git
cd inception

# Fill and rename the .envTemplate with .env

# Create necessary directories and set permissions
make setup

# Build and start all services
make up

# Stop all services
make down

# Clean everything (containers, images, volumes)
make fclean

# View logs for debugging
make logs
```


## Usage

### Quick Start
```bash
# Build and launch the complete infrastructure
make up
```

### Service Management
```bash
# Check service status
docker-compose ps

# View specific service logs
docker-compose logs nginx
docker-compose logs wordpress
docker-compose logs mariadb

# Restart specific service
docker-compose restart wordpress

# Execute commands in running containers
docker-compose exec wordpress bash
docker-compose exec mariadb mysql -u root -p
```

### Development Workflow
```bash
# Rebuild specific service after changes
docker-compose build nginx
docker-compose up -d nginx

# Monitor resource usage
docker stats

# Clean up unused resources
docker system prune -a
```


## Key Concepts Learned

### Containerization and Orchestration
- **Docker Fundamentals**: Image creation, container lifecycle, and multi-stage builds
- **Docker Compose Mastery**: Service orchestration, dependency management, and networking
- **Infrastructure as Code**: Declarative infrastructure definition and version control
- **Container Security**: Implementing security best practices and least privilege principles

### System Administration
- **Service Configuration**: Setting up and configuring web servers, databases, and applications
- **SSL/TLS Implementation**: Certificate management and HTTPS configuration
- **Process Management**: Service supervision, health checks, and automatic restarts
- **Log Management**: Centralized logging and monitoring strategies

### Network and Security Engineering
- **Container Networking**: Custom networks, port mapping, and service discovery
- **Security Hardening**: Non-root users, resource limits, and attack surface reduction
- **Data Persistence**: Volume management and data backup strategies
- **Environment Configuration**: Secure secrets management and environment variables


## Skills Developed

- **DevOps Engineering**: Professional-level container orchestration and infrastructure management
- **System Architecture**: Designing scalable, maintainable multi-service applications
- **Security Engineering**: Implementing enterprise-grade security practices
- **Problem Solving**: Debugging complex distributed systems and networking issues
- **Automation Expertise**: Creating reproducible, automated deployment processes


## Project Overview

Inception recreates a complete web hosting environment using containerized services, mirroring production-grade infrastructure used by modern web applications.
The project emphasizes security, scalability, and maintainability while avoiding shortcuts like pre-built Docker images.

### Architecture Goals
- **Microservices Design**: Separate containers for each service layer
- **Security First**: All communications encrypted, non-root execution
- **Production Ready**: Data persistence, and proper configuration
- **Maintainable**: Clean separation of concerns and documented configurations

### Core Components

**Container Orchestration**: Docker Compose configuration managing service dependencies, networking, and data persistence across multiple containers.
**Web Server Layer**: Custom Nginx container with SSL termination, reverse proxy configuration, and security headers implementation.
**Application Layer**: WordPress container with PHP-FPM, custom configuration, and secure database connectivity.
**Database Layer**: MariaDB container with optimized configuration, data persistence, and security hardening.
**Network Infrastructure**: Custom Docker networks providing secure inter-service communication and external access control.


## Infrastructure Architecture

### Service Topology
```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│     NGINX       │    │   WORDPRESS     │    │    MARIADB      │
│   (Web Server)  │◄──►│  (Application)  │◄──►│   (Database)    │
│                 │    │                 │    │                 │
│ • SSL/TLS       │    │ • PHP-FPM       │    │ • Data Storage  │
│ • Reverse Proxy │    │ • WordPress     │    │ • User Auth     │
│ • Security      │    │ • Custom Config │    │ • Persistence   │
└─────────────────┘    └─────────────────┘    └─────────────────┘
         │                       │                       │
         └───────────────────────┼───────────────────────┘
                                 │
                    ┌─────────────────┐
                    │  DOCKER NETWORK │
                    │   (inception)   │
                    └─────────────────┘
```

### Data Flow
1. **Client Request** → HTTPS (port 443)
2. **Nginx** → SSL termination → Reverse proxy to WordPress
3. **WordPress** → PHP processing → Database queries to MariaDB
4. **MariaDB** → Data retrieval → Response back through stack
5. **Response** → Encrypted delivery to client


## 42 School Standards

### Norm Requirements
- ✅ Maximum 25 lines per function
- ✅ Maximum 5 functions per file
- ✅ Proper indentation and formatting
- ✅ No forbidden functions usage
- ✅ Compilation without warnings

### Project Standards
- ✅ Custom Docker images only (no pre-built images from Docker Hub)
- ✅ Docker Compose orchestration for all services
- ✅ SSL/TLS encryption for all communications
- ✅ Non-root container execution for security
- ✅ Data persistence using Docker volumes
- ✅ Proper network isolation and security

### Infrastructure Requirements
- ✅ **Nginx**: Web server with SSL termination and reverse proxy
- ✅ **WordPress**: Complete CMS with PHP-FPM backend
- ✅ **MariaDB**: Database server with persistent storage
- ✅ **Custom Domain**: Configured for local development
- ✅ **Volume Management**: Persistent data for database and WordPress files
- ✅ **Network Security**: Isolated container communication

### Security Standards
- ✅ All containers run as non-root users
- ✅ SSL certificates properly configured and functional
- ✅ Environment variables for sensitive data
- ✅ Network isolation between services
- ✅ Proper file permissions and ownership
- ✅ No hardcoded passwords or secrets in code


## Contact

- **GitHub**: [@TuroTheReal](https://github.com/TuroTheReal)
- **Email**: arthurbernard.dev@gmail.com
- **LinkedIn**: [Arthur Bernard](https://www.linkedin.com/in/arthurbernard92/)
- **Portfolio**: https://arthur-portfolio.com

---

<p align="center">
  <img src="https://img.shields.io/badge/Made%20with-Docker-blue.svg"/>
  <img src="https://img.shields.io/badge/DevOps-Infrastructure%20as%20Code-green.svg"/>
  <img src="https://img.shields.io/badge/Security-SSL%2FTLS-red.svg"/>
  <img src="https://img.shields.io/badge/Made%20with-Docker-2496ED?logo=docker&logoColor=white" alt="Made with Docker" />
</p>
