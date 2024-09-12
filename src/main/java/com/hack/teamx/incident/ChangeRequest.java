package com.hack.teamx.incident;

import org.springframework.data.annotation.Id;

import java.time.Instant;

record ChangeRequest(@Id String changeId, String description, String product, String implementationPlan, String requestor, Instant completionTs, String status) {
}
