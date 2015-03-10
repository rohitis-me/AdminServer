import org.springframework.security.authentication.encoding.PlaintextPasswordEncoder

// Place your Spring DSL code here
beans = {
	passwordEncoder(PlaintextPasswordEncoder)
}
