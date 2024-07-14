package dev.arshnirmal.foodtruckbackend.services;

import dev.arshnirmal.foodtruckbackend.models.User;
import dev.arshnirmal.foodtruckbackend.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class UserService {
    private final UserRepository userRepository;

    public void updateFcmToken(String email, String fcmToken) {
        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new UsernameNotFoundException("User not found"));
        user.setFcmToken(fcmToken);
        userRepository.save(user);
    }
}
