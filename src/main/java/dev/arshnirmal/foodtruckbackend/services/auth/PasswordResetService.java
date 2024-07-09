package dev.arshnirmal.foodtruckbackend.services.auth;

import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.Message;
import com.google.firebase.messaging.Notification;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.security.SecureRandom;

@Service
@RequiredArgsConstructor
public class PasswordResetService {
    private final FirebaseMessaging firebaseMessaging;

    public String sendVerificationCode(String email) {
        String code = generateVerificationCode();
        sendFirebaseNotification(email, code);
        return code;
    }

    private String generateVerificationCode() {
        SecureRandom random = new SecureRandom();
        int code = random.nextInt(999999);
        return String.format("%06d", code);
    }

    private void sendFirebaseNotification(String email, String code) {
        Notification notification = Notification.builder()
                .setTitle("Password Reset")
                .setBody("Your verification code is " + code)
                .build();

        Message message = Message.builder()
                .setNotification(notification)
                .setToken(email)
                .build();

        try {
            firebaseMessaging.send(message);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
