# Day3 

![image](https://github.com/user-attachments/assets/42e9462c-e409-4b49-b2d4-918fbabc36ca)

## 2 Pipline Migration

**Source:** Github Action - [Link](https://github.com/itsmanibharathi/Docker-image-test-app/) 

**Target:** Gitlab CI/CD - [Link](https://gitlab.com/Owncodezs/Docker-image-test-app)

> Source Action file

```yml
name: Deploy Images to GHCR


on:
  push:
    branches:
      - main
jobs:
      push-store-image:
        runs-on: ubuntu-latest
        steps:
          - name: 'Checkout GitHub Action'
            uses: actions/checkout@main

          - name: 'Login to GitHub Container Registry'
            uses: docker/login-action@v1
            with:
              registry: ghcr.io
              username: ${{github.actor}}
              password: ${{secrets.GITHUB_TOKEN}}

          - name: 'Build Inventory Image'
            run: |
              docker build . --tag ghcr.io/itsmanibharathi/store:latest
              docker push ghcr.io/itsmanibharathi/store:latest
```
> Target Action file

```yml
stages:
  - build

variables:
  IMAGE_NAME: "$CI_REGISTRY_IMAGE/store:latest"

build-and-push-image:
  stage: build
  image: docker:latest
  services:
    - docker:dind
  script:
    - docker login -u "$CI_REGISTRY_USER" -p "$CI_REGISTRY_PASSWORD" $CI_REGISTRY
    - docker build . --tag $IMAGE_NAME
    - docker push $IMAGE_NAME

before_script:
  - apk add --no-cache curl

```
