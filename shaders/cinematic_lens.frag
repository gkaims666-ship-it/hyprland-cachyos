precision mediump float;
varying vec2 v_texcoord;
uniform sampler2D tex;

void main() {
    vec2 uv = v_texcoord;

    // Вектор удаления от центра экрана (-0.5 .. 0.5)
    vec2 dist = uv - 0.5;
    float d2 = dot(dist, dist); // Квадрат расстояния (быстрее, чем length/sqrt)

    // 1. Микро-хроматическая аберрация по краям (только 3 выборки текстуры)
    float aberration = d2 * 0.0035;
    float r = texture2D(tex, uv + dist * aberration).r;
    float g = texture2D(tex, uv).g;
    float b = texture2D(tex, uv - dist * aberration).b;
    vec3 color = vec3(r, g, b);

    // 2. Кинематографичный контраст и углубление черного (S-curve)
    color = clamp(color, 0.0, 1.0);
    color = pow(color, vec3(1.04));

    // 3. Мягкая оптическая виньетка по краям
    float vignette = clamp(1.0 - d2 * 0.55, 0.0, 1.0);
    color *= vignette;

    gl_FragColor = vec4(color, 1.0);
}
