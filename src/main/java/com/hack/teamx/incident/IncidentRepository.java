package com.hack.teamx.incident;

import org.springframework.data.repository.ListCrudRepository;

interface IncidentRepository extends ListCrudRepository<Incident, String> {
}
