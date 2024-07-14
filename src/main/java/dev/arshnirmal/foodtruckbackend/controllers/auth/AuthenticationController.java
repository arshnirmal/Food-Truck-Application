package dev.arshnirmal.foodtruckbackend.controllers.auth;

import dev.arshnirmal.foodtruckbackend.models.auth.AuthenticationResponse;
import dev.arshnirmal.foodtruckbackend.models.auth.LoginRequest;
import dev.arshnirmal.foodtruckbackend.models.auth.PasswordResetResponse;
import dev.arshnirmal.foodtruckbackend.models.auth.RegisterRequest;
import dev.arshnirmal.foodtruckbackend.services.UserService;
import dev.arshnirmal.foodtruckbackend.services.auth.AuthenticationService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
public class AuthenticationController {
    private final AuthenticationService authenticationService;
    private final UserService userService;

    @GetMapping("/")
    public ResponseEntity<String> demo() {
        return ResponseEntity.ok("Hello Auth");
    }

    @PostMapping("/register")
    public ResponseEntity<AuthenticationResponse> register(@RequestBody RegisterRequest request) {
        try {
            var response = authenticationService.register(request);
            userService.updateFcmToken(request.getEmail(), request.getFcmToken());
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            return ResponseEntity.status(400).body(AuthenticationResponse.builder()
                    .token("")
                    .errorMessage("User already exists")
                    .build()
            );
        }
    }

    @PostMapping("/login")
    public ResponseEntity<AuthenticationResponse> login(@RequestBody LoginRequest request) {
        try {
            var response = authenticationService.login(request);
            userService.updateFcmToken(request.getEmail(), request.getFcmToken());
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            return ResponseEntity.status(401).body(AuthenticationResponse.builder()
                    .token("")
                    .errorMessage("Invalid credentials")
                    .build()
            );
        }
    }

    @PostMapping("/reset-password")
    public ResponseEntity<PasswordResetResponse> resetPassword(@RequestBody Map<String, String> request) {
        try {
            var email = request.get("email");
            var code = authenticationService.reset_password(email);
            return ResponseEntity.ok().body(PasswordResetResponse.builder()
                    .verificationCode(code)
                    .errorMessage("")
                    .build()
            );
        } catch (Exception e) {
            return ResponseEntity.status(400).body(PasswordResetResponse.builder()
                    .verificationCode("")
                    .errorMessage("User not found")
                    .build()
            );
        }
    }
}
