# 🚀 Projeto: Pipeline CI/CD para Aplicação FastAPI

<p align="center">
  <img src="https://img.shields.io/badge/status-concluído-green?style=for-the-badge" alt="Status do Projeto"/>
  <img src="https://img.shields.io/badge/Kubernetes-326CE5?style=for-the-badge&logo=kubernetes&logoColor=white" alt="Kubernetes"/>
  <img src="https://img.shields.io/badge/ArgoCD-EF7B4D?style=for-the-badge&logo=argo&logoColor=white" alt="ArgoCD"/>
  <img src="https://img.shields.io/badge/GitHub_Actions-2088FF?style=for-the-badge&logo=github-actions&logoColor=white" alt="GitHub Actions"/>
  <img src="https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white" alt="Docker"/>
</p>

---

### 📖 Sobre o Projeto

Este projeto demonstra a criação de uma pipeline completa de **Integração Contínua e Entrega Contínua (CI/CD)** para uma aplicação web. O objetivo é automatizar todo o ciclo de vida do desenvolvimento: desde o `commit` do código até o `deploy` da aplicação em um ambiente Kubernetes.

O fluxo implementado segue as melhores práticas de **GitOps**, onde o repositório Git atua como a única fonte da verdade para o estado desejado da aplicação.

Este trabalho foi desenvolvido como parte do **Programa de Bolsas - DevSecOps da Compass UOL**.

---

### 🛠️ Tecnologias Utilizadas

* **Aplicação:**
    * `FastAPI`: Framework web Python para a construção da API.
* **Contêineres:**
    * `Docker`: Para empacotar a aplicação e suas dependências em uma imagem portátil.
    * `Docker Hub`: Como registry para armazenar as imagens Docker publicadas.
* **Automação (CI/CD):**
    * `GitHub Actions`: Para automatizar os processos de build e push da imagem Docker e a atualização dos manifestos de deploy.
* **Orquestração e Deploy (GitOps):**
    * `Kubernetes`: Plataforma de orquestração para executar a aplicação de forma escalável e resiliente em um cluster local.
    * `ArgoCD`: Ferramenta de GitOps que sincroniza o estado do cluster com os manifestos definidos no repositório Git.

---

###  ✨ Fluxo da Automação

<details>
<summary><strong>Clique para ver as etapas e os resultados do projeto</strong></summary>

#### 1. O Gatilho: `git push`
Tudo começa quando um desenvolvedor envia uma alteração de código para o branch `main` do repositório da aplicação.

#### 2. A Pipeline de CI no GitHub Actions
O `push` aciona um workflow no GitHub Actions que executa duas tarefas principais:
- **Build & Push:** Constrói uma nova imagem Docker da aplicação e a envia para o Docker Hub com uma tag única (o hash do commit).
- **Update Manifests:** Faz o checkout do repositório de manifestos e atualiza o arquivo `deployment.yaml` com a nova tag da imagem, enviando um novo commit de volta para o repositório de manifestos.

#### 3. A Mágica do GitOps com ArgoCD
O ArgoCD, que está constantemente monitorando o repositório de manifestos, detecta o novo commit. Ele compara o "estado desejado" (descrito no Git) com o "estado atual" (rodando no Kubernetes) e percebe a diferença.

<p align="center">
  <img src="imagens/argo-final-status.png" alt="Status Final da Aplicação no ArgoCD" width="700"/>
</p>

#### 4. O Deploy Contínuo (CD)
Automaticamente, o ArgoCD inicia o processo de sincronização, comandando o Kubernetes para baixar a nova imagem do Docker Hub e atualizar os pods da aplicação, completando o deploy sem qualquer intervenção manual.

#### 5. O Resultado Final
A nova versão da aplicação está no ar e pode ser acessada pelos usuários.

<p align="center">
  <img src="imagens/api-final-response.png" alt="Resposta Final da API no Navegador" width="700"/>
</p>

</details>

---

### 🚀 Como Executar Localmente

Siga os passos abaixo para replicar o ambiente e o fluxo de CI/CD.

#### 1. 🏡 Preparação do Ambiente
   - **Clone os repositórios** da aplicação e dos manifestos.
   - **Garanta os pré-requisitos:** Docker Desktop com Kubernetes ativado e ArgoCD instalado no cluster.

#### 2. 🔑 Configuração do CI/CD
   - No repositório da aplicação no GitHub, vá em `Settings > Secrets and variables > Actions`.
   - Crie os três segredos necessários para a pipeline: `DOCKER_USERNAME`, `DOCKER_PASSWORD`, e `GH_PAT`.

#### 3. 🔄 Execução e Acesso
   - **Crie o App no ArgoCD**, apontando para o seu repositório de manifestos.
   - **Faça um `push`** no repositório da aplicação para iniciar o ciclo de automação.
   - Após a sincronização do ArgoCD, exponha o serviço com o comando:
     ```bash
     kubectl port-forward svc/hello-fastapi-service 8080:80
     ```
   - **Acesse o resultado final** no seu navegador:
     > `http://localhost:8080/`