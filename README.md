# terramock-infra-terraform

## Instalación de CLI necesarios

Para trabajar con la infraestructura de TerraMock en Google Cloud Platform, asegúrate de tener instaladas las siguientes herramientas en tu entorno:

---

### 1. [Google Cloud SDK (gcloud)](https://cloud.google.com/sdk/docs/install)

```sh
sudo apt-get update && sudo apt-get install -y apt-transport-https ca-certificates gnupg

echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

sudo apt-get update && sudo apt-get install -y google-cloud-sdk
```
---

### 2. [Terraform](https://www.terraform.io/downloads.html)

```sh
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common

sudo add-apt-repository --yes ppa:hashicorp/terraform

sudo apt-get update && sudo apt-get install -y terraform
```
---

### 3. [Docker](https://docs.docker.com/get-docker/)

```sh
sudo apt-get update && sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common

curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

echo "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list

sudo apt-get update && sudo apt-get install -y docker-ce
```

---

## 🚦 Variables obligatorias

- `project_id`: ID de tu proyecto en GCP (ejemplo: `terramock`)
- `region`: Región donde desplegar los recursos (ejemplo: `us-central1`)
- `zone`: Zona por defecto para recursos zonales (ejemplo: `us-central1-a`)
- `instance_image`: Imagen Docker completa para desplegar en Cloud Run (ejemplo: `us-central1-docker.pkg.dev/terramock/terramock-docker-registry/terramock-app-frontend:1.2.3`)

Puedes definirlas en un fichero `terraform.tfvars` o exportarlas como variables de entorno `TF_VAR_<nombre>`.

---

## 🏗️ Recursos gestionados

- **VPC**: Red básica para la infraestructura.
- **Firewall**: Permite acceso SSH (puerto 22) desde cualquier IP (ajusta para producción).
- **Cloud Run**: Despliega el frontend como servicio serverless público.

---

## 🚀 Comandos principales

- **Inicializar Terraform:**
  ```sh
  terraform init
  ```

- **Planificar cambios:**
  ```sh
  terraform plan -var="project_id=terramock" -var="region=us-central1" -var="zone=us-central1-a" -var="image_name=us-central1-docker.pkg.dev/terramock/terramock-docker-registry/terramock-app-frontend:1.2.3"
  ```

- **Aplicar cambios:**
  ```sh
  terraform apply -var="project_id=terramock" -var="region=us-central1" -var="zone=us-central1-a" -var="image_name=us-central1-docker.pkg.dev/terramock/terramock-docker-registry/terramock-app-frontend:1.2.3"
  ```

- **Destruir recursos:**
  ```sh
  terraform destroy -var="project_id=terramock" -var="region=us-central1" -var="zone=us-central1-a" -var="image_name=us-central1-docker.pkg.dev/terramock/terramock-docker-registry/terramock-app-frontend:1.2.3"
  ```

---

## 🔐 Permisos mínimos para la cuenta de servicio

La cuenta de servicio usada por Terraform debe tener estos roles en el proyecto:

- `roles/run.admin`
- `roles/iam.serviceAccountUser`
- `roles/artifactregistry.reader`

Puedes asignarlos así:

```sh
gcloud projects add-iam-policy-binding TU_PROJECT_ID \
  --member="serviceAccount:TU_SA@TU_PROJECT_ID.iam.gserviceaccount.com" \
  --role="roles/run.admin"

gcloud projects add-iam-policy-binding TU_PROJECT_ID \
  --member="serviceAccount:TU_SA@TU_PROJECT_ID.iam.gserviceaccount.com" \
  --role="roles/iam.serviceAccountUser"

gcloud projects add-iam-policy-binding TU_PROJECT_ID \
  --member="serviceAccount:TU_SA@TU_PROJECT_ID.iam.gserviceaccount.com" \
  --role="roles/artifactregistry.reader"
```

---

## 📝 Notas

- Asegúrate de tener la API de Cloud Run habilitada en el proyecto.
- Usa regiones soportadas por Cloud Run (ejemplo: `us-central1`, `europe-west1`, `us-east1`).
- El firewall permite SSH desde cualquier IP solo para pruebas. ¡Restringe en producción!
- El despliegue de Cloud Run es público (invocación anónima permitida).

---


## Referencias
- [Terraform Google Provider](https://registry.terraform.io/providers/hashicorp/google/latest/docs)
- [Cloud Run Locations](https://cloud.google.com/run/docs/locations)
- [Artifact Registry](https://cloud.google.com/artifact-registry/docs)
