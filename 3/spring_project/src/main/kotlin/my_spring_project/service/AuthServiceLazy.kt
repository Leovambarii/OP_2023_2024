package my_spring_project.service

import org.springframework.stereotype.Service

@Service
class AuthServiceLazy {

    private var username: String = "admin"
    private var password: String = "password"
    private var authenticated: Boolean = false

    companion object {
        val instance: AuthServiceLazy by lazy {
            AuthServiceLazy()
        }
    }

    fun authenticate(usernameCredential: String, passwordCredential: String): Boolean {
        instance.authenticated = usernameCredential == instance.username && passwordCredential == instance.password

        return instance.authenticated
    }

    fun isAuthenticated(): Boolean {
        return instance.authenticated
    }

    fun logout() {
        instance.authenticated = false
    }
}