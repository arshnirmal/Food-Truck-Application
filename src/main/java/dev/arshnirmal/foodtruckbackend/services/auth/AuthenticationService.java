package dev.arshnirmal.foodtruckbackend.services.auth;

import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.Message;
import com.google.firebase.messaging.Notification;
import dev.arshnirmal.foodtruckbackend.models.Role;
import dev.arshnirmal.foodtruckbackend.models.User;
import dev.arshnirmal.foodtruckbackend.models.auth.AuthenticationResponse;
import dev.arshnirmal.foodtruckbackend.models.auth.LoginRequest;
import dev.arshnirmal.foodtruckbackend.models.auth.RegisterRequest;
import dev.arshnirmal.foodtruckbackend.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.security.SecureRandom;

@Service
@RequiredArgsConstructor
public class AuthenticationService {
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final JwtService jwtService;
    private final AuthenticationManager authenticationManager;
    private final FirebaseMessaging firebaseMessaging;


    public AuthenticationResponse register(RegisterRequest request) {
        if (userRepository.findByEmail(request.getEmail()).isPresent()) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "User already exists");
        }
        var user = User.builder()
                .firstName(request.getFirstName())
                .lastName(request.getLastName())
                .email(request.getEmail())
                .password(passwordEncoder.encode(request.getPassword()))
                .role(Role.USER)
                .fcmToken(request.getFcmToken())
                .build();

        userRepository.save(user);
        var jwtToken = jwtService.generateToken(user);

        return AuthenticationResponse.builder()
                .token(jwtToken)
                .errorMessage("")
                .build();
    }

    public AuthenticationResponse login(LoginRequest request) {
        authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        request.getEmail(),
                        request.getPassword()
                )
        );

        var user = userRepository.findByEmail(request.getEmail())
                .orElseThrow(() -> new UsernameNotFoundException("User not found"));
        var jwtToken = jwtService.generateToken(user);

        return AuthenticationResponse.builder()
                .token(jwtToken)
                .errorMessage("")
                .build();
    }

    public String reset_password(String email) {
        if (email == null || email.trim().isEmpty()) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Email is required");
        }
        userRepository.findByEmail(email)
                .orElseThrow(() -> new UsernameNotFoundException("User not found"));

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
        final String fcmToken = userRepository.findByEmail(email)
                .orElseThrow(() -> new UsernameNotFoundException("User not found"))
                .getFcmToken();

        Notification notification = Notification.builder()
                .setTitle("Password Reset")
                .setBody("Your verification code is " + code)
                .build();

        Message message = Message.builder()
                .setNotification(notification)
                .putData("email", email)
                .setToken(fcmToken)
                .build();

        try {
            firebaseMessaging.send(message);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}