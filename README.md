# terramock-infra-terraform

## Infraestructura como código para TerraMock

Automatiza la creación de red, firewall y despliegue de servicios en Google Cloud Platform usando Terraform.

---

## 🚦 Variables obligatorias

- `project_id`: ID de tu proyecto en GCP (ejemplo: `terramock`)
- `region`: Región donde desplegar los recursos (ejemplo: `us-central1`)
- `zone`: Zona por defecto para recursos zonales (ejemplo: `us-central1-a`)
- `cloud_run_image`: Imagen Docker completa para desplegar en Cloud Run (ejemplo: `us-central1-docker.pkg.dev/terramock/terramock-docker-registry/terramock-app-frontend:1.2.3`)

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
  terraform plan -var="project_id=terramock" -var="region=us-central1" -var="zone=us-central1-a" -var="cloud_run_image=us-central1-docker.pkg.dev/terramock/terramock-docker-registry/terramock-app-frontend:1.2.3"
  ```

- **Aplicar cambios:**
  ```sh
  terraform apply -var="project_id=terramock" -var="region=us-central1" -var="zone=us-central1-a" -var="cloud_run_image=us-central1-docker.pkg.dev/terramock/terramock-docker-registry/terramock-app-frontend:1.2.3"
  ```

- **Destruir recursos:**
  ```sh
  terraform destroy -var="project_id=terramock" -var="region=us-central1" -var="zone=us-central1-a" -var="cloud_run_image=us-central1-docker.pkg.dev/terramock/terramock-docker-registry/terramock-app-frontend:1.2.3"
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

## 📦 Outputs útiles

- `cloud_run_service_url`: URL pública del servicio Cloud Run desplegado.
- `cloud_run_service_name`: Nombre del servicio Cloud Run.
- `cloud_run_service_location`: Región de despliegue.

---

## 📝 Notas

- Asegúrate de tener la API de Cloud Run habilitada en el proyecto.
- Usa regiones soportadas por Cloud Run (ejemplo: `us-central1`, `europe-west1`, `us-east1`).
- El firewall permite SSH desde cualquier IP solo para pruebas. ¡Restringe en producción!
- El despliegue de Cloud Run es público (invocación anónima permitida).

---

## Ejemplo de fichero terraform.tfvars

```hcl
project_id      = "terramock"
region          = "us-central1"
zone            = "us-central1-a"
cloud_run_image = "us-central1-docker.pkg.dev/terramock/terramock-docker-registry/terramock-app-frontend:1.2.3"
```

---

## Referencias
- [Terraform Google Provider](https://registry.terraform.io/providers/hashicorp/google/latest/docs)
- [Cloud Run Locations](https://cloud.google.com/run/docs/locations)
- [Artifact Registry](https://cloud.google.com/artifact-registry/docs)
