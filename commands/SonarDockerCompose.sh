sudo nano /etc/sysctl.conf
# Add this line of code in above
vm.max_map_count=524288
fs.file-max=131072


sudo sysctl --system



# Create a Docker Compose file for SonarQube and PostgreSQL:

mkdir sonarqube-docker
cd sonarqube-docker


nano docker-compose.yml
# add this to docker-compose.yml

version: "3"

services:
  sonarqube:
    image: sonarqube:lts-community
    ports:
      - "9000:9000"
    environment:
      - SONARQUBE_JDBC_URL=jdbc:postgresql://db:5432/sonar
      - SONARQUBE_JDBC_USERNAME=sonar
      - SONARQUBE_JDBC_PASSWORD=sonar
    volumes:
      - sonarqube_data:/opt/sonarqube/data
      - sonarqube_extensions:/opt/sonarqube/extensions
      - sonarqube_logs:/opt/sonarqube/logs
    depends_on:
      - db

  db:
    image: postgres:13
    environment:
      - POSTGRES_USER=sonar
      - POSTGRES_PASSWORD=sonar
      - POSTGRES_DB=sonar
    volumes:
      - postgresql_data:/var/lib/postgresql/data

volumes:
  sonarqube_data:
  sonarqube_extensions:
  sonarqube_logs:
  postgresql_data:




# Start SonarQube
docker compose up -d