package dev.arshnirmal.foodtruckbackend.controllers;

import dev.arshnirmal.foodtruckbackend.models.AuthenticationRequest;
import dev.arshnirmal.foodtruckbackend.models.AuthenticationResponse;
import dev.arshnirmal.foodtruckbackend.models.RegisterRequest;
import dev.arshnirmal.foodtruckbackend.services.AuthenticationService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/auth")
@RequiredArgsConstructor
public class AuthenticationController {
    private final AuthenticationService authenticationService;

    @PostMapping("/register")
    public ResponseEntity<AuthenticationResponse> register(
            @RequestBody RegisterRequest request
    ){
        return ResponseEntity.ok(authenticationService.register(request));
    }

    @PostMapping("/login")
    public ResponseEntity<AuthenticationResponse> register(
            @RequestBody AuthenticationRequest request
    ){
        return ResponseEntity.ok(authenticationService.authenticate(request));
    }

    @GetMapping("/")
    public ResponseEntity<String> demo(){
        return ResponseEntity.ok("Hello");
    }

}
