package com.hack.teamx.incident;

import org.springframework.ai.chat.client.ChatClient;
import org.springframework.ai.chat.client.advisor.PromptChatMemoryAdvisor;
import org.springframework.ai.chat.client.advisor.QuestionAnswerAdvisor;
import org.springframework.ai.chat.memory.InMemoryChatMemory;
import org.springframework.ai.document.Document;
import org.springframework.ai.vectorstore.SearchRequest;
import org.springframework.ai.vectorstore.VectorStore;
import org.springframework.boot.ApplicationRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.core.simple.JdbcClient;
import org.springframework.util.ResourceUtils;

import javax.sql.DataSource;
import java.io.IOException;
import java.nio.file.Files;
import java.util.List;
import java.util.Map;

@Configuration
class ChatAssistantConfiguration {

    @Bean
    ChatClient chatClient(VectorStore vs, ChatClient.Builder builder) throws IOException {
        var system = new String(Files.readAllBytes(ResourceUtils.getFile("/system-prompt.md").toPath()));
        return builder
                .defaultSystem(system)
                .defaultAdvisors(new QuestionAnswerAdvisor(vs, SearchRequest.defaults()), new PromptChatMemoryAdvisor(new InMemoryChatMemory()))
                .build();
    }

    @Bean
    JdbcClient jdbcClient(DataSource dataSource) {
        return JdbcClient.create(dataSource);
    }

    @Bean
    ApplicationRunner applicationRunner(JdbcClient db, IncidentRepository repository, ChangeRequestRepository changeRepository, VectorStore vs) {
        return args -> {

            db.sql("delete from vector_store").update();

            repository.findAll().forEach(inc -> {
                var vector = new Document("id: " + inc.incidentId() + ", description: " +
                        inc.description() + ", product: " + inc.product() + ", product: " + inc.severity() +
                        ", status: " + inc.status() + ", category: " + inc.category() + ", createdDate: " + inc.createdTs(),
                        Map.of("incNumber", inc.incidentId()));
                vs.add(List.of(vector));
            });

//            changeRepository.findAll().forEach(rfc -> {
//                var vector = new Document("id: " + rfc.changeId() + ", description: " +
//                        rfc.description() + ", product: " + rfc.product() + ", plan: " + rfc.implementationPlan() +
//                        ", status: " + rfc.status() + ", completionDate: " + rfc.completionTs(),
//                        Map.of("incNumber", rfc.changeId()));
//                vs.add(List.of(vector));
//            });
        };
    }
}
