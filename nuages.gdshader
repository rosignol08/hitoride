shader_type spatial;

// Texture de bruit pour les nuages
uniform sampler2D noise_texture; // Texture de bruit seamless
uniform float cloud_speed : hint_range(0, 10) = 1.0; // Vitesse des nuages
uniform float cloud_density : hint_range(0, 1) = 0.5; // Densité des nuages
uniform vec3 cloud_color : source_color = vec3(1.0, 1.0, 1.0); // Couleur des nuages

// Couleur et luminosité du ciel pour teinter les nuages
uniform vec3 sky_light : source_color = vec3(0.8, 0.8, 1.0); // Couleur du ciel
uniform float light_intensity : hint_range(0, 1) = 0.8;

void fragment() {
    // Calcul des coordonnées UV
    vec2 uv = UV;

    // Animation des nuages
    vec2 animated_uv = uv + vec2(TIME * (cloud_speed/100.0), 0.0);

    // Lecture de la texture de bruit
    float cloud_layer = texture(noise_texture, animated_uv).r;

    // Opacité des nuages
    float cloud_mask = smoothstep(1.0 - cloud_density, 1.0, cloud_layer);

    // Couleur finale des nuages, teintée par la lumière du ciel
    vec3 final_color = mix(cloud_color, sky_light, light_intensity) * cloud_mask;

    ALBEDO = final_color;
    ALPHA = cloud_mask; // Activer la transparence
}
