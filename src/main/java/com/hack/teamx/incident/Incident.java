package com.hack.teamx.incident;

import org.springframework.data.annotation.Id;

import java.time.Instant;

record Incident(@Id String incidentId, String description, String category, String severity, String product, String reportedBy,
                Instant createdTs, String status) {
}
