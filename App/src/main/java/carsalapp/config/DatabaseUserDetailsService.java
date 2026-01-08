package carsalapp.config;

import carsalapp.model.Klient;
import carsalapp.repository.KlientRepository;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(readOnly = true)
public class DatabaseUserDetailsService implements UserDetailsService {

    private final KlientRepository klientRepository;

    public DatabaseUserDetailsService(KlientRepository klientRepository) {
        this.klientRepository = klientRepository;
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        Klient klient = klientRepository.findByUsername(username)
            .orElseThrow(() -> new UsernameNotFoundException("Nie znaleziono użytkownika: " + username));

        return User.withUsername(klient.getUsername())
            .password(klient.getPasswordHash())
            .roles(klient.getRola())
            .disabled(!klient.isEnabled())
            .build();
    }
}
