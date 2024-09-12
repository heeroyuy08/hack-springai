package com.hack.teamx.incident;

import org.springframework.ai.chat.client.ChatClient;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.util.Collection;
import java.util.Optional;

@Controller
@ResponseBody
@Transactional
@RequestMapping("/incidents")
class IncidentController {

    private final IncidentRepository repository;

    private final ChatClient chatClient;

    IncidentController(IncidentRepository repository, ChatClient chatClient) {
        this.repository = repository;
        this.chatClient = chatClient;
    }

    @GetMapping("/list")
    Collection<Incident> list() {
        return this.repository.findAll();
    }

    @GetMapping("/{id}")
    Optional<Incident> byId(@PathVariable String incidentId) {
        return this.repository.findById(incidentId);
    }

    @PostMapping("/prompt")
    String prompt(@RequestBody String prompt) {
        return chatClient.prompt().user(prompt).call().entity(String.class);
    }
}
