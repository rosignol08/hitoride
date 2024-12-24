shader_type sky;

// Couleurs de base pour différents moments de la journée
uniform vec3 morning_color : source_color = vec3(1.0, 0.6, 0.5); // Rose pour 6h
uniform vec3 noon_color : source_color = vec3(0.5, 0.7, 1.0); // Bleu pour 12h
uniform vec3 evening_color : source_color = vec3(1.0, 0.5, 0.3); // Orange pour 18h
uniform vec3 night_color : source_color = vec3(0.05, 0.05, 0.2); // Nuit sombre

// Heure de la journée (0 = minuit, 12 = midi, 24 = minuit)
uniform float time_of_day : hint_range(0, 24) = 12.0;
uniform bool time_scroll = false; // Active/désactive le défilement du temps
uniform float time_speed : hint_range(0, 10) = 1.0; // Vitesse du défilement du temps

void sky() {
    // Calcul de l'heure en fonction de l'activation de time_scroll
    float t = time_scroll ? fract((time_of_day + TIME * time_speed) / 24.0) : fract(time_of_day / 24.0);

    // Interpolation des couleurs de ciel en fonction de l'heure
    vec3 sky_color;
    if (t < 0.25) {
        float factor = t / 0.25;
        sky_color = mix(night_color, morning_color, factor);
    } else if (t < 0.5) {
        float factor = (t - 0.25) / 0.25;
        sky_color = mix(morning_color, noon_color, factor);
    } else if (t < 0.75) {
        float factor = (t - 0.5) / 0.25;
        sky_color = mix(noon_color, evening_color, factor);
    } else {
        float factor = (t - 0.75) / 0.25;
        sky_color = mix(evening_color, night_color, factor);
    }
    // Couleur finale
    COLOR = sky_color;
}
