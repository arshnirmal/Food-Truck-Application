package dev.arshnirmal.foodtruckbackend.controllers.auth;

import dev.arshnirmal.foodtruckbackend.models.AuthenticationRequest;
import dev.arshnirmal.foodtruckbackend.models.AuthenticationResponse;
import dev.arshnirmal.foodtruckbackend.models.RegisterRequest;
import dev.arshnirmal.foodtruckbackend.services.auth.AuthenticationService;
import dev.arshnirmal.foodtruckbackend.services.auth.PasswordResetService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
public class AuthenticationController {
    private final AuthenticationService authenticationService;
    private final PasswordResetService passwordResetService;

    @GetMapping("/")
    public ResponseEntity<String> demo() {
        return ResponseEntity.ok("Hello Auth");
    }

    @PostMapping("/register")
    public ResponseEntity<AuthenticationResponse> register(@RequestBody RegisterRequest request) {
        var response = authenticationService.register(request);
        if (response.getToken().equals("User already exists")) {
            return ResponseEntity.status(409).body(response); // Conflict status if user already exists
        }
        return ResponseEntity.ok(response);
    }

    @PostMapping("/login")
    public ResponseEntity<AuthenticationResponse> login(@RequestBody AuthenticationRequest request) {
        var response = authenticationService.authenticate(request);
        if (response.getToken().equals("Invalid credentials")) {
            return ResponseEntity.status(401).body(response); // Unauthorized status if credentials are invalid
        }
        return ResponseEntity.ok(response);
    }

    @PostMapping("/reset-password")
    public ResponseEntity<String> resetPassword(@RequestBody String email) {
        var code = passwordResetService.sendVerificationCode(email);
        return ResponseEntity.ok(code);
    }
}
