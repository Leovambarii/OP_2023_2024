package my_spring_project.service

import org.springframework.stereotype.Service

@Service
class AuthService {

    private var username: String = "admin"
    private var password: String = "password"
    private var authenticated: Boolean = false

    fun authenticate(usernameCredential: String, passwordCredential: String): Boolean {
        authenticated = usernameCredential == username && passwordCredential == password

        return authenticated
    }

    fun isAuthenticated(): Boolean {
        return authenticated
    }

    fun logout() {
        authenticated = false
    }
}