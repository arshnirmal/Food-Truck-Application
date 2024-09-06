package dev.arshnirmal.foodtruckbackend.config;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.messaging.FirebaseMessaging;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ResourceLoader;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Base64;

@Configuration
@RequiredArgsConstructor
public class FirebaseConfig {
    private final ResourceLoader resourceLoader;

    @Value("${firebase.config-file}")
    private String firebaseConfig;

    @Bean
    public FirebaseApp firebaseApp() throws IOException {
        InputStream serviceAccount;

        if (firebaseConfig.startsWith("classpath:")) {
            serviceAccount = resourceLoader.getResource(firebaseConfig).getInputStream();
        } else {
            byte[] decodedBytes = Base64.getDecoder().decode(firebaseConfig);
            serviceAccount = new ByteArrayInputStream(decodedBytes);
        }

        FirebaseOptions options = FirebaseOptions.builder()
                .setCredentials(GoogleCredentials.fromStream(serviceAccount))
                .build();

        return FirebaseApp.initializeApp(options);
    }

    @Bean
    public FirebaseMessaging firebaseMessaging(FirebaseApp firebaseApp) {
        return FirebaseMessaging.getInstance(firebaseApp);
    }
}
