
(define (problem tama_problem)
    (:domain tama)

    (:objects
        t1 - tamagotchi
    )
    (:init
        ; tamagotchi starts alive, in bed, and in sleep mode
        (alive t1)
        (at t1 bed)
        (sleep-mode t1)

        ; tamagotchi starts slightly hungry, unhappy, unhealthy, and sleepy - needs some attention
        (= (hunger t1) 5)
        (= (unhappiness t1) 5)
        (= (sleepiness t1) 5)

        ; starting point for countdown
        (= (mode-countdown) 10)

        ; length of time before switching modes
        (= (mode-duration) 10)

    )

    ; goal: keep the tamagotchi in a stable, healthy state
    (:goal
        (and
            (done)
        )
    )
)
